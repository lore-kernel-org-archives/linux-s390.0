Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5F3A3E9A;
	Tue, 28 Jul 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258451; cv=none; b=JELRwEkTyq5jWkWMuB1QhcY31P0bjsdQC8DJ8DfL86b3+obfpaEUaRm/x47BtdYkUi4Le8JC4XWqbe/Do7MiOhOwPtqrsrNBFIa1KFVGCUSuCIPSogjurf1N51yOcnQbFfdSIR542W0fbdGHKw+O+wVDVuVC7GS/DNq59z39Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258451; c=relaxed/simple;
	bh=GhQDAQcW2+bP2UHFkZeM7f2JX02O1FYZ5x2Epgtlx34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F62oQMp4fTT+e17y6F4HC9YRKj7SvVPlNU+Dy+KUWza9YonTZrT1ljAwmCA7yXtF9KhjFQ1Ke6MWckMt1hpoqJ7MHuQjRJwwL+iAFRuuVXR7aroAJd5+YsQmnXO3MxnwYazvdN+DOv3StfbwGopSCdxYVFmDwv5t3xkM0CdYTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VHIu+Lkn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VHIu+Lkn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElhU81500797;
	Tue, 28 Jul 2026 17:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+m830w3tW09d7KaQB
	xcZopv5lCJfsPRWZVQi0oMrbNs=; b=VHIu+Lkne5trSPu0B1lylbHmWc0j5HuKs
	rZ1+4wsjHwOFLi4eRQefHN/eyDO/kETbPwJa1ZoKizA+L6pIhJ5WhDdm+Z3k3B2F
	aXXhlxJ8kuQ1XtUKrt3zamNuBjPGOVok+E/bd5QrYABlOnQ2lwt28pGXY3Twiw/5
	sIW1F7Q9Ed1INWbFTzJgUVIjEs2wY05r6eLJZlGqDLt7sozAKtnlpOC29wDr8LHj
	xbvEbGKErQqKFnEdJcEZKeRfPcjZljCbqE86+mhzyGeeP8haTevxg4mvcU4RqgqV
	NWjGCGg/L0JgS/kCl6WJhRj/xdSiwsIwP7pnB7s389pSkdeuBQNIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcwx55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuE7C031340;
	Tue, 28 Jul 2026 17:07:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqb4hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7JrT49807848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC19D20049;
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A34F20040;
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 11/13] KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
Date: Tue, 28 Jul 2026 19:07:06 +0200
Message-ID: <20260728170708.294400-12-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mgjS5gXiKwoqs5Sofhnk04aPkr_SaEjt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXyBHBI5QNAgtk
 MjWrOd+AVqXNzIsRiUml6l38Txk4+CftDjb0q9syAkGyS6Du2hkmB+pDNrkXFxfAQraUnO4LIwE
 G17cdwjY9pJLw9Okx8pzvrzHOf8A+DE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68e1ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UZJgiOjggnZcZ0CJR5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXz5OF0tQoL+p4
 BnFAUYTyApcc/Sjtz8GrQ0Ggu957geyhU5NXC3uE1eckAu+fPF+J9gM7W6KQvseV/cftLy6Nc4o
 yWgfDS4KhuC7HjpGiT1teVIIBf2OCrtHiy0AJOsxwEXiIKP3KzQ2m0L/VppuFw4MMuwmJewXtnR
 WpT/OgYdRWfrZ6Hj90NpltTPer1jALHemHjSx+YRs8gCLm7EVa5DidfQaJeO/b5R/I3qA3uMI+W
 u9Ayr7t57YmzOQkQyuui8UP1jNbScTUsqM3/GQNt+aVLw744Ov2LXPorEPlSfSbWRs+bifnS+B3
 tgWPsWyjFVdIJqXNkCZmAkSmGaeg1QkQ5aPLNVYq44AmErmthEYYkNJOUovGOznXy2ot80r2+NX
 1kB+EG9U1osSfu8jwJj+v/pOUq0Hdl1Sp4Z6GrkngUusDq3q4zxYAEbLNrQ9wsBRnFKCmnv8MYE
 kzcO4t7AbjEUMu0nzvg==
X-Proofpoint-GUID: mgjS5gXiKwoqs5Sofhnk04aPkr_SaEjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

When low on memory, kvm_arch_commit_memory_region() might not perform
the required action completely, and instead just print a warning and
return. This allows the VM to continue running with an inconsistent
state.

Fix by refilling the struct kvm_s390_mmu_cache and trying again. A true
failure only happens if the refill fails, or if the cache cannot be
allocated at all; in such case print a warning and kill the VM. Such a
failure cannot currently happen.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/kvm-s390.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 59f784f8c01b..b151d25a4a4c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5817,7 +5817,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
+	int rc = -ENOMEM;
 
 	guard(mutex)(&kvm->slots_arch_lock);
 
@@ -5825,11 +5825,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		return;
 
 	mc = kvm_s390_new_mmu_cache();
-	if (!mc) {
-		rc = -ENOMEM;
+	if (!mc)
 		goto out;
-	}
-
+retry:
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
 			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
@@ -5852,11 +5850,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		case KVM_MR_FLAGS_ONLY:
 			break;
 		default:
+			rc = 0;
 			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
 		}
 	}
+	if (rc == -ENOMEM) {
+		rc = kvm_s390_mmu_cache_topup(mc);
+		if (!rc)
+			goto retry;
+	}
 out:
-	if (rc)
+	if (KVM_BUG_ON(rc, kvm))
 		pr_warn("failed to commit memory region\n");
 	return;
 }
-- 
2.55.0

