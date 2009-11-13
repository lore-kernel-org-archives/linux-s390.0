Return-Path: <linux-kernel-owner+w=401wt.eu-S1756530AbZKMPSR@vger.kernel.org>
Message-Id: <20091113150911.577400905@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/52] [PATCH] use generic sockios.h header file
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=112-sockios-generic.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Index: quilt-2.6/arch/s390/include/asm/sockios.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sockios.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/sockios.h	2009-11-13 16:08:14.000000000 +0100
@@ -1,21 +1,6 @@
-/*
- *  include/asm-s390/sockios.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/sockios.h"
- */
+#ifndef _ASM_S390_SOCKIOS_H
+#define _ASM_S390_SOCKIOS_H
 
-#ifndef __ARCH_S390_SOCKIOS__
-#define __ARCH_S390_SOCKIOS__
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#include <asm-generic/sockios.h>
 
 #endif
