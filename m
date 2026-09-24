Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7343A7E3;
	Thu, 24 Sep 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238185; cv=none; b=ff0IEd6RHX694svwlpKTQV8e6IEhxC8ff9q73Ohdvelbi6flCIiJ10vCVSV01eSvt/RO4dd314f9NOE7bjzDZmGRTTBB4UXORtTIL65Agn8NkyefnC6iNpQHsakbAiyncFWaU17+aghV5aG2PO4gpjWqz1d/+DNPNMgp1cuDZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238185; c=relaxed/simple;
	bh=Kw+7uJwadmA3/+0VnGX3uBWEfazwrylhCy0o5tuUHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7K94Ey4dp1pBJQE4fdWl8TUEHw2v3OM/NUO7cSK3NRJcCbD1wsAGw58JxWtNuKHgsMHO56Qz45Gy+IgfvUGEW2ZSM783VgzN1WZQsf93koTX+gmFzonFnIvmbEm08zahKoRWpVMnNtiapMgF2+u+ZT8IxFWHq7HKZpGW1lk2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKRk7Yef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKRk7Yef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC31F000FF;
	Thu, 24 Sep 2026 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790238179;
	bh=S/8lUKp9mIX5d6BKwHywb1J2XqYuMwPVrIBYkOuLxkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LKRk7Yef7xIRXywmYt9T9p8ZQrbVXd7n+swMMEKmBp2zOWJ7YgL2ycv5JC3WOiQE8
	 r75OCp43XzZPdNxIfpBLHg8Hyxi3VbuxfkXtmHo/dsPoPHl8sDvZWu5skYpaz/3h6B
	 I8leYeJmIZKqLPggRWdGz6bna2VuECRUlAG++6RMWW3kP9Ou/obf8jtu4nbr1c6rOu
	 p3GbpdB08d3+J+pskLku3PjKjTCWIia2EGwx7LWnwDYmTt+kSnV9PQR3jRSJV1zKOd
	 xCU7kf9CeR9HBun9nMQR9UiRg5w6NUmieCFF/EbxzD2C2y9Km6mTqbnlX54j3TFiCv
	 KozGf/TKQzglA==
Date: Thu, 24 Sep 2026 09:22:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 01/14] KVM: Allow architectures to disallow pre-fault
Message-ID: <arTdxHgk_3gGySOO@gremlin>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
 <CA+EHjTzDYSuBVEc+SMdDa41sq-ET=m_oWW0gL9dYf+AumPYPUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzDYSuBVEc+SMdDa41sq-ET=m_oWW0gL9dYf+AumPYPUg@mail.gmail.com>

On Wed, Sep 23, 2026 at 07:52:27PM +0100, Fuad Tabba wrote:
> Hi Lorenzo,
>
> On Wed, 23 Sep 2026 16:15:44 +0100, "Lorenzo Stoakes (ARM)"
> <ljs@kernel.org> wrote:
> [...]
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> [...]
> > +int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +        if (!vcpu->kvm->arch.pre_fault_allowed)
> > +                return -EOPNOTSUPP;
> > +
> > +        return 0;
> > +}
>
> nit: the comment above the smp_rmb() in tdx_sept_map_leaf_spte() still
> says pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory(),
> but after this patch it's read here.

Ack can fix up I need to respin!

>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks! :)

>
> Cheers,
> /fuad

--
Cheers, Lorenzo
