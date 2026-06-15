Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2B3E6DC3;
	Mon, 15 Jun 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527375; cv=none; b=rO8oNPISIvQ6apq6HwZ+UnHdqkkuc8bEfZG1HOg+ChzU0tn0jxGaIJOzs4GG5KVea94QHh95PxUxVdONKsdzTvAGF0dtC0Li9LECRM0sBKqKxLcLqVd1MUTo2wdWjcB2wWUChvKUy20hLbK7cBMJLeWjMmEtZk5jVHK3h8q7op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527375; c=relaxed/simple;
	bh=2UFlUXDfhKTl58D7gpAX5ut7ovTm3HTiqdigVcuswKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVnN8StFHYXeGb+S8veZInMWWRBvdjE7Muu39j25LO5cfCabRmBlAZVyNSAt5Kml8VQyH8JOtXNcV/oaTscv7iVQn+OBk2qNuUnMwCAVYvL86keIBj2R0maE9dS6kzkjOvYrPgujAaZA4KsuAkatqiOuUkPmg90ynEEYcP0aZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKU7S18k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKU7S18k"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAquZq2271299;
	Mon, 15 Jun 2026 12:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qHxnjIP/JRQBk1cbr
	qMkm8XIh/yTE+cR6G/3Aj7r40c=; b=qKU7S18k5iuotZ7C93D2CGiFpO/92cUtV
	g7hjq9Cc5mjxZrSQwc5FDdqkQvqV7zrTn1ayvL+RxAGtd7gGJsq9qnQcG1whRtiC
	sCdxjoN4PbEIgtnJXR9yJwHHVY6M3jPf4zGznS/C+e9gWwB+MJQWMfSYvTnKax7F
	swMLls3oW9vYKqXnU9kebg2ZwFNObgHlpBaMvCoKjJfF4cYMl8Eiu9kBVlk1v7eB
	Qn9SS8TotxiJ9uHzuQrAAw14P51fvpQAcvGp+kaEpLRym0hYa5eZmbNEnWhIVpbk
	yT1WOKvxsA2F27MxwDRJ/THp+j4CIt0WREa3EV5OAOXgou3kvhe/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg03jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYb6f017133;
	Mon, 15 Jun 2026 12:42:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg6cpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgjin10027518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA73F2004B;
	Mon, 15 Jun 2026 12:42:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A962005A;
	Mon, 15 Jun 2026 12:42:44 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 02/17] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Mon, 15 Jun 2026 14:42:28 +0200
Message-ID: <20260615124243.187614-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX64SIz8bJ4cF1
 Uc3s+arDx/E5thCEscyLEqwBEsmWXixNDW0akWlJOllmijFPX0Vhe/EE6E+H8EFlSCoZVEyxio7
 AOX2XOtIffEh2g3ERy5H1UHpY/nZjVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8QedNYq/22mb
 G/pPRWTPJs82van5CgH+uNEUlbgi1WQfEN6zuBO8ZCSG2LZRTif6/sNJcEzPQHdaRo2kg73IsY7
 to3KI8YnU7qagBghEqvMLwRSiCdCrQeMY7nNzTL25SFRvVIMfKTgkG3XidV8hSxNDhNtDqxCppK
 iVB5CGDG0dginwRjMFAab6tSTqn6+4VM56sERGF+1FwpVu8ihziK6oRixXLHpbNLUxmzAJ8p9ZX
 2iwKMq4+o27EnDmNUzgytXRAirmai/J4rp/ZTl0xI4QGLkDZncYLPljZsOXR7d0BRUjCiUychU9
 ziZR/EjIsmiiL/ZYbpeFeV9wSBkr/ou8zVK8i2j8Yk7x1wJJdczl1/31WGzoSBXoqV5wNfJtbGM
 wbSOx7u1GdFF03vAO/QEI8J5CVA7brcadwtRHjbW+3SyU4UWfduEBnO98NoSZx0GAznrRCQSWL5
 fc0d8I8ysDJXZiNs/ow==
X-Proofpoint-GUID: 1gRbJMpnW7egbvihzJuIAC9w5Fr32OEX
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2ff34b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ISO6XetKLR92WHMvAYAA:9
X-Proofpoint-ORIG-GUID: 1gRbJMpnW7egbvihzJuIAC9w5Fr32OEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

Implement and enable the KVM_PRE_FAULT_MEMORY ioctl for s390.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260527144358.186359-3-imbrenda@linux.ibm.com>
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

