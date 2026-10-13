Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D0535FCD;
	Tue, 13 Oct 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905579; cv=none; b=rmqQDRdcg140pp15IOu4R8i43IdTgyohFFmBFEc7+5duD5VIoq0xQ/LK6ZzAEF0JYzeEeQ5Mrgb4yn8ofAteyHWdHD2Tvpl59Div2PT84lHmHJ/t7xxlXAwYyz/dWZPJq4YJMXz7NzIpt92NqWqC5jtpwKSpPZ5klJMiy4rVFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905579; c=relaxed/simple;
	bh=DiCq55B4qucF9iFiQCHd+74dgbDphFrE2rKIUmPnrg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plbaqDTZhe+Stx42yopMQR3tU5wshmU30PVU+FsBFrkVB1s8w7+AnicUDLjzHo0xbaXgsVrhPW8o9mnGrhudCGQELpZwYaGnJECehK3+PNppdokeAT7DOt3uVSQYqStX5tyKn8ZcbOzur7Z3+SGpR5xUkTwvjf4suKljLu2zPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pYrVLi7q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pYrVLi7q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDYYGU150087;
	Tue, 13 Oct 2026 15:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IPtq2SSWtfLroDjHR
	frUQtfCRbL/27GelgdOm9OZgWc=; b=pYrVLi7q38l2opT79DJ3ufr3GnCDYu70E
	p0WKFNN2dtX7gjjJyR9tQRGHseQr9Fw80FSr+BrRce3PAi+xIN+L5luq2cuZWwXP
	GrnLBqOPa37l77MpK75G2aKE3esNxuDx59dV7xWKlYELNMIQJh6Uf4ay8XoFJ+Ux
	Swyk7GImSlpxUCIcD0ZKEr0bgBWgutjD4i7i5r33tGEhE9u3Vze9YB2FFspcXt70
	UaYsrgejba02W3OgQtBbGpTDGxFdhdmHR/JArqVs0VbWEqHmNd3Km1nQllT/fDZY
	/4cb9h7E2lCAPoH1eTYvdryIBx0Mqz+wGjtjpKmljbdJE47QajHmA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhf2v6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCPWhP2667224;
	Tue, 13 Oct 2026 15:32:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vtrpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWg0753412302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08B535806A;
	Tue, 13 Oct 2026 15:32:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581E258063;
	Tue, 13 Oct 2026 15:32:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:40 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 11/15] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Tue, 13 Oct 2026 11:32:15 -0400
Message-ID: <20261013153219.3534306-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXxMM+WGuG0GAF
 ierMYzQt0Vgy9yRIQXxMN2xtI9zRYzrzWL0nE8d0wuxcQUQO5mXhWBXYkyHAxR3e3Z6bGfKeZPn
 5LxzESSxYVwyJAlchUC0inLgv6UVRyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXw3WQIrkcHdbW
 FFU3PgL3bqmHL8FPBCvku7t93B5UElPXbbV9o15+m6L2RZC8LA6zKKY2JvQXIpoV/doPR12kdTV
 X3TWBe46UOq997lodAy8R2B8ZhOixxz1TvgdYNQobJjMNDACdSibnj7oJFc7+0DrxMUVYN1QHZH
 8gxlwN+rdd4PrB6IbqX+1ExJYeoXT6XKvVK/RzvZIyjTy6KTkIxrWMGp+z1ZOz2jbwmufDlhd5p
 9226CSdyIe1JwaEGvRUNY82M6xGMN8F59eTToQDxO9pBPSMzCCbjYT92yRphmMr+5lY64oga03R
 D6MVab5eB1qRz6hCUO5mOvurfQ+agnTSoMAbw//EUswQ3RzwXjc0B/5iryz4VCxKvKLyWWkXMp5
 0tZBWXPCcFSBb2oRwskuwzrZKGmXFp6vkB+CsISVdx7EFkwgI2g3/5ORB+hnIvJUOawpI9I1yTR
 9dE82ri5b32yRoMYdvg==
X-Proofpoint-GUID: ekeFxm5ggg71A2bRdMs_0hIJ2BXbsOaF
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace4f1c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VNY0xBRuMkiM1X0ihcwA:9
X-Proofpoint-ORIG-GUID: ekeFxm5ggg71A2bRdMs_0hIJ2BXbsOaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

Implements the 'write' callback function that was added to the
'file_operations' structure for the file stream created to restore the
state of the vfio-ap device on the destination system when the migration
state transitioned from STOP to RESUMING.

Userspace reads the source guest's saved vfio-ap device state, i.e., its
AP configuration, from the file stream created when the source device
state transitioned from STOP to STOP_COPY and writes it to this file
stream, possibly in multiple chunks. The write callback copies each chunk
into a pre-allocated vfio_ap_config structure. Once all of the data has
been received, the source guest's AP configuration is validated against
the destination host's and, if compatible, set as the destination guest's
AP configuration, hot plugging and unplugging adapters, domains and
control domains as needed.

In order for the source guest's and destination host's AP configurations
to be considered compatible:

* The migration data must carry the expected magic number and version

* Each APQN in the source guest's AP configuration must also be in the
  destination host's AP configuration

* Each matching APQN ... (unchanged)

* Each control domain in the source guest's AP configuration must be
  installed on the destination host

* [existing hardware list, plus]
  - The source and destination queues must have the same SLCF facility
    setting

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 748 +++++++++++++++++++++++-
 1 file changed, 739 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index d4da68a69953..52466864ee75 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -12,6 +12,61 @@
 #define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
 #define VFIO_AP_MIG_VERSION			1U
 
+/*
+ * Masks the fields of the queue information returned from the PQAP(TAPQ)
+ * command. In order to migrate a guest, it's AP configuration must be
+ * compatible with AP configuration assigned to the target guest's mdev.
+ * This mask is used to verify that the queue information for each source and
+ * target queue is compatible.
+ *
+ * The following bits must match for the source device and the corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * S bit 0: APSC  facility installed
+ * M bit 1: APQKM facility installed
+ * C bit 2: AP4KC facility installed
+ * Mode bits 3-5:
+ *     D bit 3: CCA-mode facility
+ *     A bit 4: accelerator-mode facility
+ *     X bit 5: XCP-mode facility
+ * N  bit 6: APXA facility installed
+ * SL bit 7: SLCF facility installed
+ *
+ * Either bit 8 or bit 9 will be set. If bit 8 is set for the source device,
+ * then it must also be set for the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * Classification (functional capabilities) bits 8-16
+ *     bit 8: Native card function
+ *     bit 9: Only stateless functions
+ *
+ * The BS bits must be set to 0 for both the source and corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * BS bits 16-17:
+ *
+ * The AP type of the source device must be less than or equal to that of
+ * the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * AP Type bits 32-40:
+ */
+#define QINFO_DATA_MASK		0xffffc000ff000000
+
+/*
+ * Masks the bit that indicates whether full native card function is available
+ * from the 8 bits specifying the functional capabilities of a queue
+ */
+#define CLASSIFICATION_NATIVE_FCN_MASK		0x80
+
+/* The maximum number of queues that can be installed in an s390 system */
+#define MAX_AP_QUEUES				(AP_DEVICES * AP_DOMAINS)
+
+/* The maximum size of a vfio_ap_config blob, used to pre-allocate the receive
+ * buffer on the destination host during the RESUMING phase of migration.
+ */
+#define VFIO_AP_CONFIG_MAX_SIZE \
+	(sizeof(struct vfio_ap_config) + \
+	 MAX_AP_QUEUES * sizeof(struct vfio_ap_queue_info))
+
 /**
  * struct vfio_ap_migration_file
  *
@@ -125,9 +180,10 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 
 static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
 {
-	/* Stub to be implemented when the mig_data->resuming_mig_file.ap_config
-	 * object is allocated.
-	 */
+	kvfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+	mig_data->resuming_mig_file.filp = NULL;
 }
 
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
@@ -218,7 +274,7 @@ static int get_hardware_info_for_queue(const char *mdev_name,
 		/* For all these RCs the tapq info should be available */
 		return 0;
 	case AP_RESPONSE_Q_NOT_AVAIL:
-		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
 				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
 				   status.response_code);
 		return -ENODEV;
@@ -230,7 +286,7 @@ static int get_hardware_info_for_queue(const char *mdev_name,
 		if (status.async)
 			return 0;
 
-		pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
 				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
 				   status.response_code);
 		return -EIO;
@@ -284,7 +340,7 @@ static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
 
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 
-	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
+	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
 
 	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
 	if (!ap_configuration)
@@ -439,11 +495,663 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
 	return filp;
 }
 
+static int validate_resuming_write_parms(struct file *filp, size_t len)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t total_len;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!len || filp->f_pos < 0)
+		return -EINVAL;
+
+	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
+		return -ERANGE;
+
+	matrix_mdev = filp->private_data;
+	if (!matrix_mdev || !matrix_mdev->mig_data)
+		return -ENODEV;
+
+	mig_data = matrix_mdev->mig_data;
+
+	if (filp != mig_data->resuming_mig_file.filp)
+		return -ENXIO;
+
+	/* Reject writes that would overflow the pre-allocated buffer */
+	if (filp->f_pos + len > VFIO_AP_CONFIG_MAX_SIZE)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * qdev_is_bound_to_vfio_ap:
+ *
+ * Query to determine whether a queue with the specified APQN is available on
+ * the host system and bound to the vfio_ap device driver.
+ *
+ * @apqn: The APQN of the queue device being queried
+ *
+ * Returns: True if there is a queue device with the specified @apqn installed
+ *	    in the system and is bound to the vfio_ap device driver; otherwise,
+ *	    returns false.
+ */
+static bool qdev_is_bound_to_vfio_ap(unsigned int apqn)
+{
+	struct ap_queue *queue;
+	bool is_bound = true;
+
+	queue = ap_get_qdev(apqn);
+	if (!queue)
+		return false;
+
+	if (queue->ap_dev.device.driver != &matrix_dev->vfio_ap_drv->driver)
+		is_bound = false;
+
+	put_device(&queue->ap_dev.device);
+
+	return is_bound;
+}
+
+/**
+ * queues_available:
+ *
+ * Query whether each queue from the source guest's AP configuration is
+ * available and bound to the vfio_ap device driver; if not, log an error
+ * message.
+ *
+ * @mdev_name:	   The mdev name to use in error messages
+ * @source_config: The object specifying the source guest's AP configuration
+ *
+ * Returns: true if each queue identified in @source_config is available and
+ *	    bound to the vfio_ap device driver; otherwise, returns false.
+ */
+static bool queues_available(const char *mdev_name,
+			     struct vfio_ap_config *source_config)
+{
+	unsigned long apqn;
+	bool ret = true;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+
+		/*
+		 * Find the queue device bound to the vfio_ap device driver. If it is
+		 * not found, log an error and continue so users see all problems
+		 * at once, not one-at-a-time through retries of the migration.
+		 */
+		if (!qdev_is_bound_to_vfio_ap(apqn)) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Queue %02lx.%04lx not available to vfio_ap driver on target host\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+			ret = false;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * control_domains_available
+ *
+ * Query whether each control domain specified in the source guest's AP
+ * configuration is installed in the host system.
+ *
+ * @mdev_name:		The name of the mdev to use when logging messages
+ * @source_config:	The object specifying the source guest's AP config
+ *
+ * Returns:	True if each control domain is installed; otherwise, logs an
+ *		error message for each unavailable control domain and returns
+ *		false.
+ */
+static bool control_domains_available(const char *mdev_name,
+				      struct vfio_ap_config *source_config)
+{
+	unsigned long domain_num;
+	bool available = true;
+
+	for_each_set_bit_inv(domain_num, (unsigned long *)source_config->adm,
+			     AP_DOMAINS) {
+		if (ap_test_config_ctrl_domain(domain_num))
+			continue;
+
+		pr_err_ratelimited("vfio_ap_mdev: %s: Control domain %04lx not available on the destination host\n",
+				   mdev_name, domain_num);
+		available = false;
+	}
+
+	return available;
+}
+
+static void report_facilities_compatibility(const char *mdev_name,
+					    unsigned long apqn,
+					    struct ap_tapq_hwinfo *src_hwinfo,
+					    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apsc != target_hwinfo->apsc) {
+		if (src_hwinfo->apsc) {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->mex4k != target_hwinfo->mex4k) {
+		if (src_hwinfo->mex4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->crt4k != target_hwinfo->crt4k) {
+		if (src_hwinfo->crt4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_mode_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->cca != target_hwinfo->cca) {
+		if (src_hwinfo->cca) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->accel != target_hwinfo->accel) {
+		if (src_hwinfo->accel) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->ep11 != target_hwinfo->ep11) {
+		if (src_hwinfo->ep11) {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_apxa_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apxa != target_hwinfo->apxa) {
+		if (src_hwinfo->apxa) {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_slcf_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->slcf != target_hwinfo->slcf) {
+		if (src_hwinfo->slcf) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_bs_compatibility(const char *mdev_name,
+				    unsigned long apqn,
+				    struct ap_tapq_hwinfo *src_hwinfo,
+				    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	/*
+	 * The BS field on both the source and destination must be 0, so if one
+	 * of them is not, then report an error.
+	 */
+	if (src_hwinfo->bs || target_hwinfo->bs) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Bind/associate state for source (%01x) and target (%01x) queue %02lx.%04lx must be 0\n",
+				   mdev_name, src_hwinfo->bs, target_hwinfo->bs,
+				   AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+static void report_aptype_compatibility(const char *mdev_name,
+					unsigned long apqn,
+					struct ap_tapq_hwinfo *src_hwinfo,
+					struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->at > target_hwinfo->at) {
+		pr_err_ratelimited("vfio_ap_mdev %s: AP type of source (%02x) not compatible with target (%02x)\n",
+				   mdev_name, src_hwinfo->at, target_hwinfo->at);
+	}
+}
+
+static bool classes_compatible(struct ap_tapq_hwinfo *src_hwinfo,
+			       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_native, target_native;
+
+	src_native = src_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+	target_native = target_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+
+	/*
+	 * If the source queue has full native card function and the
+	 * target queue has only stateless functions available, then
+	 * there may be instructions that will not execute on the
+	 * target queue. This shall be reported as an error.
+	 *
+	 * If the source queue has only stateless card functions and the
+	 * target queue has full native card function available, then
+	 * we are okay because the target queue can run all stateless card
+	 * functions.
+	 */
+	return (src_native != target_native) ? !src_native : true;
+}
+
+static void report_class_compatibility(const char *mdev_name,
+				       unsigned long apqn,
+				       struct ap_tapq_hwinfo *src_hwinfo,
+				       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (!classes_compatible(src_hwinfo, target_hwinfo)) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Full native card function available on source queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+		pr_err_ratelimited("vfio_ap_mdev %s: Only stateless functions available on target queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+/*
+ * Log a device error reporting that migration failed due to queue
+ * incompatibilities followed by a device error for each incompatible feature.
+ */
+static void report_qinfo_incompatibilities(const char *mdev_name,
+					   unsigned long apqn,
+					   struct ap_tapq_hwinfo *src_hwinfo,
+					   struct ap_tapq_hwinfo *target_hwinfo)
+{
+	pr_err_ratelimited("vfio_ap_mdev %s: Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
+			   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	report_facilities_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_mode_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_apxa_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_slcf_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_aptype_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_bs_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_class_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+}
+
+/**
+ * queue_hardware_info_is_compatible:
+ *
+ * Verify whether the hardware information for a source queue is compatible with
+ * the hardware info for the corresponding queue on this system.
+ *
+ * In order to be compatible, the hardware information for each queue must
+ * meet the following requirements:
+ *
+ * 1. The hardware facilities bits much match
+ * 2. The AP type of the source queue must be the same as or older than that
+ *    of the target queue (target is backwards compatible)
+ * 3. The classification bits must indicate:
+ *    - Both queues have full native card function or both have stateless
+ *      functions available
+ *    - If the classification bits don't match, then the only acceptable
+ *      configuration is stateless functions for the source queue and
+ *      full native function for the target queue
+ * 4. The BS bits for both queues must be 0 (Queue usable for all messages
+ *    supported by the adapter)
+ *
+ * @mdev_name:	The mdev name to use in error messages
+ * @apqn:	The APQN for the queues
+ * @src_hwinfo: The hardware info for the source queue
+ * @target_hwinfo: The hardware info for the corresponding queue on this system
+ *
+ * Returns: true if the hardware info for the two queues is compatible;
+ *          otherwise, returns false.
+ */
+static bool queue_hardware_info_is_compatible(const char *mdev_name,
+					      unsigned long apqn,
+					      struct ap_tapq_hwinfo *src_hwinfo,
+					      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_bits, target_bits;
+
+	src_bits = src_hwinfo->value & QINFO_DATA_MASK;
+	target_bits = target_hwinfo->value & QINFO_DATA_MASK;
+
+	/* If all bits match the queues are compatible */
+	if (src_bits == target_bits &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	if (src_hwinfo->apsc  == target_hwinfo->apsc     &&
+	    src_hwinfo->mex4k == target_hwinfo->mex4k    &&
+	    src_hwinfo->crt4k == target_hwinfo->crt4k    &&
+	    src_hwinfo->cca   == target_hwinfo->cca      &&
+	    src_hwinfo->accel == target_hwinfo->accel    &&
+	    src_hwinfo->ep11  == target_hwinfo->ep11     &&
+	    src_hwinfo->slcf  == target_hwinfo->slcf     &&
+	    src_hwinfo->apxa  == target_hwinfo->apxa     &&
+	    src_hwinfo->at    <= target_hwinfo->at       &&
+	    classes_compatible(src_hwinfo, target_hwinfo) &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	report_qinfo_incompatibilities(mdev_name, apqn, src_hwinfo, target_hwinfo);
+
+	return false;
+}
+
+/**
+ * verify_ap_configs_are_compatible:
+ *
+ * Verifies that the queues in the source guest's AP configuration are
+ * compatible with the corresponding queues on this system.
+ *
+ * @mdev_name:	   The mdev name to use in error messages
+ * @source_config: The object specifying the source guest's AP configuration
+ *
+ * Returns: an error indicating either a failure to retrieve a queue's
+ *			hardware information or one or more source queues are not
+ *			compatible with the corresponding queue on this system; otherwise,
+ *			returns zero to indicate compatibility.
+ */
+static int verify_ap_configs_are_compatible(const char *mdev_name,
+					    struct vfio_ap_config *source_config)
+{
+	struct ap_tapq_hwinfo src_hwinfo, dest_hwinfo;
+	unsigned long apqn;
+	int ret = 0, rc;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+
+		/*
+		 * If we can't get the hardware info for a particular queue, then let's
+		 * capture the function return code and continue so we can log all
+		 * errors to aid in debugging of migration.
+		 */
+		rc = get_hardware_info_for_queue(mdev_name, &dest_hwinfo, apqn);
+		if (rc) {
+			ret = rc;
+			continue;
+		}
+
+		src_hwinfo.value =  source_config->qinfo[i].data;
+
+		if (!queue_hardware_info_is_compatible(mdev_name, apqn,
+						       &src_hwinfo,
+						       &dest_hwinfo))
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int do_post_copy_validation(const char *mdev_name,
+				   struct vfio_ap_config *source_config)
+{
+	if (source_config->magic != VFIO_AP_MIG_MAGIC ||
+	    source_config->version != VFIO_AP_MIG_VERSION)
+		return -EINVAL;
+
+	if (!queues_available(mdev_name, source_config))
+		return -ENODEV;
+
+	if (!control_domains_available(mdev_name, source_config))
+		return -ENODEV;
+
+	return verify_ap_configs_are_compatible(mdev_name, source_config);
+}
+
+/**
+ * setup_ap_matrix_from_ap_config:
+ *
+ * Set the bits corresponding to the adapters, domains and control domains
+ * from the source guest's AP configuration into an ap_matrix object to be
+ * used to update the destination guest to run on this host.
+ *
+ * @ap_config:		The source guest's AP configuration
+ * @guest_matrix:	The object to be used to update the destination guest's
+ *			AP configuration
+ */
+static void setup_ap_matrix_from_ap_config(struct vfio_ap_config *ap_config,
+					   struct ap_matrix *guest_matrix)
+{
+	struct ap_config_info host_config_info = { 0 };
+	unsigned long apid, apqi, *guest_adm;
+	struct vfio_ap_queue_info qinfo;
+
+	ap_qci(&host_config_info);
+	/*
+	 * Zero the bitmaps before calling vfio_ap_matrix_init(), which only
+	 * sets the apm_max/aqm_max/adm_max scalar fields and leaves the bitmap
+	 * arrays untouched.  Without this, stack garbage in guest_matrix->apm,
+	 * ->aqm, and ->adm would grant the destination guest access to
+	 * arbitrary unassigned queues and control domains.
+	 */
+	memset(guest_matrix->apm, 0, sizeof(guest_matrix->apm));
+	memset(guest_matrix->aqm, 0, sizeof(guest_matrix->aqm));
+	memset(guest_matrix->adm, 0, sizeof(guest_matrix->adm));
+	vfio_ap_matrix_init(&host_config_info, guest_matrix);
+
+	for (int i = 0; i < ap_config->num_queues; i++) {
+		qinfo = ap_config->qinfo[i];
+		apid = AP_QID_CARD(qinfo.apqn);
+		apqi = AP_QID_QUEUE(qinfo.apqn);
+
+		if (!test_bit_inv(apid, guest_matrix->apm))
+			set_bit_inv(apid, guest_matrix->apm);
+		if (!test_bit_inv(apqi, guest_matrix->aqm))
+			set_bit_inv(apqi, guest_matrix->aqm);
+	}
+
+	guest_adm = (unsigned long *)ap_config->adm;
+	for_each_set_bit_inv(apqi, guest_adm, AP_DOMAINS) {
+		if (!test_bit_inv(apqi, guest_matrix->adm))
+			set_bit_inv(apqi, guest_matrix->adm);
+	}
+}
+
+static int do_post_copy_processing(struct ap_matrix_mdev *matrix_mdev,
+				   struct vfio_ap_config *ap_config)
+{
+	const char *mdev_name = dev_name(matrix_mdev->vdev.dev);
+	struct ap_matrix guest_matrix;
+	int ret;
+
+	lockdep_assert_held(&ap_attr_mutex);
+	assert_has_update_locks_for_mdev(matrix_mdev);
+
+	ret = do_post_copy_validation(mdev_name, ap_config);
+	if (ret)
+		return ret;
+
+	setup_ap_matrix_from_ap_config(ap_config, &guest_matrix);
+
+	return vfio_ap_set_new_guest_config(matrix_mdev, &guest_matrix);
+}
+
 static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 				      size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_config *ap_config;
+	ssize_t ret;
+	void *kbuf;
+
+	/*
+	 * This file was opened with stream_open(), so pos should be NULL for
+	 * sequential write() calls; a non-NULL pointer will be passed only
+	 * for positional pwrite() calls in which case we return an error
+	 * indicating broken pipe/illegal seek on a non-seekable file.
+	 */
+	if (pos)
+		return -ESPIPE;
+
+	/*
+	 * Reject absurd lengths before allocating the bounce buffer below.
+	 * This only caps the allocation: a write can never be larger than
+	 * the receive buffer. The authoritative check against the space
+	 * remaining is made by validate_resuming_write_parms() under the
+	 * locks.
+	 */
+	if (len > VFIO_AP_CONFIG_MAX_SIZE)
+		return -EIO;
+
+	/*
+	 * Copy the user data into a kernel buffer before taking any locks.
+	 * copy_from_user() can fault and block for an unbounded time, which
+	 * must not happen while holding ap_attr_mutex, guests_lock, kvm->lock
+	 * or mdevs_lock.
+	 */
+	kbuf = vmemdup_user(buf, len);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/*
+	 * Hold ap_attr_mutex for the full duration of the write, just as
+	 * (un)assign_adapter_store() and (un)assign_domain_store() do.  This
+	 * prevents the AP bus apmask/aqmask attributes from being changed
+	 * while the guest's AP configuration is being updated.
+	 *
+	 * get_update_locks_for_mdev() then acquires guests_lock, kvm->lock,
+	 * and mdevs_lock in the correct order. This serialises
+	 * the entire operation against concurrent AP attribute writers
+	 * while the guest's AP configuration is being changed.
+	 *
+	 * Holding these locks for the full duration of a potentially chunked
+	 * write could in theory affect performance, but this is acceptable for
+	 * several reasons: migration is an infrequent operation; real-world
+	 * guest AP configurations are small (each CEX8 card has 2 adapters and
+	 * up to 16 domains, and the 85 cards in a system are shared across all
+	 * LPARs and guests); and only a memcpy() and some integer checks are
+	 * done for each chunk while the locks are held.
+	 */
+	matrix_mdev = filp->private_data;
+	mutex_lock(&ap_attr_mutex);
+	get_update_locks_for_mdev(matrix_mdev);
+	pos = &filp->f_pos;
+
+	ret = validate_resuming_write_parms(filp, len);
+	if (ret)
+		goto out_unlock;
+
+	ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
+
+	memcpy((char *)ap_config + *pos, kbuf, len);
+	*pos += len;
+
+	/*
+	 * Check whether we have received all the data.  We know the total
+	 * expected size once num_queues has arrived, i.e. once *pos is past
+	 * the fixed header.  Until then keep accumulating.
+	 */
+	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
+		size_t expected_sz;
+
+		if (ap_config->num_queues > MAX_AP_QUEUES) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		expected_sz = sizeof(struct vfio_ap_config) +
+			      ap_config->num_queues *
+			      sizeof(struct vfio_ap_queue_info);
+
+		if (*pos > (loff_t)expected_sz) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		if (*pos == (loff_t)expected_sz)
+			ret = do_post_copy_processing(matrix_mdev, ap_config);
+	}
+
+out_unlock:
+	release_update_locks_for_mdev(matrix_mdev);
+	mutex_unlock(&ap_attr_mutex);
+	kvfree(kbuf);
+	return ret ? ret : (ssize_t)len;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
@@ -454,9 +1162,31 @@ static const struct file_operations vfio_ap_resume_fops = {
 
 static struct file *vfio_ap_resuming_init(struct ap_matrix_mdev *matrix_mdev)
 {
+	struct vfio_ap_config *ap_config;
+	struct file *filp;
+
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 
-	return vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+	/*
+	 * Pre-allocate the maximum possible receive buffer so that
+	 * vfio_ap_resuming_write() can copy directly into it without needing
+	 * to know num_queues up front.  kvzalloc falls back to vmalloc for
+	 * large allocations rather than failing a high-order kmalloc.
+	 */
+	ap_config = kvzalloc(VFIO_AP_CONFIG_MAX_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!ap_config)
+		return ERR_PTR(-ENOMEM);
+
+	filp = vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+	if (IS_ERR(filp)) {
+		kvfree(ap_config);
+		return filp;
+	}
+
+	matrix_mdev->mig_data->resuming_mig_file.ap_config = ap_config;
+	matrix_mdev->mig_data->resuming_mig_file.config_sz = VFIO_AP_CONFIG_MAX_SIZE;
+
+	return filp;
 }
 
 static struct file *
-- 
2.53.0

