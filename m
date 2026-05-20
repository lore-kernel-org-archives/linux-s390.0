Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784A3ED3BA;
	Wed, 20 May 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290246; cv=none; b=fHiYMzfgY979GhxEYyVpPX8iGdjb5hjfcle7VCGJDJLIxuN6zukCUm0XcYeuiNLLoQdxA5oikB6Bqm/QP+UwCWFObc4mVKvKOsJQQB97mTW2dLSqzDnsBU53NstH0bWFGDqXfX6ZjF80cGTLqlL5br55GPY90C/rd29g8aRafdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290246; c=relaxed/simple;
	bh=BQCmGvYbepRft3F3wcFkb8z8H/UlTgTlA2s+YUgQsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0/VqnHip/ORggSPJ75QtpDAJyg1rQ3MB3YUg6JrFWxdGv14A3InFX1HLp+EtKb/yxAyC7G6oqRlyJYc0CbE4MroTk4rF5B5HCkDc2R2L8J/xoND1+DsFc9C0rnD3WTQJOlRVmSUYxcxNFcdCxOl3Jwe61eZH65bSk+t7M3WWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gh4+ot87; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gh4+ot87"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8MRhc3015276;
	Wed, 20 May 2026 15:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+9FG/QWYKOBvgshYr
	CprfMiWDuK9krkyWqRZ1vbmmKc=; b=Gh4+ot87enjj4qjoK/IFC6diI9YaRSQTN
	Ti1m1C7QBZ4z1CNMfjpYcfHXd7fuo/wMH/zPjFAE4cttwo00sYcJC8rFj2raW1uG
	C3b4J25QDo2XYuObcXP4FvtGfiI7E9Cx2pofess0W6oej16EqbOcdfIFDwk//zRB
	u8NHAlDVhX/dRl8Gde1qSvmT2RHjZUFyFozWCcM6KOlNry/Rf/z/IkLd+0/43jg+
	usSmFi/NFmSwHzYdGxH48bA4viU6FAHsA0CD9m1vHFMmZY6EUAKtT7By17pnBuy/
	1MfpvPKjoi5vw9ksQIrrJ/3kJroPzIUgwAp43rR9Kz5BIbEnnnBgA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw9r6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF95pC027198;
	Wed, 20 May 2026 15:17:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7mt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFHBOi26018138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:17:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC7520040;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A1D12004D;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v1 1/4] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Wed, 20 May 2026 17:17:07 +0200
Message-ID: <20260520151710.231788-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151710.231788-1-imbrenda@linux.ibm.com>
References: <20260520151710.231788-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfXxqw4N+BSWqdJ
 uxGpFdcDGYRKsQxOsdSYBbw/HKT3JZ8vkYR9EQU7LJoU2FS0UIkVyZxX9eGYyTQFlg721xeiLAN
 ftSduQxUo6dXkxHTLkTsGxR5xeFryyeNvJqXwJjGRAWO4boFiKQ8NckjPRoucZCCRO3jFLxJQPy
 F+aQvSIc7gGU40rwhShywY42LQgrnVQtnVlPkqfFUgmU0/F5QoCbxozUZU4C3oZo1KKGiwmHajz
 Io3Z/Bp27bhhgxOynyIZnN7XvUgGSdzO7kKtwqK/VXmOi2GWA+oRaxi7MYSgppzCAEMowkIYSKM
 2UfpHU3G1912rQkIKvhCgRCrSXiYL3cvC4WKKceSmEjnDq1Npmvn2yAlIWhYWyLuO89kqm9AT4e
 VnpMJ9CG2iZlLo52BRYkNirBdS+ji2P9hXzxoWHwkRBGFtruGc/HhAMxLeKe6fX8gT2bOLStGZ+
 8Rl/8Vg5P9Nzknv8Q0g==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0dd07e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xyOPYXbJwbhnVPa3_EUA:9
X-Proofpoint-ORIG-GUID: oc7y2PLgWopLHQvrrJKdabQJLD7JIMsQ
X-Proofpoint-GUID: AioF1MJ-EJ_BCgB7WqIPcKrdCWT6kYwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200147

Implement and enable the KVM_PRE_FAULT_MEMORY ioctl for s390.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/Kconfig    |  1 +
 arch/s390/kvm/kvm-s390.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index e09960c2e6ed..dd220f3d6e94 100644
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
@@ -5736,6 +5737,46 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	return;
 }
 
+/**
+ * kvm_arch_vcpu_pre_fault_memory() -- pre-fault and link gmap dat tables
+ * @vcpu: the vcpu that shall appear to have generated the fault-in.
+ * @range: the range that needs to be faulted in.
+ *
+ * The given range is faulted in and the corresponding gmap page tables are
+ * created, as if the given vCPU had performed a read operation. If the range
+ * ends outside of a memslot, only the part inside the memslot is faulted in.
+ * If the range starts outside any memslots, an error is returned. An error is
+ * also returned for UCONTROL VMs, which should instead use the
+ * KVM_S390_VCPU_FAULT ioctl.
+ *
+ * Return:
+ * * %-ENOENT if the range lies outside of a memslot.
+ * * %-EINVAL in case of invalid state (for example if the VM is UCONTROL)
+ * * %-EIO if other errors happen while faulting-in the page (considered a
+ *   bug, will trigger a warning in the caller).
+ * * other error codes < 0 in case of other errors.
+ * * otherwise a number > 0 of bytes that have been faulted in successfully.
+ */
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+{
+	unsigned long i;
+	int rc;
+
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return -EINVAL;
+
+	for (i = 0; i < range->size; i += PAGE_SIZE) {
+		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(range->gpa + i), false);
+		if (rc == PGM_ADDRESSING)
+			return i ? i : -ENOENT;
+		if (rc == -EINTR)
+			return i ? i : -EINTR;
+		if (rc)
+			return -EIO;
+	}
+	return i;
+}
+
 /**
  * kvm_test_age_gfn() - test young
  * @kvm: the kvm instance
-- 
2.54.0

