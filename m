Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/12] s390: kvm: Remove redundant license text
Date: Fri, 24 Nov 2017 15:00:39 +0100
Message-Id: <20171124140043.10062-9-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all arch/s390/kvm/ files, that identifies
the license in a specific and legally-defined manner.  So the extra GPL
text wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/Makefile    | 4 ----
 arch/s390/kvm/diag.c      | 4 ----
 arch/s390/kvm/gaccess.h   | 4 ----
 arch/s390/kvm/guestdbg.c  | 4 ----
 arch/s390/kvm/intercept.c | 4 ----
 arch/s390/kvm/interrupt.c | 4 ----
 arch/s390/kvm/irq.h       | 4 ----
 arch/s390/kvm/kvm-s390.c  | 4 ----
 arch/s390/kvm/kvm-s390.h  | 4 ----
 arch/s390/kvm/priv.c      | 4 ----
 arch/s390/kvm/sigp.c      | 4 ----
 arch/s390/kvm/vsie.c      | 4 ----
 12 files changed, 48 deletions(-)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 2c5a8190d5ce..05ee90a5ea08 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -2,10 +2,6 @@
 # Makefile for kernel virtual machines on s390
 #
 # Copyright IBM Corp. 2008
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License (version 2 only)
-# as published by the Free Software Foundation.
 
 KVM := ../../../virt/kvm
 common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 481e1fe6095f..89aa114a2cba 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2011
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 443b7fa82d56..f4c51756c462 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2014
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index d6a1bead813c..b5f3e82006d0 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2014
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
 #include <linux/kvm_host.h>
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index fc76a91a7820..9c7d70715862 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2014
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f37a34ea1601..024ad8bcc516 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2015
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
index 54a4a59cb4f9..484608c71dd0 100644
--- a/arch/s390/kvm/irq.h
+++ b/arch/s390/kvm/irq.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2014
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  */
 #ifndef __KVM_IRQ_H
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d45e32dd868..34375eed93ee 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2009
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  *               Heiko Carstens <heiko.carstens@de.ibm.com>
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 9777924c4b5c..5e46ba429bcb 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2009
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  *               Christian Ehrhardt <ehrhardt@de.ibm.com>
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c9d962ac140b..28b69ab56b7b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2013
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index d12ac5d6e8bb..c1f5cde2c878 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2008, 2013
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  *               Christian Ehrhardt <ehrhardt@de.ibm.com>
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d2b7886da444..5d6ae0326d9e 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2016
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
 #include <linux/vmalloc.h>
-- 
2.15.0
