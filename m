Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE55FC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B338660F21
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbhJ0Qun (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:50:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239889AbhJ0Qum (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Oct 2021 12:50:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGIVYH012421
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IosX5FvChmIZ0OBhVhir4/ZVwQ6pVgzITn4O5ad4jlc=;
 b=HZ7jTm4LURVvuvOgWCVT0FslZd1iaq+ibnf5oG1YJuklv/Zm0NxmE74peCSXpIvLFlEh
 BgzoWWaNW7/N7Td0yTdPIb3vED5G3TQ/FwT5v1C7j13COMPbqfLVeBV8ljoMPgpWostT
 dwkex60o8D3X7KPvYsDdzX/Ljm5A3gXdGBf5WVvuGfv3mL74tAQ7JAg9K/JrxNSlJ0z/
 SPRYUaL3js7HpoRyqnETNQt3tuhrJYk1pLh45tTznbp3imyu11dJ03B08373gJCBHniu
 5duhu6q8rq0ZJqIwIKg4cycfOikkScWFu/uT4lUngAEWCUlI2BemITDBufCBk1csdVgu pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bya5rgqd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:16 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19RGgMXN015656
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 16:48:16 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bya5rgqcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:16 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19RGRtub009117;
        Wed, 27 Oct 2021 16:48:15 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3bx4eg6qdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 16:48:15 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19RGmETA12190546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 16:48:14 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7381C2805A;
        Wed, 27 Oct 2021 16:48:14 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67E6F28064;
        Wed, 27 Oct 2021 16:48:13 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.65.227.42])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Oct 2021 16:48:13 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH 1/2] s390/vfio-ap: s390/crypto: fix all kernel-doc warnings
Date:   Wed, 27 Oct 2021 12:48:09 -0400
Message-Id: <20211027164810.19678-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027164810.19678-1-akrowiak@linux.ibm.com>
References: <20211027164810.19678-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -T_H4VX6NMwVXsyENa6aXjVHnuu2KhTs
X-Proofpoint-ORIG-GUID: wCPazks_NIdZrK8nYyNwmA60zgw_9TUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_04,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fixes the kernel-doc warnings in the following source files:

* drivers/s390/crypto/vfio_ap_private.h
* drivers/s390/crypto/vfio_ap_drv.c
* drivers/s390/crypto/vfio_ap_ops.c

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 16 ++++++----
 drivers/s390/crypto/vfio_ap_ops.c     |  5 ++--
 drivers/s390/crypto/vfio_ap_private.h | 43 +++++++++++++++++++--------
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 4d2556bc7fe5..03311a476366 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -42,10 +42,13 @@ static struct ap_device_id ap_queue_ids[] = {
 MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
 
 /**
- * vfio_ap_queue_dev_probe:
+ * vfio_ap_queue_dev_probe: Allocate a vfio_ap_queue structure and associate it
+ *			    with the device as driver_data.
  *
- * Allocate a vfio_ap_queue structure and associate it
- * with the device as driver_data.
+ * @apdev: the AP device being probed
+ *
+ * Return: returns 0 if the probe succeeded; otherwise, returns -ENOMEM if
+ *	   storage could not be allocated for a vfio_ap_queue object.
  */
 static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 {
@@ -61,10 +64,11 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 }
 
 /**
- * vfio_ap_queue_dev_remove:
+ * vfio_ap_queue_dev_remove: Free the associated vfio_ap_queue structure.
+ *
+ * @apdev: the AP device being removed
  *
- * Takes the matrix lock to avoid actions on this device while removing
- * Free the associated vfio_ap_queue structure
+ * Takes the matrix lock to avoid actions on this device while doing the remove.
  */
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 623d5269a52c..94c1c9bd58ad 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -187,6 +187,8 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
  * vfio_ap_irq_enable - Enable Interruption for a APQN
  *
  * @q:	 the vfio_ap_queue holding AQIC parameters
+ * @isc: the guest ISC to register with the GIB interface
+ * @nib: the notification indicator byte to pin.
  *
  * Pin the NIB saved in *q
  * Register the guest ISC to GIB interface and retrieve the
@@ -738,7 +740,6 @@ vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
  * assign_domain_store - parses the APQI from @buf and sets the
  * corresponding bit in the mediated matrix device's AQM
  *
- *
  * @dev:	the matrix device
  * @attr:	the mediated matrix device's assign_domain attribute
  * @buf:	a buffer containing the AP queue index (APQI) of the domain to
@@ -866,7 +867,6 @@ static DEVICE_ATTR_WO(unassign_domain);
  * assign_control_domain_store - parses the domain ID from @buf and sets
  * the corresponding bit in the mediated matrix device's ADM
  *
- *
  * @dev:	the matrix device
  * @attr:	the mediated matrix device's assign_control_domain attribute
  * @buf:	a buffer containing the domain ID to be assigned
@@ -1142,6 +1142,7 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
  * by @matrix_mdev.
  *
  * @matrix_mdev: a matrix mediated device
+ * @kvm: the pointer to the kvm structure being unset.
  *
  * Note: The matrix_dev->lock must be taken prior to calling
  * this function; however, the lock will be temporarily released while the
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 77760e2b546f..648fcaf8104a 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -26,16 +26,18 @@
 #define VFIO_AP_DRV_NAME "vfio_ap"
 
 /**
- * ap_matrix_dev - the AP matrix device structure
+ * struct ap_matrix_dev - Contains the data for the matrix device.
+ *
  * @device:	generic device structure associated with the AP matrix device
  * @available_instances: number of mediated matrix devices that can be created
  * @info:	the struct containing the output from the PQAP(QCI) instruction
- * mdev_list:	the list of mediated matrix devices created
- * lock:	mutex for locking the AP matrix device. This lock will be
+ * @mdev_list:	the list of mediated matrix devices created
+ * @lock:	mutex for locking the AP matrix device. This lock will be
  *		taken every time we fiddle with state managed by the vfio_ap
  *		driver, be it using @mdev_list or writing the state of a
  *		single ap_matrix_mdev device. It's quite coarse but we don't
  *		expect much contention.
+ * @vfio_ap_drv: the vfio_ap device driver
  */
 struct ap_matrix_dev {
 	struct device device;
@@ -49,17 +51,19 @@ struct ap_matrix_dev {
 extern struct ap_matrix_dev *matrix_dev;
 
 /**
- * The AP matrix is comprised of three bit masks identifying the adapters,
- * queues (domains) and control domains that belong to an AP matrix. The bits i
- * each mask, from least significant to most significant bit, correspond to IDs
- * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
+ * struct ap_matrix - matrix of adapters, domains and control domains
  *
  * @apm_max: max adapter number in @apm
- * @apm identifies the AP adapters in the matrix
+ * @apm: identifies the AP adapters in the matrix
  * @aqm_max: max domain number in @aqm
- * @aqm identifies the AP queues (domains) in the matrix
+ * @aqm: identifies the AP queues (domains) in the matrix
  * @adm_max: max domain number in @adm
- * @adm identifies the AP control domains in the matrix
+ * @adm: identifies the AP control domains in the matrix
+ *
+ * The AP matrix is comprised of three bit masks identifying the adapters,
+ * queues (domains) and control domains that belong to an AP matrix. The bits in
+ * each mask, from left to right, correspond to IDs 0 to 255. When a bit is set
+ * the corresponding ID belongs to the matrix.
  */
 struct ap_matrix {
 	unsigned long apm_max;
@@ -71,13 +75,20 @@ struct ap_matrix {
 };
 
 /**
- * struct ap_matrix_mdev - the mediated matrix device structure
- * @list:	allows the ap_matrix_mdev struct to be added to a list
+ * struct ap_matrix_mdev - Contains the data associated with a matrix mediated
+ *			   device.
+ * @vdev:	the vfio device
+ * @node:	allows the ap_matrix_mdev struct to be added to a list
  * @matrix:	the adapters, usage domains and control domains assigned to the
  *		mediated matrix device.
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
+ * @iommu_notifier: notifier block used for specifying callback function for
+ *		    handling the VFIO_IOMMU_NOTIFY_DMA_UNMAP even
  * @kvm:	the struct holding guest's state
+ * @pqap_hook:	the function pointer to the interception handler for the
+ *		PQAP(AQIC) instruction.
+ * @mdev:	the mediated device
  */
 struct ap_matrix_mdev {
 	struct vfio_device vdev;
@@ -90,6 +101,14 @@ struct ap_matrix_mdev {
 	struct mdev_device *mdev;
 };
 
+/**
+ * struct vfio_ap_queue - contains the data associated with a queue bound to the
+ *			  vfio_ap device driver
+ * @matrix_mdev: the matrix mediated device
+ * @saved_pfn: the guest PFN pinned for the guest
+ * @apqn: the APQN of the AP queue device
+ * @saved_isc: the guest ISC registered with the GIB interface
+ */
 struct vfio_ap_queue {
 	struct ap_matrix_mdev *matrix_mdev;
 	unsigned long saved_pfn;
-- 
2.31.1

