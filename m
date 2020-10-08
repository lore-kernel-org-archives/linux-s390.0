Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgJHNNn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 09:13:43 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v2 01/10] s390/cio: Export information about Endpoint-Security Capability
Date: Thu,  8 Oct 2020 15:13:27 +0200
Message-Id: <20201008131336.61100-2-sth@linux.ibm.com>
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Sebastian Ott <sebott@linux.ibm.com>

Add a new sysfs attribute 'esc' per chpid. This new attribute exports
the Endpoint-Security-Capability byte of channel-path description block,
which could be 0-None, 1-Authentication, 2 and 3-Encryption.

For example:
$ cat /sys/devices/css0/chp0.34/esc
0

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
[vneethv@linux.ibm.com: cleaned-up & modified description]
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/cio/chp.c  | 15 +++++++++++++++
 drivers/s390/cio/chsc.h |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index dfcbe54591fb..8d0de6adcad0 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct device *dev,
 }
 static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL);
 
+static ssize_t chp_esc_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+	ssize_t rc;
+
+	mutex_lock(&chp->lock);
+	rc = sprintf(buf, "%x\n", chp->desc_fmt1.esc);
+	mutex_unlock(&chp->lock);
+
+	return rc;
+}
+static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
+
 static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *attr, char *buf,
 				loff_t off, size_t count)
@@ -414,6 +428,7 @@ static struct attribute *chp_attrs[] = {
 	&dev_attr_shared.attr,
 	&dev_attr_chid.attr,
 	&dev_attr_chid_external.attr,
+	&dev_attr_esc.attr,
 	NULL,
 };
 static struct attribute_group chp_attr_group = {
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 7ecf7e4c402e..4f049d17355d 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -27,7 +27,8 @@ struct channel_path_desc_fmt1 {
 	u8 lsn;
 	u8 desc;
 	u8 chpid;
-	u32:24;
+	u32:16;
+	u8 esc;
 	u8 chpp;
 	u32 unused[2];
 	u16 chid;
-- 
2.17.1
