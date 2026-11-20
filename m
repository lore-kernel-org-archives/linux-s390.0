Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161237;
	b=36+1eEJaxJGOJtOhov7/xISe5EqjMijZ3LdJlvD/LSqt5jVAc1M3k6xGVuWOi2rAgHaV
	 VH6oQ7qmmZBye7y/GdAypj6+EVrc6orfm4WNqj1NiPVWRJRH+etrLK6Rkjivm7i6ewxa+
	 bcvFm6FGe135b2QUV96h6HJsHjLveiO2AYbMVJbf6szvOAkTGBXqw1hZEIev1vvGnaAwm
	 ArMyuPPOYklaKMqutLckllt4M4dbTI7hfsPGSrFb73Pe8M5M9rg8OzfqwyyUk8TBBPFkL
	 KE9KV9cn9/XP/lfKbsy3bg1x8QIc8zV+8malTnlwXfiKGzCvTBqBGXAmMamJnzIGoeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IKijM3kfgC2JN1OBsGG0eABezVd9RVeucColmgjGn7c=;
	b=suo4EEPFQbFEOwJl+z/YC7u15qmGPYai7TRTnVpwIjk3jx3YQiIMGz5L2oyb9RhGZEGv
	 TyUvRAP+JuihDB4mPIIEWjLFtLdguLnnLejcMh8+uvcJy8ie6GcYjGlcFsojhzys6v3XP
	 BxbAnm14yQDgkqTDdTSzCYVdGdofY0O3ErRvim1QuQnx5n6xVqkq/jWRBjc5SSzJE+lId
	 +XmaguoWOAT+OUdEm/FgfBHH+2vE5IllruCwbhm/VzwSj7IjThdlcI8LMgkTBJPcHwEoJ
	 WRm5K0+Dt8StpLLH7rYd4wNRjHA+jVmfG5T3GbTCWwVCXEnUxG9YlY8aTGna0/drehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qfwS+oYr;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAE606A326;
	Fri, 20 Nov 2026 07:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BAE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qfwS+oYr
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uVSm1965659;
	Fri, 20 Nov 2026 07:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IKijM3kfgC2JN1OBs
	GG0eABezVd9RVeucColmgjGn7c=; b=qfwS+oYrX7/1gKXBjbs8SHTIOJtw82sqj
	vJCQUDtyE4WePZnK6orXnffHoMSgNMddHmTrEohehrqJLyEf1j36eiKwi6bfjfVI
	XA+GJ61joMlJSdxOxvyFyr5qVbFiGYlp/94Uiq2Dt9laUL+cQ4BwM+mkMyBv9rfs
	s8rSq9T5C15XEOMyQptqP13qkPaIU/cbI/Tdkg0w+3BEZ9RX+CopOjKt2B9lHwfb
	viXGdEemUg61/2ib9jkyrtUOt3HlLpAbts1RDvMtPukpzXvenCReh5pUXyxbzDSq
	jmguafxlFbhLk0CWHKoSNOU5EdYY8LXFezCpaNd55NJyTt4vUCVdQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x6mcn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o2Ti821279;
	Fri, 20 Nov 2026 07:53:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c53mj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7roBq10682964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:53:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6987158061;
	Fri, 20 Nov 2026 07:53:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4584F5803F;
	Fri, 20 Nov 2026 07:53:48 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:53:48 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v1 1/2] KVM: s390: reserve mmu cache before stopping migration mode
Date: Fri, 20 Nov 2026 08:53:44 +0100
Message-ID: <20261120075345.116521-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120075345.116521-1-ggala@linux.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Bsk8DM2fVIyWkLSmkXDxmC1U06vSgIzV
X-Proofpoint-GUID: Bsk8DM2fVIyWkLSmkXDxmC1U06vSgIzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX/slrOP4Ag3h4
 DXKFcH++4EvYEt+RQSxv1LhsULi1uXDDW0uUwbxOtNcWywhAW3kaA7b6QV24Zq2bfxdn84ODe2h
 9zlDFX8xII0gYQ1ghUZO0iVP8sP6sXSwCBXs61HFurCTP72I5Q0l08DSfoKLMMeYsVTco/HbrLS
 L9EZxyZN84RyvqjXmDdGajoWxxYHPNXet3nsZwXxYrYPEpeKjQbY2knGjd99/vDl7e9AGEX4e2J
 19egkS+iLGBYKgDmIZ/LZNAsTsmyz395MDzZpy28Mjo+pHrd0qVF8jsV5zGRe9bXE3y7KrE/5bO
 SFsWccISTrO6rRhYbBDEumnQA0KKTrreuaZmala63x9tAHB9KJ5OkwMTj0UapFxCO+FbHEPSQIZ
 SxtO650N6Elbc/ETW/9UCtzDAXb6ZmtVRm/vLmF7NI6yqVXBvtoloOKNfxoztd2CgJ9suCpZHIo
 Ah9lrNSnpc9TELWr/jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX5qpFDlKr2kML
 LPXTbZDBToLsZ5HkxsOBO1d4zglpMN2KY8XQDSqqXrlkOWBMr6itmykESq1J9bVc/wAj2Jm/ixs
 Tlz7801LC8E2/IN7SB9KPgVuM8k8S9k=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afffc90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GocmDu4tvC5ISBat5jUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

Creating or moving a memslot without KVM_MEM_LOG_DIRTY_PAGES stops
migration mode in s390_kvm_mmu_prepare_memory_region(). If the mmu
cache reservation fails afterwards, the ioctl returns -ENOMEM with
the memslots unchanged, but migration mode stays stopped: the CMMA
state cleared by kvm_s390_vm_stop_migration() cannot be restored,
so an in-flight migration aborts over an unrelated allocation
failure.

Reserve the mmu cache before tearing down migration mode so the
error path leaves both memslots and migration state untouched.

Fixes: 19192a404327 ("KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/kvm_mmu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index 4e2da60b9859..120980cf6ac6 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -78,6 +78,14 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
 			return -EINVAL;
+
+		/*
+		 * Must be allocated before migration mode is stopped below:
+		 * kvm_s390_vm_stop_migration() is not rolled back on failure.
+		 */
+		mc = kvm_s390_new_mmu_cache();
+		if (!mc)
+			return -ENOMEM;
 	}
 
 	if (kvm_s390_is_migration_mode(kvm)) {
@@ -97,12 +105,7 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 
 	if (change == KVM_MR_FLAGS_ONLY)
 		return 0;
-	if (change != KVM_MR_DELETE) {
-		/* Enough capacity to add a new memslot */
-		mc = kvm_s390_new_mmu_cache();
-		if (!mc)
-			return -ENOMEM;
-	}
+
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		kvm_s390_update_cmma_dirty(kvm, old);
 		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
-- 
2.56.0

