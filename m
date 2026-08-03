Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B6403E82;
	Mon,  3 Aug 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760853; cv=none; b=ErgwjPOr/AhC8cVNuzOpDW6fNdKjATrtobQnnrnHJYp0OK6p6IElo118sPTxIaXbuFHlS4lmHYQZm3g30Dv2jaCvy00t2mTLM9/LPYOCd5ylxTPY0JtJLjri+bDnlKOXXbZd0GQTpvJNpUsmO1oJRIKrx7M/hHZ8LWv23Hu2ukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760853; c=relaxed/simple;
	bh=uk+7Bf8nelYwZKq8so9KDG+OngL8L2JQuT7xKObhh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTrNE/nqOBkV60d+slauCTTtFH645KfnWBYzp6NyC/zaxwOGRTg2/sHAw0UBkIQaQbVB83DKpm3sRPr/FsNb3C3vqCrQM/+9BOBLUiMky11KVIst9noFSpqP5IH0NVBcyro0xAw33akJOGRmqkjleh6f2ft2Io0sCMSuqiODrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gc/5CMyp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gc/5CMyp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHm9M1943475;
	Mon, 3 Aug 2026 12:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BpRZhORLGYKP9Crm2
	pKE9MHN8ysGCZMeb2Spf1oTGU8=; b=gc/5CMypmsGqn4lz/dfePQkp4CTEyqtbs
	uWm1MNaeoiGhq2zspUojAph7d50r7LGl872vi5xQE+mTcPdhB6L8mbu6I1cgaX9J
	YNFZymdVntZSWINN06Y7kPkudrGSZI8DLAxDvoi4S8+zpWBJW5iQJpbCMMPcSfc6
	odj2xd8Et3FRyOR/bGYrclIkYwOODI4Ffbtq8CzXgLfSokzcBRfk8+73kJtQ5Fox
	Q9IcDtpUqPkIoHF+BpEDz8HfQ4Pczv3XDtXa/rP0DhfGFIV/BDn8JueZmaRvdX0W
	w4qEnLBckpI47oi6OfiNVhiJ/3+hlrP4Un25d7s93bP+MBEJgIRNw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0k6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQKsm009779;
	Mon, 3 Aug 2026 12:40:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh59sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Ceg8M52625850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F8492004B;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FD7620040;
	Mon,  3 Aug 2026 12:40:41 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Date: Mon,  3 Aug 2026 14:40:28 +0200
Message-ID: <20260803124040.126471-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXyh7tdLNftXyN
 XTJ6FGD1cWQhtX7sPCYnXRab/r5u5m3iClBRIpS5TAPqhc/YQb7lPF4Sc/a+dnI6tzFpbVhszJq
 2THKqVePMe3EL/aWa6St015u+Ve6Al4MeqWEu/U7bemCGl8ztZmw7vsozIZqrPJLGG/VUqlql73
 jKGQoLCKCnT5SidtMa9gySiZHGepkozw7xqtnjz0N4/psNHa24WwBy3ZGEk6OLIJk+pJOnCwxPR
 zJx97Zlz22hl9JZB8tVvAkwpftHEfky2ulE9z817VxcNG3m10r5nz2R2VC3QhTQXW1OmfE67FZO
 ks7vLQFHZd0aLa6qQdKJeTu7TiE63oHPHSLfcPfsSupK42pQaA3Pgl2bjKwycm2Slkd8V3UJeJP
 +E0Nuc6Yek37GR/dN7vgYfT9k9tJL2G1ltUvR8MdPFz914nmtPPHqzvXg6WVdkd4zKEUQJKin4R
 yuOoH9OOVCGzzvPvmog==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a708c50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-GUID: MgGi7bqxck2eQVVu2SibGd-p8HljkYPG
X-Proofpoint-ORIG-GUID: MgGi7bqxck2eQVVu2SibGd-p8HljkYPG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX8INfFEQJZTb9
 Si4gn0vSMHHZJZofo+TkIWDG0r46L6G98W0HsoykwnniWa6wIUa4BasiPdPTf4lBFcS7DdmTG8i
 IwzK0dYdY+mhEZiygh/7XdSBZGRlZUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

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

