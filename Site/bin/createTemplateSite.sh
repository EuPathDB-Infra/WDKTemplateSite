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
  if [ -e $SITE_DIR/$SETUP_FILE ]; then
    source $SITE_DIR/$SETUP_FILE
  fi
}

createTemplateSite() {
  createSiteDir $1
  checkPrereqs
  selection=
  while [ "$selection" != "0" ]; do
    echo "Detail logs available in: $SITE_DIR/logs"
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
        ;;
      8)
        buildAllButDb $2 $3
        buildDatabase
        ;;
    esac
  done
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
  runSql $PROJECT_HOME/WDK/Model/data/persistent_tables_postgres.sql userDbTables.log
  # also, give PostgreSQL an Oracle-style DUAL table
  runSql $PROJECT_HOME/WDKTemplateSite/Model/lib/sql/dual.sql dualTable.log
  echo "  Building TemplateDB data model tables"
  fgpJava org.gusdb.wdk.model.test.TestDBManager -model TemplateDB -new > appDbTables.log
  echo "  Building WDK Cache"
  wdkCache -model TemplateDB --new
}

runSql() {
  cmd="fgpJava org.gusdb.wdk.model.WdkSqlScriptRunner TemplateDB APP $1 true false"
  echo "  Running: $cmd"
  $cmd > $SITE_DIR/logs/$2
}

configureSite() {
  echo "Configuring Site"
  sed "s|<db_password>|$1|g" $PROJECT_HOME/WDKTemplateSite/Model/lib/yaml/metaConfig.yaml.sample | sed "s|<template_site_host>|$2|g" - > $SITE_DIR/metaConfig.yaml
  templateSiteConfigure -model $PROJECT_ID -filename $SITE_DIR/metaConfig.yaml > $SITE_DIR/logs/siteConfig.log
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
  # clean jar files
  rm -rf $GUS_HOME/lib/java/*
  bldw WDKTemplateSite $SITE_DIR/webapp.prop > $SITE_DIR/logs/build.log
}

configureWebappProp() {
  echo "Configuring Build"
  echo "  Generating $SITE_DIR/webapp.prop"
  sed "s|<baseDirectory>|$SITE_DIR|g" $PROJECT_HOME/WDK/Controller/config/webapp.prop.sample > $SITE_DIR/webapp.prop
  echo "  Generating $SITE_DIR/wdkTemplateSite.context.xml"
  sed "s|<baseDirectory>|$SITE_DIR|g" $PROJECT_HOME/WDKTemplateSite/Model/config/wdkTemplateSite.xml.tmpl > $SITE_DIR/wdkTemplateSite.xml
}

checkOutProjects() {
  echo "Downloading Source Code"
  cd $PROJECT_HOME
  checkout install
  checkout FgpUtil
  checkout WSF
  checkout WDK
  checkout WDKTemplateSite
  cd -
}

checkout() {
  baseSvn=https://www.cbil.upenn.edu/svn/gus
  echo "  Checking out ${1}..."
  svn co $baseSvn/$1/trunk $1 > $SITE_DIR/logs/codeCheckout.log
  if [[ ! -e $PROJECT_HOME/$1 ]]; then
    echo "Error: could not check out project $1"
    exit 1
  fi
}

buildSiteFramework() {
  echo "Building Site Framework"
  echo -n "  "; mkdir -v -p logs
  echo -n "  "; mkdir -v -p project_home
  echo -n "  "; mkdir -v -p gus_home
  echo -n "  "; mkdir -v -p gus_home/config
  echo -n "  "; mkdir -v -p gus_home/config/$PROJECT_ID
  perlPath=$(which perl)
  bashPath=$(which bash)
  echo "  Creating basic gus_home/config/gus.config"
  echo "perl=$perlPath" > gus_home/config/gus.config
  echo "  Creating $SETUP_FILE"
  echo "#$bashPath" > $SETUP_FILE
  echo "export GUS_HOME=$SITE_DIR/gus_home" >> $SETUP_FILE
  echo "export PROJECT_HOME=$SITE_DIR/project_home" >> $SETUP_FILE
  echo "export PATH=\$GUS_HOME/bin:\$PROJECT_HOME/install/bin:\$PATH" >> $SETUP_FILE
  source $SETUP_FILE
}

if [[ "$#" != "3" ]]; then
  echo "USAGE: createTemplateSite.sh <install_dir> <db_password> <template_site_host>"
  echo "   install_dir: This is a directory where the site will be installed.  This directory should be created by the script; specify the dir to create, not its parent"
  echo "   db_password: Assuming you followed the steps above, but with a different password, pass your wdktemplatedb user's password here"
  echo "   template_site_host: This is the host at which the webapp will live.  For testing, this might be 'http://localhost:8080' or similar"
  exit 1
fi

createTemplateSite $1 $2 $3
