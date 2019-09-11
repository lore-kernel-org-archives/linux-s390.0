Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfIKQlH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Sep 2019 12:41:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390/cio: fix intparm documentation
Date: Wed, 11 Sep 2019 18:41:03 +0200
Message-Id: <20190911164103.16156-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The common I/O layer is maintaining an "intparm" inspired by
the hardware intparm for driver usage. This "intparm" is not
only applicaple for ssch, but also for hsch/csch. The kerneldoc
states that it is only updated for hsch/csch if no prior request
is pending; however, this is not what the code does (whether
that would actually desireable is a different issue.)

Let's at least fix the kerneldoc for now.

Fixes: b2ffd8e9a76e ("[S390] cio: Add docbook comments.")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/device_ops.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index d722458c5928..65841af15748 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -124,9 +124,7 @@ EXPORT_SYMBOL(ccw_device_is_multipath);
 /**
  * ccw_device_clear() - terminate I/O request processing
  * @cdev: target ccw device
- * @intparm: interruption parameter; value is only used if no I/O is
- *	     outstanding, otherwise the intparm associated with the I/O request
- *	     is returned
+ * @intparm: interruption parameter to be returned upon conclusion of csch
  *
  * ccw_device_clear() calls csch on @cdev's subchannel.
  * Returns:
@@ -179,6 +177,9 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
  * completed during the time specified by @expires. If a timeout occurs, the
  * channel program is terminated via xsch, hsch or csch, and the device's
  * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
+ * The interruption handler will echo back the @intparm specified here, unless
+ * another interruption parameter is specified by a subsequent invocation of
+ * ccw_device_halt() or ccw_device_clear().
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -256,6 +257,9 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
  * Start a S/390 channel program. When the interrupt arrives, the
  * IRQ handler is called, either immediately, delayed (dev-end missing,
  * or sense required) or never (no IRQ handler registered).
+ * The interruption handler will echo back the @intparm specified here, unless
+ * another interruption parameter is specified by a subsequent invocation of
+ * ccw_device_halt() or ccw_device_clear().
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -287,6 +291,9 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
  * Start a S/390 channel program. When the interrupt arrives, the
  * IRQ handler is called, either immediately, delayed (dev-end missing,
  * or sense required) or never (no IRQ handler registered).
+ * The interruption handler will echo back the @intparm specified here, unless
+ * another interruption parameter is specified by a subsequent invocation of
+ * ccw_device_halt() or ccw_device_clear().
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -322,6 +329,9 @@ int ccw_device_start(struct ccw_device *cdev, struct ccw1 *cpa,
  * completed during the time specified by @expires. If a timeout occurs, the
  * channel program is terminated via xsch, hsch or csch, and the device's
  * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
+ * The interruption handler will echo back the @intparm specified here, unless
+ * another interruption parameter is specified by a subsequent invocation of
+ * ccw_device_halt() or ccw_device_clear().
  * Returns:
  *  %0, if the operation was successful;
  *  -%EBUSY, if the device is busy, or status pending;
@@ -343,11 +353,12 @@ int ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
 /**
  * ccw_device_halt() - halt I/O request processing
  * @cdev: target ccw device
- * @intparm: interruption parameter; value is only used if no I/O is
- *	     outstanding, otherwise the intparm associated with the I/O request
- *	     is returned
+ * @intparm: interruption parameter to be returned upon conclusion of hsch
  *
  * ccw_device_halt() calls hsch on @cdev's subchannel.
+ * The interruption handler will echo back the @intparm specified here, unless
+ * another interruption parameter is specified by a subsequent invocation of
+ * ccw_device_clear().
  * Returns:
  *  %0 on success,
  *  -%ENODEV on device not operational,
-- 
2.20.1
