Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D52C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B742B60234
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhJ0Quo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:50:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61124 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237657AbhJ0Qun (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Oct 2021 12:50:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGlOd2032020
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yoXbq0ZKJQYZ1hqWIhvQoiQkG+Ch4lwWT1sorU8uG/U=;
 b=BZphs5O5opQYhlf3cAT3XwGSicMKQuVg3u0ZASAO4a/7ubFP49/CzCgsUoGE5cjtMorP
 +KtIHNwESiBygajee8uETL9bm1yVQKxtytCi6z8D9WPySQsHPkDMBdutlqjD9pYriZVl
 xg25VuNbvYegiARPFC2hlRlW5+84EJZM2PG5tx2njiQjeWRWIoq38XJ4QKrHCdF5eao8
 dOP6051Bjk8HDWh6m4RAlDlJLWJo5u/3j/5KyD7Fz+hy27Kl3nO38HkhpOCBG9HfmkjT
 W/d1pIaMwKU4w+vyQ6P0RijVC+7X1PHJsY6yYuft5wphLNvtXsU80U8xcx8o7aw2BROj ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by8udtxvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:17 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19RG2NnU031064
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:17 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3by8udtxv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19RGRT6L001671;
        Wed, 27 Oct 2021 16:48:16 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3bx4f884hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19RGmFBX36438494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 16:48:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CFF28058;
        Wed, 27 Oct 2021 16:48:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953C828064;
        Wed, 27 Oct 2021 16:48:14 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.65.227.42])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Oct 2021 16:48:14 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH 2/2] s390/vfio-ap: add status attribute to AP queue device's sysfs dir
Date:   Wed, 27 Oct 2021 12:48:10 -0400
Message-Id: <20211027164810.19678-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027164810.19678-1-akrowiak@linux.ibm.com>
References: <20211027164810.19678-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RsXMIJFCfg4i9Ha8PJI7_Vds9dO4bnhV
X-Proofpoint-GUID: rmL8WAwyyEgdoUsKlD8FxN-Eze8Z1J4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch adds a sysfs 'status' attribute to a queue device when it is
bound to the vfio_ap device driver. The field displays a string indicating
the status of the queue device:

Status String:  Indicates:
-------------   ---------
"assigned"      the queue is assigned to an mdev, but is not in use by a
                KVM guest.
"in use"        the queue is assigned to an mdev and is in use by a KVM
                guest.
"unassigned"    the queue is not assigned to an mdev.

The status string will be displayed by the 'lszcrypt' command if the queue
device is bound to the vfio_ap device driver.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
[akrowiak@linux.ibm.com: added check for queue in use by guest]
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 79 +++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 03311a476366..e043ae236630 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -17,6 +17,9 @@
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
 #define VFIO_AP_DEV_NAME "matrix"
+#define AP_QUEUE_ASSIGNED "assigned"
+#define AP_QUEUE_UNASSIGNED "unassigned"
+#define AP_QUEUE_IN_USE "in use"
 
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
@@ -41,26 +44,95 @@ static struct ap_device_id ap_queue_ids[] = {
 
 MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
 
+static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
+			return matrix_mdev;
+	}
+
+	return NULL;
+}
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	ssize_t nchars = 0;
+	struct vfio_ap_queue *q;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_device *apdev = to_ap_dev(dev);
+
+	mutex_lock(&matrix_dev->lock);
+	q = dev_get_drvdata(&apdev->device);
+	matrix_mdev = vfio_ap_mdev_for_queue(q);
+
+	if (matrix_mdev) {
+		if (matrix_mdev->kvm)
+			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
+					   AP_QUEUE_IN_USE);
+		else
+			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
+					   AP_QUEUE_ASSIGNED);
+	} else {
+		nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
+				   AP_QUEUE_UNASSIGNED);
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return nchars;
+}
+
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *vfio_queue_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static const struct attribute_group vfio_queue_attr_group = {
+	.attrs = vfio_queue_attrs,
+};
+
 /**
  * vfio_ap_queue_dev_probe: Allocate a vfio_ap_queue structure and associate it
  *			    with the device as driver_data.
  *
  * @apdev: the AP device being probed
  *
- * Return: returns 0 if the probe succeeded; otherwise, returns -ENOMEM if
- *	   storage could not be allocated for a vfio_ap_queue object.
+ * Return: returns 0 if the probe succeeded; otherwise, returns an error if
+ *	   storage could not be allocated for a vfio_ap_queue object or the
+ *	   sysfs 'status' attribute could not be created for the queue device.
  */
 static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 {
+	int ret;
 	struct vfio_ap_queue *q;
 
 	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (!q)
 		return -ENOMEM;
+
+	mutex_lock(&matrix_dev->lock);
 	dev_set_drvdata(&apdev->device, q);
 	q->apqn = to_ap_queue(&apdev->device)->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
-	return 0;
+
+	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
+	if (ret) {
+		dev_set_drvdata(&apdev->device, NULL);
+		kfree(q);
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return ret;
 }
 
 /**
@@ -75,6 +147,7 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	mutex_lock(&matrix_dev->lock);
+	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	q = dev_get_drvdata(&apdev->device);
 	vfio_ap_mdev_reset_queue(q, 1);
 	dev_set_drvdata(&apdev->device, NULL);
-- 
2.31.1

