Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7F3624C3;
	Thu, 11 Jun 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174942; cv=none; b=Up1O4GVW4azaNV1P/IyIHkADh/hqdfLGDby1wHnKcsCBUebfSeKDNdqVD/uIQ5ivCq3qDwrJ/vC8HbDbosjQMQYsexf54r56oHP8BPL03lzrwrgNQpMmqwyrrtOH94wI67ceZjDeLnkh106y7FrFpYRzJGgpmWNjjiwUalC5ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174942; c=relaxed/simple;
	bh=pq2weFFFXR0imduvB1J6gWHXqZXSanej91AXMrH+M0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk4WP3IKqXeqaiZEow1tlyLjz5GKoHYR12ypopAWPxAjX4e2F6IFYa5CbKICADmsVDvjjkGWKtNUVagc0+L9LuwqYjvY4YXvingM4awkYNBjFQgR5oBaRX0rK3bS63xtX0n57d2XPH56RSbNAkzZ4rqDGUJYEVxNTQ7Y50Ux4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bzUVRisr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bzUVRisr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu4YR677347;
	Thu, 11 Jun 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4dOFa94RBYoM9TJHJ
	JkbtRumrIfhrFK9YD+IH6jEh8w=; b=bzUVRisrrNOm51jMsFDztsi9FmhYPP629
	FDqtK5w1yLJVY+LcQ9wUAc4O7EGwi22hNCa1mdhvYrh1EnqwDjCoRuWJSWXs6nKo
	NyYnzxzoznw7pdgImiRl9hxMaoNzk60mTA1MvGJwOS6RBILHjFOMOGJwqeV9QbEY
	dSKUTJOoX0F5FNPs/vtKQzprxBNWnl6Te3Badfa+hlQdUo0XNyBk0mMECvz90nY3
	VxxTKh9k4LYSGH6Ild5CaKMkJE+4BY8TfJFs5gmBTNWNp70SMDYxWZB0gXTkuzjJ
	OGOyyHObIsrkQpFGyxrtcr1q24CcTgynqBtU/mnycZGC2V9KjZudw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ajv9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAYfNl012920;
	Thu, 11 Jun 2026 10:48:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jthf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAmpS042009084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:48:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7C7F20040;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA37F20043;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 3/5] KVM: s390: vsie: Fix allocation of struct vsie_rmap
Date: Thu, 11 Jun 2026 12:48:48 +0200
Message-ID: <20260611104850.110313-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611104850.110313-1-imbrenda@linux.ibm.com>
References: <20260611104850.110313-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: COVb8--pWL_BJ9uYxHZhaNihd8QCx-sV
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2a929a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=hYSCaGdr6WFvCWo5WKQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfXyND1AYdSKeqI
 lJixkDIhJuDi0FDzSsKTkisyDdFioEfTapuKEOqSUUf/Hi08rnwT7N+06Za4C93QBh6PWl0zL3e
 Gnk84VLf7gwkkNsKjLNG/cXsJ7KY7aRsLmnHV5jX3gLxJPps6Bq4dYAjPvL8TF8CPwnX5ETwNy5
 NkakNzTTFJk0kZbVUeeW5ZnP2CbwRau8C4gv9g62sD4oq5e0ma+zNKO0AuEcHZnxFYL0Gl4k1DO
 iQjJK0GPdS5yM4D0rl19QZXJr0gwZhheD4d+Pt6YxbJuSFxoXzTmof948IuNj9aayF0++5sPl1D
 RpvemcwVMwgNE/h+ElEeR8bXV2G0GYZhKRviJ/SG1a5BVBzMwpunvgJfewANLjcBl8enQHX4huG
 v77/SmyxrzVWTCl6CnmFb4epNdb+Ubxc9hZa20G6lr9+wZVTubNW7IqHCx8pPGz03LMwlZjPiBv
 fcLGtl0pAUZL/QOUClQ==
X-Proofpoint-GUID: COVb8--pWL_BJ9uYxHZhaNihd8QCx-sV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX9Bfz6UeivVH9
 cXXSbIb8yt/N22VUV/qevT971BMaOmCs3c2YNpHQEwNeiIyZtDyGwug4MzOXw/USroxO99hizMu
 +ipEPh84aHZpJjCQLfi0I0Crdq0NTms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106

The allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
was wrong due to a copy-paste error.

Fix it by using the type name.

Fixes: 12f2f61a9e1a ("KVM: s390: KVM page table management functions: allocation")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..a4fe664f65ee 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc)
 		mc->pts[mc->n_pts] = o;
 	}
 	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
-		o = kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
+		o = kzalloc_obj(struct vsie_rmap, GFP_KERNEL_ACCOUNT);
 		if (!o)
 			return -ENOMEM;
 		mc->rmaps[mc->n_rmaps] = o;
-- 
2.54.0

