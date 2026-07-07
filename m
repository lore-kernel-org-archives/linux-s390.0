Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740263AE706;
	Tue,  7 Jul 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414969; cv=none; b=BNvjh2jdy1rHuSuXyTUsOFvNxmDo318+/yXDoh5Z5B18Qlb92RWLEpnCa+h8na8yDWe+KUXZ958VOOf5wltZ0JweTKiSfT48td5PAjncEmRSQgkw7zmqdYr9eANLno8cE3FKsWgqrvQo6VPxwX2BduhJ4W47voN+AqjVqR/AZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414969; c=relaxed/simple;
	bh=v34g5z1WTsl76ISLv2qMKlD0Y1LlSPuNsS389zXEJwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5ql5vwTRKth1+5N0egN6Lwbj02GjNunRjwd+vuGl9yen3X4oScbKW8pOqPXFXRV0525kH3sdXZzzHZQi5n6lFamzFez3S/3gOjCbsD/Rk5furPADtZ5iU8IWHpiGPxRwoDQnZoJFIli3KPDRhwCX+n8VX6AcY33k0FtmBAGQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RT48BG4k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RT48BG4k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IMXu3011766;
	Tue, 7 Jul 2026 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ajrKx/yn8l6PQ2r9q
	M7gQGMzKJRNj7SwvjTTqtbqyOM=; b=RT48BG4kmIU37jlb4GFe0sPK/cCBtrAql
	1j9M6w06JAh3j1lJ3vU7U4f/9kfoCh+cliPvrVpmjNZEwT1NXyHx9/BOJnktpATL
	Oli5MmiMQWkIL4QezztPzcOE/9qDwzXLuhH6qi7e+/FpquF+000fsMWJYWXxmMNd
	ccwyTF/FlDZ0NV4n6yT4Ix1t8y1l+SfA3Lvw8ylEh9IVpY9RGM6W3ECPLyZvWVS2
	FUchoVp8pB4LoNLzAtgfzbJrwK9i1CgcpOrquI31EwSIBSRfSeC2WTdyggQSCiGD
	YbRZh04CoB7SUOVmiIxXJoYcJBGNbdRxeev9UiZvUs4IP7/63unDw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3p8se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678Yg37027617;
	Tue, 7 Jul 2026 09:02:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h9u72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792d6B26935866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20EB5805A;
	Tue,  7 Jul 2026 09:02:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76AD958056;
	Tue,  7 Jul 2026 09:02:38 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 09/15] s390/vfio-ap: Add method to set a new guest AP configuration
Date: Tue,  7 Jul 2026 05:02:11 -0400
Message-ID: <20260707090226.3206695-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4cc0b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=7yNgoilTr2P9NN8D:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ZcgK3RE9OFBsU1M5gScA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfXxP3gtRUoR0NT
 CJaQ/2uibBy+v8fwHE6onWLvPXWifIpxMvhCytKnDF113J5wpSwZLXFqgloPH6cjGmGQ0HbEHOO
 HbeSLPRk6ti20xMuvYxV39zcwAent28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfXxsRYP7gkiwBY
 QwrZf3xonyjXuhKiaih8a/DQMtFHwMSVKdDZCCPayyBY1eQbHHBCg4ySGzwr3yhYi2AIOrtgYg/
 R9d339kbuUIcG9sC7hQGiXNNEnv/5fMKsjq7jdb55swOeRUJzo9Q191D6uek0L1GRLwx1DnJrfc
 UFDxXV/KrTpXKo1NJhIDSl8i6L5XhckIKK3ZyCZVzOLx+Bz8m/AA2trFEwocr2AK+dPN3rilrDj
 tgCB91K+njQm7RiaF4BgCOeMmbTPmpa2iGVflZ+3wl1MhHtDJNYmX5+aVjIBxtOPkUEDNUzfDs0
 dQjblr/C+I+tkJCdusv71g+/6/KyYmLrsp0yu1NcKdEywkGVEuazjqZDu8cDV5hPUB2WjFx2oll
 zp2MpFHM7lvTkzRl3Y5l0TpebtBrjop2yV2xIPZbTplYQOTopXj00F0rDzXhur21m3DWLCJh6Mv
 /80kyBMX/mHUpOggmEw==
X-Proofpoint-ORIG-GUID: iFIViUGqWNOFPgZvyBj0ZkDfxFWrQ_Q1
X-Proofpoint-GUID: iFIViUGqWNOFPgZvyBj0ZkDfxFWrQ_Q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Adds a new vfio_ap_set_new_config function to set a guest's AP
configuration. This is needed in order to set the state of the mdev when
it is migrated from a remote host system during the RESUMING phase.

Key changes:
* Refactored code from the ap_config_store function - handles changes to
  the sysfs ap_config attribute - into a new, non-static function which
  is callable from the ap_config_store function as well as the live guest
  migration code.

* A flag parameter indicating whether the update to the guest's AP
  configuration can proceed if APIDs must be filtered out because one or
  more of the queues are not bound to the vfio_ap device driver. This is
  primarily for calls from the migration code because we don't want code
  that is running in the guest to lose access. The ap_config_store function
  will continue to operate as it did before and allow filtering.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 358 +++++++++++++++++++++-----
 drivers/s390/crypto/vfio_ap_private.h |   4 +
 2 files changed, 298 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 8a9e83921f74..c5eb9e4aa85c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -105,6 +105,27 @@ static inline void get_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
 	mutex_lock(&matrix_dev->mdevs_lock);
 }
 
+/**
+ * assert_has_update_locks_for_mdev:
+ *
+ * Assert the locks required to dynamically update a KVM guest's APCB are
+ * currently held.
+ *
+ * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
+ *		 configuration data to use to update a KVM guest's APCB.
+ *
+ * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
+ *		 lock will not be taken.
+ */
+static inline void
+assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->guests_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		lockdep_assert_held(&matrix_mdev->kvm->lock);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+}
+
 /**
  * release_update_locks_for_mdev: Release the locks used to dynamically update a
  *				  KVM guest's APCB in the proper order.
@@ -875,7 +896,40 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
 			q = vfio_ap_mdev_get_queue(matrix_mdev,
 						   AP_MKQID(apid, apqi));
 			if (q)
-				q->matrix_mdev = NULL;
+				vfio_ap_mdev_link_queue(matrix_mdev, q);
+		}
+	}
+}
+
+static void vfio_ap_unlink_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     AP_DOMAINS) {
+			q = vfio_ap_mdev_get_queue(matrix_mdev,
+						   AP_MKQID(apid, apqi));
+			if (q) {
+				vfio_ap_unlink_queue_fr_mdev(q);
+				vfio_ap_unlink_mdev_fr_queue(q);
+			}
+		}
+	}
+}
+
+static void vfio_ap_link_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     AP_DOMAINS) {
+			q = vfio_ap_find_queue(AP_MKQID(apid, apqi));
+			if (q)
+				vfio_ap_mdev_link_queue(matrix_mdev, q);
 		}
 	}
 }
@@ -1014,19 +1068,36 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
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
+		if (q)
+			list_add_tail(&q->reset_qnode, qlist);
+	}
+}
+
+static void collect_queues_by_apqi(struct ap_matrix_mdev *matrix_mdev,
+				   unsigned long apqi,
+				   struct list_head *qlist)
+{
+	struct vfio_ap_queue *q;
+	unsigned long  apid;
+
+	for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm, AP_DEVICES) {
+		q = matrix_mdev ?
+			vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
+			vfio_ap_find_queue(AP_MKQID(apid, apqi));
 		if (q)
 			list_add_tail(&q->reset_qnode, qlist);
 	}
@@ -1038,7 +1109,7 @@ static void reset_queues_for_apid(struct ap_matrix_mdev *matrix_mdev,
 	struct list_head qlist;
 
 	INIT_LIST_HEAD(&qlist);
-	collect_queues_to_reset(matrix_mdev, apid, &qlist);
+	collect_queues_by_apid(matrix_mdev, apid, &qlist);
 	vfio_ap_mdev_reset_qlist(&qlist);
 }
 
@@ -1054,7 +1125,7 @@ static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
 	INIT_LIST_HEAD(&qlist);
 
 	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES)
-		collect_queues_to_reset(matrix_mdev, apid, &qlist);
+		collect_queues_by_apid(matrix_mdev, apid, &qlist);
 
 	return vfio_ap_mdev_reset_qlist(&qlist);
 }
@@ -1725,82 +1796,241 @@ static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
 	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
 }
 
-static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
-			       const char *buf, size_t count)
+static int validate_ap_matrix(struct ap_matrix_mdev *matrix_mdev)
 {
-	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
-	struct ap_matrix m_new, m_old, m_added, m_removed;
-	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
-	unsigned long newbit;
-	char *newbuf, *rest;
-	int rc = count;
-	bool do_update;
+	int rc;
 
-	newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
-	if (!newbuf)
-		return -ENOMEM;
-	rest = newbuf;
+	lockdep_assert_held(&ap_attr_mutex);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
 
-	mutex_lock(&ap_attr_mutex);
-	get_update_locks_for_mdev(matrix_mdev);
+	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
+	if (rc)
+		return rc;
+	rc = ap_matrix_overflow_check(matrix_mdev);
+	if (rc)
+		return rc;
 
-	/* Save old state */
-	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
-	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
-	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
-	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
-		rc = -EINVAL;
-		goto out;
+	return 0;
+}
+
+static void get_removed_matrixes(struct ap_matrix *m_removed,
+				 struct ap_matrix *m_old,
+				 struct ap_matrix *m_new)
+{
+	bitmap_andnot(m_removed->apm, m_old->apm, m_new->apm, AP_DEVICES);
+	bitmap_andnot(m_removed->aqm, m_old->aqm, m_new->aqm, AP_DOMAINS);
+	bitmap_andnot(m_removed->adm, m_old->adm, m_new->adm, AP_DOMAINS);
+}
+
+static void reset_removed_queues_by_apid(unsigned long *apm_removed,
+					 unsigned long *apm_filtered,
+					 struct list_head *qlist)
+{
+	DECLARE_BITMAP(apids_removed, AP_DEVICES);
+	unsigned long apid;
+
+	for_each_set_bit_inv(apid, apm_filtered, AP_DEVICES)
+		set_bit_inv(apid, apids_removed);
+
+	for_each_set_bit_inv(apid, apm_removed, AP_DEVICES) {
+		if (!test_bit_inv(apid, apids_removed))
+			set_bit_inv(apid, apids_removed);
 	}
 
-	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
-	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
-	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
-	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
+	if (!bitmap_empty(apids_removed, AP_DEVICES)) {
+		for_each_set_bit_inv(apid, apids_removed, AP_DEVICES)
+			collect_queues_by_apid(NULL, apid, qlist);
+	}
 
-	/* Need new bitmaps in matrix_mdev for validation */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+	if (!list_empty(qlist))
+		vfio_ap_mdev_reset_qlist(qlist);
+}
 
-	/* Ensure new state is valid, else undo new state */
-	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
-	if (rc) {
-		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
-		goto out;
+/**
+ * remove_queues_already_reset:
+ *
+ * Remove the queues that have already beeen reset from a list of queues that
+ * have yet to be reset.
+ *
+ * @qlist_rst:	A list of queues that have already been reset
+ * @qlist_rem:	A list of queues from which already reset queues are to be
+ *		removed.
+ */
+static void remove_queues_already_reset(struct list_head *qlist_rst,
+					struct list_head *qlist_rem)
+{
+	struct vfio_ap_queue *rq, *qr, *trq, *tqr;
+
+	if (list_empty(qlist_rst))
+		return;
+
+	/*
+	 * Each queue in qlist_reset has already been reset, so remove the
+	 * matching queues from qlist_reset so they don't get reset again
+	 */
+	list_for_each_entry_safe(qr, tqr, qlist_rem, reset_qnode) {
+		list_for_each_entry_safe(rq, trq, qlist_rst, reset_qnode) {
+			if (qr->apqn == rq->apqn)
+				list_del(&qr->reset_qnode);
+		}
 	}
-	rc = ap_matrix_overflow_check(matrix_mdev);
-	if (rc) {
-		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
-		goto out;
+}
+
+static void reset_removed_queues(struct ap_matrix *m_removed,
+				 unsigned long *apm_filtered)
+{
+	struct list_head qlist_by_apid, qlist_by_apqi;
+	DECLARE_BITMAP(apqis, AP_DOMAINS);
+	unsigned long apqi;
+
+	INIT_LIST_HEAD(&qlist_by_apid);
+	INIT_LIST_HEAD(&qlist_by_apqi);
+	bitmap_clear(apqis, 0, AP_DOMAINS);
+
+	reset_removed_queues_by_apid(m_removed->apm, apm_filtered, &qlist_by_apid);
+
+	for_each_set_bit_inv(apqi, m_removed->aqm, AP_DEVICES) {
+		set_bit_inv(apqi, apqis);
+		collect_queues_by_apqi(NULL, apqi, &qlist_by_apqi);
 	}
-	rc = count;
 
-	/* Need old bitmaps in matrix_mdev for unplug/unlink */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
+	if (list_empty(&qlist_by_apqi))
+		return;
 
-	/* Unlink removed adapters/domains */
-	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, m_removed.apm);
-	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
+	remove_queues_already_reset(&qlist_by_apid, &qlist_by_apqi);
 
-	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+	if (!list_empty(&qlist_by_apqi))
+		vfio_ap_mdev_reset_qlist(&qlist_by_apid);
+}
 
-	/* Link newly added adapters */
-	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
-		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
+/**
+ * restore_mdev_state:
+ *
+ * Restore the mdev to its previous state:
+ * - Unlink the queues from the updated mdev
+ * - Copy the previous matrix and shadow_apcb to the mdev
+ * - Re-link the original queues to the mdev
+ *
+ * @matrix_mdev:	The object that maintains the AP configuration for a guest
+ * @m_old:		The object containing the bitmaps specifying the guest AP
+ *			configuration profile as it was prior to the attempt to set
+ *			a new one
+ * @m_old_shadow:	The object containing the bitmaps specifying the guest AP
+ *			configuration as it was prior to the attempt to set a new
+ *			one
+ */
+static void restore_mdev_state(struct ap_matrix_mdev *matrix_mdev,
+			       struct ap_matrix *m_old,
+			       struct ap_matrix *m_old_shadow)
+{
+	vfio_ap_unlink_queues(matrix_mdev);
+	ap_matrix_copy(&matrix_mdev->matrix, m_old);
+	ap_matrix_copy(&matrix_mdev->shadow_apcb, m_old_shadow);
+	vfio_ap_link_queues(matrix_mdev);
+}
 
-	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
-		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
+/**
+ * vfio_ap_set_new_guest_config:
+ *
+ * Set a new AP configuration for a guest.
+ *
+ * @matrix_mdev: Object used to maintain the AP configuration for a guest
+ * @m_new:		 Object used to set the new AP configuration
+ * @filtering_allowable: A boolean value indicating whether any filtering of
+ *			 new AP configuration is acceptable. If the configuration
+ *			 needs to be filtered before it can be passed through to
+ *			 the guest and this flag is set to false, then
+ *			 the operation shall be terminated with an error.
+ *
+ * Returns: zero (0) if the new AP configuration is successfully set; otherwise,
+ *	    returns an error:
+ *
+ *	    ~ EADDRNOTAVAIL One or more APQNs are reserved for host use
+ *	    ~ EADDRINUSE    One or more APQNs are assigned to another mdev
+ *	    ~ ENODEV	    An adapter, domain or control domain in the new
+ *			    AP configuration exceeds the max architected value
+ *	    ~ ECANCELED	    @filtering_allowed was specified as false and the
+ *			    AP configuration needs to be filtered.
+ */
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new,
+				 bool filtering_allowable)
+{
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
+	struct ap_matrix m_old, m_old_shadow, m_removed;
+	bool do_update;
+	int rc;
 
-	/* filter resources not bound to vfio-ap */
+	lockdep_assert_held(&ap_attr_mutex);
+	assert_has_update_locks_for_mdev(matrix_mdev);
+
+	/* Save old state */
+	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
+	ap_matrix_copy(&m_old_shadow, &matrix_mdev->shadow_apcb);
+
+	/* Reset mdev state */
+	vfio_ap_unlink_queues(matrix_mdev);
+	ap_matrix_copy(&matrix_mdev->matrix, m_new);
+	vfio_ap_link_queues(matrix_mdev);
+
+	rc = validate_ap_matrix(matrix_mdev);
+	if (rc) {
+		restore_mdev_state(matrix_mdev, &m_old, &m_old_shadow);
+		return rc;
+	}
+
+	/*
+	 * If APIDs need to be filtered from the guest AP config and filtering
+	 * is not allowable according to the caller, then terminate the operation.
+	 */
 	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
+	if (!bitmap_empty(apm_filtered, AP_DEVICES) && !filtering_allowable) {
+		restore_mdev_state(matrix_mdev, &m_old, &m_old_shadow);
+		return -ECANCELED;
+	}
+
 	do_update |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
 
-	/* Apply changes to shadow apbc if things changed */
-	if (do_update) {
+	if (do_update)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-		reset_queues_for_apids(matrix_mdev, apm_filtered);
+
+	get_removed_matrixes(&m_removed, &m_old, m_new);
+	if (!bitmap_empty(m_removed.apm, AP_DEVICES) ||
+	    !bitmap_empty(apm_filtered, AP_DEVICES))
+		reset_removed_queues(&m_removed, apm_filtered);
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
 	}
-out:
+
+	rc = vfio_ap_set_new_guest_config(matrix_mdev, &m_new, true);
+	if (!rc)
+		rc = count;
+
 	release_update_locks_for_mdev(matrix_mdev);
 	mutex_unlock(&ap_attr_mutex);
 	kfree(newbuf);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 1fbdfcce5a11..7ae48729cafa 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -177,4 +177,8 @@ int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new,
+				 bool filtering_allowable);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

