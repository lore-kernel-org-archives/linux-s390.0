Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635843932F9;
	Tue, 11 Aug 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462669; cv=none; b=uH3DCCVIG/v6B8YmWjZJAdT9T6EHUVI6uEX9RSogDv4Ms45DvgCx8UxAZOxudAQxvEb4tScLzAoE5unCG9ZWfOJP1edF0FQHzxnjRIBFdrqcWhOHTAL8CxwL4A4E9mIQYLhUO8AIeM9F7xpQNYb9+Cld5XAHGaPUn0LnOPNwqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462669; c=relaxed/simple;
	bh=q5+LFdSBIoYBkXj9s59Ft05cRwTgOGt6FAiHKaKrt3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8alSdTbmskOyK13bodBEJ9oCCLWDTBXYS4LhkKu/WcDYMN+FvyRht2rnfjdPvdHtFNN6GhsuyaCvfxk49lAo5ggbnK1kZbqQONVmksh/+OjtOGrIRiC5ZHE/0wpDAPIv3KIeGtH7soAC5n8bcXS5HOB2gURsQKuqXUb1hRaBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h5Msc2Uu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h5Msc2Uu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWc7u492485;
	Tue, 11 Aug 2026 15:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ImoiHS5VPnYpx7Khc
	kUV+t6DxLoGWXwrbCH8ZfbazRY=; b=h5Msc2Uuw6Qfv6CXyK/621iImk/IVjd0p
	poTuxjl3JIn2A8xy0XsFglnjWSt41xPvTVHJttq7Z0JWpyk/YgC4nxwsdB3W408Z
	GQsTHpIN6vXLUd7InyRn8F1TXl4jxoafHPnqdhmOYsgV5JhBK7z1Jcso7tCl2rit
	3ZKE9RTvLmjt5842GXwAe26do6L+XXulAZn68oxdWGiIs2UAOVrF9SZ9HJzkZJ/j
	0ppdCBywWHGn4fO05+xhasF3GlKfVUDwrI+qgkr09Dh4oK98mrHaeIityAiPkI9v
	u6OJRSXzEaunuxs+Qp3kTF1LYi965WaxJwPy6AO9GKPLShPOrHpxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9dpj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQIw0026435;
	Tue, 11 Aug 2026 15:37:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9dee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFbhVW43909390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:37:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E563E58063;
	Tue, 11 Aug 2026 15:37:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F201B5804B;
	Tue, 11 Aug 2026 15:37:41 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:37:41 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/4] KVM: s390: keyop: use mmu_lock to read gmap->asce
Date: Tue, 11 Aug 2026 17:37:35 +0200
Message-ID: <20260811153738.206885-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811153738.206885-1-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jWD8-_OMgxtOLodWl_cMwi5juwx0pdxV
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b41ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gDroBBNs1Zwq6DZD0gIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+Du/TFdmG17v
 R9vsmL7wq6wFzJ16nwtANKDLYgliPsQZQgwlcornt7M5qwGltg0sgz2lJnvjY2vNB/11hiJJk7P
 kV1bu+t/hdTygf9aqh6ZAWe7LM/J+zqTEsENrqjL3/nrXlypj+r1wXIfE0sWE7xw0ZCE93llNTS
 LCKZDu9x3EGVrz5huWxxFgUdQXNDBhPl8b6FeYJKg53GbzBeaVjroSb1ZILzzjS/Ne9cZmYOBAP
 nS4DGIoLWiEEX4Mw7sq9FSMyK/4ZZ0tslO0SetYQfcPeoHwQAUnrWpPU+EQS5WxapeY3mbANsLd
 kjF8KFyltcjsLXNb5rvy9APkNTghNR/N0/wQ6seg7EMk6a4YEJcpSJ3JDag7GcI1i37OgGdeGde
 OSe8Wik+EuWYdPH762oQ/OmhAPzpjZERK3R8TtsCNSFvHotoTh31UwsmdMkgg0WoQhyZMtOx0ej
 jqmUA1OiTYE6q2ZPWlQ==
X-Proofpoint-ORIG-GUID: jWD8-_OMgxtOLodWl_cMwi5juwx0pdxV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXzZI1Hx5f8UGe
 b/xo1QIeOZ6PHP8mT+HsgxvA0bwBRAa4btblbGJ17nLRl56JGiqxcWkJDUjMcNDGyVJ+OvDZWsD
 1XUVQcgTXjWqGUfa/5hIFNGCPViDu0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

Every other dat_* consumer in this file (kvm_s390_get_skeys,
set_skeys, get_cmma_bits, set_cmma_bits, MEM_CLR_CMMA,
kvm_s390_fixup_prefix, kvm_test_age_gfn, kvm_age_gfn) reads
kvm->arch.gmap->asce *inside* the mmu_lock read-side. keyop is the only
outlier.

gmap->asce is mutated under write_lock(mmu_lock) by gmap_set_limit()
and keyop might use a stale asce value for walking as KVM_S390_KEYOP
and KVM_S390_VM_MEM_LIMIT_SIZE can run concurrently. This can result
in memory corruption.

Fixes: 0ee4ddc1647b ("KVM: s390: Storage key manipulation IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4faff6625da3..ea9bfb32d0f2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -561,11 +561,12 @@ static void __kvm_s390_exit(void)
 static int kvm_s390_keyop(struct kvm_s390_mmu_cache *mc, struct kvm *kvm, int op,
 			  unsigned long addr, union skey skey)
 {
-	union asce asce = kvm->arch.gmap->asce;
 	gfn_t gfn = gpa_to_gfn(addr);
+	union asce asce;
 	int r;
 
 	guard(read_lock)(&kvm->mmu_lock);
+	asce = kvm->arch.gmap->asce;
 
 	switch (op) {
 	case KVM_S390_KEYOP_SSKE:
-- 
2.53.0

