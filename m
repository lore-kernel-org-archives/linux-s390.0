Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 9/9] s390: drivers: Remove redundant license text
Date: Tue, 14 Nov 2017 18:38:08 +0100
Message-Id: <20171114173808.25092-10-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Now that the SPDX tag is in all drivers/s390/ files, that identifies the
license in a specific and legally-defined manner.  So the extra GPL text
wording can be removed as it is no longer needed at all.

This is done on a quest to remove the 700+ different ways that files in
the kernel describe the GPL license text.  And there's unneeded stuff
like the address (sometimes incorrect) for the FSF which is never
needed.

No copyright headers or other non-license-description text was removed.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/char/zcore.c        |  1 -
 drivers/s390/cio/cmf.c           | 14 --------------
 drivers/s390/cio/css.c           |  2 --
 drivers/s390/cio/device.c        |  2 --
 drivers/s390/cio/device_ops.c    |  2 --
 drivers/s390/net/lcs.c           | 14 --------------
 drivers/s390/net/netiucv.c       | 15 ---------------
 drivers/s390/net/smsgiucv.c      | 14 --------------
 drivers/s390/virtio/Makefile     |  4 ----
 drivers/s390/virtio/virtio_ccw.c |  4 ----
 10 files changed, 72 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index dd86559ce7fb..4369662cfff5 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -8,7 +8,6 @@
  *
  * Copyright IBM Corp. 2003, 2008
  * Author(s): Michael Holzheu
- * License: GPL
  */
 
 #define KMSG_COMPONENT "zdump"
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 320ce009ba41..5e495c62cfa7 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -8,20 +8,6 @@
  *	    Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * original idea from Natarajan Krishnaswami <nkrishna@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define KMSG_COMPONENT "cio"
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index f4c2e71e7a56..0f11dce6e224 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -6,8 +6,6 @@
  *
  * Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *	      Cornelia Huck (cornelia.huck@de.ibm.com)
- *
- * License: GPL
  */
 
 #define KMSG_COMPONENT "cio"
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 4cbcb7166d78..3b8fa05a3462 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -6,8 +6,6 @@
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * License: GPL
  */
 
 #define KMSG_COMPONENT "cio"
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index aa125d92cc65..1caf6a398760 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -4,8 +4,6 @@
  *
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *	      Cornelia Huck (cornelia.huck@de.ibm.com)
- *
- * License: GPL
  */
 #include <linux/export.h>
 #include <linux/init.h>
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 36899e94d268..92ae84a927fc 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -8,20 +8,6 @@
  *	       Rewritten by
  *			Frank Pavlic <fpavlic@de.ibm.com> and
  *			Martin Schwidefsky <schwidefsky@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define KMSG_COMPONENT		"lcs"
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 150053131baf..5ce2424ca729 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -19,21 +19,6 @@
  *    Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
  *    Martin Schwidefsky (schwidefsky@de.ibm.com)
  *    Alan Altmark (Alan_Altmark@us.ibm.com)  Sept. 2000
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #define KMSG_COMPONENT "netiucv"
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 93405e0bad3c..3b0c8b8a7634 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -5,20 +5,6 @@
  * Copyright IBM Corp. 2003, 2009
  *
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/module.h>
diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
index 7c6f0c8db883..2dc4d9aab634 100644
--- a/drivers/s390/virtio/Makefile
+++ b/drivers/s390/virtio/Makefile
@@ -2,9 +2,5 @@
 # Makefile for kvm guest drivers on s390
 #
 # Copyright IBM Corp. 2008
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License (version 2 only)
-# as published by the Free Software Foundation.
 
 obj-$(CONFIG_S390_GUEST) += virtio_ccw.o
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 56346caadb21..ba2e0856d22c 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -4,10 +4,6 @@
  *
  * Copyright IBM Corp. 2012, 2014
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  */
 
-- 
2.15.0
