Return-Path: <linux-kernel-owner+w=401wt.eu-S1760706AbXJDLdf@vger.kernel.org>
Message-Id: <20071004112830.596222209@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/34] remove packed attribute from ext_int_info_t.
Content-Disposition: inline; filename=022-ext-info.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

ext_int_info_t is no longer used in entry(64).S Instead do_extint is a C
function that handles the hash search.
As the structure is handled in C code, we can also remove the packed
attribute to avoid alignment issues. (Currently there is no alignment
problem in ext_int_info_t, even if packet)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/s390_ext.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: quilt-2.6/include/asm-s390/s390_ext.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/s390_ext.h
+++ quilt-2.6/include/asm-s390/s390_ext.h
@@ -5,7 +5,7 @@
  *  include/asm-s390/s390_ext.h
  *
  *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 1999,2007
  *    Author(s): Holger Smolinski (Holger.Smolinski@de.ibm.com),
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
@@ -14,15 +14,11 @@
 
 typedef void (*ext_int_handler_t)(__u16 code);
 
-/*
- * Warning: if you change ext_int_info_t you have to change the
- * external interrupt handler in entry.S too.
- */ 
 typedef struct ext_int_info_t {
 	struct ext_int_info_t *next;
 	ext_int_handler_t handler;
 	__u16 code;
-} __attribute__ ((packed)) ext_int_info_t;
+} ext_int_info_t;
 
 extern ext_int_info_t *ext_int_hash[];
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
