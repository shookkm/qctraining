###############################################################################
# Makefile
#
# (c) COPYRIGHT Queen City Software, Inc. 2016 All Rights Reserved
# No part of this copyrighted work may be reproduced, modified, or distributed
# in any form or by any means without the prior written permission of Queen
# City Software, Inc.
#
# $Id:$
###############################################################################

PROJDIR = $(PROJECTS)/QcTraining
JDEBUG = -g
#JOPTS +=
PACKAGE = com.qcsoftware.qctraining.%%INITIALS%%.projecttwo

include $(DEVDEFAULTS)/makefile

PROJCLASS = $(PROJDIR)/Classes

#
# the tables to have a base class generated for.
#
TABLES = %%TABLE_NAME%%
  
#
# add the "Base.java" extension to the table names to be used for the class
# name.
#
TABLESRC = $(foreach table, $(TABLES), $(table)Base.java)

all: $(TABLESRC)

#
# removes the source code for the table base classes.
#
cleantables:
	$(RM) $(TABLESRC)

#
# rule to build the java source files for the tables.
#
%.java:
	$(JAVA) Library.Database.DbTableSrc -c $* -n $(patsubst %Base,%,$*) -p $(PACKAGE) -e Packages.DbBase.BaseTable -l qc/qc -v

#
# this will keep make from deleting the java source files once they are
# created
#
.PRECIOUS:  $(TABLESRC)
