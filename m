Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425011;
	b=hSaTp4ZZIv+FiidOgp/sYzf/B1a6XYCvRpUYjLMj3RcGw9RDz7NETDN7ImSlO8MSL+Rc
	 0qYu3wDTeVLoYYqRnq3vg2zZAMs1T9qW3ccHYUgIY4i6X/1AAagi1DLV5myp15lChzfS2
	 8nYl5Ar6iFBt4IK4I59SMv3Mfqi91ES/yFCjVGRjF03S9g3DLb1iABuTY5qfr2a3G2MSW
	 EZ+WBnE6O4oIQgCziCYLw7u3I2IN8MTXbQWVbj/rKvYvS5q5DDIdIBsCX0GDJgT8Fy4Fq
	 mNJhSzAJ4kuw5rJWU+ETAZCCvZ9yekI+Cn75C6dRf8VBZYSFmzEm/e4dE/rqyk6j4aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425011;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qg4VdgFKzBFMkL6A+koKUiGfjurci+RSLcEK9fmi54k=;
	b=vwUi8HCn++7Cnp2oNpOb2hCPjx4hruzfgUzqUfvH6p6hVtfm/3DLX4AZUUVB6gvA6G6d
	 UKca5qPuchC4aai8euPQBHxKQdkaNwM4TwWk9hoHmzkYX2zCkGeKYfgyR9Nw2vjABDIip
	 UfbPhJqENlqnFUfK5VMWRDboBXCFQCZsct+dTEsXJOO8pxQALrGaHKa810VA4v8sMjAcz
	 yrsioVete1r8sENTLSVaX9eRp5PTorDS2hwg3bC6oz1OTgBQEcBAvP282O0x8vJ1aQPT4
	 GZPMD6F5R/u+7pVgO1bqYy2INqrANnRyFZl4nYiYsrKFvOptWAi0BNMjA9v4oFDz4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dloJxZVc;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294760A6F46;
	Wed, 11 Nov 2026 19:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6294760A6F46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dloJxZVc
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiH611828804;
	Wed, 11 Nov 2026 19:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=dloJxZVc+3Lh2a76JUMI/T7Wtn4aQsddb
	nerG0nCt+jIb/i0v1Q0mHu3yZr/XwP4ZMShm0ZHnRkfaYfTQEjyrB/6PNMCf4nZ5
	fJiu7Tn8pCt4+CuX2Q04RrLb1hkYmU0QZPGLGkvhlfk4y/UzvstCLaMl2vVqRuQW
	8ddXTZrLBtp0X2JoY2WMwqkuYdKDhmfJ+wv9c+Iby2EfwPUtm3LyuMG+PMSLlGE9
	MCYhIyrazqbjMwptDTmyZeHt9Yr6NIvpluLfbcX2maDuVr3ReWsUj6EkeEbtw32Y
	sO//lL84xoz+NZYFNWPKjp9GHPo4eqMFsqD/4OKY2IGT7G8G9Ci5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkuuxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIo5VH3774382;
	Wed, 11 Nov 2026 19:23:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0tbrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNOkH29360820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2E1258056;
	Wed, 11 Nov 2026 19:23:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC77658052;
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 13/14] s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
Date: Wed, 11 Nov 2026 14:23:07 -0500
Message-ID: <20261111192308.2585984-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4c0ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX981Vejjrk2zH
 ZN6hd7YS7yH1yN/6L5W8DP06IzOMS0B2JqNLMRyA8BoKLuPEAvmX0B61vr/UDxonYFyAMRmvaQV
 0Apr9hPJjpbeAwVWTEQk/+QitLfbmDRyrvqDSFqWmm6SP9oo31Pr2WMix/YZhJ4JOIRu8G6+iM4
 9b59gW9cyDzTeD3uh1ih5QdrD9YTv+GuD6WDxYsiREHplsOqky7fMzKka81qy8fM1MKqiY/OWbD
 JRkouS2V4LhZEqmCGBfROn1aS0GhWj5jwg/QPp7ahAsV48l7KM/7vhezGAk5kNXHqhAdnJnIDyO
 F1uUG0Wjdl4kWDwqXjagZB0v1Artq7+PAFrCpFOzRzlPbmQAJgSnoVaAaamk8VVhPvX+naQD63R
 fDrG+M7EKN+9ECzse/k9qyZ9mLJa7FfM3XDRIhjFr+B+r3OOlnA+CjyKKLdAv/35yjTRx3gPfWN
 0ski7fq07WHcM0HQ6hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX6apPR3qcwj2m
 2QN6AgFLX+RPLsrYlXD+WH5rHBhCGM7cv1pVUVSRchJQbiZ1+EdefAnZ9Bc8LYglq1I8R/yOv3M
 h+ZvxasS18NMr9UG3eJRNeyKsG4pBn0=
X-Proofpoint-ORIG-GUID: 2vzoyOxAi9WitYsZC3U25nD_jRvLThYw
X-Proofpoint-GUID: 2vzoyOxAi9WitYsZC3U25nD_jRvLThYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

