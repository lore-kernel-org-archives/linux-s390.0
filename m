Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDF41D4F1;
	Mon, 27 Jul 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164591; cv=none; b=gODCNn7hLiNK3OyCVxuI3/p3ZHWXxWjem9qyEmFMaXhCx1/2EgVKnqo3MW1ohvhyeIQtJogsjdCQ/+/RQyGnPYX2YD+ycp48ApRDU6JWTPUaLLcb2/HYwiUqdrKmFmwh/ZGUtUtJzwD9K3R5Br7tDpy8s1jhWIGzJj14chuDv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164591; c=relaxed/simple;
	bh=23tXtclqVawxFg1lN+Ycsw8/6hkvjG/0rgAkcxzu1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj1Sx1HZ57J5HmJyaej1GbvtS7R0Pqs/FZ+N8JVYeXSAy8xX5DHLBEz1zjw8gTNCEY3oBte2gRAwCo+V+vTDBVRalnY4TNlCSPjxPF4kkPZaIJ4QBINkQjZzdQrv9uznxtZm4xLZ1bbBmT4f/+f5Z9MseArAxm7hSKehnjxrfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqIpLnMH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqIpLnMH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnUHu2298724;
	Mon, 27 Jul 2026 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tG6sUt3R+uHbIu3qy
	aRfPI6HM3HqvsIlv77xbdwtspY=; b=HqIpLnMH8CuqrAxk5VPTyviJmZLTgNBew
	KJevrtcHF+7roM8OX5m8JkWPLjO9O2hY9QWtgaV/ePP5MwNW+vgyvvp2uVyZB9mu
	eQ4M8Q4qlAfeD6sQs5JMzi99V2aXc65biFM8o2ggz0LCuDm7GKXT28+lrSBP/7Ls
	/gu0oJszQyrZDwkKtNbag5uHQ817pl+5FUd9zH3V7gMeWcfJ25BKDfDq5+zysHwR
	FK0b/gYo362pBP2ogbfRzItRPpm69vOgGdgKGgDN6AJ+Gj8uIyMaOyF8FLmaDgYx
	+aYNLvcrB8UxRjCKK/rW66KZzIZP8f0rkMnecU4jeCo+d20MwJjWg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuWFJ006578;
	Mon, 27 Jul 2026 15:03:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh5rtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF2xEt47972668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:02:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C12200F6;
	Mon, 27 Jul 2026 15:02:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C851200F4;
	Mon, 27 Jul 2026 15:02:58 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:02:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 04/10] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Mon, 27 Jul 2026 17:02:48 +0200
Message-ID: <20260727150254.236021-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX5r33fYvp9pH1
 7xQ+THuYbV08fgUlCE87MKnSdyP50xtrWXbk1+LK8L46XrLZHyhYa4l8eZKdb7k8Dk17TpPRQu4
 Ufni+rxlHZZTB2eb8sJuKgI/3lZoP4M=
X-Proofpoint-GUID: pffOg-S3zhRV9P5JNvt1_cgBLfe6sYH2
X-Proofpoint-ORIG-GUID: pffOg-S3zhRV9P5JNvt1_cgBLfe6sYH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX5I8bKAOndxlh
 yK3935TfFAXslpsfcfHUPQQm32gxuSo0Ct8+zoOKWQ4l7NVyNV7XFTpCP62oC1xY3EUHP5WboBx
 kV0NJ4gIx1THUztEC03wCWJsD+hIZFlMuSc/cTL/lbPeI7qJ4tH4vOA3n1fxgWUH6pRei4a0kvE
 LCv3spTevUTb1rsZfhRfwwwOsklRFC2d4ZiOpKSlx2YJDYuavGtA1RMgW7q3GbhfGDltWkzGykh
 XwdOMvkTJsgoGma6LRN5Lr2s7P2QwM27VlYpIO6OEk8oWZcRhMbHjOyA/6cWwMwzvwJOSMFrMjF
 7fhXegl3ScUugbvmaLKbhOXtpV3hEsl5fFgApeSx0nU7Sioqqsg7zYW5nCUgy8KAjrQJdT81QYD
 a40XZ2nYYYic6+ExTFNhPN5iJF+ZyG7jOWfS3/JMck62PWLc+ViwIwdI44Ucv0E6Pt2/YmBf82Y
 PrrLs0KWZpzxBKPvA6g==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67732a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VchRnoiWiGOQ40ZGZhEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270140

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
 arch/s390/kvm/kvm-s390.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 171b61959908..3f2d6e8902d7 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -850,6 +850,7 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	struct slot_priv *p = walk->priv;
 	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
+	union pgste pgste;
 
 	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
 
@@ -857,7 +858,11 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
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
index 879fdc42cb71..19294d8dff96 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5802,11 +5802,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
 
@@ -5819,7 +5827,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		goto out;
 	}
 
+	guard(mutex)(&kvm->slots_arch_lock);
+
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

