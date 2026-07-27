Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709A438488;
	Mon, 27 Jul 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173588; cv=none; b=t7ahWe5R0PqItDH3LqVhINE+sq7vtKb96Hb2ypJAn5LTdzOYSxG3tRZqno5o/T7e7W5wx//nKbwc/HF+g0I+kKEgO3dVPTfkgePttCxaHeIMoiiK0aD7g5Jxfd7xoQ9u9yOCpwbBK4hHLq7yx3qmkpkbpNhFglR0bWlODf6sBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173588; c=relaxed/simple;
	bh=QE8JoK2f4e/CvnsJ1tjnl9pA7dQpCTbFjdSpDQxOTUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvpE2XwHf+p155AYOEtJNwCComTv/a2DmNSB3c7yVUl3JJhYXkSc+PkVBAVZlMv+yQmVM5yMnSeFrXYoIYxHogJxHHPS3TtHvXrDIm7b1It+hEfQyQuNNTQ879Myoyd5V48jUQ6LZQhiVY1rTvQqMXlvWZGDEgRsVeGz4k1SOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6xpLsDo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6xpLsDo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmeKg2406272;
	Mon, 27 Jul 2026 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VZF7ETn/mpwIR81JG
	+YaBifEqUkO25GFW2jl3SvuVUU=; b=P6xpLsDoKzzmmfsUItCQgya0JouFyFNZm
	m437WRVXWeyoa2xnQXaz9t/M4jfQ/z384+5J2PbEMgggkwHPcpE0ld7xFAMnio45
	MOlgqdXd40P9I9sUWzFTuU4pjaovkN4ApgRDldlcH5HUE+3+6RP2inkxiGB6xY4m
	N8ttVfTz5PpPVW+VSGzf97/OakMpUdSnNMXHYpzw8Gu3ANurmwT+Iv/DHO7UwIWP
	ZiVEkUKUhtA6+zU/o2uFAxxhymzNNGgZGQkkZCXLE5SVVFA331xi5DKF2TqMzkuv
	PpyCk2mghsro2d/H35jAtq1nxUmojMo221ORILrRyLdtF4EPlAhQA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xha87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQNrm023006;
	Mon, 27 Jul 2026 17:33:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xx2yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWMp729622914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBE015805C;
	Mon, 27 Jul 2026 17:32:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2990058059;
	Mon, 27 Jul 2026 17:32:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 09/15] s390/vfio-ap: Add method to set a new guest AP configuration
Date: Mon, 27 Jul 2026 13:32:33 -0400
Message-ID: <20260727173239.2420754-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5VUS9sFGqDCmM1_JzVDwL_AI7d2JGh-U
X-Proofpoint-ORIG-GUID: 5VUS9sFGqDCmM1_JzVDwL_AI7d2JGh-U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXyjfdQUvaNrEM
 92/2KwLdU4bEMH1dMO/J/6OI2zbDVQrYbgZ4cVHUiUW8tV5imqvmI+G4k0aZ52IFRC33Ouc29xw
 zxvjhtiHT1vpvaaIBHecacvMHFJgYoA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a67964d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=7yNgoilTr2P9NN8D:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=N1Ivd2qBLINY2Vw9BGkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX9J+JuP1PHLTf
 WWvOrPk59bJMsoihtygbW56cbQ+VK2t8XemchLqucrhyEBS72yYtXi2l3WGM0JTvQ8OntbXHlwj
 LTZ9WlMGGu2xDB64MAGqZJx4HwV6uSnuGaxW3SXNmNmVvwemrkC/KYmNCJi152sj0d85WKC7xIM
 uOlFIIEeF3xK/k4AkEtwuuxFLRkEyf0ZhDaLk2MwglmZ6EAiSpQmgo84J+pKHABPwB3Xdw1Rb+M
 9KwY+/s73JjxGa857k9cyJrsP8kVymPsCq+pTz4bEcnxhneHVmxVGEi2igfRT2kDQVZhBkNrE3t
 76dzO8pWqnUwZ/fj5Pgog8pinxrM99YhFrJJAOv559/Z1hkbRaiA8bFd0sTyEpCCX8rk5ZsbZ0j
 PptcceFA0tHoJPxiA6jBkjmUFlDEcLhE68pfbOjKqveS2srcub3xwfyPnJsHHzUqQPfpZ5RgZQQ
 9LYUgyFY0JSLOQTXXSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

Adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. This is needed in order to set the state of the mdev when
it is migrated from a remote host system during the RESUMING phase.

Key changes:
* Refactored code from the ap_config_store function - handles changes to
  the sysfs ap_config attribute - into a new, non-static function which
  is callable from the ap_config_store function as well as the live guest
  migration code.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 225 ++++++++++++++------------
 drivers/s390/crypto/vfio_ap_private.h |  61 +++++++
 2 files changed, 187 insertions(+), 99 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d05372b50d2f..0b49be22d5d8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -81,53 +81,6 @@ static inline void release_update_locks_for_kvm(struct kvm *kvm)
 	mutex_unlock(&matrix_dev->guests_lock);
 }
 
-/**
- * get_update_locks_for_mdev: Acquire the locks required to dynamically update a
- *			      KVM guest's APCB in the proper order.
- *
- * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
- *		 configuration data to use to update a KVM guest's APCB.
- *
- * The proper locking order is:
- * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
- *			       guest's APCB.
- * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
- * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
- *
- * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
- *	 lock will not be taken.
- */
-static inline void get_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
-{
-	mutex_lock(&matrix_dev->guests_lock);
-	if (matrix_mdev && matrix_mdev->kvm)
-		mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-}
-
-/**
- * release_update_locks_for_mdev: Release the locks used to dynamically update a
- *				  KVM guest's APCB in the proper order.
- *
- * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
- *		 configuration data to use to update a KVM guest's APCB.
- *
- * The proper unlocking order is:
- * 1. matrix_dev->mdevs_lock
- * 2. matrix_mdev->kvm->lock
- * 3. matrix_dev->guests_lock
- *
- * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
- *	 lock will not be released.
- */
-static inline void release_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
-{
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	if (matrix_mdev && matrix_mdev->kvm)
-		mutex_unlock(&matrix_mdev->kvm->lock);
-	mutex_unlock(&matrix_dev->guests_lock);
-}
-
 /**
  * get_update_locks_by_apqn: Find the mdev to which an APQN is assigned and
  *			     acquire the locks required to update the APCB of
@@ -642,8 +595,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void vfio_ap_matrix_init(struct ap_config_info *info,
-				struct ap_matrix *matrix)
+void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix)
 {
 	matrix->apm_max = info->apxa ? info->na : 63;
 	matrix->aqm_max = info->apxa ? info->nd : 15;
@@ -1018,19 +970,20 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 	unsigned long apqi;
 
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS)
-		vfio_ap_mdev_link_apqn(matrix_mdev,
-				       AP_MKQID(apid, apqi));
+		vfio_ap_mdev_link_apqn(matrix_mdev, AP_MKQID(apid, apqi));
 }
 
-static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
-				    unsigned long apid,
-				    struct list_head *qlist)
+static void collect_queues_by_apid(struct ap_matrix_mdev *matrix_mdev,
+				   unsigned long apid,
+				   struct list_head *qlist)
 {
 	struct vfio_ap_queue *q;
 	unsigned long  apqi;
 
 	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {
-		q = vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
+		q = matrix_mdev ?
+				vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
+				vfio_ap_find_queue(AP_MKQID(apid, apqi));
 		if (q)
 			list_add_tail(&q->reset_qnode, qlist);
 	}
@@ -1042,7 +995,7 @@ static void reset_queues_for_apid(struct ap_matrix_mdev *matrix_mdev,
 	struct list_head qlist;
 
 	INIT_LIST_HEAD(&qlist);
-	collect_queues_to_reset(matrix_mdev, apid, &qlist);
+	collect_queues_by_apid(matrix_mdev, apid, &qlist);
 	vfio_ap_mdev_reset_qlist(&qlist);
 }
 
@@ -1058,7 +1011,7 @@ static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
 	INIT_LIST_HEAD(&qlist);
 
 	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES)
-		collect_queues_to_reset(matrix_mdev, apid, &qlist);
+		collect_queues_by_apid(matrix_mdev, apid, &qlist);
 
 	return vfio_ap_mdev_reset_qlist(&qlist);
 }
@@ -1729,54 +1682,100 @@ static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
 	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
 }
 
-static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
-			       const char *buf, size_t count)
+static void get_removed_matrixes(struct ap_matrix *m_removed,
+				 struct ap_matrix *m_old,
+				 struct ap_matrix *m_new)
 {
-	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
-	struct ap_matrix m_new, m_old, m_added, m_removed;
+	bitmap_andnot(m_removed->apm, m_old->apm, m_new->apm, AP_DEVICES);
+	bitmap_andnot(m_removed->aqm, m_old->aqm, m_new->aqm, AP_DOMAINS);
+	bitmap_andnot(m_removed->adm, m_old->adm, m_new->adm, AP_DOMAINS);
+}
+
+static void get_added_matrixes(struct ap_matrix *m_added,
+			       struct ap_matrix *m_old,
+			       struct ap_matrix *m_new)
+{
+	bitmap_andnot(m_added->apm, m_new->apm, m_old->apm, AP_DEVICES);
+	bitmap_andnot(m_added->aqm, m_new->aqm, m_old->aqm, AP_DOMAINS);
+	bitmap_andnot(m_added->adm, m_new->adm, m_old->adm, AP_DOMAINS);
+}
+
+static int validate_new_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	int rc;
+
+	/* Ensure new state is valid, else undo new state */
+	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
+	if (rc)
+		return rc;
+
+	rc = ap_matrix_overflow_check(matrix_mdev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void link_new_queues(struct ap_matrix_mdev *matrix_mdev,
+			    struct ap_matrix *m_added)
+{
+	unsigned long apid, apqi;
+
+	for_each_set_bit_inv(apid, m_added->apm, AP_DEVICES)
+		vfio_ap_mdev_link_adapter(matrix_mdev, apid);
+
+	for_each_set_bit_inv(apqi, m_added->aqm, AP_DOMAINS)
+		vfio_ap_mdev_link_domain(matrix_mdev, apqi);
+}
+
+/**
+ * vfio_ap_set_new_guest_config:
+ *
+ * Set a new AP configuration for a guest.
+ *
+ * @matrix_mdev: Object used to maintain the AP configuration for a guest
+ * @m_new:		 Object used to set the new AP configuration
+ *
+ * Returns: zero (0) if the new AP configuration is successfully set; otherwise,
+ *	    returns an error:
+ *
+ *	    ~ EADDRNOTAVAIL One or more APQNs are reserved for host use
+ *	    ~ EADDRINUSE    One or more APQNs are assigned to another mdev
+ *	    ~ ENODEV	    An adapter, domain or control domain in the new
+ *			    AP configuration exceeds the max architected value
+ */
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new)
+{
+	struct ap_matrix m_old, m_old_shadow, m_added, m_removed;
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
-	unsigned long newbit;
-	char *newbuf, *rest;
-	int rc = count;
 	bool do_update;
+	int rc;
 
-	newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
-	if (!newbuf)
-		return -ENOMEM;
-	rest = newbuf;
+	lockdep_assert_held(&ap_attr_mutex);
+	assert_has_update_locks_for_mdev(matrix_mdev);
 
-	mutex_lock(&ap_attr_mutex);
-	get_update_locks_for_mdev(matrix_mdev);
-
-	/* Save old state */
+	/* Save the old state */
 	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
-	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
-	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
-	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
-		rc = -EINVAL;
-		goto out;
-	}
+	ap_matrix_copy(&m_old_shadow, &matrix_mdev->shadow_apcb);
 
-	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
-	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
-	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
-	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
+	/*
+	 * Get the adapters, domains and control domains added and/or removed
+	 * from the existing configuration
+	 */
+	get_removed_matrixes(&m_removed, &m_old, m_new);
+	get_added_matrixes(&m_added, &m_old, m_new);
 
 	/* Need new bitmaps in matrix_mdev for validation */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+	ap_matrix_copy(&matrix_mdev->matrix, m_new);
 
 	/* Ensure new state is valid, else undo new state */
-	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
-	if (rc) {
-		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
-		goto out;
-	}
-	rc = ap_matrix_overflow_check(matrix_mdev);
+	rc = validate_new_state(matrix_mdev);
 	if (rc) {
 		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
-		goto out;
+		ap_matrix_copy(&matrix_mdev->shadow_apcb, &m_old_shadow);
+		return rc;
 	}
-	rc = count;
 
 	/* Need old bitmaps in matrix_mdev for unplug/unlink */
 	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
@@ -1786,14 +1785,10 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
 
 	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
-
-	/* Link newly added adapters */
-	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
-		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
+	ap_matrix_copy(&matrix_mdev->matrix, m_new);
 
-	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
-		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
+	/* Link queues associated with the newly added adapters and domains */
+	link_new_queues(matrix_mdev, &m_added);
 
 	/* filter resources not bound to vfio-ap */
 	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
@@ -1804,7 +1799,39 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 		reset_queues_for_apids(matrix_mdev, apm_filtered);
 	}
-out:
+
+	return 0;
+}
+
+static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
+	struct ap_matrix m_new;
+	char *newbuf, *rest;
+	ssize_t rc;
+
+	newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
+	if (!newbuf)
+		return -ENOMEM;
+	rest = newbuf;
+
+	mutex_lock(&ap_attr_mutex);
+	get_update_locks_for_mdev(matrix_mdev);
+
+	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
+	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
+	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
+		kfree(newbuf);
+		release_update_locks_for_mdev(matrix_mdev);
+		mutex_unlock(&ap_attr_mutex);
+		return -EINVAL;
+	}
+
+	rc = vfio_ap_set_new_guest_config(matrix_mdev, &m_new);
+	if (!rc)
+		rc = count;
+
 	release_update_locks_for_mdev(matrix_mdev);
 	mutex_unlock(&ap_attr_mutex);
 	kfree(newbuf);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 1fbdfcce5a11..150dfce8a674 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -157,6 +157,62 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+/**
+ * get_update_locks_for_mdev: Acquire the locks required to dynamically update a
+ *			      KVM guest's APCB in the proper order.
+ *
+ * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
+ *		 configuration data to use to update a KVM guest's APCB.
+ *
+ * The proper locking order is:
+ * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
+ *			       guest's APCB.
+ * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
+ * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
+ *
+ * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
+ *	 lock will not be taken.
+ */
+static inline void get_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	mutex_lock(&matrix_dev->guests_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		mutex_lock(&matrix_mdev->kvm->lock);
+	mutex_lock(&matrix_dev->mdevs_lock);
+}
+
+/**
+ * release_update_locks_for_mdev: Release the locks used to dynamically update a
+ *				  KVM guest's APCB in the proper order.
+ *
+ * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
+ *		 configuration data to use to update a KVM guest's APCB.
+ *
+ * The proper unlocking order is:
+ * 1. matrix_dev->mdevs_lock
+ * 2. matrix_mdev->kvm->lock
+ * 3. matrix_dev->guests_lock
+ *
+ * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
+ *	 lock will not be released.
+ */
+static inline void release_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	mutex_unlock(&matrix_dev->mdevs_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		mutex_unlock(&matrix_mdev->kvm->lock);
+	mutex_unlock(&matrix_dev->guests_lock);
+}
+
+static inline void
+assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->guests_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		lockdep_assert_held(&matrix_mdev->kvm->lock);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+}
+
 int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
 
 int vfio_ap_mdev_register(void);
@@ -172,9 +228,14 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
+
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

