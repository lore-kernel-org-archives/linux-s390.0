Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507653E308;
	Wed, 23 Sep 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176590; cv=none; b=bXbK9oDOJ5D9OdJ6JA2EiNBuAaMDilZqRimyyxLdvkLirAUl8+D/Gc3vLdOrhWaQzJN8fyOin0kEP8mSfGBlIFoL+e9okd7SWmEAY6IldvwY0EbGCBAVFYzOchPOpo6dg0AvmqznLn+Uiao5qozx5kpqFyEV25rxJe18RMwYbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176590; c=relaxed/simple;
	bh=CrKeLvuwUnfStnYfIX5SaSTXH36Ss6uiAa8UepVZb3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otMLyjds8NXtP+jORqXZZQDSgVTJxF+J69VDW/vtaU6dA2inwVFUjbTlZmdJRKP7QOVMqlvQovwSZ71vd/ObrCRgbAqV476NCb0RmKXXViCScu+/xgwsUKMVE5muQfDkSaWchZyOLtvRp0Vk6UaR5h2l6GeeRAY4vMTAsi9RQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX83m2a5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX83m2a5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB641F00899;
	Wed, 23 Sep 2026 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176588;
	bh=ohYf1XvtMCeR2pp1iNho8B7oyFZ/zgS/g8G2hAtOeWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TX83m2a5ihaN8AA6SgsfKyiWX3o4AzsbmqBQy1/23gbkmXBUzNb3hIsXdZqAw7aED
	 L3dCsZvzhtyWabP2O9siUu8OedxVHnmidmolwexgWoV9S9lSOoH+lQ7RSwUXB2ALi/
	 Rps0skkdnYO15xoUBm28l2qBZtpJJo4NsSRw7iaj7nyS7loxYJdjiG0iw8n46WAopl
	 pMaIPTNp6dnOR6qgUdhnr+TxxjNw7gfmOQhFuxgHuTFBcHwdR3aYh9e7vKeWXZQ+op
	 q5P2zeOqJXeugOlvQHjORXsALDil3bRoYqOMphSQrybTQEbQMo8ukVeQZL6DcRZSBv
	 73WIl/O7m/jvw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:45 +0100
Subject: [PATCH v4 02/14] arm64: Add ESR fault helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-2-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Thomson <jackabt@amazon.com>, 
 Jack Thomson <jackabt.amazon@gmail.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 Vincent Donnefort <vdonnefort@google.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
 linux-s390@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524; i=ljs@kernel.org;
 h=from:subject:message-id; bh=CrKeLvuwUnfStnYfIX5SaSTXH36Ss6uiAa8UepVZb3I=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9WJFBIqqMxftTCC49yZIBWP+rbJ367f2mA/26Pp4
 7XVZw0cO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRnY6MDJ3PK102y8e0nrgx
 jf+y+jl3vrPlKdu71dOMVFY+Cqt5p8bwV3p9pt45P3fbdbH5NSfjP3C+zs84+O3r3Sq1xqqzpyO
 COQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Add helper functions which operate directly on an ESR value rather than
trying to access the register itself.

These mirror equivalent KVM vCPU wrappers in kvm_emulate.h and allow those
wrappers and KVM's stage-2 fault handling to operate on a plain ESR value.

This is needed to later generate a synthetic fault for the stage-2 page
table pre-faulting mechanism.

No functional change intended.

Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/include/asm/esr.h         | 29 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_emulate.h | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index f816f5d77f1a..86756fc9bb5a 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -437,6 +437,35 @@
 #ifndef __ASSEMBLER__
 #include <asm/types.h>
 
+static __always_inline bool esr_trap_is_iabt(unsigned long esr)
+{
+	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
+}
+
+/* Always check for S1PTW *before* using this. */
+static __always_inline bool esr_dabt_is_write(unsigned long esr)
+{
+	return esr & ESR_ELx_WNR;
+}
+
+static __always_inline bool esr_dabt_is_cm(unsigned long esr)
+{
+	return esr & ESR_ELx_CM;
+}
+
+static __always_inline bool esr_abt_is_sea(unsigned long esr)
+{
+	switch (esr & ESR_ELx_FSC) {
+	case ESR_ELx_FSC_EXTABT:
+	case ESR_ELx_FSC_SEA_TTW(-1) ... ESR_ELx_FSC_SEA_TTW(3):
+	case ESR_ELx_FSC_SECC:
+	case ESR_ELx_FSC_SECC_TTW(-1) ... ESR_ELx_FSC_SECC_TTW(3):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline unsigned long esr_brk_comment(unsigned long esr)
 {
 	return esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a3c1928bdf74..654e8c1b4461 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -336,6 +336,16 @@ static __always_inline u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.esr_el2;
 }
 
+static __always_inline bool esr_abt_is_s1ptw(unsigned long esr)
+{
+	return esr & ESR_ELx_S1PTW;
+}
+
+static __always_inline bool esr_abt_is_exec_fault(unsigned long esr)
+{
+	return esr_trap_is_iabt(esr) && !esr_abt_is_s1ptw(esr);
+}
+
 static inline bool guest_hyp_wfx_traps_enabled(const struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);

-- 
2.55.0

