Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48A4483BC;
	Fri, 24 Jul 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909677; cv=none; b=l3IDTvtSv5QUHo4cUSzK6XIN1f9GR1+HbfPaZM1nH2dDzyshOHdGOJx+efod6KGNCU9jBVAQ0t+TfbiVGON24q5RMTixOFZQ69pRa+6h6F3MNluNdhDoWWHRIfYZWRBXmdMpWILzTG2ZwHyOkx360hvnLZUcDB3GYmZ7fPpG0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909677; c=relaxed/simple;
	bh=Hal2jLpW9jwI4RpxS7uNTsEG8gypNxlL9fhMbAkxgr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqG42ZNzq5CVW0iGirFTU1v7ejJBKCw98FseGnFkAUt8yKfMdfLRkK7xV0VPg/169I0nTndR/fOh2KjS+5hbP1Ar4f18arlPXr5otv4FaUywV1XNsPbSbOm5ukT/NUzbg+fF+4EHol6Gg49GZGMmYYwIPDDNIE9jeM0d1poNmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=deY6cp7B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="deY6cp7B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfdll1973574;
	Fri, 24 Jul 2026 16:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MuFmywDxoSDjBBAjm
	Z7MnYtpHXmbfOsODaDcZdMsvkg=; b=deY6cp7BJJ88IYs6Jusnuo+kN1wDOzyoL
	4ZUHIjbQHv4VxYR0biZ5rQga6Hh1n3p7n3RPx+xzoRV72BY08yCn5hmyZQYIUGpK
	tqEvy5W/E3Q29No/LjoKnbzMwApcWSQZrwW8sI5hlb5UuSDGYECwPWnSa9mfKzti
	Rms5MS4J90vmJAyn1ZEmHBjAvURUKM/3vcKcFAwujcW3zMKOJ3H4bfLlY8XljSOw
	yBj6KfZf5NnmrXIuVCDIMDAiLdK7okHmSZKFPUjHV8N58FcYEUHLzAVOLkTpk8we
	Kl9E8BKTI7yUSZwuDd1RbumEApsoIHgZGXA4tKl4DqBgYVsg0F5Cg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50u73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4bvc026008;
	Fri, 24 Jul 2026 16:14:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whr2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGEIBa11534912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E8C75804E;
	Fri, 24 Jul 2026 16:14:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10805803F;
	Fri, 24 Jul 2026 16:14:16 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:16 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Fri, 24 Jul 2026 12:13:50 -0400
Message-ID: <20260724161351.1802644-15-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX+Qtgjd5UjSTU
 PZMIPMAo5yrSkPgBLVFAtzmNQMi0SI1RpaP6hVWhZlZSUmwk+S5DoLB+TnwXCDPbT8Dxe9uIwHV
 3Kvxj99HamuKhGddWHlUGszHS/ZplCs=
X-Proofpoint-ORIG-GUID: GWsqgRMRj23gH4sJSL2tuHVJAKpCT6uy
X-Proofpoint-GUID: GWsqgRMRj23gH4sJSL2tuHVJAKpCT6uy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX3X4aeyZcCe9r
 06fqQ4s8Wpy8JXGy1YnSQboKj0ZuB/sz7tkR9IYg/9ePCWrABphGAby1yRWCiuObNX+kvXa4eTX
 lriCCo2Je8PjXWwIzNTVksMWxjHzokqcgsjx62EEjhsNIsoSbFZ+gf6ZfAMdcgeoqpW7iULMOtt
 ibxGdh5SGDR6HAesIKzimykUMEFSkDCtz3ZcHX1WvTBaeOTCWHeesNxOzR9iJKQFlme2IJacpVk
 4ewJnz2Uc95oquRRlS4upun3qkmQKmBHmQQMnbeGKwPQ+0JyILhErqAPt6Co1ckRhOts12tbXyN
 wNFD1ewvwcroFgnrAlWZ6KwZS+7F+96yvpXNVRSQ1dhll96Nj5SwHci7bDpj4e+40Tf0+9Zv8I2
 adM8b0kw1LbtXAaJMaQE6QxaRvqdHrIxsJmN/LCELpDfi20xe2nQF63f2IKpvIHVje6RLfLcLQi
 f0qY1GHKd4guUmPd05g==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a638f5c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..4e973736522b 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define FEATURES "guest_matrix hotplug ap_config migratable"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	return sysfs_emit(buf, "%s\n", FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0

