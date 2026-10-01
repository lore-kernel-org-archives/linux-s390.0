Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800551C071;
	Thu,  1 Oct 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865600; cv=none; b=RCQm/YhtJNwIaZnEkaMBHgRCJEdrt30CXM/AyffvqrkdM/wFhgU9AlaJQqzDz3DgcZ9+uHf6sBDnvhOwLN47Ie+LrroqdU8SkwxMa+xz/2ez9QrlBjE0uPrOFyIxaBdxpXdvSH7sVOAeKwC6VBhKgIiQAaM4sNGugN4MP93yS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865600; c=relaxed/simple;
	bh=bpX6kvOMvsE3smFK0vsqbL4FwySxtPqXwLTy/Yyx7jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtWeGMIzmypJOo9Cms5hS3AqOgfDDFDvCRS3qjShac04My/peJaKYSbQQLEqNp0GscIAVTbAFq3eOuc7aJ4Pm/SaQABOeq4YVnMcDuDZY0iJuHp7SboZVLLqGFxtmbe6odvqDAHyUkPIW0zLk1alqd8md9dIStdSFuuSNe4C+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Z+ehIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Z+ehIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0887B1F000FF;
	Thu,  1 Oct 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865592;
	bh=zrZF9htcgFwurGelubRw2y+vGDbhNqUEY9ht2zIj3A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V2Z+ehITLzlytS6ExkwFAUw1ZyPlXGHmYqb/Cog99vNuqHH7pQPa327No2IEMqHlC
	 m5E+c1ikFUeLWiWJ9GPG/AXvfcFSfre/22sIJj4SCBEQkP6NFamqaySD/BcG6hmUH3
	 GiapTECNf1vZjqORXdj3e/tOeqC8HWTrCg5OV6lNYZno68RjPomjOqezvBIqn8lBLX
	 yJtHwR0QH7GZnmdHgm0tVsWrHyfxWr1jmRMbYNSCaxLBpAGAr7ApLvdzr5ztjoEUGs
	 bMKobLfCan0nCpOaFh1cgBQGqhZuGQXRpW3QVA/6vnSBcJtAiUNfvuxHK90BkTjZLD
	 ECbfNxiA3pAFw==
Date: Thu, 1 Oct 2026 15:39:41 +0100
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
Message-ID: <ar5wJRdtp6dogT6u@gremlin>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
 <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>

On Thu, Oct 01, 2026 at 02:10:06PM +0200, Arnd Bergmann wrote:
> Hi Steffen,
>
> [Adding Lorenzo Stoakes to Cc]
>
> I see this function fails to build on top of linux-next, as the
> kvm_vcpu_dabt_is_cm() function was removed by commit 18b94675b1fb
> ("KVM: arm64: Use ESR helpers in guest abort handling").
>
> I used this patch to make it build, but I'm not sure if this is
> the correct fix:
>
> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> index 3c1c8a2def73..7ee157c61d70 100644
> --- a/arch/s390/kvm/arm64/mmu.c
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -119,6 +119,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>  	write_fault = kvm_s390_cur_gmap_fault_is_write(vcpu);
>  	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> +		unsigned long esr = kvm_vcpu_get_esr(vcpu);
>  		ret = -ENOEXEC;
>  		/*
>  		 * The guest has put either its instructions or its page-tables
> @@ -143,7 +144,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		 * Check for a cache maintenance operation. Assume the guest is
>  		 * cautious and skip instruction
>  		 */
> -		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> +		if (kvm_is_error_hva(hva) && esr_dabt_is_cm(esr)) {
>  			kvm_incr_pc(vcpu);
>  			ret = 1;
>  			goto out_unlock;

Thanks for the report!

The original function was:

static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
{
	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_CM);
}

And esr_dabt_is_cm() is:

static __always_inline bool esr_dabt_is_cm(unsigned long esr)
{
	return esr & ESR_ELx_CM;
}

So looks good to me at a glance!

--
Cheers, Lorenzo
