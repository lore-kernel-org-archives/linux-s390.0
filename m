Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CE455173;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338992; cv=none; b=sYLs95FWzz1jKrXugfoqKJ9OaKVPzofSSj0dcPZ1bOP4gW5xrNiI3Z1C4eLRtxgVy+e3V9cxWabRkXWA8/aRdy4SqchFNI3+S7Zu0rlYia6aCBgPUawR2VCvMViHKW/cPOd8PpdHZvSlpH5g28hKzHElAMQUE2euoNUijreFfuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338992; c=relaxed/simple;
	bh=I8mSvwYg5F4E+kX+IBCn4KPXa/Ti2ddo4k1UpqxgVVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfLjaN19nyj4IoD6JL5Q5wQkzbVPmczIvNvndSWN43j+nG/m6sNsEPnuQx2V6CzaVotq43tGY85LjUxkoPu/MGMjtOqNBcf+LEDltz7IYVULjSvATuQNYMSvg+RuROQKXO/G6w9gRbhpVsRavK4IYu0GlF/yxR8RTT5ahnWTUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QLQ4lLQX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QLQ4lLQX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHaBc388610;
	Wed, 29 Jul 2026 15:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PNE9DDVkjX2ICXQlk
	AGtRU85i7JdpU7lYvjfH5f5uW0=; b=QLQ4lLQXliTmh39QUnH1xkWZKAKI1EZHF
	fQ1txxtI/uvWWo2WWwbr+ef9v0+/XYxhxd4Mj9CBHFj56u3bqNypLQArmhHsWCNr
	WmQoi5nYAxUmKw0cLnDklwXrQ47iO+BqEVw8HrzDoYOJZ18lEh5ygpdBmPekKaa1
	UoTpH3DC8L712YAlUb7ngy82Th7zc1cPf6uVWJMlkUbUo0QhEGVXNLBBzw5kWLWX
	DbBHQwriFDGrTXA8A8UpePghizFPprpl0wDmebdZzr4t3yrO7LOpRuuGUbqDL+N0
	oQrquljaojFYfhJj0MK1/gDPz3Mzes9SRv7JeZTmUfatTgr4tPEeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xuefj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQI1O028775;
	Wed, 29 Jul 2026 15:29:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf6d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTfke31129932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E204120043;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3082004B;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 13/13] KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
Date: Wed, 29 Jul 2026 17:29:38 +0200
Message-ID: <20260729152938.782383-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ll2t0jPL46u0Wydjm_D5XG-oIo7lmFUr
X-Proofpoint-ORIG-GUID: Ll2t0jPL46u0Wydjm_D5XG-oIo7lmFUr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX+JgBFiAaYAuK
 hGuEr9R2dg+Dfi4fTj2e+RFV906Bp4EQM+b5m8aR1LNogAypwaVa14jdODRlmb2HOUr4JQQToJM
 q2US4ZIO1lVQiz2siSg+GOQlJre2oKE=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a1c6c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UZJgiOjggnZcZ0CJR5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXw0NEquilzZae
 5XHX4ez9zwxerc/U2WGger11IXGhfAeow+BBVqI9Bg89hibhKt1EGJuXA7n7mnWahiKSF17xkzy
 6LARvD2RNVjMFmBLyrxbjLHc3Vgoq4skJgmwuzzwg4LbQ8yezpbfyuv9E/xn6NeOK80REYNQLQY
 Fchhl2SyVB7XgOMVbE2Y05NQaJY6c+l/6Q+CUI1oWME6kFioVYcTX9rKaFdrYRavxBBxqDln8Oo
 kC/Ll8FdmwaSjMU3Quhe+YfydeMAqGXCdTGAmLPagOJrjWdCuQ5vtwtDx7d/wvWiRpwd0zLacX2
 FSiiO62I/KYmFDf7BQ+8nvizfqkqqr4cDOG2ewAor6wc6Wyd+lZ8lMrNSHfGDpeERVH8DaLWOyd
 pvY8c0BEq+GbJ3piVQPy9O6BDVBnFTYwbdP7ufHezC9fKoq/XnzrwCikNBOIIF2QwtvoHedXpVa
 4zAzd5R3kcDL+5t9C+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
index cdda7a00a0ff..b29e5460f5ef 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5824,7 +5824,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
 	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
+	int rc = -ENOMEM;
 
 	guard(mutex)(&kvm->slots_arch_lock);
 
@@ -5832,11 +5832,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5859,11 +5857,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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

