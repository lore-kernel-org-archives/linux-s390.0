Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D894534AC;
	Thu, 30 Jul 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428850; cv=none; b=XB61qRBL/wxkxyXUfWsc6tEyrhroiwLOqYTc65ttgLRkBPlEuXfcKANC0OpGpgyL4EBa942L0D3Vh96NOpeDjfTd9zXZOdt/W4i77Uo+Md1c78h/V2gx3g98R3J2iaZPBvJx88/TM7CsCZ4BEFhKLxP0Xd2G/gvnlMsosp7kCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428850; c=relaxed/simple;
	bh=uk+7Bf8nelYwZKq8so9KDG+OngL8L2JQuT7xKObhh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slLZKWHrXLQYuVUK5mgND2SGUnOV8XSGXm1uDGhny/qQswd86d5TinVb0JI181LemfwYx4fc5IsrXVYH0SpmtwS4N7IKSxikHqvmRFJ8jpALSQgVoG3kuXe0IW2Cx++CweL5NyaVZXB7tzJ4hSoOc4/MY0yWaiMM7zykKKUQ0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7ML1Wjc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7ML1Wjc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFm2E71561673;
	Thu, 30 Jul 2026 16:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BpRZhORLGYKP9Crm2
	pKE9MHN8ysGCZMeb2Spf1oTGU8=; b=L7ML1WjcPZpIWdROb+Ls+9rDkrig+I7pt
	QYrETNUSFl7nF1QL7bSN/Dj/XABb0yRi9j52Of39l6vUvtOJZqfGospLF/bD/5sF
	+1SB+dqUpqZ0v6WqYQxp94U0OXH3zLAZLi4glh0QBdWrNoPvjigU490EKaYk6MGb
	lYc1ByUo4jagqPME78DF7rJJOuCsXRD6fME38tvCiqLuD9mahffJpG2IZ1NiK5Cm
	YvgcaGeZXBRIKPY3E8wk2FevOnsA/vfLzJvi7EoM5hWNXU8gOE2MupgKvFS4Si9H
	w2Dh/DrXWvClMfsd3giZ3e3D96KbhF+uBY03bAk5Gq0eT0BoOObsA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycrq4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQI8f014636;
	Thu, 30 Jul 2026 16:27:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwc98e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRFwb32244174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1738920040;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CFA2004B;
	Thu, 30 Jul 2026 16:27:14 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 01/14] KVM: s390: Fix unlikely NULL gmap dereference
Date: Thu, 30 Jul 2026 18:27:01 +0200
Message-ID: <20260730162714.133327-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: C6QHddfyTbynbEUmrdvUk_Tz7Rn8PvMS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXzOHPSmK83+5A
 c7oouK2FWQ6OtzFcTH6sFW6ZCQL3iRtw9mVkRfs2vSfXnIi+gOfqhylfoXwyYIlThhOuZbFssZb
 XyqT1zVliMev6svDwI+ouVIY8+oZs/DJPIZoSeq7CC8bazzR3cmKFpAzLM9dREizY6yV+bT0AW6
 5In75fc9F6Q4Rv6Oegcks3/8wLF1cbOHMOC7zcTx9qQ1bXJkVgL6Vg1WFUBA6gWnvnzS10vcPr3
 wvxtOJaLP9Vf/21AJVb/e/LCbSaSje1TEz/F06q9RSoZGK7Pxi1QuYd/u0kCfsVL4XzjqzgjwnW
 U/pNWNeUodZPjFl0mVitY8x+AdwK6ZRIa30/Yx15HobgWHmS+RRKGcNhcpepS48D+FjJql0xp4f
 InMEcq5bv+3KsnHFleuM6azuxe1RPeyXMDhNgHcKY0pqB13YZovcTyFolXBPZ1dVLR8FCaF/ZqO
 +sxiWjfiKtXyKGDPskg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX8GUNv+7dmhXS
 iEvELUy0apyS+QvRlTjdWsSBRi1HD045z1HPoYg+AveNA1Vhk7itGH6LLkL6axSStyYytE2Tfvb
 Bfz2btZkvxBr/fYLM0gaD9m6tCnj5hU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b7b6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-GUID: C6QHddfyTbynbEUmrdvUk_Tz7Rn8PvMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

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

