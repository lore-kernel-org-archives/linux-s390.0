Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934C3CBE75;
	Thu, 21 May 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368748; cv=none; b=AQJkGrVC2fGvU00rQ8So/VWUWYfv5H71h7nB3foA7sil5VlgbMw9KabftQpDJdbyJykVOwuIK1933EIJmpWLQD96XHY8nvhIgJyI6fnHSrt2bhiPtpCa7rnxgzHtfSFlTO40nu2BExv1l3kfhZEMr/dlVNz4xqCLHOaBNzAouXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368748; c=relaxed/simple;
	bh=NGd74zXTr7yVCdgLJpcJp5urQnD7AFzDHnGuvIlxen8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNmcjFgVmNGX/yVzIdaZhhlRarAneMlikElJAHqhKI79bXU+8rZ8ileQg7eofccqNmmND6zHQySBC9ulrchRyQkYfxtA2QGxvksex/4Ga5P3X5BDf/HzETVY7hezRAuIUewpy1UlVcoNdQKhcYZd0ZMenm/cEV3WL3ehBXcid+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5DTPWc0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5DTPWc0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1b1ck3214577;
	Thu, 21 May 2026 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=feImQcvzuEXnqHVBD
	h2+oQtVuWm//l/SVpfSkCqifjk=; b=C5DTPWc0dJrWttShsuCFhMZNcK+NP5UMf
	HMtbInCTluMoce99Hw5j7SdQ21JSAbi3AI0shXVk67/dUwteH2ul06FOqG1b7T+M
	gZHxk6SzyqEQJbaNrCdh9oKtYEYNQfyS27k9X8TXbVd6Oc2tD8u9x9G93T5QaPQj
	/8gqNRIB5H9BtIFg3yqKRNkeHv4ftYfBKZKQaA76YdtzBAjX9JkIO2kplE8d0B0Z
	CI/bmSnN+RrwRnzxHn5gqedFbH5phFRSRGzaJTUY/jt+0pUq/9iyCdXPvqZfEeEB
	YQeAs/76P4p0CRu+AqjOtjaot51KphNmWsbhXLESShvfYZGXbWVLQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawdtgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCs6gn008445;
	Thu, 21 May 2026 13:05:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkc6c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5Yg931261090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1ABF20040;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 741FE20049;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 2/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Thu, 21 May 2026 15:05:30 +0200
Message-ID: <20260521130533.156491-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130533.156491-1-imbrenda@linux.ibm.com>
References: <20260521130533.156491-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX8xplmGRRirD1
 AzWnbZM6My3fIy2rAASivu8TaU2QLIWJInezz3IggwrhvdbOab1XjXjHX7pkGpTyxqLnuKIZLLH
 Dy+vZmg2DuIKo49PSq5KQVkVDT7TwGT+TpG/k3nMlY0wvcuURhtwtcdJMF/XnW8Bt8bU9ku4SRq
 DlpHt+kmdYRbBfse9SYlV8lfsfFK8oGGSXQtoBWcew2n8uAHfpkrwkAt0Cg+GsMpSM6pjGjq6YM
 JTqT3oEqDcrUz5tQMKWH9roF4wZcp6MuGHhK4voPdSuT14WTk2/K9324aulYxsAlLP7nwJ2Iy12
 BQ3CBNuhXrxFNrLG0fBDyHL419lg9oPBUxtIy9W1RpA450ZiCFijA78A8Kd89Eh+UFi6myscg9R
 vWHwdUmxBnOFkp4kFcBeVy3PKHNI8/P7FK266vK7q/IyjZnNuQQeuiMSzZ0Ykhx6kcIe94RuUbY
 4Hz65l4WalULufdt6vA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f0325 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xyOPYXbJwbhnVPa3_EUA:9
X-Proofpoint-ORIG-GUID: oEqrLTKZM9VhQfsEs8maf72ksjhW1V9U
X-Proofpoint-GUID: N-1SR1pmaxgXzbxWIlUE-DBHyHjPDDEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Implement and enable the KVM_PRE_FAULT_MEMORY ioctl for s390.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/Kconfig    |  1 +
 arch/s390/kvm/kvm-s390.c | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 5b835bc6a194..8d3ee17a1bcb 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -30,6 +30,7 @@ config KVM
 	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
+	select KVM_GENERIC_PRE_FAULT_MEMORY
 	help
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..f6521f16532a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -630,6 +630,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_USER_OPEREXEC:
 	case KVM_CAP_S390_KEYOP:
 	case KVM_CAP_S390_VSIE_ESAMODE:
+	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -5736,6 +5737,50 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	return;
 }
 
+/**
+ * kvm_arch_vcpu_pre_fault_memory() -- pre-fault and link gmap dat tables
+ * @vcpu: the vcpu that shall appear to have generated the fault-in.
+ * @range: the range that needs to be faulted in.
+ *
+ * The first page of the given range is faulted in and the corresponding gmap
+ * page tables are created, as if the given vCPU had performed a read
+ * operation.
+ * If the range starts outside any memslots, an error is returned. An error is
+ * also returned for UCONTROL VMs, which should instead use the
+ * KVM_S390_VCPU_FAULT ioctl.
+ *
+ * Return:
+ * * %-ENOENT if the range lies outside of a memslot.
+ * * %-EINVAL in case of invalid state (for example if the VM is UCONTROL).
+ * * %-EIO if errors happen while faulting-in the page (will trigger a warning
+ *   in the caller).
+ * * other error codes < 0 in case of other errors.
+ * * otherwise a number > 0 of bytes that have been faulted in successfully.
+ */
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+{
+	struct guest_fault f = { .gfn = gpa_to_gfn(range->gpa), };
+	gpa_t end;
+	int rc;
+
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return -EINVAL;
+
+	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
+	if (rc == PGM_ADDRESSING)
+		return -ENOENT;
+	if (rc > 0)
+		return -EIO;
+	if (rc < 0)
+		return rc;
+
+	if (f.ptep)
+		return PAGE_SIZE;
+
+	end = ALIGN(range->gpa + PAGE_SIZE, f.crste_region3 ? _REGION3_SIZE : HPAGE_SIZE);
+	return min(range->size, end - range->gpa);
+}
+
 /**
  * kvm_test_age_gfn() - test young
  * @kvm: the kvm instance
-- 
2.54.0

