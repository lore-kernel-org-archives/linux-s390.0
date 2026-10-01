Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067E3B2FDF;
	Thu,  1 Oct 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865402; cv=none; b=Cr/JbnQLYXOnE8N8wAp6grkXw/d5VL0q2Oy6vhvB+oY1KZy7Y6caE88vwC3URZad4IlEr6W1gO8yzax+zxMjyC/7uTJfdB5vRS4uRorgCGYX0/6ZJ2kEXCFG98g2+1N6h0gwy/vtC5fhQG5RLfKDIbdjKWwtZrqej/Xl3d7a/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865402; c=relaxed/simple;
	bh=2kxmO6iReapZ9oKKYWiYUJYQSMUSU1Lhiqom05w8dw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGuek9lkqkzz6+4zJ97jR55NAVWwAnBCxKDBOPQVZV30wcFGYCep7lFnUUXZKfCtykLcfrJYr/Ddr8TYc6F0yjNXT9tFaS3cikddjkhns4Y35lratQEZG9dq6lo5ndZaJnXGuOTlSMt5DtDh47FzbYIu46Mpj4fXnk/bf4ELiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRA3ndmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRA3ndmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731E11F000FF;
	Thu,  1 Oct 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865397;
	bh=KqppwbTyT6zkR1AvrZPfMSRvNskOl/Jz4/VeCTg9S+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oRA3ndmuic8x5tRK8Thog7048p9/0q1/4fqTgxaNdxfq2ksuOlOiYGYor6Edw5mFh
	 gbvysr6lqUVRtSROKKKFcydrUR4RABYSu2qIUBBNEEbKqM1p2z4uKUQHArX06X3jJ6
	 MFbDk23qOyANQ6TQq68cZYSKJCPBFnzLFV0R9ES5BRxzev1bjVfOz5tZBV3AqnGJ37
	 AkHkZPtEfhJU+WU+tWgk2Ug6+d9PXdoDBnZtKaMRNnQvgc6gOh6WzgQGIsnMGG8vih
	 oR/uj2xdHGU8jqPDFk+wEZo3O+KuG2Q9D4/q3JeXQmQSYTJfy5KRO6vlq6A7UTzpMB
	 O/3vpWAUJQPVQ==
Date: Thu, 1 Oct 2026 15:36:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, Gautam Gala <ggala@linux.ibm.com>, 
	Hariharan Mari <hari55@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, 
	Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault
 handler
Message-ID: <ar5udQI9qDAtYrGi@gremlin>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
 <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
 <e1569c6e-94df-4609-8d94-d6319b4171cf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1569c6e-94df-4609-8d94-d6319b4171cf@app.fastmail.com>

On Thu, Oct 01, 2026 at 03:35:37PM +0200, Arnd Bergmann wrote:
> Another ones: after 34cfa9b3af17 ("KVM: arm64: Implement
> KVM_PRE_FAULT_MEMORY"), we are now missing a kvm_arch_pre_fault_allowed()
> definition in arch/s390/kvm/arm64/mmu.c:
>
> ERROR: modpost: arch/s390/kvm/arm64/kvm-arm64.ko: symbol 'kvm_arch_pre_fault_allowed' undefined!
>
> I copied the arm64 version without the pkvm reference to make it
> build for me.
>
>      Arnd
>
> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> index 7ee157c61d70..be16351acaae 100644
> --- a/arch/s390/kvm/arm64/mmu.c
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -179,6 +179,14 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>
> +int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> +{
> +	if (!kvm_vcpu_initialized(vcpu))
> +		return -ENOEXEC;
> +
> +	return 0;
> +}
> +

Ah the s390 <-> kvm emulation stuff.

Yep if it's meant to behave like arm64 then that should be correct.

It's odd to me that pre-faulting was not previously implemented for actual-arm64
but was added as part of the virtualised s390/arm64 thing automatically :)

Not sure if this implementation requires what s390 does with:

+int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
+{
+       if (kvm_is_ucontrol(vcpu->kvm))
+               return -EINVAL;
+
+       return 0;
+}

Or both conditions? One for the s390 guys.

--
Cheers, Lorenzo
