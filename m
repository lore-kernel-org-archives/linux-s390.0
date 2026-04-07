Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A933B6C6;
	Tue,  7 Apr 2026 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595098; cv=none; b=XydR8ADAcn5ZNUKDvP3C/NQjidhFe1qni0tW5g+o/ajJDFT9PuW/L4RyRTZ6YZZI9gJ0VY8oYOJiaiac3LaFw8I3WeV9o+eCP6ncjNfGJWisyiWbWgeXal8QCMhgVsD+21W8Z7KBT/+chipebRLZXocmisR4qvpXNsZwcA2RsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595098; c=relaxed/simple;
	bh=uRKV0D+Q6XMD+HEKRlc4uERZOxMIlh8pi35qiHiVGrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZIF5E7P88XI6x6Lysowo4fSKMCnk9WQyFNncnZ0zjDp4c3ZQud2nSiFqJl58vPHN/94vklAMx2Vt0YSqyRCdN/7uhZ5gX8ES5wcYpr2Pn1/aO3yfvKjjUMRYqU94NovroO0+65GfwHyT0EsxWMP3XKb9NCc82V8vWSJINCglUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZaQZHhC9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZaQZHhC9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EY5fi2302659;
	Tue, 7 Apr 2026 20:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qSmUbhgMZy+IxLkdr
	ByGeR2wsIm+CKil+CHEI0vVd8E=; b=ZaQZHhC9ehw2U9Xom/raJdIV1YPhLK4+1
	Di1wfLJAhRpUAoDt+yR2yJaLuabRxQ7go7B2SQUC5+IMjOdKbIvWsgi9ZaS/n6So
	oB/Imo6rwpWW4Twx/ZWVzKEdTSZBx9QDlQHII9ApU2EdW1N/Ra/I/a0y8kE6sdyx
	VyAVz+x/KM+BPaSS1pCPuvAyJO/e3cl4m5rohrFkqgxPGnDmNcoBbMED/uE9j1et
	GUNy7Z7zKg/+EYX7+dBjVlpYqt8MYku77ZGHuDY542oiAZOWVUhjgK7WBqhCosXl
	i0ErTg9YG9PMgEZAmTS8cQqNKPOlXM6Hjo1LRXdFxoCrR35vIrASg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fd2sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IfKMc018961;
	Tue, 7 Apr 2026 20:51:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cuqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Kp4Z210224354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F09058059;
	Tue,  7 Apr 2026 20:51:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EE0158058;
	Tue,  7 Apr 2026 20:51:27 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:27 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 15/16] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Tue,  7 Apr 2026 16:50:31 -0400
Message-ID: <20260407205100.331150-16-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX1a10af+X+4Zz
 69oBgzKHPKjNKC0pwTPqpppwcXkFFzZKsAEiFk+Wk0jpCLTPSxklW/L8JWXKolDy7vJ4SsnYyFl
 1WVLVSF3tpFV31gushA4nxUZSWk2nIfJhcXoTmCqPu38h5lFyTUE/U+1R6nkZ479RN1hTly7Cm+
 eyZwAdg9EuOXgrhSmtr5MRqt/WulsgLUPJ599b+O/cVDhFwHXqQJhH6iKd7BCOFOErT7Kr56h8V
 wm0hcUHPHBrV3w50ez6juHfxZj5S73x58IpT48wR7D/M4jc1YvAPWu7AMUsU+JCD72Iu3LIy05W
 MsYOL67OFRtQX+P+tOw5e+y5b7X0R/uq/xqx12c8ycPNGVxQKWbpfV52Az6cDZXpg0lbGm6mHp2
 lhKvzUqcpkbafylS6T8Bj7PTcI5qm9T/M/65aV/vP1MrN5BLX6UElp45a8piZweZAt9io42MT4C
 LuuUph/Qbk5NEOnkqbQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d56e53 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CB_8iKbeFirw2v3l3xgA:9
X-Proofpoint-ORIG-GUID: 9D8Dcd4jIrpg6qn0ebo54X35qwP97Ajb
X-Proofpoint-GUID: 9D8Dcd4jIrpg6qn0ebo54X35qwP97Ajb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

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

