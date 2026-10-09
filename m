Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084964D1797;
	Fri,  9 Oct 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546202; cv=none; b=I9jbWR2Uo5x43qOzradmrep/ym9o8F6h/u/R/6KBs8u04aJb6WDA7ByS/eM2SJe69CDZny4ON6NfqyRrKPDkpg4t4KuUYTwpSiga89GLH54NslpNcY6N0cV9atwKWAMBYnk5T5jyeTJoGAbtPy2IePpgNyr/G9qsXSSsP7i8aVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546202; c=relaxed/simple;
	bh=stOag1eM2e3ktvWsD/UCDytefx6z1v8t3vr8OyEpI0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGJC6Q92AIFnMnHmTo7Lk2vtRoOtRNDQHWhDq9uZiVnJYRZ/UyE3sl0epWtgtQIkhmU4lwJYiBR1pWqYl2bOsZeazqoZz4SbsExitwfKfoc8vh35HBB7NnBp5v7nwUxzbZ/IoZyKjg/6UMg4LUkoPh97a9X0BZegpwChDaXgb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bBnQTjo/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bBnQTjo/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZaRD3773968;
	Fri, 9 Oct 2026 11:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vmigop82pP2ICkkpL
	x/1phcp7fszWB85DwuBAtpEFTM=; b=bBnQTjo/GlaALBKIU6ATqDABDhaVRlmpR
	ugLqE5IA9lIZJMN52Me1T+ABEy//ApFXaJoGT7rUany5fRENDIcb6mAzjdJ0ByaP
	1wqw8AppQEHw01znmN523gehgBsuYWZ77cXv/FnJnFj+yAwk7TLk2ktNS6AIFfVw
	aSP19BMMWe95SVH+OKDtd6roJkVc5/9YP8v4umMAJmN3F51GAPNJnOQgs0bYCm57
	OrOTMhMrL6pc2/Hq5pGgLnDKFUEeSeI6RdMgEeBloy1oAsn4G62OiUdlFXVkZw3/
	UFYVh9rVt+EhzdnvJXDfE4TbbJDet6xettxHqeR075Lm49WCBTZeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjckr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I0Jw578908;
	Fri, 9 Oct 2026 11:43:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76rrm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bh3J510551970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABC3D58056;
	Fri,  9 Oct 2026 11:43:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031AF58045;
	Fri,  9 Oct 2026 11:43:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:01 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 09/15] s390/vfio-ap: Prepare lock helpers and matrix init for cross-file use
Date: Fri,  9 Oct 2026 07:42:38 -0400
Message-ID: <20261009114244.1213173-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SuZcRJELSNkTVqeOsVatn9YPuBZ9ZD26
X-Proofpoint-ORIG-GUID: SuZcRJELSNkTVqeOsVatn9YPuBZ9ZD26
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8d349 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fTSzii-f3gA6o6vWqDQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX/1EhrZMNFbos
 IWtWZM1/gv05VzoC+hL2+OpA1njx24fMqrGhF1K8KGb4lDnD1YguIgzyEiehiY5d2khWPYFIofC
 /gfDnb5wQU5wrZAAIApLjHpEI5MIUnFCiXDazJgTd/2H6BbtgQ6wpVijt4CQJKY23ORKy/na8jt
 qRlaL7qcrAfromAUj/J3OVbC1zRysWuBDeRzpCSEmtK74lmn1nkx5rpoZt/KrDsttwJ+cNYtZ9i
 lq9pQunWGDSvGZ0wehfHDOziPZwN7JzWjmJb2hQGf8lMRLIHLU+qKyxiUpKoagQDBqjfw0KMPyj
 29EWHFhgnrGaXx1kuVZAiKwf1k3Ob/uLLY6TtQH8BZOrWUyOtW75N4+3wLxAyO9zwHKDvvlpWL3
 QeXpTZ67NaNrY8kCIWfy2mR0b6vc3IXLlHp51wGqQE1iabHKLJYgpPMuNfxDHOfe02OIltdTdHv
 xDr0MaMkKPKy5ROyTlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX+UTFHTqw08SC
 N3J12+vs0s6yJygwyiXVj7J+XHWuarHAU5NbMd3J4MwnY1T80MhBTCQq5sKlUay1ZPJZmdgXPfs
 Uegz3beK9lYRN378ABwOLNg3H2kqn8c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

Move get_update_locks_for_mdev(), release_update_locks_for_mdev(),
and assert_has_update_locks_for_mdev() from vfio_ap_ops.c into
vfio_ap_private.h as static inline functions so they are accessible
to vfio_ap_migration.c in subsequent patches.

Make vfio_ap_matrix_init() non-static and add its declaration to
vfio_ap_private.h for the same reason.

No functional change.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 50 +----------------------
 drivers/s390/crypto/vfio_ap_private.h | 58 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 3095e771b6a5..c951f289f305 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -88,53 +88,6 @@ static inline void release_update_locks_for_kvm(struct kvm *kvm)
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
@@ -649,8 +602,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void vfio_ap_matrix_init(struct ap_config_info *info,
-				struct ap_matrix *matrix)
+void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix)
 {
 	matrix->apm_max = info->apxa ? info->na : 63;
 	matrix->aqm_max = info->apxa ? info->nd : 15;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 79cd378c30d8..9044ef4408c8 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -177,4 +177,62 @@ int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
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
+void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

