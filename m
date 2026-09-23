Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B43556B9F;
	Wed, 23 Sep 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176651; cv=none; b=WNCYbCdnY4QVpyy8zCSA05361wxMUBKTiaHiOha99c/+3szAjWuMUVwty/m1lpS4Sf/1QPv4dl/MAuZXKZ373esHlWxLWT1zSkbSvYNOHcPQO8ARuz6K+vq8BPc6dCppcbGiU1IO2K3XiTprIZNhcYmkNrl7sB6aX9dQqbHRQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176651; c=relaxed/simple;
	bh=ZOeS30gofdCLOtXFawVIsqjJmujH+ZzrHXswM13UJw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMla65qogU6eacb/0lTXps66AitpFyFwwBK8uY6jON/iqBSUKSNM/vgvYNND1LVkc1o50YMAiQ23+YrEGXs751RwFzs4NUi72WpcJyC83AGvIcCub3QTx34l3V+5yKmDXk/6cn9maRAK1wwlyHwqFYey04Pre3f5SAmH3aY+lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd1tzxbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd1tzxbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ADA1F00893;
	Wed, 23 Sep 2026 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176649;
	bh=XFLThVHVojpEVUSy57OzgxDT30uqvYagO8r4EUiTrpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nd1tzxbUupmp39i9v7NxLW1mFVXBMOX/eSLEcGX0ecyR0PHYJekwz5icqDiYzFqU0
	 LswEIO9iNNZHJZ+KPEzitCY96UvuJk0Rrj6GT/+xJrwN4uwxeVDXOrDuL+DGwHlQEq
	 ePfaO+41RQcLA0tcUrvY3JbgTwmaPX2mfBtKPOGG1d4lfzcbVixX2V2e9P/HEvOQ5H
	 7ljAMM5HexD9vFN4kNufxBBF7u9TLaurFX2Qlmddfp7qWno04KyoIw1m8+OJQ9FEuE
	 zZWwp8BA3zy31fIRlEKvppBNTQKQi+SGsYTDKZp2PCW1WC9tQ8nNpaXP/ola4k0B/m
	 MIE3tVWDv9z1A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:51 +0100
Subject: [PATCH v4 08/14] KVM: arm64: Propagate EHWPOISON in
 kvm_s2_fault_pin_pfn()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-8-d4b0b4dfa8c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ZOeS30gofdCLOtXFawVIsqjJmujH+ZzrHXswM13UJw8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9Vt2MfWm/N2xtr7N844/I0u0+y+6Rq6OMV299KqW
 u3w+cyvOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRT/8Z/vAXbd4uur/4xMoL
 NlHK0tJ2xdIX5U4IbNt6P030Wc/9CRcY/rsvCQsMlf6Xd0/4qriZpHaEGaN0wzz50LyQz/u53KZ
 OZgUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Currently kvm_s2_fault_pin_pfn() handles a poisoned page directly by
sending a SIGBUS signal itself.

This is an odd place to do it, the caller should decide what to do with
errors, so move the handling to the sole caller, user_mem_abort().

This lays the foundation for stage 2 pre-faulting which, arising from a
synthetic fault, should not send a signal.

In order to do so, check to see if user_mem_abort()'s caller has set result
- i.e. whether it wants to be informed about the outcome of the fault
handling.

If it does, then it is implied that it should handle the -EHWPOISON error
itself. This is the case for pre-faulting.

Otherwise this is real hardware, so send the signal.

No functional change intended.

Reviewed-by: Oliver Upton <oupton@kernel.org>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index cd4bc1d1bcdb..476a98cbe05d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2018,10 +2018,8 @@ static int kvm_s2_fault_pin_pfn(const struct kvm_s2_fault_desc *s2fd,
 				      kvm_s2_fault_is_write(s2fd) ? FOLL_WRITE : 0,
 				      &s2vi->map_writable, &s2vi->page);
 	if (unlikely(is_error_noslot_pfn(s2vi->pfn))) {
-		if (s2vi->pfn == KVM_PFN_ERR_HWPOISON) {
-			kvm_send_hwpoison_signal(s2fd->hva, __ffs(s2vi->vma_pagesize));
-			return 0;
-		}
+		if (s2vi->pfn == KVM_PFN_ERR_HWPOISON)
+			return -EHWPOISON;
 		return -EFAULT;
 	}
 
@@ -2263,6 +2261,13 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd,
 	 * get block mapping for device MMIO region.
 	 */
 	ret = kvm_s2_fault_pin_pfn(s2fd, &s2vi);
+	if (ret == -EHWPOISON) {
+		/* If result is specified, let the caller handle this. */
+		if (result)
+			return -EHWPOISON;
+		kvm_send_hwpoison_signal(s2fd->hva, __ffs(s2vi.vma_pagesize));
+		return 0;
+	}
 	if (ret != 1)
 		return ret;
 

-- 
2.55.0

