Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48151331230;
	Wed, 25 Mar 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472529; cv=none; b=khGVW5rhrx9pSf2iRw070EulN+iIH3lvJRtx5WunTFgZAkekOq4qTc9xHhU3czkELmcyChD5dbMwE2uHQz6So5jssMippydtYObxUf6ij3fZv+hHka9lF5LXU8s58R9GGaKpfgz/c6XWWplWEV3gfp/FNm+bLCBymwPpY6J1tbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472529; c=relaxed/simple;
	bh=uRKV0D+Q6XMD+HEKRlc4uERZOxMIlh8pi35qiHiVGrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czBGNzUs7JN/cQYPu8vWCrksRHhI8dWDlOaHCcccSuGml1rvnrt3rlmtlgey4hkaD3IixpxytU9y6TkKs3G9vhtPzCNBFtsoGA+Ef/lhDilG+plOUXTOhjuuNRpdX3KC7ADWT3QqCT6pbjhmfc6f8Zp4GzkvjTBC1VEp5Gef9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qOWC7+ZX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qOWC7+ZX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PILXrM3744362;
	Wed, 25 Mar 2026 21:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qSmUbhgMZy+IxLkdr
	ByGeR2wsIm+CKil+CHEI0vVd8E=; b=qOWC7+ZXUHgqIYOnG23Pp9YlpvWV2MHoz
	v++XJI1ox1dRriCDy3SbUWulcqPDMatNdPT+Vni8wQiYeXatefq+3rTxMBNC9Mof
	1KnB3NRd2PtGH59KmSWjNUUCUk7PH3bBNIYtQKSXLFS4WdlGprQ0Fvws6X09kZMd
	KJfbyDhqsETjQBn1U7+HvVO/XzW8H2lqlNjcwW01LcCoK2njKB3RzIYJ8OCwEkeC
	LlTMOb1K+UGp2xOrRI6o9y6seiM2AR0e6qCqJujgpe3nFJMGsoPdjjxgxNN3Ekbr
	QYRCi3ErzAtDqaeNd9hqq2DEsY4g7jqW5A7D/ysWidwDN452y5ExA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa2dea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJ62Ai031631;
	Wed, 25 Mar 2026 21:02:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt0brj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1xKo20120222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439ED58052;
	Wed, 25 Mar 2026 21:01:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4466F58068;
	Wed, 25 Mar 2026 21:01:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 07/24] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Wed, 25 Mar 2026 17:00:54 -0400
Message-ID: <20260325210149.888028-8-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iRugTJjjWMLkFvKGujEYGPRZXZtpw-5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX4QmHo2flNmxO
 oipIDuVWUBP2rwyFrRXTRwpRvojuf69lhJPH6n7pkbvqejaLMZw3XVg9+BMpKRxt0hMZT17hBAa
 xy3QuUQf48+at5sAcP+fnNTAXgwPuhXA9srgDhHPaVv7JV8b41hF2K8EaBBTB7crGfI6bzNEz5N
 INaKorkt/zhsklZ3x0eCQW1OaniaCTIeXLhpL4CrUa4PDX4TNNq0Y3YojAfrXHJXwy+0gjxvlT2
 2wetDIRItV3DdvKrslww+XROe1yjDTvhIuQXfgAu53rpApQu5XD7zYI+yyU4SaBiTXYpO76Evdp
 a7kixYO3up2KE7OncszYsGKk7/DEZGM2aIB2t2xH1W06ghcCwbNZZ2Azz9mRmmPniHo1j0j6ctN
 rE/JNeNdZRbhCA4NOk614YuDNK2Xky9KvcnOgZhnK5OUeQERRKg+bjaRwRXMFEKuUJ+HHZFgSvl
 99XNC2w177KCD8jzu1A==
X-Proofpoint-GUID: iRugTJjjWMLkFvKGujEYGPRZXZtpw-5Z
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c44d49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index fd7394d81880..d2fc3598cd24 100644
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
2.52.0

