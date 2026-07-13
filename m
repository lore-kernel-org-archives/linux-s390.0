Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1943B3DE;
	Mon, 13 Jul 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955353; cv=none; b=XUong79mBdkQr5eOPN4XIYdcucgWbjpaclQpxf/tkBPaqgxDFLDbSdoRvqJIfh/Sp49qvS7WVVNYZl+Qf176YdNXDJvyK9fjZ5yfSjaeSvssHQI4UeezFB/jSwpe8f5s2HPW2xtmkM1fJniT7Y09XmCD2Yq9h9brgg802JGpkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955353; c=relaxed/simple;
	bh=lRPq5W78SRyF5XuaLS+1/OK0+nz8Bh/M1o+sL/t/QVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmigfqGiRR7emgKasFvbzsEIkqpY9BxHqi4UKJn3cQYRWEyMZpTXYe24zO5s2bBEwQpJfnYoiTINj6UtakuwdT5MBGmy8pTn8wMeb4Ho72PK+ZW1vtSaKbQqD/WKzW5hPA/lOu9AdqeIqGEBtCtwo1GNbiCvQDyBO8TKC/HylyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCteyF4b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCteyF4b"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD6Vr554963;
	Mon, 13 Jul 2026 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ksRnIewlaavpGEMby
	cdIbR1YjxZSamSBIjRbXkpnABU=; b=aCteyF4brBalfuQzP9q6lpyL+15AcVy03
	FXUzfZvpLVhOVivhLjhTXg9UiMjw9MmdlJ30d2LnZJj7GJ6WCpHpGzEgZktzSim5
	EwMmcijdjLbVoyWJo65qRmUCwUFLKWT784iOV3wjcXjCqmQRg08GkII2uUXsgLAL
	88VhMPPsjcKpNFT9kxVLgfXT3UFAzIqK37zj1xLCTlo1bvhLrzhXQccYE/354lKh
	VpOel2lDXP4dTHeEYOVOLeRubAMM4X+YMjxCJctJaTVhjpVRBukyt88hN7i67ney
	hgUr2tnC0JEruhqEN4QVmkX16447dLYu1Mp+Ql9rNtXo1El/Ji8Lw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv331uyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4e0P024781;
	Mon, 13 Jul 2026 15:09:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwxpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF927U42008924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787BC20040;
	Mon, 13 Jul 2026 15:09:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9052004B;
	Mon, 13 Jul 2026 15:09:01 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:09:01 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/7] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Mon, 13 Jul 2026 17:08:54 +0200
Message-ID: <20260713150857.269954-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX4zom+YPoBfJF
 1jgIO0OphbhuWMimCQT9KRLDYvPPA//dnHgUHXcLRraXT6YAZMV2jgkK0O1Qs23afTG7JekSgbF
 9S3amYMDCjX8oRCgCOKVJareZiSRNxk=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54ff95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VchRnoiWiGOQ40ZGZhEA:9
X-Proofpoint-GUID: ZtNDdClKLj6cs9099sb2zCmjEz1w-wVV
X-Proofpoint-ORIG-GUID: ZtNDdClKLj6cs9099sb2zCmjEz1w-wVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX6rQLkJSs8nKk
 YxxLPCzS+g0wbMLjkvFtLPVtZ/9+jOyBURjJ3Dl4AGlocp5PhzqmjtLbKf83NtcH5Yd8HJ0XXVo
 GH475K4RZ6N9kRbjfkBTblKy5AZJggy8twufBwOaPp0elbvTHHqgriL9lQTSN9Y0AAL+Xa1vWcC
 A3OywdHzBZhncDHnDbKrhRF05wLb4Fon8Khnatw0iIaXaBalbpsICc4W8korJBqaY927J/PwePd
 yGyIvsTAUZB/q98OMRepbdEqpZ95D5nVHkQZ887U+DlBXTFYhQGX7rycblAG2JamtYPDljmNv1L
 xPkMZODdIUM8GmbXYhPxuVXoyECLu1OXr/ZwZDFaA/gJObMr4U05yfwQWBjpMsEiUZ22OPO3AH3
 5MODUiysL7HDuZY8JM9BGZvufiKx0upEBAv7unfXf9a2wa+Rh9jx1m3iD8BjPSbJ/TRwrWPZFDf
 82EypmMa6kGWjWpNB8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

When a memslot is removed, all ptes that mapped the slot are cleared or
even deallocated. If this happens while the system is in migration
mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
not reflect reality.

Fix by appropriately decrementing the cmma-dirty counter when removing
a memslot.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  7 ++++++-
 arch/s390/kvm/kvm-s390.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 5f1960ec982d..cc0b8b1330c2 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -844,6 +844,7 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	struct slot_priv *p = walk->priv;
 	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
+	union pgste pgste;
 
 	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
 
@@ -851,7 +852,11 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	if (pte.val == new_pte.val)
 		return 0;
 
-	dat_ptep_xchg(ptep, new_pte, gfn, walk->asce, false);
+	pgste = pgste_get_lock(ptep);
+	pgste = __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->asce, false);
+	pgste.cmma_d = 0;
+	pgste_set_unlock(ptep, pgste);
+
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9e3b8b5c6aa6..5c2408fc5a8c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5796,11 +5796,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
 
@@ -5814,6 +5822,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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

