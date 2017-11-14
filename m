Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/9] s390: cio: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:02 +0100
Message-Id: <20171114173808.25092-4-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/cio/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/ccwgroup.c     | 1 +
 drivers/s390/cio/chp.c          | 1 +
 drivers/s390/cio/chsc.c         | 1 +
 drivers/s390/cio/chsc_sch.c     | 1 +
 drivers/s390/cio/cio.c          | 1 +
 drivers/s390/cio/cmf.c          | 1 +
 drivers/s390/cio/css.c          | 1 +
 drivers/s390/cio/device.c       | 1 +
 drivers/s390/cio/device_fsm.c   | 1 +
 drivers/s390/cio/device_ops.c   | 1 +
 drivers/s390/cio/eadm_sch.c     | 1 +
 drivers/s390/cio/isc.c          | 1 +
 drivers/s390/cio/qdio_main.c    | 1 +
 drivers/s390/cio/qdio_setup.c   | 1 +
 drivers/s390/cio/scm.c          | 1 +
 drivers/s390/cio/vfio_ccw_drv.c | 1 +
 16 files changed, 16 insertions(+)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e2f7b6e93efd..bfec1485ca23 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  bus driver for ccwgroup
  *
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index f4166f80c4d4..5c94a3aec4dd 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *    Copyright IBM Corp. 1999, 2010
  *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 7b0b295b2313..c08fc5a8df0c 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   S/390 common I/O routines -- channel subsystem call
  *
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 8e7e19b9e92c..0015729d917d 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for s390 chsc subchannels
  *
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 89216174fcbb..987bf9a8c9f7 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   S/390 common I/O routines -- low level i/o calls
  *
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 7d59230e88bb..320ce009ba41 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux on zSeries Channel Measurement Facility support
  *
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index d3e504c3c362..f4c2e71e7a56 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * driver for channel subsystem
  *
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e5c32f4b5287..4cbcb7166d78 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  *  bus driver for ccw devices
  *
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index f98ea674c3d8..7d8a7a5464c5 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * finite state machine for device handling
  *
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index cf8c4ac6323a..aa125d92cc65 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  * Copyright IBM Corp. 2002, 2009
  *
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index d14795f7110b..13ebcd3daa05 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for s390 eadm subchannels
  *
diff --git a/drivers/s390/cio/isc.c b/drivers/s390/cio/isc.c
index c592087be0f1..77fde9f5ea8b 100644
--- a/drivers/s390/cio/isc.c
+++ b/drivers/s390/cio/isc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Functions for registration of I/O interruption subclasses on s390.
  *
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index a4ad39ba3873..24edfaca7873 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Linux for s390 qdio support, buffer handling, qdio API and module support.
  *
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 48b3866a9ded..895d8ae76665 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * qdio queue initialization
  *
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 1fa53ecdc2aa..6bca1d5455d4 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Recognize and maintain s390 storage class memory.
  *
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 82f05c4b8c52..ea6a2d0b2894 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * VFIO based Physical Subchannel device driver
  *
-- 
2.15.0
