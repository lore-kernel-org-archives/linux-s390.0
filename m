Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FE50AC18;
	Mon, 31 Aug 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188479; cv=none; b=qYRkaTTbIJ59NvgA3B3kGRMszcc3BIj1at2RDYBkLC5ZIXTUDSRyoS5weAjxxfw+PjskxxNTbmxSRbRGGZuRV0c0TlyTXx9XH4FTTcnba6JksN7W/PEjF1rmrpbTDkALV3/xAO2VrWS2se3V753VWVhqXlEthI5KUTr50c4Kk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188479; c=relaxed/simple;
	bh=cXbjAr3/cFqBz8xIm0fvIZOEqQfBNmD15mzUs6Xu7vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlJL7DDs/7N5WWzQOulNXCBrKbQc9JAIj2bur1nGR43ifQI4ji5WhwhRHElG+vm9by5Fm3oFAHbDLsrpzmGQvZ3RmcElWw4+WGbiBeL9VTCSVZt9i7RIFD4AbdZf8OF5UBGz0bbJv0XPEGmomSpppVUnPnbq8Tg+m4hNYmLDZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MswAUQPU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MswAUQPU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZMYp1398414;
	Mon, 31 Aug 2026 14:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MmNBAaSP10njDEMdV
	ZMQ4XCdAiOoaIKg1V9E56+33X0=; b=MswAUQPUygQGaQ8vGlocoWdRdNj1XajXw
	7gkvwOiHuIxKp7z0KygxWEMcbXS8TgoUoTuoHAofM30hL+zgfd1j85LJc8gA3yeD
	q115LHLyncqaBAgBe2CXoz0gfwWUWxSbUs0i0oRdmpOkq1JqyE53QaLBWrvM1dH1
	LjgyOExgv7FaDhFFHzyTAOiajO3lgxBgCRNZWm5e4NdATHtcQy5Rb51hMCMaLBRM
	uasQI2SPD2++Ikg0NRTz7gtZvIz2DhXSUdXG7q+5QqBrf5f+0ZwczASyKIoyi8KU
	OawaXrn32mZRegm+mln0nl/RdrQn5rVvCUTIN3DYYrwHrYPPR2tOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudj18k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfcEX029530;
	Mon, 31 Aug 2026 14:55:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx8v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtkgH49086974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 193BF20040;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4112004D;
	Mon, 31 Aug 2026 14:55:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:45 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 17/20] KVM: s390: arm64: Finalize page fault handling
Date: Mon, 31 Aug 2026 16:55:32 +0200
Message-ID: <20260831145536.913567-18-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hZjDaTtAfeAICy-xgzvXSwbI66Vtr1TP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX6cDYM6nRgIso
 gMUtvnOyN6rAokb0HxDWp8kBI9v9ocaaWKuBGXpu1JnHlEAXatxbMj/Zi8dGKFe1buY3nVz+rGP
 jZdhmf8UUpXZW/jzvs/wQ/f4vWlna7dYfWG0Byg2E/xkAdYf+lTx5p8ZPt6kIxoiIZnDPeT3fh0
 gqK/klvnZOa6ontAjBI/xXKywVGeesgKsQDxjLwc0F1ni5moTUAgb88RpBXcOs3KiZWgwtE/LJ9
 n9FAKW6QSWfL7gHMhHwI6gS5LNaRT3v6LhxME4imPCaSrk/3zxXGEyHT0zdnySfFbr7PDRCE66k
 cxQtnaXbErFzjHl1NcCyjOT85+XG2PnkOdJTbf7GbOOYZlpGKiw1/Abf7MVjGChPBcwAkmhwrMg
 P5vbW6GxinAb5uLnQNQAWgO2g6rNIpyU1eAdO6jy1vJJQPBJutsFtygK5ITOlZdGUhlvxqIn0tv
 JtgsEACYRdPb3Nert0g==
X-Proofpoint-ORIG-GUID: upSeR6PoHmbjotaSlhTZxboIidNTVjRE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX3BhtkiMLLJ1Z
 uIjDmch94OgUgODmGmC6liW3qzyysCYvlLi+dO2R9trDR7ZpgVgbYszcOjnyPg82fGxe/WLPua0
 jWJBxwXj2ZiY0jN/NxOmzd4/GoELdCI=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9595fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LtHRyupC2uTP9dkk8LUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Complete the page fault handling implementation by replacing temporary
error returns with proper ARM64 exception injection.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  1 +
 arch/s390/kvm/arm64/arm.c              |  6 +++
 arch/s390/kvm/arm64/mmu.c              | 68 ++++++++++++++++++--------
 3 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 16a378b68c8a..c0e8fbddc9dc 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -427,5 +427,6 @@ static inline bool has_broken_cntvoff(void)
 }
 
 void kvm_adjust_pc(struct kvm_vcpu *vcpu);
+size_t kvm_parange_to_address_sanitized(u32 id_parange);
 
 #endif /* ASM_KVM_HOST_ARM64_H */
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 89984c6a5b64..d2ff69422217 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -62,9 +62,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
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
index bf3442d3609b..b5f1dc3ca0d2 100644
--- a/arch/s390/kvm/arm64/mmu.c
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -30,12 +30,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
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
@@ -68,6 +70,33 @@ static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
 	return 0;
 }
 
+size_t kvm_parange_to_address_sanitized(u32 id_parange)
+{
+	static u32 ranges_map[6] = {
+		[ID_AA64MMFR0_EL1_PARANGE_32] = 32,
+		[ID_AA64MMFR0_EL1_PARANGE_36] = 36,
+		[ID_AA64MMFR0_EL1_PARANGE_40] = 40,
+		[ID_AA64MMFR0_EL1_PARANGE_42] = 42,
+		[ID_AA64MMFR0_EL1_PARANGE_44] = 44,
+		[ID_AA64MMFR0_EL1_PARANGE_48] = 48,
+	};
+	u32 parange;
+
+	/*
+	 * Future values must be higher than we know already.
+	 * See ARM DDI 0487C.a. Return a safe limit.
+	 */
+	parange = ranges_map[min(id_parange, ID_AA64MMFR0_EL1_PARANGE_48)];
+	return BIT_ULL(parange);
+}
+
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
@@ -97,16 +126,17 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	}
 
 	if (translation) {
-		/*
-		 * For both cases:
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
-		 */
-		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit()))
-			return -ENOEXEC;
+		/* Beyond sanitised PA range (which is the IPA limit) */
+		if (fault_ipa >= kvm_get_pa_address(vcpu->kvm)) {
+			kvm_inject_size_fault(vcpu);
+			return 1;
+		}
 
-		if (fault_ipa >= vcpu->kvm->arch.guest_phys_size)
-			return -ENOEXEC;
+		/* Falls between the IPA range and the PA range? */
+		if (fault_ipa >= vcpu->kvm->arch.guest_phys_size) {
+			fault_ipa |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
+			return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
+		}
 	}
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
@@ -122,18 +152,14 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
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
2.53.0

