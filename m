Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789452;
	b=KxWkIrDRiKui7ZTT+CrZgEmX+PfB8E7VWa9iPhzLhu1y6ZUhLBeOOUFD2SDnpe47y483
	 JmSk3gxhe8lyrDLugUd3PFUBe3nqzPkW2cKUkI8Sg4kjl6bPDsGknRN7JTTalKjrx8VXt
	 7/hnWlKFf831qsxdAMVXaJzYg+QsT8NV645GBCmHqqOXR4Q2EEZVzEvzpDXErBgH6MHTF
	 Ls+aJISCooqdl8QKavpbPI6b+9WAzyyIH8j+8bdu98BJv3w9rkAjgo/LuMrPmLOwU9zvs
	 Y/y8I8IGH3CT5hQtQCwq5V6TAjt4POrVkAassLnIHsDapNXETSJYOw3Pj1mkZEAXjag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nb9I2DFvTsKFIXWg+x3woDZtsTUl9HEU/96bcBOM9zY=;
	b=do6/6nUNNoMaoK7XpoQ+WAt7LxZFTOKYTOLdVhs3yAVTj7/IM0/0qAS/tBZqu3k5G40s
	 c91P6jUsQjhUDS8DHWXZSeSorQLGx0quq2E5jCMoj1cvIwRIDyMiCwIXjWI2TNENoFmn3
	 ju5EWMfETb/KEwt3jzzrUTfvnSe/A4/6tqZCgWt3kFKd1rSH3yRN3kpNAlrC7YGmlXLCT
	 VEaO4tU0V5TIw5E5l8LKsJDdxxzh3MK3pZhuUc8+WvuCl9qlyHr/iAYymjFHmqmS80f6C
	 8uIFqOc9LYsnzKr/p7Xr5daezt5QCH84g+rV6fdrZem1k2ooMoHhk2y8r3CZG4kk1IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR5CmKg6;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3060A382E;
	Fri, 27 Nov 2026 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D3060A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR5CmKg6
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE500j3266106;
	Fri, 27 Nov 2026 14:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nb9I2D
	FvTsKFIXWg+x3woDZtsTUl9HEU/96bcBOM9zY=; b=KR5CmKg6+meSoICJWOrUua
	7eEczRwpvmvNfH4K6Qlv115y2o7cgjwDwxD4OgNGcr6W5OxKamITai9hUUoMrJDu
	TpRWDzFjBpR10QALSmxhycDvM7EHzP6BBWAkTDwkqnWBcwHSBhmThOcmUIETNvyP
	jRhkthwcr+0KfMTmR/H/ej6TtKKscFX0Xyler0NspYXgBdnjw4ZFS3LHDOyYPMet
	VvYVD6dc3Z3ywc0Iul8aLqmwKb9QSz+r/Sy/HqpEbkPqAUlLyyDFQPkb0sASg7k1
	q2JKtuaJBtQDN/Sf7+Iq9tRq9yggYintVlq+il4vuLsrx8j5xcAnr1W4bOf14YZQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1ne2s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4G4W3892969;
	Fri, 27 Nov 2026 14:23:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6ucctx48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENPbj37880102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE0F420067;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A9222004E;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:24 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:25 +0100
Subject: [PATCH v4 22/25] KVM: s390: arm64: Finalize page fault handling
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-sysreg-v4-22-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 90k26m02ZFRl03GAf6PQAjt4Wqx5CfYT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX1dFhS0DVAUdD
 S723aVGaeBkVdJqMDc5V3zrHbDPmVzmjKHctfxcvLi2FldpjU+xZJxB7h5aWcU935ykiXHQBs/2
 reUgSxWOEG2dCG8FXjGPhZibqq9pNVk=
X-Proofpoint-GUID: 90k26m02ZFRl03GAf6PQAjt4Wqx5CfYT
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b099264 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=esxTPpjmjEy2b565Pi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX6lG97M5AXUID
 0JQW536TNIXcReqPrlgYzvyWyc6F49gYaNu/3zCdOSHJDh5/N9NnNwrLxvRQWMwZ7GPHWER6Tt+
 jOP1og/h2iL2SCvl9Zr1CFFicuq7O6HtXtZ3784TWCqQKsgklW4SCpiaWTh4rGA1fuXAGJ2IGFu
 X/gaCRw9j66GsQ6XEGGzXVquVF/4fbtD8vltOZkShtHnpNY5+LZgApxuhXy4Rmu/851cRCF+MD7
 cBc/uSG07NaDwvOoy02bqWD08bjsYdI2sdDzRP+/pieps5nY08FyYeZed2IpRFKWvXqhuHP/hkk
 8W/r8EnMiUjo+184x64k3hqfcNwCrG3gKp+QHrZr/77a0sIjHTdGjuMzoZgxYVQHi9P5lu7vOc2
 cWh4HL1Skho7n7v/o8NLwmGqTUOtrZExX9Mw2RKyDjsN1xTiR5vb016/Ge7zps8Jh1vL5SvkoWd
 yWNqOq6Hv7nJszhjy6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Replace the temporary -ENOEXEC returns of the arm64-on-s390 page fault
handling with exception injection into the guest, mirroring arm64's
kvm_handle_guest_abort().

Translation faults beyond the physical address range  are injected as an
address size fault, while faults falling between the VM's IPA size and
that range are injected as a synchronous external abort. Instruction
aborts and stage-1 walk faults on host addresses that back no guest page
are injected as synchronous external aborts as well, and a
PGM-addressing from the fault-in path is injected as an address size
fault, the closest arm64 equivalent. Injected faults return 1 so the
vCPU re-enters the guest with the pending exception instead of exiting
to userspace.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c |  6 ++++++
 arch/s390/kvm/arm64/mmu.c | 52 ++++++++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index d6bfb29c8186..899a897c5486 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -63,9 +63,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 static u64 kvm_max_guest_address(void)
 {
+	u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	u64 id_pa_addr;
 	u64 max_addr;
 
+	id_pa_addr = kvm_parange_to_address_sanitized(
+		SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, mmfr0));
+
 	max_addr = min_t(u64, TASK_SIZE_MAX, sclp.hamax);
+	max_addr = min_t(u64, max_addr, id_pa_addr);
 	max_addr = max_t(u64, max_addr, SZ_1G - 1);
 	return ALIGN_DOWN(max_addr + 1, SZ_1G) - 1;
 }
diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
index c93f5fbe69c9..7a6f6ba326c1 100644
--- a/arch/s390/kvm/arm64/mmu.c
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -16,7 +16,8 @@ static inline bool kvm_s390_cur_gmap_fault_is_write(struct kvm_vcpu *vcpu)
 /*
  * user_mem_abort() - handle a dat fault for the gmap of a vcpu
  *
- * Return: 0 on success, < 0 in case of error.
+ * Return: 0 if the fault was resolved, 1 if an exception was injected into
+ * the guest; the caller resumes the vCPU in both cases. < 0 in case of error.
  * Context: The mm lock must not be held before calling. May sleep.
  */
 static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
@@ -32,12 +33,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
 	ret = kvm_s390_faultin_gfn(vcpu, NULL, &f);
 	if (ret <= 0)
 		return ret;
-	if (ret == PGM_ADDRESSING)
+	if (ret == PGM_ADDRESSING) {
 		/*
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
+		 * There is no page with the requested address. Inject size fault
+		 * which is the closest arm match to PGM-addressing
 		 */
-		return -ENOEXEC;
+		kvm_inject_size_fault(vcpu);
+		return 1;
+	}
 	KVM_BUG_ON(ret, vcpu->kvm);
 	return -EINVAL;
 }
@@ -92,6 +95,13 @@ size_t kvm_parange_to_address_sanitized(u32 id_parange)
 	return BIT_ULL(parange);
 }
 
+static size_t kvm_get_pa_address(struct kvm *kvm)
+{
+	u32 id_parange = get_idreg_field_enum(kvm, ID_AA64MMFR0_EL1, PARANGE);
+
+	return kvm_parange_to_address_sanitized(id_parange);
+}
+
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 {
 	struct kvm_memory_slot *memslot;
@@ -120,16 +130,17 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	}
 
 	if (translation) {
-		/*
-		 * For both cases:
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
-		 */
-		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit()))
-			return -ENOEXEC;
+		/* Beyond the PA range programmed for the guest */
+		if (fault_ipa >= kvm_get_pa_address(vcpu->kvm)) {
+			kvm_inject_size_fault(vcpu);
+			return 1;
+		}
 
-		if (fault_ipa >= vcpu->kvm->arch.guest_phys_size)
-			return -ENOEXEC;
+		/* Falls between the IPA range and the PA range? */
+		if (fault_ipa >= vcpu->kvm->arch.guest_phys_size) {
+			fault_ipa |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
+			return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
+		}
 	}
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
@@ -143,23 +154,18 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
 	write_fault = kvm_s390_cur_gmap_fault_is_write(vcpu);
 	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
-		ret = -ENOEXEC;
 		/*
 		 * The guest has put either its instructions or its page-tables
 		 * somewhere it shouldn't have. Userspace won't be able to do
 		 * anything about this (there's no syndrome for a start).
-		 *
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
 		 */
-		if (is_iabt)
+		if (is_iabt) {
+			ret = kvm_inject_sea_iabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			goto out_unlock;
+		}
 
 		if (kvm_vcpu_abt_iss1tw(vcpu)) {
-			/*
-			 * Without the relevant sysregs we cannot do anything for now.
-			 * Go back to userspace with an error. TODO sysreg handling
-			 */
+			ret = kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			goto out_unlock;
 		}
 

-- 
2.56.1

