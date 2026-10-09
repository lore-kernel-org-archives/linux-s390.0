Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682384D7965;
	Fri,  9 Oct 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546208; cv=none; b=KLKJNqubD5kJDAdCjJn5+jR8WbO8hNnz52xFhrwYnMt7b12+hljDu3ZZ6bQed5txnWbambwtJj0uFPvgECkQ2uQRpkqaCPtjxL6ZUUpueh11Y7pZDlM31aA4eKyzxNfqFM0QQ3uOliIJn35zy40ZX2vyBl0QfUKxNkZeWdYFYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546208; c=relaxed/simple;
	bh=rUNQIsj75qmOBUfILezDEdZQiTQabD7S35DjS0eVppw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgf2hHIQyvoY0UnYIuZ6T46AtleVTOXA8PTXUX3Gz2PZR7DfJRnIbGTUg2v8QY8U50+8DNEzVNHyNbQVE28UDX/CtHBShx7SJkO51o9kor1T9giRq3oqB3K89/VDnXIcBxMfs203L0N3V/1A7s7pKr7RDQ09HoNkaWrrfW7Sz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbgm2GwU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbgm2GwU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZYR62596557;
	Fri, 9 Oct 2026 11:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gMNNMYzZRAO9a/Ul1
	WY+jc219fozkZ5vsuGwUpH/GcM=; b=bbgm2GwUjB/2taul9IWGtLEzoD2DzB71q
	EJVVHWgdDF5LDJNZiu3hplNVU+mEYHsE5vBh340h7CDTwPwIQs3Wo+VOWOKy9L9Q
	bgFLpqRwVrGkPPF20GvpLPQIPFm+AnYI0rz1fXfAZXYgJMEgqr2o4R9kK6Hv21Hp
	oUQDmQwQCSo66iYICr0R6me16dMKQXeAQCfP+oEU+y39m/7KqDQ+GszoZE/AfrUn
	wGmS0ESg7Dp9aLX0TMiU1H8NXlRIGEiqiKIk0UxGNoIN9j4QzTZ5YGncCQSpJ1j+
	Nvxr+T2AsEtKs2grTeL8Y3NLxCEx++FMu8D0Wui1kJ15RyH6FJqag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1hn6n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I35M621418;
	Fri, 9 Oct 2026 11:43:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bh57R51315104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97CAE58050;
	Fri,  9 Oct 2026 11:43:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83FE58054;
	Fri,  9 Oct 2026 11:43:03 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:03 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 10/15] s390/vfio-ap: Add method to set a new guest AP configuration
Date: Fri,  9 Oct 2026 07:42:39 -0400
Message-ID: <20261009114244.1213173-11-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac8d34b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=7yNgoilTr2P9NN8D:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=yveY4INecE8b9H3w9zAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX7BNau7D66h2F
 sIyjVVA6APwsutHY4rrxrnbDGYPQjrsAtpYHJJWuz+7/67QTCP/qDvgx5dwiBq/662WZRNP4BNL
 d4VIO+ExV7SCAL57DagzuYFnnqQUvZiaIdoXgPAfvIa0D6uPK/gcq3/FyRrPbml1HQdpE+QIbc1
 NPxlkXNrX+3I2sQb6bkoh77HdG2KTWfDu/7oG45uAvupeiG6ndo6/1EL6sKeQ7aRdJo4MLDrcw3
 gDxALIUtVPsYS9SCzfvA8u1sHHgdQYrI7x9C+gROlO6l4PMz8Kl23q26yoBFaCyJPO0csfk9CM3
 RLNCnt967O51cgS4TNJp59Ufb50LYpmz5D2Xdjom9yHF+ngycZQ7XOVnyGiJHwuRc+ZbX4Lb5nY
 Ibg5oM4O5tVPpE7B1k6PkXizxrDcNvMw7eIKCKBoa87IWL1Ep437v7m0nWgFQbLzNcetj5rLh54
 PPn6McU7vVun8kgEPmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX9PMmWdBOZrrk
 Lki7bIsbDf0aE5pcfEK43i0cxqCfBtR+tgaPRxWf3/IzwNFBRFQ9JcEBz55ia0SIg5FVGm+iO3k
 stzt5WKYY2bcMegOmAOz/yoZ1Cb52cI=
X-Proofpoint-GUID: kuhm_aqjhBuvzYSMZTlsA2_FpKUDuCop
X-Proofpoint-ORIG-GUID: kuhm_aqjhBuvzYSMZTlsA2_FpKUDuCop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

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
 drivers/s390/crypto/vfio_ap_private.h |   5 +
 2 files changed, 120 insertions(+), 44 deletions(-)

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
index 9044ef4408c8..3910b5c023c9 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -172,6 +172,8 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
+
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
@@ -235,4 +237,7 @@ assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
 
 void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
 
+int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
+				 struct ap_matrix *m_new);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

