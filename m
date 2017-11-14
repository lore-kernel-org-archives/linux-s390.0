Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/9] s390: virtio: add SPDX identifiers to the remaining files
Date: Tue, 14 Nov 2017 18:38:06 +0100
Message-Id: <20171114173808.25092-8-gregkh@linuxfoundation.org>
In-Reply-To: <20171114173808.25092-1-gregkh@linuxfoundation.org>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-ID: <linux-s390.vger.kernel.org>

It's good to have SPDX identifiers in all files to make it easier to
audit the kernel tree for correct licenses.

Update the drivers/s390/virtio/ files with the correct SPDX license
identifier based on the license text in the file itself.  The SPDX
identifier is a legally binding shorthand, which can be used instead of
the full boiler plate text.

This work is based on a script and data from Thomas Gleixner, Philippe
Ombredanne, and Kate Stewart.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/virtio/Makefile     | 1 +
 drivers/s390/virtio/virtio_ccw.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
index f68af1f317f1..7c6f0c8db883 100644
--- a/drivers/s390/virtio/Makefile
+++ b/drivers/s390/virtio/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Makefile for kvm guest drivers on s390
 #
 # Copyright IBM Corp. 2008
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b18fe2014cf2..56346caadb21 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ccw based virtio transport
  *
-- 
2.15.0
