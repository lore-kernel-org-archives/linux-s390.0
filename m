Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671B39FCAE;
	Tue, 28 Jul 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258446; cv=none; b=LBF00a7nvplPBG6fWSuphnk01zZ6PlYd/xI0lm/3tJvZs7DH+rpeqaaBjn0KcStkaLeSe21DffeK4waVKlfU0mOG5HbIO51ZuAsc9xttOLdsTT18xQyEku1+wMkE1T4uOAg/ipwpqbElKivfuUc8fcaKyTipPWSxgOfx7o71bS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258446; c=relaxed/simple;
	bh=3WUP6dOe9oR05yxJxHlySq5i1ABsCTA5gepApG2weOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDWZhVEf9mpgwdqcOTU6oIPWKJhc02ho2ww5ygBFDYWqIvW1F1mrpo7ZydtnUKs7kWIoqnjPxQpv1pKaTwjHvJtHkvud4X8MjrnIFrGCF1vogiFALcGL8hv8YIqn/dvsRDL37uLY03emlWr3RU6sN4uHC/SNIds8mg4ib8JOtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b9X8fr6h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b9X8fr6h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEljAe1459403;
	Tue, 28 Jul 2026 17:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T3VUHQvhHm6DSWeKv
	pTbA/gh6LZ8ovPOixF8lE2oU00=; b=b9X8fr6hXyDnEFdmqh/28GNk/fLTNh57+
	7jxJ85ynJJU5VjvpOSpGvVOFYePy36H2QUSQAyT43lQhCb4hsEuao0StbIxnw/rG
	+NSlG1m8JfCSa8zLM1haBYZ3lLt5cAOIVu6Myq+wriMO29XPyD6PHQmmygoHlEiq
	5vSYOs2TIA/91Bx9jA1j5V2yvxqXi/X4QxzM6/pcacBCasREO52wetbjm1fG8Gg2
	wc45ZNg0PR6LhvI/fMfWYRoQmjSiSlvFgoW7VF9Ez/vHke0xetZaFl3Bw2V4Urcj
	yUPEQO28euVe4Eo2jRJa97UuebzN1XjPBRw71/v3OmBH/PnAhu09Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7egxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuGjC029496;
	Tue, 28 Jul 2026 17:07:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7A8944106020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FEC12004D;
	Tue, 28 Jul 2026 17:07:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B684D20049;
	Tue, 28 Jul 2026 17:07:09 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Date: Tue, 28 Jul 2026 19:06:56 +0200
Message-ID: <20260728170708.294400-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: abX848-CQofRUXy91bWb6t4OVxpZ2NzT
X-Proofpoint-ORIG-GUID: abX848-CQofRUXy91bWb6t4OVxpZ2NzT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXzbn8vdAHf5SK
 9aY9TmgpnXKxLwdTuhw6G8s3oHT8/tMGETjO2iOe6jwa5o8fmuXb9TtynJRKAgkII2V0UxyepqZ
 8nuFWb20qhmsqqGO++kIAzIBlSqb4wA89K/ZpVzV4gKwdx/XlXPzcClRU4P7N1U1iY+fifPdxka
 CbSGGvvOPH9gC4RQrR2LeGwstGDtHxHwO8s74dXsYB4KiFzbJXBI5M0mpuPARJTu75y1T7e/wRO
 z65BppAVf7o8rA0Rnh9awPY3wVgr4p+PFU2k2oIYSTVpC9SIOXbXB0slgHPTiZBuOiuQhIFIDZD
 SCKZatrVKhEjaAZKbybmQCCrSNbPrjoxLmx3z5PEaxYIF0eWFT1GVOL654IA/uj4bLcSTwgf2aA
 ezXE7D6SEuYllJo+SoXbDyB21Ifm4feX1f6hM8oH61Y+la5uUzOj2xsfmkKL4Lj6zCgqTnofIAE
 G/cJSWcj85gg79KylMA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68e1c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX4hf5+sVqu13Q
 QLaE8vOFnlNxMxTZQxDH2Fr1mLsreyckIldy8Af4jaIVFdVkHTtSVL40dj7d72Vk3T6ZTsAumSD
 tREnLSCPOl3DafC0TZJDqKrKW8q95xk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
has been created. The new file descriptor has not been returned yet,
but a malicious userspace program could try to guess it.

If a malicious userspace program manages to start the newly created vCPU
before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
dereference vcpu->arch.gmap and trigger a NULL pointer dereference.

Fix this by adding a new field to struct kvm_vcpu_arch to keep track of
the initialization status of the vCPU. Refuse to run a vCPU that is not
fully initialized.

Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eaa34c5bd3c1..edf75b6ad20c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -440,6 +440,7 @@ struct kvm_vcpu_arch {
 	bool skey_enabled;
 	/* Indicator if the access registers have been loaded from guest */
 	bool acrs_loaded;
+	bool initialized;
 	struct kvm_s390_pv_vcpu pv;
 	union diag318_info diag318_info;
 	struct kvm_s390_mmu_cache *mc;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 150b5dd2170e..f86b4b0b356f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3613,6 +3613,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
 	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
+
+	/* Pairs with smp_load_acquire() in kvm_arch_vcpu_ioctl_run() and kvm_arch_vcpu_ioctl() */
+	smp_store_release(&vcpu->arch.initialized, true);
 }
 
 static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)
@@ -5039,6 +5042,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
 		return -EINVAL;
 
+	/* Pairs with smp_store_release() in kvm_arch_vcpu_postcreate() */
+	if (!smp_load_acquire(&vcpu->arch.initialized))
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 
 	if (guestdbg_exit_pending(vcpu)) {
@@ -5523,6 +5530,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	long r;
 	u16 rc, rrc;
 
+	/* Pairs with smp_store_release() in kvm_arch_vcpu_postcreate() */
+	if (!smp_load_acquire(&vcpu->arch.initialized))
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 
 	switch (ioctl) {
-- 
2.55.0

