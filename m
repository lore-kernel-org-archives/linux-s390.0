Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD273F8893;
	Wed, 27 May 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893052; cv=none; b=YMK6/E+7wQIPphtFrGRBzuf59RNFDAiAXYrhsk6Ufddh2sMDs8LF7hlWuJXgyOZPrjDRmEph7SqNa9Sc+wqZDJjBAvPUQ5PdruZuwV6OZJP1bG7oL1tJWFfJJ386Uy9oicoBnTbmqPmUe2e0mQWjh/sl//TmknOz3GhfNFcIJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893052; c=relaxed/simple;
	bh=NGd74zXTr7yVCdgLJpcJp5urQnD7AFzDHnGuvIlxen8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaSrAw6V/iHcPLVMWrTyIpURnE4TV29whHK22hBjdLIoO5Eshq+RNAQHrtu8AxEwhQ3r1UXAAIVsV60091ufQpqNxnrmxMn7M46x3nrD8JCZN/ozydJ/tGOWRHnBDTsu3zVmgwTmRLrAaG3KB/Rzaei414bfpvZ00mn95WUgji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sWftOgLM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sWftOgLM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCmekp735911;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=feImQcvzuEXnqHVBD
	h2+oQtVuWm//l/SVpfSkCqifjk=; b=sWftOgLMwEXRkB0p8J8+ZOP2uflm3MYCW
	NfHLw5VCN02TCT1VpQ3y5pBOdQmqfS7DV4fvsIyONa8MwGoeatwV6r3e1YeGhimb
	QYdk0t0QNj7OMcmF2On0EnAV8dLmYFvABPBJ/PJ6C1pJW344Tc0/BJ07X8XQTQwP
	ZUWHcHK4qc4ObY18xLA0AWED46lNqBQUUB2i+UItEuowhAqWSM7FbM5moMF8d37E
	1QYrKonT5lIacT/+us4jciovUYRdAaTmoNfuY6iTxpf3hx0doFRPmCGJ5fF9JxGu
	K0Bc/A0iV7rZbnvDuktVxqzzNncP1VSCyG0SIHkafej4b+AKkokDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc8k12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd6XU021402;
	Wed, 27 May 2026 14:44:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbkfgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REhx0L30998876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:43:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3575620040;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F35EC20043;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 2/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Wed, 27 May 2026 16:43:55 +0200
Message-ID: <20260527144358.186359-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=xyOPYXbJwbhnVPa3_EUA:9
X-Proofpoint-ORIG-GUID: 5GeyOIDo7hVGdDAOXGLV9vSFunxrMBVU
X-Proofpoint-GUID: aC75_mlYPUfBt8mr06lEZ5ywk_qLrTyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX/+lFNowh0vsg
 vh5xS1vOfdQBb0VvkxWOdSy5rN9VRQnxA/UqWUG7rhrzxsSjyOX17FJxH4mTyiFY5mbvQ4iDUz9
 lPbML+nAvuzStxbAtlLS9UYr6SDtovhV/OTgodpiuhp7os3A94jbesIx7rlMSRsPzQKHXAwDEHB
 /5Y9xjxDxSq7JGCJg3134IxXhgY0IwVLyD+24I58YuG93hkJzf8VAGUfs9v9IQ1TYup6dw+MDGL
 N3E2hhWdkYaxCMKaVqVtZHx19DrNVLkOn7giWP3Rx3UTWTjgBV0g7nKk0jh0RQdprYkV/cJjFuc
 stZMQBqEXR4aWxBtnQloS18pr9wOs+ZeXakUtglyuiY6/RQdvplZxd0+6TXjW9ZX6dxyz8rfWPj
 sjmgxRuKohp2Y/Kj0Buke5jzXHKpktQ3rCM1rrqdyDff3k4wJUQtPxowyY6UNBEjvqPp+GA/A8t
 Xptuw2WmSZE68iSiIXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270144

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

