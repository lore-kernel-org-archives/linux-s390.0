Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1E4302F8;
	Fri, 24 Jul 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911359; cv=none; b=I2AeL6YDowJR6a7ASKjEe4rjlQI8quct9Rr78DCsok2ijqEukO11E0y4k4lYAmmhuFhwEoooTcAn8DI4w9c9SxcRorOuljjUlSC5e7aj2sV3nyG2bqs/ia0cuDx6pp5o12epo575xoMfm4J1LDR/8SudHgHVX+FbVFEHEp8QHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911359; c=relaxed/simple;
	bh=YJM/x+AP0ugNAWHOYZQLjAh++KAF8+DUspJBolR7AaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pnnhgg6GC8EKj/IVspGYWuHUchW9uCgVUalB2hidFLsWOw5bsOXN3ExDPZeNGiRK/+f2fi+XtoslnS1Gsbs5ZxcMUCZdPVjU/h9Nmqg97VWYPzaMINhtI3MvxUPsiAXpY/c1pfqCyvAWywUzjzyMcgh1OII+BEXqA0X5jbPUCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fzTfdcjt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fzTfdcjt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfdVU1973588;
	Fri, 24 Jul 2026 16:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ToddTH3EdKmswPEGd
	ZFs2hGvBoaxn59bPSaSVjb3PRs=; b=fzTfdcjt9CdCkM0IiUg8lV9PHnr9ld+m0
	5MrQon4nmODeOAr0kNASMyj0M0zIMKzbJ8bckf9IBVkaV10gdrwHxM5tfhh55n6q
	8eOqBTHTG/wSpguSTC6fZ4BRwPTdd3qjg2H7cNOwXTkFC9euwJ/TcvPa3l2EZ9Nr
	hlJhzdgJPiD+4PP1K2PUYptn0/KXuRZ8VaVcFYEdfXZprbmkkV4gaNtEF27LkbaS
	Yd+p3PVadkBKzDmz020lL5w9Eb8n+BU7PjBMcIeP+l2Cbjvzg/RiAsRcCBROaF8h
	1j+IfypRHfQ9bJC4fRr5H8HOfCJcDsoOv52ktmmafLkOJ177TjkIA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50u5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4bFM028391;
	Fri, 24 Jul 2026 16:14:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk9n2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGE9Eb32113276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC5858054;
	Fri, 24 Jul 2026 16:14:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13BC25803F;
	Fri, 24 Jul 2026 16:14:08 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:07 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 09/15] s390/vfio-ap: Add method to set a new guest AP configuration
Date: Fri, 24 Jul 2026 12:13:45 -0400
Message-ID: <20260724161351.1802644-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX1juPOEU6TUpS
 xGvY3kp1Ot6P8xge5HnUIUjbHinlT8Mbs1Mp6we1ZGFHSd34rsyC6zUGSM0YJ1hUmsoW+HA07wh
 ibmT8tY5Am8lIpY+WyHVwwI4UphQDlY=
X-Proofpoint-ORIG-GUID: zcDj5A-qTUimI64GASIbkdwhPfngudQv
X-Proofpoint-GUID: zcDj5A-qTUimI64GASIbkdwhPfngudQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX22sI7/9429aE
 RIZMw1zAmftWw7TjCL+WB4O/DwopXnCovFQkosTOD1W0g29d+tTzamdQWpolTRxmm4U88SKNrbO
 hSMRBuH1kF3QZZ0WmxU5AmKo6REzI4kNjry/uXkBDIiaOJV9dBz295sX1gNnXEWDnyyqxwpcJeq
 hkoDKBAgNsLwBW9naMvhynuQigjUT5d3NJDgRm+zzru23z0nulYCiIOe8woMcuoVE0Guk4Xg/zb
 x8LyWdtonkVd6nfLJwfvrUPa/zH9wOP8hQqaP8Jlyxrr4ntzurkZgEArCKdO/KuPS+Yzek8a6hU
 5sJbJYsIJmaslkDqsjpKyyfLxsxk4xxDAqElC1JsF+iG4+r3IWTXmgm5atnU4mvhL1fW/HowasY
 tIgoyR4WWOIaD0ip+L0n4qYkwAjQkRGvnz799E1QXzxrUATMbkGwThnjpPi5i461fkaNLGgufOH
 usQenRRlbhhcszA7xdA==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a638f54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=7yNgoilTr2P9NN8D:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=N1Ivd2qBLINY2Vw9BGkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

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
 drivers/s390/crypto/vfio_ap_ops.c     | 227 ++++++++++++++------------
 drivers/s390/crypto/vfio_ap_private.h |  61 +++++++
 2 files changed, 188 insertions(+), 100 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 678bdd4c82e9..454bb9fe1971 100644
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
@@ -875,7 +827,7 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
 			q = vfio_ap_mdev_get_queue(matrix_mdev,
 						   AP_MKQID(apid, apqi));
 			if (q)
-				q->matrix_mdev = NULL;
+				vfio_ap_mdev_link_queue(matrix_mdev, q);
 		}
 	}
 }
@@ -1014,19 +966,20 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
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
@@ -1038,7 +991,7 @@ static void reset_queues_for_apid(struct ap_matrix_mdev *matrix_mdev,
 	struct list_head qlist;
 
 	INIT_LIST_HEAD(&qlist);
-	collect_queues_to_reset(matrix_mdev, apid, &qlist);
+	collect_queues_by_apid(matrix_mdev, apid, &qlist);
 	vfio_ap_mdev_reset_qlist(&qlist);
 }
 
@@ -1054,7 +1007,7 @@ static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
 	INIT_LIST_HEAD(&qlist);
 
 	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES)
-		collect_queues_to_reset(matrix_mdev, apid, &qlist);
+		collect_queues_by_apid(matrix_mdev, apid, &qlist);
 
 	return vfio_ap_mdev_reset_qlist(&qlist);
 }
@@ -1725,54 +1678,100 @@ static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
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
@@ -1782,14 +1781,10 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
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
@@ -1800,7 +1795,39 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
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

