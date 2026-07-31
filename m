Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981612264A9;
	Fri, 31 Jul 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502911; cv=none; b=uq0rVAJnXp1j5e54QYJ/tvtIYVPL5LISi3Op5KbT2up6JI2Mxr220gDguRkwCtGYJ8Flsf0eKA0aREXnrIYR+ytOfxdnUrxbtfpxaNjXH8zi7vKBzg+zbv+rhBLegq9UTW8iCuJhCpzwJnqYAzzl7iDrG8S8Y23N49wQO19WlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502911; c=relaxed/simple;
	bh=uk+7Bf8nelYwZKq8so9KDG+OngL8L2JQuT7xKObhh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJXpyu6RibIK6vBywWqO8fPjZIZfjibx5Z2jxeAeQBsE0RqsdvBk9NbuZFadJHDUes05MdaUw3o2/YTE5U5hYWUIrOSrchNX/uNSQW2ZV8h7NKk10S6os5YPMM6/8jKKiAT0RGaq4U7ctdefx6VhW6+06jaS717iZfVU8kDbkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHDOjXne; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHDOjXne"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlppU4072834;
	Fri, 31 Jul 2026 13:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BpRZhORLGYKP9Crm2
	pKE9MHN8ysGCZMeb2Spf1oTGU8=; b=LHDOjXne/sVFFCq1mZUmkHDH+biTGxo4Y
	bcTEC4V6p3lfZZ4jOoYnbdlOj4J6rL1w4WOSZgPXVI/B9Hu2b3PJ7nin1VlEkjak
	6DXrkiHX1Ms0DYlNWyhS2waMaO2n0xAH3vv8ohO2x+oP9UaT71yCtcvNowlImtV7
	2tkNdIjgQ+GvmsA8/6+z66Ky3GLfqdJnaTLfLXxYNvTzLVfqvjp5tR5i6xqHDFMJ
	sZsUY3WTuReshuHs/PXE6nhgxHvq+a1y+oRBH5gwnqPOgcLNjEqgYvy9W4/CWJtz
	Gyvdz3chGwOb4ciVWRnreQWhz4HecwBSXNT9MPVdLDMPj5vvH6DHw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw1cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEap026825;
	Fri, 31 Jul 2026 13:01:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqs3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1eDb51446108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEDD20043;
	Fri, 31 Jul 2026 13:01:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1D242004B;
	Fri, 31 Jul 2026 13:01:39 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 01/14] KVM: s390: Fix unlikely NULL gmap dereference
Date: Fri, 31 Jul 2026 15:01:25 +0200
Message-ID: <20260731130138.173983-2-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 97t0CvyjBJrGgRX5u7kucguJagRvBpRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXx7CeoqkMC1I0
 o+fzdElw7hETbqjEoUiS80RfYysZExd11c+jofdTKzlLa8LsMmy33eLbkAnw7QQTmjV45b3MCpA
 BiuIbIv5g7G9iDy7huq9fDSDD0NhC+GwoX7qe8actoxOmVaxU4wAAuvdTKBh8ZuMUVRDR2uod7C
 vM/xA9r9s7dJ8h9NYpSTPPw4t+qox5TzVXJA9ni6rVCsfi07zxzIH7DU+gCafui6Pr25ptTSvrq
 ydN1QJjUWwavOb0FvKXqUi61uCBB9QzvATBekG4SH5cGWhmpWBILrqKcptuL8e+iAwod/lZXWDZ
 S1wVGOiPRJV97vBvEwAUoOA6/LDpzeyG5Gu2a2HIDSffmTwvzdELGIZVdieG/MQkfTBgWZ5bHEk
 2oUw6EuXvNQVWxtm+aCSeAYLik76C3M5aAj5n4ISY1eAlKQGf9JfZ1p1XTs7PEM48wdhP0J9bCY
 pvkc/BTiaT9x6VQzj0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX34xSA4PndlrP
 +rkz8A0Q3a1F8VaVwJzF/jLERMklEXK/gjpj3RXSwVVppmhhMbgPao2i2xqEWZXRpedY6Arl6ON
 mBGfbEG4rdAHj0UJgSvF18SdRr9EX6I=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9cbb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-GUID: 97t0CvyjBJrGgRX5u7kucguJagRvBpRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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

