Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7F436367;
	Fri, 31 Jul 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502925; cv=none; b=DQ8DOUYKpUvvGAY94WR9vFl1HSG7V5goxlVEng3azRkniGpo2PUK9wQlzBcKFJ+9V3l37X0AeoPHI3ZYvoCMiM0dgovB15C0Qin0HDqQ6qwbEFVHPBLGKQFypYwtMAnyrDTUh5gzqt0vVBqsBAQXXwJvlIEVb51arZRLka/ogK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502925; c=relaxed/simple;
	bh=b/FnuFBeNRL1fg42qbv/eY/bvC3oo74Z1wmOgclH1iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcDxls+xdhLcndeVXowlUc0suwOwDfgSA1x5GG4aLybdzM+RTFQGf+Z74xoZSL0/TTP84owpEiHR/7/5RdNr3i1EDss64MpIO4TdR24YiH4tkcgl0ozwBkN/xuqFHAjRtQkQ608DR2mJoAQtuTdgfe2F5jMp3XAIdioOYq58v6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EUoXaBzK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUoXaBzK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlg421672712;
	Fri, 31 Jul 2026 13:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JoqRAFDJVF71pHpNT
	n63l2JSsVeaBFtqNLLsWQK4oOo=; b=EUoXaBzKBv8jugGIS0YGzjizPjSfrxsko
	ZzAVyAyB7wifsaLGQfWfCcFddjtzMGSUGflSWI4gWwrBn3WOSzPDdou56jcUx47R
	gzlc0MB7Y3lZPOoMjbbxYuInbhGR6MXz5hrjG7mnuC2QcclSnrHPQUxe1SRyKEfS
	KU/dyVcm01CoQqY89nR7i2wfHo5QmCbt28xjbfpkAjtlcaWNSISwdZpKbNxmiY+H
	oBgtBPqIPi5Zs8nbKPlclFsv62xNH2jZ+rUZM4FwbPtr6FIw54z/ixgxY21UL4ds
	ioaXo6xs9WEqLbEZaegvWwStx8dG/i5CFICMfN4jrkbmkZd3pYWOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p421d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:02:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuOlJ021058;
	Fri, 31 Jul 2026 13:02:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqr3vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:02:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1rWi30605648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04B420043;
	Fri, 31 Jul 2026 13:01:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9C8320040;
	Fri, 31 Jul 2026 13:01:52 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 14/14] KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
Date: Fri, 31 Jul 2026 15:01:38 +0200
Message-ID: <20260731130138.173983-15-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX3vHTqdDiCkri
 ifXg3Dkyr/Y0O7f6G55kOzoeXSBXO2KuJPBewuUrPJLjy5eNCtR57eXWjHvJfixLjQ08rewdu0f
 5UGOYYraApYx4BlyDVIRCoHaCXjpE/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXwmdoRzAl4n+s
 wESxoNTVS+pqiBgNTIUfmuSLTjoxmZeNylf+Fy+UiwxXh/3tKsYQS82TgU4BWnB5TVLELRKt6ai
 ZpTze1xFBvdafkdRowVKPoyaEkgWs6WEf1NzE+vk4pG6EInrh7dArGQXDG/x0sbj6orpF/zxnK/
 BpJwp+YgGaiebEuF45onLei5khMyHPCquSH5A8wpiAvIXVbtNPOhh3B106WnC5wQ8INsS/Pclb5
 HuvStyn6u1AxhFZkalQaoKWI2mPyew12t2yenUBVwKju1mNNTMxwCFPZ2u7d4S46FEVtynT1ytS
 LIH/pNLctRp2/2kWSlSH2Xdz51JxF06tJX875V0F8bhZxz1OxByF/dCezco8B6V6CNeBsjQXRlG
 dnadg0mit/GPocduRA+i9vYwJj1vYv37zkSavO1UnNFE4gxL+81CGOLvN10zpmyK6M5myylgGQ4
 YIe0l2URxDVnoVolRew==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c9cc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=UZJgiOjggnZcZ0CJR5AA:9
X-Proofpoint-GUID: lGkeF6Uwoupbth2r2MTLuJL4rZ2ps_Vl
X-Proofpoint-ORIG-GUID: lGkeF6Uwoupbth2r2MTLuJL4rZ2ps_Vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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
 arch/s390/kvm/kvm-s390.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..fd8badb0d571 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5830,7 +5830,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
+	int rc = -ENOMEM;
 
 	guard(mutex)(&kvm->slots_arch_lock);
 
@@ -5838,11 +5838,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5865,9 +5863,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
 	if (rc)
 		pr_warn("failed to commit memory region\n");
-- 
2.55.0

