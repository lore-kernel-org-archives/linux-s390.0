Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777464;
	b=wzO2uRWBk3hOdounw0xPQTL7aQvAu10GJq+F5kDqLdl6Jax97aijcfXcXS4zUH3cT4/j
	 gaVdfvXl/yAI3cO9/g3jNi8mlHJPUcJDj5nnimmDULWknojrKuEWiFKAVScqJwYrEXR6l
	 H0Tq/XXFgjg20fla0GBbfR/AVFpwBKn2X3DXsn12GwAnN+P5tcDSWig4A7JrKDJ8myoAF
	 R1Umc2mnX5cK8JOn/er91CRJfbPDfvOF+PJ/t/G/bjfXt2NmU/wdYlhLx8+WZL0MPMO3B
	 RmlZnirZUpJCT8g+ZTY14mp4bNWVlkhc9T8knHfDOk5PN/qZmu4eGTqfq6dF2KDsWmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qg4VdgFKzBFMkL6A+koKUiGfjurci+RSLcEK9fmi54k=;
	b=AjKN6nqB0jTbsHprPZPW1qhehPeA5e+7WmoQ4p5v8OVlLORe/acOPFClbFT8Sfqf79q3
	 XrTBVwJhOr3cVxFbQ74nMVQyivAiWK9sRUK+egudL7KanvnUjB0vh2kfIb9PdYVua9mxw
	 kBY8rBGYtrksv/h0QEKb/TTXRNp2u1bSUSbpT9jg3CbCGIXvkaCWuo2MEI3+tdpe0txYK
	 Rj4tpCnXoICoAgSYtlDfB2sSBqwjRYsJ3KlELDPU7vp4lHtjxuU6opfWMshe9xtGO/w8P
	 LQxl/UzaVF4Nue4OROJK+RtyCBojoocLkyJls2EIidqeMo6ieHS2/fAhx9l8p7wm9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HRHmBRL2;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E360A5BD7;
	Fri, 23 Oct 2026 17:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 830E360A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HRHmBRL2
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoZOL3562288;
	Fri, 23 Oct 2026 17:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=HRHmBRL2bGhEjFmoqcESS/emdZpwC+yDE
	wjGAii2ICH9CnAgxCd6Kn1gvxb1lMHqE96KU/3z7sqhM137/otYAtGxcGiW291K1
	kbJYiely8m3PU8zxURd3kw+fuyARyGfpnv06dOrrSVbgno1UAEZHDNu0PNWGghJP
	TKI4SmQ6luEIyq8xIrsNGBg1geOFTbO01TNc5OgXURjv0XQFzv1XAAHqD19P3iFK
	7gHTeWTdpeuT0g7Mzp7vhhfArK4sTF3ljMVIGYfxVU6zv9db4xZcn2kkZLVTE8tO
	ihKukk3f8v8/W+erYlJ+nedF00qJN3syUWH0IWnfKVmSRFUCXJlNw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5apktd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE64kQ2220904;
	Fri, 23 Oct 2026 17:44:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHiGb929688402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98A05805F;
	Fri, 23 Oct 2026 17:44:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3611458054;
	Fri, 23 Oct 2026 17:44:15 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:15 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 14/15] s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
Date: Fri, 23 Oct 2026 13:43:48 -0400
Message-ID: <20261023174349.3545941-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfXx/WG51nNIj0O
 FRZ4NRFkFBOhSLwW13+ZUdP4WWMllb1QBaaOTx7voEz1Oo/F0oGK8x92PxXYHgtTONBBRsKLx+e
 wS4EiG9DYr9FicIKTBuVMXYTUr4qWtU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX8gQfEr35r+Z5
 fD9WuVxPovSm5SdBXH5zLakOcyeiPjRDJD5VvWGAe72fIKTuyDyJ7Jh30k0ZKwfXJ3Ycd+14tIQ
 +HA1/a8sf1KgrpEQaQsqFMWAGh9ocxrLzH3NuTtIyM0VFsUcbFHxT5cHqCe7MBI+Lvrp4nyqE6Z
 UAUhWiPNgOiwFTf0/aXKFDd1/BL8RmpMLrKoQC3fW3lfEuqgaGsyXW2xwRF9yrMwbgHtvzmb+IA
 bfHpvDqdqKVpb5+k2yj5Lbo8XPr7g3VN+jZ9XTmv4wrb/uvzGH0HMlEl2jaK7yrnDPM0iGVXOdC
 f2XCtUiKq3xqLV6P1TIoNb0GeYMxjJ31r//w4kc+SYRaPuCdxHgAnXckDIkrp8dOXmT8t3FMQI2
 Rotl3PSgu/WNon1NRnNeT3boueimZJPYCAPNWph4p3rJftvhDqd7WA7ZaJ0sdY3Z3Yd2W5bkKDN
 vJFUsACXHKz5+BeZxOg==
X-Proofpoint-GUID: L-jUSMi9yO-Lsh56c9GV95kG_S4l-kk_
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb9cf3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-ORIG-GUID: L-jUSMi9yO-Lsh56c9GV95kG_S4l-kk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230069

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

