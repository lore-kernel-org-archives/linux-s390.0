Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 3/3] s390/cmf: fix kerneldoc
Date: Tue, 23 Jan 2018 16:02:45 +0100
Message-Id: <20180123150245.30312-4-cohuck@redhat.com>
In-Reply-To: <20180123150245.30312-1-cohuck@redhat.com>
References: <20180123150245.30312-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: corbet@lwn.net, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Make sure we use proper Return sections, and make the output
for cmf_enable() less odd.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/cmf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 5e495c62cfa7..6e4f50d5b655 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1118,9 +1118,10 @@ int ccw_set_cmf(struct ccw_device *cdev, int enable)
  * enable_cmf() - switch on the channel measurement for a specific device
  *  @cdev:	The ccw device to be enabled
  *
- *  Returns %0 for success or a negative error value.
- *  Note: If this is called on a device for which channel measurement is already
- *	  enabled a reset of the measurement data is triggered.
+ *  Enable channel measurements for @cdev. If this is called on a device
+ *  for which channel measurement is already enabled a reset of the
+ *  measurement data is triggered.
+ *  Returns: %0 for success or a negative error value
  *  Context:
  *    non-atomic
  */
@@ -1160,7 +1161,7 @@ int enable_cmf(struct ccw_device *cdev)
  * __disable_cmf() - switch off the channel measurement for a specific device
  *  @cdev:	The ccw device to be disabled
  *
- *  Returns %0 for success or a negative error value.
+ *  Returns: %0 for success or a negative error value.
  *
  *  Context:
  *    non-atomic, device_lock() held.
@@ -1184,7 +1185,7 @@ int __disable_cmf(struct ccw_device *cdev)
  * disable_cmf() - switch off the channel measurement for a specific device
  *  @cdev:	The ccw device to be disabled
  *
- *  Returns %0 for success or a negative error value.
+ *  Returns: %0 for success or a negative error value.
  *
  *  Context:
  *    non-atomic
@@ -1205,7 +1206,7 @@ int disable_cmf(struct ccw_device *cdev)
  * @cdev:	the channel to be read
  * @index:	the index of the value to be read
  *
- * Returns the value read or %0 if the value cannot be read.
+ * Returns: The value read or %0 if the value cannot be read.
  *
  *  Context:
  *    any
@@ -1220,7 +1221,7 @@ u64 cmf_read(struct ccw_device *cdev, int index)
  * @cdev:	the channel to be read
  * @data:	a pointer to a data block that will be filled
  *
- * Returns %0 on success, a negative error value otherwise.
+ * Returns: %0 on success, a negative error value otherwise.
  *
  *  Context:
  *    any
-- 
2.13.6
