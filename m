Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF73EBF2F;
	Wed,  6 May 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076732; cv=none; b=trBHp2BXrI2CG6LKWmH6MGle7b3d2xRWuX8QPgpYjYf967CtI9QfzZ61zfZf8Dcgu4gWLiCoL2pkIE/kaauOQB1X3P9hi2UakXpW/NXTsUw3z8Q5Wy0ql88QeHptnnmvoonY1c2cL9JxvYkFjs4ayljLz7NnNfVm8SRQliDDWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076732; c=relaxed/simple;
	bh=uV7zSy0el/vGLgHsiSmPpflQKIpEHxU6qV9MJH93HW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY5H25flEsGs8bQC23EXP80ycQAiAsu/TOrGliHi0TnnbYxhvnKeLojy1Qs6APv+CoovC7H8U/1clFJjJHVBGKl+OuBUqlnXwcc+5SBBtyEpapg0Dt2PbVCxaN9zI0v/YS3XB0/FmsXxJzB5QwT3zLo011rE01us5xYehmYAO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W84A6Fkd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W84A6Fkd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6460tWa81383158;
	Wed, 6 May 2026 14:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Hi6x6owi33AHI8nF
	8akzM8rEDf01kP9B4FFxVEBRJ0=; b=W84A6FkdTcoHjKdwq4CHZ5azQx/WcSEcG
	nmBVxzeZ8rDhup/0GOC9jM5O9A9jW5mgBcVcCTjB6rl9epcu4HHnLq2PrRcaRS66
	f8FKoK03r3iVpppQdo3HGaihFY4BlW/XlnOZiV6PEO6YLaoeb41CBgzmMmQd4Y5T
	0wCkaOC9BT63ULrOXo+sSuArWM2T0aNOQmEmFiOlKoWNsaPzeiNGcXFDt7vmG20T
	Bx+57nsGzkSmEoiZvwStcJZYEblvznMap6Df+4vPmyYWO44lPQy//9HP/6WzZBVO
	pFecfGmXnhm44l41B0OcMUF57I1WEy9sB+OqnL1kHaBmlduYZPFiQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7h4w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9at6001518;
	Wed, 6 May 2026 14:12:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw6mrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EC0ee58327424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:12:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A50EE2004B;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 771CE20067;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 2/3] KVM: s390: Fix memory leak in UCONTROL path
Date: Wed,  6 May 2026 16:11:58 +0200
Message-ID: <20260506141159.154240-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506141159.154240-1-imbrenda@linux.ibm.com>
References: <20260506141159.154240-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfXxUOgQz8RATAY
 7uUrEERlaINJs2XhvrHn8lalo1Ti0UV/GSfmiRierqhAwGHl0TBvXhURHjKvmTcnjTpHUx1Ytp/
 KLeBhiCwA2MZzN6KxOlKVvrxPJZcPQgmKymeukZ+A8FSNSLndCGclJl9XNWsdetbcxSwsGi1wt/
 dBbr7cAXpBJrvQdOsznGSY/UFdJ9rdwweIBthSLKJZ1tz/yqG9I13jvAzT//801IVAFEK55WkFB
 baXZCOUXyM2iHfPj4Ave1ygvbgIljf8FGjfIZjQ0Q1OFLTVqs/ILBbnvagLbpVKaMeQd8cQtMis
 rhFdOj6oeLK/MDgNtQ93SN0+v/4sMAPSzGKVHT9qJ3a42Qv097i0noxveT6F8VGYzfSdMD24DYn
 T3kIDnnkTfZLgL9GM5Upjn5n9n18w+c5R1+RwXNZoFpYGEqpSjcDHflzYby4jqX/CInHukOx/mf
 yljdIq8CxBO596u9xOw==
X-Proofpoint-GUID: lcAYYLc5YJRCL8xUqtFuiw8Nkmpk8NtJ
X-Proofpoint-ORIG-GUID: lcAYYLc5YJRCL8xUqtFuiw8Nkmpk8NtJ
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fb4c37 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jYruZbZcGJNaxceoNIUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

Fix a memory leak that can happen if gmap_ucas_map_one() or
kvm_s390_mmu_cache_topup() return error values.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reported-by: Jiaxin Fan <jiaxin.fan@ibm.com>
---
 arch/s390/kvm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index fd1927761980..c1140da0689d 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -822,8 +822,8 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
 {
-	struct kvm_s390_mmu_cache *mc;
-	int rc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
 
 	mc = kvm_s390_new_mmu_cache();
 	if (!mc)
-- 
2.54.0

