#/bin/bash

PROJECT_ID=TemplateDB
SETUP_FILE=envSetup.sh
PREREQS=( svn perl java npm node ant mvn )

createSiteDir() {
  if [ ! -e $1 ]; then
    echo -n "  "
    # fail if unable to create
    mkdir -v $1;
  fi
  cd $1
  export SITE_DIR=$(pwd)
  echo "  \$SITE_DIR set to $SITE_DIR"
  # source env file if exists; if not,
  #   will be created and sourced later
  if [ -e $SITE_DIR/etc/$SETUP_FILE ]; then
    source $SITE_DIR/etc/$SETUP_FILE
  fi
}

createTemplateSite() {
  echo ""
  echo "Initializing..."
  createSiteDir $1
  checkPrereqs
  echo "  NOTE: Please check detail logs for success, available in: $SITE_DIR/logs"
  selection=
  while [ "$selection" != "0" ]; do
    echo ""
    echo "Select:"
    echo "  1: Build basic directory structure"
    echo "  2: Check out source code from Subversion"
    echo "  3: Configure webapp.prop and context.xml files"
    echo "  4: Compile source code"
    echo "  5: Build meta yaml file and configure site"
    echo "  6: Build initial database tables (UserDB, AppDB, WdkCache)"
    echo "  7: Run all the above, in order, EXCEPT #6: Database"
    echo "  8: Run all the above, in order, including #6"
    echo "  0: Exit"
    echo -n "> "
    read selection
    echo ""
    case "$selection" in
      0)
        exit 0
        ;;
      1)
        buildSiteFramework
        ;;
      2)
        checkOutProjects
        ;;
      3)
        configureWebappProp
        ;;
      4)
        buildSite
        ;;
      5)
        configureSite $2 $3
        ;;
      6)
        buildDatabase
        ;;
      7)
        buildAllButDb $2 $3
        nextStepsMessage
        ;;
      8)
        buildAllButDb $2 $3
        buildDatabase
        nextStepsMessage
        ;;
    esac
  done
}

nextStepsMessage() {
  echo "All steps complete."
  echo ""
  echo "Please check logs for errors in $SITE_DIR/logs"
  echo "There are three more steps to running the WDK Template Site"
  echo "  1. Download the PostgreSQL JDBC database driver and install in Tomcat"
  echo "    a. Download from: http://jdbc.postgresql.org/download.html"
  echo "    b. Place in \$CATALINA_HOME/lib"
  echo "  2. Copy the template sites context.xml file to Tomcat"
  echo "    a. cp $SITE_DIR/etc/wdkTemplateSite.xml \$CATALINA_HOME/conf/Catalina/localhost"
  echo "  3. Set the environment and restart Tomcat"
  echo "    a. \$CATALINA_HOME/bin/shutdown.sh"
  echo "    b. source $SITE_DIR/etc/$SETUP_FILE"
  echo "    c. \$CATALINA_HOME/bin/startup.sh"
}

buildAllButDb() {
  buildSiteFramework
  checkOutProjects
  configureWebappProp
  buildSite
  configureSite $1 $2
}

buildDatabase() {
  echo "Building TemplateDB database tables"
  runSql $PROJECT_HOME/WDK/Model/data/persistent_tables_postgres.sql userDbTables.log persistent_tables_postgres.sql
  # also, give PostgreSQL an Oracle-style DUAL table
  runSql $PROJECT_HOME/WDKTemplateSite/Model/lib/sql/dual.sql dualTable.log dual.sql
  echo "  Building TemplateDB data model (AppDb) and inserting test data"
  echo "    Note: This can take some time.  Please be patient."
  fgpJava org.gusdb.wdk.model.test.TestDBManager -model TemplateDB -new &> $SITE_DIR/logs/appDbTables.log
  echo "  Building WDK Cache"
  wdkCache -model TemplateDB --new &> $SITE_DIR/logs/wdkCache.log
}

runSql() {
  cmd="fgpJava org.gusdb.wdk.model.WdkSqlScriptRunner TemplateDB APP $1 true false"
  echo "  Running SQL: $3"
  $cmd &> $SITE_DIR/logs/$2
}

configureSite() {
  echo "Configuring Site"
  echo "  Generating $SITE_DIR/etc/metaConfig.yaml"
  sed "s|<db_password>|$1|g" $PROJECT_HOME/WDKTemplateSite/Model/lib/yaml/metaConfig.yaml.sample | sed "s|<template_site_host>|$2|g" - > $SITE_DIR/etc/metaConfig.yaml
  echo "  Running templateSiteConfigure"
  templateSiteConfigure -model $PROJECT_ID -filename $SITE_DIR/etc/metaConfig.yaml &> $SITE_DIR/logs/siteConfig.log
}

checkPrereqs() {
  for prereq in ${PREREQS[@]}; do
    echo "  Checking $prereq"
    prereqPath=$(which $prereq)
    if [[ "$prereqPath" == "" ]]; then
      echo "Error: You must have $prereq in your \$PATH.  Please add it and try again."
      if [[ "$prereq" == "node" ]]; then
        nodejsPath=$(which nodejs)
        if [[ "$nodejsPath" != "" ]]; then
          echo "  You have nodejs (legacy) installed but not node."
          echo "  If you are running Debian/Ubuntu/Mint, you can probably resolve this problem with:"
          echo "     > sudo apt-get install nodejs-legacy"
        fi
      fi
      exit 1
    fi
  done
}

buildSite() {
  echo "Building and Installing Code"
  # clean jar files and webapp
  echo "  Cleaning last build (if any)"
  rm -rf $GUS_HOME/bin
  rm -rf $GUS_HOME/data
  rm -rf $GUS_HOME/doc
  rm -rf $GUS_HOME/lib
  rm -rf $GUS_HOME/test
  rm -rf $SITE_DIR/webapp
  cmd="bldw WDKTemplateSite $SITE_DIR/etc/webapp.prop"
  echo "  Running $cmd"
  $cmd &> $SITE_DIR/logs/build.log
}

configureWebappProp() {
  echo "Configuring Build"
  echo "  Generating $SITE_DIR/etc/webapp.prop"
  sed "s|<baseDirectory>|$SITE_DIR|g" $PROJECT_HOME/WDK/Controller/config/webapp.prop.sample > $SITE_DIR/etc/webapp.prop
  echo "  Generating $SITE_DIR/etc/wdkTemplateSite.xml"
  sed "s|<baseDirectory>|$SITE_DIR|g" $PROJECT_HOME/WDKTemplateSite/Model/config/wdkTemplateSite.xml.tmpl > $SITE_DIR/etc/wdkTemplateSite.xml
}

checkOutProjects() {
  echo "Downloading Source Code"
  # clear log
  rm -f $SITE_DIR/logs/codeCheckout.log
  cd $PROJECT_HOME
  checkout install
  checkout FgpUtil
  checkout WSF
  checkout WDK
  checkout WDKTemplateSite
  cd - &> /dev/null
}

checkout() {
  baseSvn=https://www.cbil.upenn.edu/svn/gus
  echo "  Checking out ${1}..."
  svn co $baseSvn/$1/trunk $1 >> $SITE_DIR/logs/codeCheckout.log
  if [[ ! -e $PROJECT_HOME/$1 ]]; then
    echo "Error: could not check out project $1"
    exit 1
  fi
}

buildSiteFramework() {
  cd $SITE_DIR
  echo "Building Site Framework"
  echo -n "  "; mkdir -v -p etc
  echo -n "  "; mkdir -v -p logs
  echo -n "  "; mkdir -v -p project_home
  echo -n "  "; mkdir -v -p gus_home
  echo -n "  "; mkdir -v -p gus_home/config
  echo -n "  "; mkdir -v -p gus_home/config/$PROJECT_ID
  perlPath=$(which perl)
  bashPath=$(which bash)
  echo "  Generating $SITE_DIR/gus_home/config/gus.config"
  echo "perl=$perlPath" > gus_home/config/gus.config
  echo "  Generating $SITE_DIR/etc/$SETUP_FILE"
  echo "#$bashPath" > etc/$SETUP_FILE
  echo "export GUS_HOME=$SITE_DIR/gus_home" >> etc/$SETUP_FILE
  echo "export PROJECT_HOME=$SITE_DIR/project_home" >> etc/$SETUP_FILE
  echo "export PATH=\$GUS_HOME/bin:\$PROJECT_HOME/install/bin:\$PATH" >> etc/$SETUP_FILE
  source etc/$SETUP_FILE
  cd - &> /dev/null
}

if [[ "$#" != "3" ]]; then
  echo "USAGE: createTemplateSite.sh <install_dir> <db_password> <template_site_host>"
  echo "   install_dir: This is a directory where the site will be installed.  This directory should be created by the script; specify the dir to create, not its parent"
  echo "   db_password: Assuming you followed the steps above, but with a different password, pass your wdktemplatedb user's password here"
  echo "   template_site_host: This is the host at which the webapp will live.  For testing, this might be 'http://localhost:8080' or similar"
  exit 1
fi

createTemplateSite $1 $2 $3
