Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791879;
	b=Nv7/n0ZM8xb6up2MIn1U30BQSuxKmoIxNRm+5NPEGpQzNrF/6xRZfQ8MyuYimzf6X+ly
	 Qk0yPk0D4bANqlE9aJHYtpJfZw421e8GQgIe/kUQ/rK43XPLOYx9AxSmXtx/mDqbhj9vo
	 ZVRrAsOk+9SN0bgX4R1ZbaYax06jZhh7ewC901NBBGKjdSgKaPWXISkHui3iyM84eLSqo
	 8dpcHSZ0M8n/yY6kpc9r/uL43XImsyQuFK1HIJpZ/Gq2HnNHJlZqULYUlz5II4CgYpca5
	 ue5lICalwddjncN7NzUDAbaL74cLjheIU/8Vne+riYH7pSJ0AT3+AutR2P0Ihe/H2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=f68mEENTBGpke3qhjoJauNQH8RyAIgk4v6K6j4zTTNA=;
	b=05zuvetTNvKgacRZbBRoxZDbi3itdEonv/HmCKA/k4AWt6Q3ZVNXMeDavR7N32XVGqgr
	 fjtv0xp7X6htPIxeoYf3ALUk2sud0v6Wm/0Z3xkR4D3U5A6J5onuj8iD/RKiobUXFJJVz
	 LnVjTHTs1qD/zeqsoWxkhRb+LwbJQXIHmDTB6zepDz+pGC8uTJKu1plNdZXQ9HZdIR1xI
	 IG68P+HVfS4L8+DeBcKGWIWY/ZZ1vkiG2ZdSvmugSX1rkCWYD6uNXy0IoxT4xjSGAYGi9
	 h7wKyEqaegvDm568YwZ2kHr1B6su6rXM5q6I1/59TS/zQRnBiUsNgIlDtOKoYJRTJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rp763uUa;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00888606A332;
	Fri, 27 Nov 2026 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00888606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rp763uUa
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4i4h2011456;
	Fri, 27 Nov 2026 15:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f68mEENTBGpke3qhj
	oJauNQH8RyAIgk4v6K6j4zTTNA=; b=Rp763uUa2SPdfjFZF/5eE4WdLzlhu5u7F
	wEehs+vDIGp3njyIU8Spf5WCtYuMEid5CR1WeOoNmx/8nIqHmKdaKh/reUI9gtQ3
	5sEUUzMZBpx2H0Eih0mBbrW6zvwL0JfqjZHXaafZz6XwZ2HJ03Zrx8RkTGrPtDW+
	p1P6EQ0VB5Z4/Ih6HbSQOifwWY0E71A4xESwRnZiaAt+UxxH5NoYTGzi6mhp4QWH
	1+0df/mM0+MHsvs/KL8n2zTgvi6KV/dreRdjxRSiKSKDj0lxlRkl3IrUfgjjjYsl
	0H6EAj3cs6DC6qUiNa2JVAIPyHhAiCkDptsIcegB8g6f+i20K66qg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4wct5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Kfi861638;
	Fri, 27 Nov 2026 15:04:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4h39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4HOI49676700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63CC32005A;
	Fri, 27 Nov 2026 15:04:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF4320040;
	Fri, 27 Nov 2026 15:04:16 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 04/12] KVM: s390: Allocate page tables when CMMA is used
Date: Fri, 27 Nov 2026 16:04:03 +0100
Message-ID: <20261127150411.221072-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX0E6xWICRh4QK
 Fud4eDUa8+QEvY057RWKJ0hWjPi3IxnFR3qpm41qWiy5fbzYKkQTbB+HkOQz9LmBYNdIo6PAXbk
 CLX0OutCrP1+1f+ZpywoLR9Fq6nwSUU=
X-Proofpoint-GUID: RJxJHry1LN-WI64nogtjXd4xOdDi-v4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX4FuCF60g7hkp
 hyZcQBNrlWk+kFOyzgcO2BQgMqahPXSgSHlWBaypjsx2t8ptWLwu8r0s9l38+daJixOS78KmdJy
 HS/Me9/3pZcewN+Kg1pZWbFFkfyRd5POgdWZLUFDYIhkNWgt7QdRgmlzwHdqnYkoSPDdIglIMSh
 tR/CbCSYA2By/im07MKBESlBqkt1bEsSE7p1CqsEN/rrO3L3al9P92UpxVWVP14q2dtKntb+dpD
 DE2fFIb0PvfqTrsjmnk9+T5WgHOuA1JNriE3/BG0PwBsGklxyFGAZFHu/C6qUjDL89tQeXVtatw
 XqKPsZPOcXZ6C4J8MzfT5xVLG7wVIcHzx4X0re68DFbCFsgxrJhUYMJjo/Xft50vD32I5ticrHB
 hXlLc3nEX9ncif0c13womJuesUuhDsUPabyhxoIBfPN4qhRUqUkT6rX8KEtOHiKIw77Bg2Axvs8
 VtywE/NV4kL+xRKENAQ==
X-Proofpoint-ORIG-GUID: RJxJHry1LN-WI64nogtjXd4xOdDi-v4U
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099bf7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mGTAQ1HydBjmFMawsAEA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060

When ESSA is executed in the guest for the first time, allocate all
page tables and split all existing large page mappings, regardless of
the hpage parameter. This also applies if the first ESSA instruction
was performed in migration mode. Also fence UCONTROL VMs from using
the KVM_S390_SET_CMMA_BITS ioctl, returning -EINVAL.

With the page tables present (even if all the entries within are not
present), ESSA will not cause page faults.

Without this fix, ESSA will cause a fault on the first page of each
segment (1M block). If userspace is backing the guest with huge pages
(hugetlbfs or THP), the page fault will be resolved by faulting in the
whole huge page. The result is that at startup the whole guest memory
is faulted in, since the guest will mark all of its memory at boot.

With this fix, no extra guest memory is allocated. This will also
prevent the first page in each segment from being faulted in, regardless
of hugepages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/priv.c | 11 +++++++----
 arch/s390/kvm/s390/s390.c |  9 +++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index 856939acf012..f5d4a82e1078 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1241,14 +1241,15 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
-		 * the SIE block and in the mm_context, and we are not doing
-		 * a migration. Enable CMMA in the mm_context.
-		 * Since we need to take a write lock to write to the context
+		 * the SIE block and in the gmap, and we are not doing a
+		 * migration. Enable CMMA in the gmap.
+		 * Since we need to take a mutex to write to the gmap
 		 * to avoid races with storage keys handling, we check if the
 		 * value really needs to be written to; if the value is
 		 * already correct, we do nothing and avoid the lock.
 		 */
-		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
+		if (!uses_cmm(vcpu->arch.gmap))
+			gmap_enable_cmm(vcpu->arch.mc, vcpu->arch.gmap);
 		/*
 		 * If we are here, we are supposed to have CMMA enabled in
 		 * the SIE block. Enabling CMMA works on a per-CPU basis,
@@ -1262,6 +1263,8 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
+		if (!uses_cmm(vcpu->arch.gmap))
+			gmap_enable_cmm(vcpu->arch.mc, vcpu->arch.gmap);
 		scoped_guard(mutex, &vcpu->kvm->slots_arch_lock)
 			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
 				i = __do_essa(vcpu, orc);
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index cec1278f2ceb..f96d3cff2971 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -2349,6 +2349,9 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 	if (r)
 		return -EFAULT;
 
+	scoped_guard(srcu, &kvm->srcu)
+		gmap_enable_cmm_already_locked(mc, kvm->arch.gmap);
+
 	do {
 		r = kvm_s390_mmu_cache_topup(mc);
 		if (r)
@@ -2359,8 +2362,6 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		}
 	} while (r == -ENOMEM);
 
-	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
-
 	return r <= 0 ? r : -EFAULT;
 }
 
@@ -2991,6 +2992,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
+		if (kvm_is_ucontrol(kvm)) {
+			r = -EINVAL;
+			break;
+		}
 		mutex_lock(&kvm->slots_arch_lock);
 		r = kvm_s390_set_cmma_bits(kvm, &args);
 		mutex_unlock(&kvm->slots_arch_lock);
-- 
2.56.1

