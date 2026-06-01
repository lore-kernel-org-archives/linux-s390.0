Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516037F006;
	Mon,  1 Jun 2026 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352758; cv=none; b=cnC1Qtmc16QUji9onK+X8PFVe3wwpzCiN2levNbuRlp2SwEMZhNp9WSmvzip0szAYU3ZgMGG2KMHvhBDGaronxhspyTWtvs9wYNuVU/0rZjwFu86tcsEPGi72CGXrDD5HzDsr5Jov/5noAz8sWQZUWGVhmi+3O938FVjFoEkrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352758; c=relaxed/simple;
	bh=fjobrbtuKYgCrdGYVlRFQncubNK6apBUCBI2STV6AzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhIj/s9zXJ0mIWu5J7rXPhewlBbNvlEsRiXPiFTmfehXzBICcpzBtBAt04vbYxQ6cNdKPtglmtLtrBfh8yfMGh9idOJ2oXxtIhLwkeKPctnGOgtckY7IP6ZQVmcM+PhBz59ESYcSAxxn6XDuFadT0xxjfGay5Qt0aPuzSpL3IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX1jJ9z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX1jJ9z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BE1F00893;
	Mon,  1 Jun 2026 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352756;
	bh=O2qKexwHvz3KRPtLvli9oqJZOU4toPFHhWC4yeROzbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gX1jJ9z91LC+/qmrlP8VPboWqw8SsdjZktFpR99yh5czC27sSEqQ68cUslcSwG13b
	 BC2298F3sEps6D/HmGxaR7tc8J+24iEeDY2jd3faxV/fKM1VXzMWrVp88zYzPMJQ9Q
	 tAd5fi5JCxIOGU51f8hcYDLA7myI9yh70R4in3HTua2s1nwLtx/U/D6wAZCrsuMbw6
	 GYhjM83oUEYn3u3WGjFW9KVBv2fib1fqri0AMcTk0906OnqEvnC4KgpN0bYCPZ8vP7
	 qeKjIHcIVx/pytLeKSV/RR95JDuM3s1FzE93jI+FUAugg+QDJI5WeHSSc3ZlhwqpHD
	 je+ci9vVbbOeA==
Date: Mon, 1 Jun 2026 15:25:55 -0700
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
Subject: Re: [PATCH v1 15/26] s390: Add functions to query arm guest time
Message-ID: <ah4G847iT_pPRuQm@kernel.org>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-16-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529155601.2927240-16-seiden@linux.ibm.com>

On Fri, May 29, 2026 at 05:55:48PM +0200, Steffen Eiden wrote:
> Add functions to convert between ARM guest time (LSB0) and s390 host
> time (MSB0) using new ptff function codes.
> 
> Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/timex.h | 49 +++++++++++++++++++++++++++++++++++
>  arch/s390/kernel/time.c       |  1 +
>  arch/s390/kvm/arm64/arm.c     |  9 ++++++-
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
> index 49447b40f038..9ec22a28bbda 100644
> --- a/arch/s390/include/asm/timex.h
> +++ b/arch/s390/include/asm/timex.h
> @@ -99,6 +99,8 @@ extern unsigned char ptff_function_mask[16];
>  #define PTFF_QSI	0x02	/* query steering information */
>  #define PTFF_QPT	0x03	/* query physical clock */
>  #define PTFF_QUI	0x04	/* query UTC information */
> +#define PTFF_QAGTO	0x10	/* query arm guest time offset */
> +#define PTFF_QAGPT	0x11	/* query arm guest physical time offset */

Are these analogous to CNTVOFF_EL2 and CNTPOFF_EL2?

Thanks,
Oliver 

>  #define PTFF_ATO	0x40	/* adjust tod offset */
>  #define PTFF_STO	0x41	/* set tod offset */
>  #define PTFF_SFS	0x42	/* set fine steering rate */
> @@ -136,6 +138,17 @@ struct ptff_qui {
>  	unsigned int pad_0x5c[41];
>  } __packed;
>  
> +/*
> + * Query Arm Guest Time
> + * used for:
> + *	- Query Arm Guest Time Offset
> + *	- Query Arm Guest Physical Time
> + */
> +struct ptff_qagt {
> +	u64 in;
> +	u64 out;
> +};
> +
>  /*
>   * ptff - Perform timing facility function
>   * @ptff_block: Pointer to ptff parameter block
> @@ -286,4 +299,40 @@ static inline int tod_after_eq(unsigned long a, unsigned long b)
>  	return a >= b;
>  }
>  
> +/*
> + * ptff_qagto() -  Query Arm Guest Time Offset
> + *
> + * @physical_time: Arm guest physical time in MSb 0
> + *
> + * Converts Arm guest physical time in MSb 0 bit ordering
> + * into the Arm guest offset in LSb 0 bit ordering.
> + *
> + * Return: Arm guest time offset in LSb 0
> + */
> +static inline u64 ptff_qagto(u64 physical_time)
> +{
> +	struct ptff_qagt qagto = { .in = physical_time };
> +
> +	ptff(&qagto, sizeof(qagto), PTFF_QAGTO);
> +	return qagto.out;
> +}
> +
> +/*
> + * ptff_qagpt() - Query Arm Guest Physical Time
> + *
> + * @guest_time_offset: Arm guest time offset in MSb 0
> + *
> + * Converts Arm guest offset in MSb 0 bit ordering
> + * into the Arm guest physical time in LSb 0 bit ordering.
> + *
> + * Return: Arm guest physical time in LSb 0
> + * */
> +static inline u64 ptff_qagpt(u64 guest_time_offset)
> +{
> +	struct ptff_qagt qagpt = { .in = guest_time_offset };
> +
> +	ptff(&qagpt, sizeof(qagpt), PTFF_QAGPT);
> +	return qagpt.out;
> +}
> +
>  #endif
> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index bd0df61d1907..2b989bebd220 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -65,6 +65,7 @@ ATOMIC_NOTIFIER_HEAD(s390_epoch_delta_notifier);
>  EXPORT_SYMBOL(s390_epoch_delta_notifier);
>  
>  unsigned char ptff_function_mask[16];
> +EXPORT_SYMBOL(ptff_function_mask);
>  
>  static unsigned long lpar_offset;
>  static unsigned long initial_leap_seconds;
> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index bf0866659421..636bbeda98a8 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
> @@ -692,8 +692,15 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
>  
>  static int __init kvm_s390_arm64_init(void)
>  {
> -	if (!sclp.has_aef)
> +	if (!sclp.has_aef) {
> +		pr_info("SAE is not available\n");
>  		return -ENXIO;
> +	}
> +
> +	if (!(ptff_query(PTFF_QAGTO) && ptff_query(PTFF_QAGPT))) {
> +		pr_info("PTFF for arm on s390 is not available\n");
> +		return -ENXIO;
> +	}
>  
>  	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
>  				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
> -- 
> 2.53.0
> 
