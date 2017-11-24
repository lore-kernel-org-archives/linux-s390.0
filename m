Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/12] s390: Remove redundant license text
Date: Fri, 24 Nov 2017 15:00:43 +0100
Message-Id: <20171124140043.10062-13-gregkh@linuxfoundation.org>
In-Reply-To: <20171124140043.10062-1-gregkh@linuxfoundation.org>
References: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all arch/s390/ files, that identifies the
license in a specific and legally-defined manner.  So the extra GPL text
wording in the remaining files can be removed as it is no longer needed
at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Makefile        |  4 ----
 arch/s390/boot/install.sh |  4 ----
 arch/s390/hypfs/inode.c   |  1 -
 arch/s390/mm/mmap.c       | 15 ---------------
 4 files changed, 24 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ffd95861f9ac..de54cfc6109d 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -7,10 +7,6 @@
 # for "archclean" and "archdep" for cleaning up and making dependencies for
 # this architecture
 #
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
 # Copyright (C) 1994 by Linus Torvalds
 #
 
diff --git a/arch/s390/boot/install.sh b/arch/s390/boot/install.sh
index 32a9367b9bf0..bed227f267ae 100644
--- a/arch/s390/boot/install.sh
+++ b/arch/s390/boot/install.sh
@@ -3,10 +3,6 @@
 #
 # arch/s390x/boot/install.sh
 #
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
 # Copyright (C) 1995 by Linus Torvalds
 #
 # Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 05d62cdb78b5..43bbe63e2992 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -4,7 +4,6 @@
  *
  *    Copyright IBM Corp. 2006, 2008
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
- *    License: GPL
  */
 
 #define KMSG_COMPONENT "hypfs"
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 5ec9a8c2b768..831bdcf407bb 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -5,21 +5,6 @@
  * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
  * All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *
  * Started by Ingo Molnar <mingo@elte.hu>
  */
 
-- 
2.15.0
