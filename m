Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D65349A8;
	Tue, 13 Oct 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905575; cv=none; b=U1HmKbkjIZlhrREP1pqtW7Is7FCDzAq52MFTiFLLBRlmLk5DpzfSKIiPOYhERxk1H55obNXwbOcNeZffZ0n1Kbzv0fdC4/RY3HFXFmLyNGZjrEqLdFhtTH/jrbxjo+zbw8d91SdyA9Za6ZkmVCZbulb9uzRAJ9mfHh0VgkPwe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905575; c=relaxed/simple;
	bh=1UOVlmbhslRypdc8vvisifiSG43GRt+2njvaH9mgN54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsKqtDU2pyvobxAdJ0gbj8K4YLW42bz6Jsm9lkTN88se/uSHW54KLndl/Wy9dlX8rmNiWpjirEiafPL6WLbnzgGr6lL1sXxXpGVyEOhy3l1ZZuzFMpPT10FzFRv9ZGUgtkZlc75VNnqbdXZmyQyAQY1NPbFIZD8aTJ8j0NuFhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ezBGOySE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ezBGOySE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDM84w1933966;
	Tue, 13 Oct 2026 15:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dT/1tZTYB/sNOscIQ
	eWSTnvc67RQFQkW3771CWNptd4=; b=ezBGOySEurdpyjU/YQJ63TtkOEYo9gP6x
	P/E3wZWpdwJopIRWgTyWxhLPFk3BVbhQe0GgoMsNp7fMWHV/43z/4Th9Gzvqh1ZV
	Z15oUiTgK1RCLfBMOT9sbodxN1SEC3EmOgIPqMUnH0ByXbc1iv1Z6ab1f4aTIZC3
	lONAyCheUC8c1THpqeNA/7K1hLk+RGmpRN5TFcTxeNziMmkAvImZXdE1oEJGYtOk
	2GGDReQ0Srr2ShSbgUUfVQlbE61b/hM2rvTBZlAkjmGncRNTFyh08tFezBB4mYwM
	KdkX0jdroVcYqzJj0SI8paXMv3miK966AIZCYDWmovDlEkLxV8p1A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w6m7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCTLvk2709317;
	Tue, 13 Oct 2026 15:32:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h2jtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWemx56623432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1A958067;
	Tue, 13 Oct 2026 15:32:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8C858063;
	Tue, 13 Oct 2026 15:32:38 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 10/15] s390/vfio-ap: Add method to set a new guest AP configuration
Date: Tue, 13 Oct 2026 11:32:14 -0400
Message-ID: <20261013153219.3534306-11-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX4SJkLfhlW4MN
 k8mqcQFntbkihBuWXr29Q3J1QRcuHd1phKb11O87NWhr1NS3/LrWiHU6FLvRpZg1c92lmELhU8E
 ps1tJEsEYZ5V4BHpw9ZPS6Kl5877rNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX01RMuK7x6tTW
 kLuXseAa1b8CTl91av0jV3OdRF10O6MzlWQJMxiI/ueLa/taQJy49/cqVvZlO//wXezoYY+YMw6
 Yr0+C5r+jrOgN7xFRaPdXqhGnwYhTRLSr9wx90cikqoodmbOLg8TC4WTVIkg/LBNZ7kjDM7Ajon
 4RD2XIcJ+rCn4HaONVPEGWq3tFm8bwi0P+MLOwsbyEHhXLzvm6HpH67pGeNZIC/A0u7EHB57zr6
 Adt0rw4yI5i8omIr6nXfePxLpxCbLRa/4jFRHSE0vtSmPvYwZCEYubI70vQqKIpW7yS/QPtukKy
 LiELDLHtN3X2gmP+9gCGRektHSNKEWF50TFE661ufka8JWTzB2gQfhbZ/mLL1KgIb3BF4e6ieRw
 WXFYUmlCoWEXUKkAqlYX/Qtb0yEyTYpDPMih5CFmvuyH1BQY0WYK+rAir3j+HmNRD0pZJwpuO6G
 JtoX7ltVocHGWdIrxow==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace4f1a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=7yNgoilTr2P9NN8D:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=yveY4INecE8b9H3w9zAA:9
X-Proofpoint-ORIG-GUID: 4HHefr3FPUwhd2Y59KPVKbq2ieZbfAor
X-Proofpoint-GUID: 4HHefr3FPUwhd2Y59KPVKbq2ieZbfAor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

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
 drivers/s390/crypto/vfio_ap_ops.c     | 159 +++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 2 files changed, 118 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c951f289f305..5803207e9846 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -981,8 +981,7 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 	unsigned long apqi;
 
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS)
-		vfio_ap_mdev_link_apqn(matrix_mdev,
-				       AP_MKQID(apid, apqi));
+		vfio_ap_mdev_link_apqn(matrix_mdev, AP_MKQID(apid, apqi));
 }
 
 static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
@@ -1692,54 +1691,98 @@ static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
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
+	struct ap_matrix m_old, m_added, m_removed;
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
-
-	mutex_lock(&ap_attr_mutex);
-	get_update_locks_for_mdev(matrix_mdev);
+	lockdep_assert_held(&ap_attr_mutex);
+	assert_has_update_locks_for_mdev(matrix_mdev);
 
-	/* Save old state */
+	/* Save the old matrix to restore it if validation fails */
 	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
-	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
-	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
-	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
-		rc = -EINVAL;
-		goto out;
-	}
 
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
+		return rc;
 	}
-	rc = count;
 
 	/* Need old bitmaps in matrix_mdev for unplug/unlink */
 	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
@@ -1749,14 +1792,10 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
 
 	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
-	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+	ap_matrix_copy(&matrix_mdev->matrix, m_new);
 
-	/* Link newly added adapters */
-	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
-		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
-
-	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
-		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
+	/* Link queues associated with the newly added adapters and domains */
+	link_new_queues(matrix_mdev, &m_added);
 
 	/* filter resources not bound to vfio-ap */
 	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
@@ -1767,7 +1806,39 @@ static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr
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
index 9044ef4408c8..f506c4b07b46 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -235,4 +235,7 @@ assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
 
 void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
 
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

