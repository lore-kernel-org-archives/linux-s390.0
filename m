Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA433630B3;
	Mon,  1 Jun 2026 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352619; cv=none; b=Nuqs5OlVfLFfD0LuT5e5Co/1jZWGy7mqrJZf4MYWhwf73Khevqgi0JK7r+lJQ1k9bh+PbnohK+Ce5TFEZB8pqO1ggCGr2YbuxYBowu7glWjBr4tjuZB0mJYp7hzuHzx343RglfaF94GfZjMo+FdJagKx53TZ26FrAANUc+P2Xjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352619; c=relaxed/simple;
	bh=lKZ/LT2s+nn8b+E3EKUra0T3ss6ixwVHPsJhHO4LZo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9iexV5vooch9Q5B/k2pg9xI8HFz/e4bTP3lWd89hbpq36zed8gEKK3DhaxpVBOMJG6kaWMCqpyxezO8LNjP1p8qv3Q3xH/fZ+RTMUiZii9f4sVHvCXZrT+Qfuhg2NIPLtx0dGcDiv02RECr2IEwX54bSunzDh7L11ERb8nOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLo8azV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLo8azV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8068A1F00893;
	Mon,  1 Jun 2026 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352617;
	bh=l3QcFHlEvcjj6MiNyJMZ0YIhRNNN88+mlPp+PR6ZG3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLo8azV+HKDO7n7o3OMo/wuuHzrw6nU083rl17z/EwmSElqD27QQIxGNjDUyLjImi
	 bODiBHUObrVmDMaJoU/7jC3v6F7cH9AGZO5U7EPvQlXOao4SRcdTnNfSfJfE601iSk
	 jHOVp181+depQL+AlaX+nmY8+Gtbv/TyjwomyAx/lVwjYpa+/wwVYPiD9a3Ee7zaVn
	 QLxoNxTGxs/Xl32RcO3BRp8Y1kBD/wIY3K3nS9+B+7RK7WcjUIdAALeqHhzKGUvpuj
	 N4CkTjuJDYzKStH0LpItdOH6H1tjoMDN72kOe1fC+KqCQ7d0KAun1jAQDMBSJ7MUQc
	 UnUMIQ465WaUQ==
Date: Mon, 1 Jun 2026 15:23:36 -0700
From: Oliver Upton <oupton@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 12/26] KVM: arm64: Add PVM_ prefix to avoid name
 collisions
Message-ID: <ah4GaFNM7xfS7CJC@kernel.org>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-13-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529155601.2927240-13-seiden@linux.ibm.com>

On Fri, May 29, 2026 at 05:55:45PM +0200, Steffen Eiden wrote:
> Rename ID_UNALLOCATED to PVM_ID_UNALLOCATED and read_id_reg to
> pvm_read_id_reg to prevent future name collisions with other subsystems.
> While at it, fix whitespace issues in the macro invocations
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

No issues with the rename but do you even need the nVHE object at all
for s390?

Thanks,
Oliver

> ---
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c | 48 +++++++++++++++---------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> index e8d773d38905..08b14053568b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> +++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> @@ -282,8 +282,8 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>  	inject_sync64(vcpu, (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT));
>  }
>  
> -static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> -		       struct sys_reg_desc const *r)
> +static u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu,
> +			   struct sys_reg_desc const *r)
>  {
>  	struct kvm *kvm = vcpu->kvm;
>  	u32 reg = reg_to_encoding(r);
> @@ -341,7 +341,7 @@ static bool pvm_access_id_aarch64(struct kvm_vcpu *vcpu,
>  		return false;
>  	}
>  
> -	p->regval = read_id_reg(vcpu, r);
> +	p->regval = pvm_read_id_reg(vcpu, r);
>  	return true;
>  }
>  
> @@ -379,7 +379,7 @@ static bool pvm_idst_access(struct kvm_vcpu *vcpu,
>   * register with encoding Op0=3, Op1=0, CRn=0, CRm=crm, Op2=op2
>   * (1 <= crm < 8, 0 <= Op2 < 8).
>   */
> -#define ID_UNALLOCATED(crm, op2) {			\
> +#define PVM_ID_UNALLOCATED(crm, op2) {			\
>  	Op0(3), Op1(0), CRn(0), CRm(crm), Op2(op2),	\
>  	.access = pvm_access_id_aarch64,		\
>  }
> @@ -438,46 +438,46 @@ static const struct sys_reg_desc pvm_sys_reg_descs[] = {
>  	AARCH32(SYS_MVFR0_EL1),
>  	AARCH32(SYS_MVFR1_EL1),
>  	AARCH32(SYS_MVFR2_EL1),
> -	ID_UNALLOCATED(3,3),
> +	PVM_ID_UNALLOCATED(3, 3),
>  	AARCH32(SYS_ID_PFR2_EL1),
>  	AARCH32(SYS_ID_DFR1_EL1),
>  	AARCH32(SYS_ID_MMFR5_EL1),
> -	ID_UNALLOCATED(3,7),
> +	PVM_ID_UNALLOCATED(3, 7),
>  
>  	/* AArch64 ID registers */
>  	/* CRm=4 */
>  	AARCH64(SYS_ID_AA64PFR0_EL1),
>  	AARCH64(SYS_ID_AA64PFR1_EL1),
>  	AARCH64(SYS_ID_AA64PFR2_EL1),
> -	ID_UNALLOCATED(4,3),
> +	PVM_ID_UNALLOCATED(4, 3),
>  	AARCH64(SYS_ID_AA64ZFR0_EL1),
> -	ID_UNALLOCATED(4,5),
> -	ID_UNALLOCATED(4,6),
> -	ID_UNALLOCATED(4,7),
> +	PVM_ID_UNALLOCATED(4, 5),
> +	PVM_ID_UNALLOCATED(4, 6),
> +	PVM_ID_UNALLOCATED(4, 7),
>  	AARCH64(SYS_ID_AA64DFR0_EL1),
>  	AARCH64(SYS_ID_AA64DFR1_EL1),
> -	ID_UNALLOCATED(5,2),
> -	ID_UNALLOCATED(5,3),
> +	PVM_ID_UNALLOCATED(5, 2),
> +	PVM_ID_UNALLOCATED(5, 3),
>  	AARCH64(SYS_ID_AA64AFR0_EL1),
>  	AARCH64(SYS_ID_AA64AFR1_EL1),
> -	ID_UNALLOCATED(5,6),
> -	ID_UNALLOCATED(5,7),
> +	PVM_ID_UNALLOCATED(5, 6),
> +	PVM_ID_UNALLOCATED(5, 7),
>  	AARCH64(SYS_ID_AA64ISAR0_EL1),
>  	AARCH64(SYS_ID_AA64ISAR1_EL1),
>  	AARCH64(SYS_ID_AA64ISAR2_EL1),
> -	ID_UNALLOCATED(6,3),
> -	ID_UNALLOCATED(6,4),
> -	ID_UNALLOCATED(6,5),
> -	ID_UNALLOCATED(6,6),
> -	ID_UNALLOCATED(6,7),
> +	PVM_ID_UNALLOCATED(6, 3),
> +	PVM_ID_UNALLOCATED(6, 4),
> +	PVM_ID_UNALLOCATED(6, 5),
> +	PVM_ID_UNALLOCATED(6, 6),
> +	PVM_ID_UNALLOCATED(6, 7),
>  	AARCH64(SYS_ID_AA64MMFR0_EL1),
>  	AARCH64(SYS_ID_AA64MMFR1_EL1),
>  	AARCH64(SYS_ID_AA64MMFR2_EL1),
> -	ID_UNALLOCATED(7,3),
> -	ID_UNALLOCATED(7,4),
> -	ID_UNALLOCATED(7,5),
> -	ID_UNALLOCATED(7,6),
> -	ID_UNALLOCATED(7,7),
> +	PVM_ID_UNALLOCATED(7, 3),
> +	PVM_ID_UNALLOCATED(7, 4),
> +	PVM_ID_UNALLOCATED(7, 5),
> +	PVM_ID_UNALLOCATED(7, 6),
> +	PVM_ID_UNALLOCATED(7, 7),
>  
>  	/* Scalable Vector Registers are restricted. */
>  
> -- 
> 2.53.0
> 
