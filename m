Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB63AAF65;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338994; cv=none; b=R+qT4hJDFC3309Yj+8R9Elk7fiou3emyAG9OFczYPKQLZ9576LgOzwF9p1eJwYZzFwSnNV4SHW1cjqv0Wd8SxaCoUvgEikWcjJ9HuCkdgPF6zWsBy5YTLmAM2rApWtt/pH/p1/kUswFaFLcUgKMOm1yTrhTaqb7R1wSK5FXVdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338994; c=relaxed/simple;
	bh=uk+7Bf8nelYwZKq8so9KDG+OngL8L2JQuT7xKObhh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv7McQO8hIuegzb5onIjhle+dC4cVtFkPgugiVSu2gnxOYHe2jL3DKn9bgGl3afK/VRKFOZIjdlMievX4XRFYO1SujIelTQd8PpYKT60YGEBsw/lZdrm254fc9KNcEGeXOvfGOwTtIlYiEBNKxSr+u4S46BpNbG0b9eILa8H2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0vwNlaE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0vwNlaE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFI6MO403335;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BpRZhORLGYKP9Crm2
	pKE9MHN8ysGCZMeb2Spf1oTGU8=; b=r0vwNlaEkvqolefFSzi7w9m1Bn8kKOBPY
	GzS8a7RWfTtA/sXEyBdTGt4kK6gjAqUBizr0w91CPV81aTIukQF02t9wsW8InOJT
	uQi2ygtUcb8reFdVtr8jpHNvemFNNOOWY1tF6kO48huuUw5uYpPMdqHp/MwC7N4L
	+XHZbweXnwXRIY1LuBeK0YG2B05F64R4Y6dOUJo7kVE/vi4CrgzZrulHWgGNzGdf
	BeSgQF9brb4MckkVssuhQ1wZ749nolEUgiv+BOud4CdE9ZRuZMo0Vqgfz+gwGfM+
	hGxH3V/fhApuj6sbbsdCw+AqHRs/ikJfiZomPtqiyDLPEnG6wsQHg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd2n53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQJF6028783;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf6ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTcMk51839404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1A0D20040;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A30E2004B;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Date: Wed, 29 Jul 2026 17:29:26 +0200
Message-ID: <20260729152938.782383-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qzKJ2gw1ryxfQy_gaRQpn-UIxLpMHIZl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX9GJOor7Xw50l
 WyxUx1G2iZyWSi4DZIb5kgMnZkyZnGfALD/ZQjhLFhmhmixHDE9R+y0DGqLhN+TIDa8qjc+8uH+
 A+BiPQ6nO4zqgmjaymuSo2M3Puc0Nn0=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6a1c69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX1drHjxHSKz9f
 Qt/YU7tQ96NIJqTiRIFrovopUNzLixdpJdwxtxT43PR3SHNVLcUOGnVlOG7r6PPdRQLLJmDEViM
 hSTJBhG/WqOlKrqDqZ40/Z08EKoYJxF8FNr2GIg9dRfkz/x4BrbUCNSIu4tOcQtrH/lUVtiPId1
 ZAayJ/A/L5RDT5zFyPP1YWZ1NEQx1g6j1Y0l2r8U5UqdAt7kQDrFHpURpCWU0dcunhPIf+lHHQl
 QY+02hHO/kxlmxN8zIu9g5+48++OxEmFEl3SK2HTLxe/hsam8E/MuiQHMUtCZqmfoBjRHWG/aLs
 oGS8TM2jQ0dHqDK4Tsz1xInxIF3S6ojHo50NQj52E4+ckjVU0fBYouvlrwGhb747W5+RRaI3D1/
 Z3RHN3LGufeOa8J5x6/eVQ3fmiwCuRJplH1jm7OfewR/3dgm6VU/fv5E47FZTyEaODjzq+Ku7U8
 BFYrC0mxF9qaSin86qQ==
X-Proofpoint-GUID: qzKJ2gw1ryxfQy_gaRQpn-UIxLpMHIZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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

