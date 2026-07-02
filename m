Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF437A833;
	Thu,  2 Jul 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005865; cv=none; b=VKNGjRx3YC65uaZFEUuTxA5ANhJxe1AVYzc4Ebja/CcCzVFn3wDyu4/SBS4CvsyENGE3ImGhL+g17zxoGg7xdDQDSXW4BJF/caiqrFb1c8X/K0FPDC7BKP0pLHqN+iz3ip2w0NHePrVwUGoOQ+TsRLhymNqCAyciG53hCAWkssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005865; c=relaxed/simple;
	bh=10XThZQfqABmbmYgUfutSC/JgJPZE2ZDwr/VeZOL6J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnwuvmfOBgRtfHGMEJ7FZ+iu9nWfkfbw97EEX6a6AkYQRbWr1Iq4e+4F9hWQU9xslfOXRh2dy5vT5to5yYIKT7NktjfOsrusg/nTERnKc72dN5DnAGhd8VPM/zyyQIMab4LRy9qGiWdwPLG9mh61nYEPdShcz2QPN99ckphO5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GIlAhjuE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GIlAhjuE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIL4R4015810;
	Thu, 2 Jul 2026 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uEgQjDJ097bnh8kDZ
	mNVR5HiaJouwCuM4+z9+RRmtzc=; b=GIlAhjuEQg5k2VoRdzNAaHxKpq9vknjFs
	WveiKNJowEbPBjrHAU+eRa+UHVp6EN3M7eyMb1SqKNhGSzcwp8eDAI8ZNY5qfcI+
	MUHYwyIo42FoXCi76HGYxk92VuOlG8O/ra8npUXfnX8xMurR2GD1AOhB6YplxPYe
	Dn13TKureBf2aFOgW+nk5UIZkZNXvOet2Ftu2YfZmL1OQ/icXE/Xu/iGy11z+QUT
	17VSNpAD4ivlsLfivWblMsB05lvT2c2yQuOgfg6dnDL43XvwF8GHvECN2ZFckvc1
	vjTIs9NsBPTpJDrswT8XmkNVswtnX9EkQF22aSBr5CWtJqWFQohHQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qaa9rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJdoh016325;
	Thu, 2 Jul 2026 15:24:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmgkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOEYb16646428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 771182004B;
	Thu,  2 Jul 2026 15:24:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9245520040;
	Thu,  2 Jul 2026 15:24:13 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 6/8] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Thu,  2 Jul 2026 17:24:04 +0200
Message-ID: <20260702152406.204782-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX3qdTc/UqTFy8
 /m3yoJWiUDBQ4JJ+LbfogtAuCzT+GXqllru3bT3VAUQ6NLxqMAQBx0bbWv9bjr8rNziGBIrsx8K
 Oxiyz+Gf/JM3CxwIEQEYI8I2M27S2woFAQhb3BVtktNFE83XwXaRKCya3tw543foM9BJxXUTrK4
 LwQFy47G6hIRUGoXIQqUsdQcHzvXbX3UYjEKkO4CJDDS0/SRMGeM5Vx3K/V55ego4Ly4fTA2/I5
 8X0ig7rvHFpTx5FXJKKmYu1d1Jb3y6yXOOSjNcs6+GYXlHz4KHussj8DPdJly+XLPWDzF/MlSRq
 BppPeDYA3PbFkNNOs+ZMYOFj2A90+9/XLF7Jrx6E6+YqLjbmVSx8ALkDbuXMuWb1QYjB1BZdowQ
 HDfoGS00N151+PuAMD/iZHITG3rXhUVt+UF9loKLuItAkGsu7JJE6AE07LGXO5o0nHbko0ZF6iM
 01GXc6l/dPyE6zn9Q6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX4/gxmgQCq5IL
 kqF1EpxTLiu5XoLu3N6k+lvDTRWRwLzsFs9tTwTDhJmTyxfb3S0HD+NahiO1eN+4QV5rikUE9c2
 2/DmXQqI78KFsmCHTbLUR0NjxxMg26Y=
X-Proofpoint-GUID: zwKYmTX9alr0JSuX7CgbFYtrLdpIwwWn
X-Proofpoint-ORIG-GUID: zwKYmTX9alr0JSuX7CgbFYtrLdpIwwWn
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4682a5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bIjUJhdxvZtpq5l5erMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020160

When a memslot is removed, all ptes that mapped the slot are cleared or
even deallocated. If this happens while the system is in migration
mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
not reflect reality.

Fix by appropriately decrementing the cmma-dirty counter when removing
a memslot.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 512c81eee068..2ac3a9ac4698 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5792,11 +5792,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
+static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	if (pgste_of(ptep)->cmma_d)
+		atomic64_dec(walk->priv);
+	return 0;
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 	struct kvm_s390_mmu_cache *mc = NULL;
 	int rc = 0;
 
@@ -5810,6 +5818,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	}
 
 	scoped_guard(write_lock, &kvm->mmu_lock) {
+		if (kvm->arch.migration_mode && kvm->arch.use_cmma) {
+			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
+					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
+					    &kvm->arch.cmma_dirty_pages);
+		}
+
 		switch (change) {
 		case KVM_MR_DELETE:
 			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
-- 
2.55.0

