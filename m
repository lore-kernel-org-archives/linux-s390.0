Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F10347BBD;
	Wed, 10 Jun 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110378; cv=none; b=SBUUZ7eYmLwNAiYOvDktQCq518DOImIdHt0zZN7aUSV3nmZkErHsnaHsuXo/BylKkyQLxhAs86Hq3tmflpMuZNFMsGXbODaHS6fABo5Nha7GfpMK4ABzz0ZQf7Bdr4ZRMR7cwgwSSkUl4YcZbxZXPtQqbamY2mX0P7VLCD2s54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110378; c=relaxed/simple;
	bh=OWadmFqyZRODz0Fym0mqfwhIB0zcxMsdWfYJdDm0stc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u12QnEcXK4xmTAPNTSBXzb4bCsd2btHdMxMKE4DPXyzOzbQyJvPTexeRz5sU1Us73dB7LTaUB53Z9FbmpgeZyqNLjYOkq0g0EG8keGTnUmkmjtKgPfkNtdtrqW05rlfw3QqtLFigtHBaRf0lprDEMB5C2Uf1S8+LB/lHMDxepbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dzZ/+a7A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dzZ/+a7A"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AFaWZd1873690;
	Wed, 10 Jun 2026 16:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VoIsrMdrT6RvSo4ei
	FqAUh+nwO4mrI1+0UrcyElu4kk=; b=dzZ/+a7ACWs+0D7AS0el/LmLZMP2yXowf
	1/lgME0v9lAfvwuKw1oZ8NLhaeRafQ6MuaJhw8bO+hCA5gsqxzOBssu4cg+lFSiL
	UuePOO9Oe6EkjeFWfywa5QnnAWTFhZUVZFw1tJ7mMDNLVJx9x03a1bFSDmOPujTb
	FIIO5KnXuMfHF93oI6t8XjsSdXtGsc8h0saT6gd4pKVsr0sJlWF5JNtxeydKzSUd
	tsZOSVm+bg8KPgiO2qESg7KKXFRQ40lEApXDG5mP8gjOZaDyhozBnatk5XtshwXO
	B0s5tKmjIqdon9h+vWRo/iZyKuzCUzCyzlWsStAHtbJDsQKaGuftw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qt4gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnZdV005253;
	Wed, 10 Jun 2026 16:52:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g7at9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqmfJ27263310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 464062004E;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157BE20040;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 3/5] KVM: s390: vsie: Fix allocation of struct vsie_rmap
Date: Wed, 10 Jun 2026 18:52:45 +0200
Message-ID: <20260610165247.238366-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165247.238366-1-imbrenda@linux.ibm.com>
References: <20260610165247.238366-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a299666 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=hYSCaGdr6WFvCWo5WKQA:9
X-Proofpoint-GUID: YOUWNDiSHK87me0D5zURj9VQnlV8-fxu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX3GqXiJxYv+3/
 +UZSknQcG759wGPowBjP2g5oCQ3x441ilVBultfgtGpomqSKsqGW8zc/jr8rYUByIWsLn+6S8Y6
 MYym2clUwrKKCy8g8EBUjqfX/x2E7US2rk96nb8wXgWIddoxzJUjHVRbuhZqDoE5sgiGtbRFlHU
 9NIKFs6lkz0gPccJOVJbe+XVvyKjshFgHdBPjk2v56OQ5/VaZ6IEh3C36XI8Pv+kbfr86IDcAwU
 uwTCFhUhZkgYAGKVP7QfSQgmeMtIRc+d92xRnWe4/9icMbB9YMtlHVgY3R9fg7Jgb5YwM4DvAI1
 /QgU5YI7bfcWsfLRlwLl3tQND12r7hTVPt8jMN0sQ3pUGi8/3EWPO/Xx3PxUrlDktGKgPuAA6Xq
 f86XTprFKdbQ0tZYwEKaEsJuLD/vWvc3tTshlxzgmPCIrTLHS2fApbHaGSr5KV/SHulWla12N9O
 Qv/ygp1sFhSgD9a/BMw==
X-Proofpoint-ORIG-GUID: YOUWNDiSHK87me0D5zURj9VQnlV8-fxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156

The allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
was wrong due to a copy-paste error.

Fix it by using the correct size.

Fixes: 12f2f61a9e1a ("KVM: s390: KVM page table management functions: allocation")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..b3931e3592b5 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc)
 		mc->pts[mc->n_pts] = o;
 	}
 	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
-		o = kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
+		o = kzalloc(sizeof(struct vsie_rmap), GFP_KERNEL_ACCOUNT);
 		if (!o)
 			return -ENOMEM;
 		mc->rmaps[mc->n_rmaps] = o;
-- 
2.54.0

