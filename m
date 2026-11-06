Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978614;
	b=nr3iT1zrx5zcorkhDw39bweRNGf7E0zJbtMrdmjyuwaQZX+rnrmLPD9MSWqzM8H8cJfE
	 I44SiDpwiXGBV7mSUIIddFj2QAGXngIZHUu8dLkKtXz6sP07nkZ+2Qu4Ld6o6Ur2v7+Mf
	 0qIHWnHCdNx7bsBsm+6mtmkCKnWX6lnPQFdURC14WYXsi14lDY+yfDz7Cyy+CuMjz3fnw
	 +sA9Ya4zfp4Td9ivqNJlEk2ZI5zNxic40XWjW19hcqzR7Q9BKA9DQ2Vkfq9zDE2FL3Ybu
	 EWLpd5i2Kc9lSXZ12xJcTEAjgozs+0tqI8ByzRmSWitvY6XGyQ0gudhkuYl5EuEUd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978614;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qg4VdgFKzBFMkL6A+koKUiGfjurci+RSLcEK9fmi54k=;
	b=314mB2IeMAipZvaSx2u90q0z5AATuE22150oT3a5ZhdkwBYIzTePYO8XPvWdXUPfhGxW
	 JHhmT7Mx6CocyY68UjItx4yjct9vltVou/zySe8/ZAH8UuXpQ18kZ06IIVIr1+E3KgN7L
	 K577EqGOPyaQaZxK3yWTMddZtJxsOjpzvFk8K2f28wogCMmNC3GSDJZNYyG+13PxxM+VS
	 zufkyOLOPtTukm3yuV0Fa/KT79wYWWFZzTpufwonXuATpyqMLDY40ZStJIH10Ctn5a9HT
	 0tG7omA7DFakHHS+jj1KNn4ZkHzugEF8nDJZ6D4n0g5Dkngdif1+TMIQTq15zEXGmlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kcmTMTtv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415ED6083613;
	Fri,  6 Nov 2026 15:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 415ED6083613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kcmTMTtv
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEICU2936105;
	Fri, 6 Nov 2026 15:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=kcmTMTtvZzIWjB8fqireGKH+lQMf/8m8L
	zoVqWak2rVbvI3Hg+axlm2zFHvNWI40x469jeeFfsOv0frFuxw5UNFREYPUMTDQt
	7upBFXryQ8L9vSlwr7cNj9BjsETlUH/hs2oV70thtC2YIWwSOEL5pfOMwl9qd3Jx
	lhA/1d8bOlYBCfRQNzNRKLEtvcgDfy1HSaixngClh+L0UtdVjJrkOZvz2HCSRpC2
	10yjJwEYcUlkITW57UMG/yKDMsUccWlzpS+UL2ddYbQKv8lE0UekTEPham8n+vTD
	lkNn3xd157nTsMORj0kwIuSjilBeTsuoFaDGjmAL9fI/VdTyFR4wA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcd72t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4rCt2390066;
	Fri, 6 Nov 2026 15:23:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13m1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNQ7m30147158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E7A258062;
	Fri,  6 Nov 2026 15:23:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B263658056;
	Fri,  6 Nov 2026 15:23:24 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:24 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 13/14] s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
Date: Fri,  6 Nov 2026 10:22:58 -0500
Message-ID: <20261106152259.1360651-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tOHRZJWlAvlDLM142-7amHZ6A68Uzx7J
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedf0f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-GUID: tOHRZJWlAvlDLM142-7amHZ6A68Uzx7J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX5Hi0lR2TLNDn
 t5KBIsOsnalCFAWe7EhzJ9Oz9AGWPvRGF9zIs+0tXDsyMoHL/GBnwEwuXsN+Bll3PYo+VTFl8HS
 bKS8J6z+wXQXdcG5qsWvq/HlfgG+SknGXkps60qqfG4fxJY0q9fyZtE03Nohr0o3Z6DxqLkfaBC
 JhWNcjN8FVyKOVjwVjx3rfYl69yhfpVvd12pEB5GsfM2lAp5Y5kRsTS6jq0PGgL2Bobhyd4ffEx
 Us83Q9OYr1Zv3bBIHtOQPYn+T52bbT8ITnpmUCWEu6kZcp+MK8B7yn46v64UDFaYvjSu92ljF6u
 QVuo6KHB2DjB57xTwi3WBdSrVBgY11Ol1gT4in+C51w1YbsYC8cwRD5Tf+tufgb5n9f5vFDC4f6
 31kUUV9qtMVaRAYWYe1heE6WNEAQYhdazoFg+o46QGFLlDAsVFE4P2RrhGlQ2HJOzBtg4nG8T23
 ckR43UGEycCoUpxH7XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX/XcDWj6ttk72
 91JXj5oNjBNpmJv2vUUe6v8Dg3lIaK2ydC0OVPH7q2L0p8kKF1r5dWyfDTbk68bzPm8Ej60168x
 uxger5tWg7uZvIyirXlq7m4xpj7nlNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

Add the 'migration' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported. Since live guest migration is not supported
for SE guests, the 'migration' feature will not be included when the
feature attribute is displayed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..c63a050a2356 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define VFIO_AP_BASE_FEATURES	"guest_matrix hotplug ap_config"
+#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	/*
+	 * SE guests do not support live guest migration; emit only the base
+	 * feature set for them.
+	 */
+	if (ap_is_se_guest())
+		return sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
+
+	/* Non-SE: base features plus those not available on SE guests */
+	return sysfs_emit(buf, "%s %s\n", VFIO_AP_BASE_FEATURES,
+			  VFIO_AP_SE_EXCLUDED_FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0

