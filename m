Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4D5349AB
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189599; cv=none; b=sfm1u+nZLphdshs9Pc6j6467eZZL0aWZOZ/luxTvKHq+qX1rNX9j58bhJIYvBjt6f7Z1zNtXknEpx8nbBVlPry1PS+K+5s0fb40XFmyCy9msqfd1nYlOEk1CSJwT10Kh/9xCImX/gq1VClZz1tVTiM4u8hwy4usRGwGOKspmNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189599; c=relaxed/simple;
	bh=VQwGs8kxbwA/pw10zZlCJcbl8pu79WWCbvhBxYPCINQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc117U+9+gzLIeiAN+OdPscDfaxyjdueEcwa3z4S1DELpL8hcUGPy8yzeaO3voyW2OImCFT0Hl0kJEcXmDH0l6w6Tzq7lal60Gb5ZVpVHx7mfTeIi5a0iTUe90vM5trAz+w5TCFfojo1ZyySen0G/4btHUfiAyMsw4PnMo2XSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HucKdqpF; arc=none smtp.client-ip=95.215.58.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HucKdqpF"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VQwGs8kxbwA/pw10zZlCJcbl8pu79WWCbvhBxYPCINQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790189589; v=1; x=1790794389;
 b=HucKdqpF2C+Z2funT521S4GuulRKRrlYL3J4dzrEasBAGy13+3ocRtfF+Ew50v4ft3xCxBNu
 MYE59PCKbXsLZplEPE7kGHRQeiMISXaENc9IvzHtcUO8w7QJfLD5b3LXV157Qq/aznA0Bw0++zT
 88vdJReZ9506tspXnQZt3SuI=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9bcd2a763a9827a6;
	Wed, 23 Sep 2026 18:53:09 +0000
X-Mizu-Trace-ID: 9bcd2a763a9827a6
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso1457e87.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 11:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw1RoAXhL8n45vdX8fNzIPt/THZVyjQTNdVvFnjBmMnzQKk9dov11jfPNM6aXMcCHrJG72ShB3GvQVS@vger.kernel.org
X-Gm-Message-State: AFuF++nWuHjxQS8CDS0e0CAD5+IuPriDmZyiOnxE2OAZ8u/ARlOtnSlE
	Qt/Xvae4cTXn62HTRdOytk0BqMz97n37yIQlhwQyD/1/2peMiAO5vQZTRkV0X9PKDEv44a/IjCD
	thWZ/aDZeQOkt7+obyxiZ9TsWLWEuiOqvEJx36bOp
X-Received: by 2002:a05:6512:124d:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5b8dda15fd4mr50291e87.8.1790189584139; Wed, 23 Sep 2026
 11:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org> <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 19:52:27 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzDYSuBVEc+SMdDa41sq-ET=m_oWW0gL9dYf+AumPYPUg@mail.gmail.com>
X-Gm-Features: AclHuK9102l5jXhHZm0wjY1xcBMQ6NzdYFil2Hlxj79BuZjg_2Y9X0YS37SYzUc
Message-ID: <CA+EHjTzDYSuBVEc+SMdDa41sq-ET=m_oWW0gL9dYf+AumPYPUg@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] KVM: Allow architectures to disallow pre-fault
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jack Thomson <jackabt@amazon.com>, 
	Jack Thomson <jackabt.amazon@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Wed, 23 Sep 2026 16:15:44 +0100, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
[...]
> +int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> +{
> +        if (!vcpu->kvm->arch.pre_fault_allowed)
> +                return -EOPNOTSUPP;
> +
> +        return 0;
> +}

nit: the comment above the smp_rmb() in tdx_sept_map_leaf_spte() still
says pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory(),
but after this patch it's read here.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
