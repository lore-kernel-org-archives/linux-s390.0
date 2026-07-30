Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6744AB98;
	Thu, 30 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428847; cv=none; b=OJl3qr455Rx3tpFuzOMP8OIFwb0Y1ZXjfC1I618c2+8i+tdjSyCDQbCdfZEd2grOEvyRB6aj6pKRj6nXFRb0egEAH6+w5MHIZgMLUavoAYV/9YUl5knfJiMlt+EUjFPPbphQpQ5aRZpj7DO/8ewCAxbO37Gyq0WUu5eOJoSv3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428847; c=relaxed/simple;
	bh=8Huf0HO4FGPCU5mw2P23lv4xZOXVqfPfe2Di/klY+kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwM8krdslLMIJRB0ZqzoXlO0Eq+UGKbdNTE+OuaLDi1VW+st9gWl9AFGIZJ66Kcgi+xTqUmJvj3sbs8ZUQHWdFG2oJTgqS1NEXJ0Ll6Z9FoR+wq7wm6yTJmb2IBOl+gp6ClSf2+RkniXNT/+Rtl4ek1SQhBXA1EKV7gS4HFuMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VCeNSZI6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VCeNSZI6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFluSl3424694;
	Thu, 30 Jul 2026 16:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8d9eEY4W5oB+n2L4N
	IDHOQvoCE3/hW6/QeBnVWtHjIw=; b=VCeNSZI6PXGkIw/X/nGfZDWbaTr0o4Mz2
	SvnEfpuCsL+9TC3tmgXS03er7JTlBl0+JsE6+DzP+XiRzZx1ggBMZNQwajHTU5Tw
	fO9wosnEoGSoAZZGymwC8z8YBdLOZT3PBA7aNPrlILCRj12u02phItW9U6xyIsaz
	0F2A9Q5WAekApxIVIYIw2JZ6Oix3dRzXcfVZBZs84Rfi/UcSslTsfPsrWUg9UZP0
	hNJAASzpnG1OmlKwDhTlnhhqZ6Iq5lMRyfhQLbGXDs8eb7R8VmnaMa2ejC6IA/qp
	awTS5wUFbtvQHpiFtpSEJt3eoeje8wgQQLv/3Bz+FY1oacfsL/Esg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7rs61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQNXQ014884;
	Thu, 30 Jul 2026 16:27:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqmacm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRH1T43450750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D99820043;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1967920040;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 13/14] KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
Date: Thu, 30 Jul 2026 18:27:13 +0200
Message-ID: <20260730162714.133327-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hUDrNWMSMdqt-8TQhDet8bE9ETev9MeO
X-Proofpoint-ORIG-GUID: hUDrNWMSMdqt-8TQhDet8bE9ETev9MeO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX/YNGo4MFloLw
 O/bUweFnNlddsCstBH802ROgHkOk+9D+hoD15Tra5a/BW81KecXtlFfAlOA8wjAafKZdDeHZpVO
 VKTmBJzUWdu1xRV5I/kUOkoo4j9cdAVZTXFrr61s9Hq8yxinaySVfXyNYK9wMeobgkIkKVlWWxL
 /7/QtbZj5A59vT0vsfG+3kjLs3hHGKdJhyQvP6FVpJgAvGAZsIyB663n7W5z3iu7F8EGTh4kSKq
 G2KNIqJHVY0jkKyPasZ9IEVU7PRMh65rhi6h7P4ysP3niX7Q7GoQjv7gBu7c7IYDcq/7UxN9WDq
 95yiB703Ohr7Y0obNNJx8i8a9ndg0thl6I2CZ032/l4NLpRhmtlElWFCztvs8gmLqoT5cyvkEU0
 I7fE+TaQXUdcPX2ui/epkKrTbnUL7HUtocv4TfpeYEmoe38og/N8ebqcKLn657/ksm3mJFt9xX/
 Fb4a1/vLMwekhyuz8+w==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b7b6c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UZJgiOjggnZcZ0CJR5AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXz72FZgL8qDW7
 f3znxj6qnbmNP1qr70ROzvJQ/a6g+oz+oS+tvq26WqQhgFCAzXqsrxTVf3olnCkD7yqhvfesnxt
 zeOZVcvz/QRuJ8Ic7lw6edvd4MN1D9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

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
index ba600c948887..035476ec7fbc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5827,7 +5827,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
+	int rc = -ENOMEM;
 
 	guard(mutex)(&kvm->slots_arch_lock);
 
@@ -5835,11 +5835,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5862,11 +5860,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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

