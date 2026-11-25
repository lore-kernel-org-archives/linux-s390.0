Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616366;
	b=bg6OJNTVIj6j+kYe25ZdGq6te4SBHaGUaVH4c2g0YYTHozGTHFsx+uY42ybuTMGdT5Vt
	 kQClezzux2FJvp3pSYgvFkBDYxe3OULA1aWmdgwDoCNAZRRRcPmeBYW80FmhXvuT/P+by
	 +aueuMZaxN10rJqI5B5QtWCnDL95jluVthp2WdsRceaHObfLnjTNyfkqNhTRrnzHaZuAM
	 +b550o1wk80AW6PBWprEbYC/KtXK5scPB9ZL0kmIBL6D3iCsoLZQRgaFeXUksdvTSfyM6
	 UxD96yAtutRVJG8rag4R/EIAsZ6ZJ8SuwWwFqQh9M6oXy5hRjNLR8Wg9nMnUWjNVcTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616366;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Uw51BNnNSMZkfcts9aiEFizxk6Nl2DC+AS1z+RPufIo=;
	b=xuySv8o0kS3fJbEO1v7IT5ax9Itajx4N6+KXqTuj0e735eTlipAGyrw39x3uSYwb+EjU
	 nZNrdZCwLRBp6X1Js//n59zuaYsD5tc5aR0ag9IVeVw4uYtRSKvc4vj5ObvRxv7seIFYQ
	 nv6CZ6JqbcB1X0Lnv2EjBhS1d4JTK8tBuowAA+AjxLtQS/+D4ElAM7bkNo5b9otyeO+xX
	 kTXI2sYeB9s4Tyn1B36uoAdJW/cAWd9ow/YLu+3l6oljQmRGix8qcm+dMoB7eZH/Aonk+
	 8gOXDiXzcTJsYobh0n+SVcgGFJ9/jvCw2Rc15hwBPuoV+i4YSTfxisWKYc028Ix2ROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CWOkp8F7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1662606A31E;
	Wed, 25 Nov 2026 14:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1662606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CWOkp8F7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46AD32F;
	Wed, 25 Nov 2026 06:19:22 -0800 (PST)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D1D03F763;
	Wed, 25 Nov 2026 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795616365; bh=zOuTUXAl5Me8B3Bviry0NGcs0zsjWzErFF7qo9A3aGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWOkp8F7fQmWiAUNbgy+iHiUf8mWp+DIO06axxeCI11H+sQ6pnGd+zxvlgwqzB9hj
	 1dmzmWI6vwm1F1TraqVf1cvJPFRIjM7bW54/QNRJWGi2SEwtorVa+EspH4/ZJdZY7V
	 58m2h8ivwmNm/x1k+jTPsSn1HB7ERn1w+30/1qdw=
Date: Wed, 25 Nov 2026 14:19:15 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 03/23] arm64: sysreg: Convert OSLSR to automatic
 register generation
Message-ID: <awbuY0mETtZ_mQh3@e143914.arm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>

Hi,

On Fri, Nov 06, 2026 at 05:07:36PM +0100, Steffen Eiden wrote:
> Convert OSLSR to automatic register generation as per DDI0601. As
> OSLSR_OLSM is a composite field using bit 0 and bit 3 the combined
> values are still defined manually. While at it rename
> OSLSR_EL1_OSLM_IMPLEMENTED to OSLSR_EL1_OSLM_IMP to be consistent with
> the rest of the system register values.
> 
> No functional changes.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Need to do the Sashiko suggestion, it does fail to build.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

> ---
>  arch/arm64/include/asm/sysreg.h | 12 +++++++-----
>  arch/arm64/kvm/sys_regs.c       |  2 +-
>  arch/arm64/tools/sysreg         | 14 ++++++++++++++
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e3b60ee03023..2ec9ba9cd896 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -186,11 +186,13 @@
>  #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
>  #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
>  
> -#define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
> -#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
> -#define OSLSR_EL1_OSLM_NI		0
> -#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
> -#define OSLSR_EL1_OSLK			BIT(1)
> +#define OSLSR_EL1_OSLM_MASK (OSLSR_EL1_OSLM0_MASK | OSLSR_EL1_OSLM1_MASK)
> +#define OSLSR_EL1_OSLM_NI						\
> +	((OSLSR_EL1_OSLM1_NI << OSLSR_EL1_OSLM1_SHIFT) |		\
> +	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))
> +#define OSLSR_EL1_OSLM_IMP						\
> +	((OSLSR_EL1_OSLM1_IMP << OSLSR_EL1_OSLM1_SHIFT) |		\
> +	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))
>  
>  #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
>  #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 2b28b929f9f3..8c91de6a4097 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3309,7 +3309,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
>  	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
>  	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
> -		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
> +		OSLSR_EL1_OSLM_IMP, .set_user = set_oslsr_el1, },
>  	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
>  	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
>  	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 997c62ab72e6..5d38f115bac1 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -122,6 +122,20 @@ Res0	63:1
>  Field	0	OSLK
>  EndSysreg
>  
> +Sysreg	OSLSR_EL1	2	0	1	1	4
> +Res0	63:4
> +UnsignedEnum	3	OSLM1
> +	 0b0	NI
> +	 0b1	IMP
> +EndEnum
> +UnsignedEnum	2	nTT
> +EndEnum
> +Field	1	OSLK
> +UnsignedEnum	0	OSLM0
> +	 0b0	VAL_0
> +EndEnum
> +EndSysreg
> +
>  Sysreg	SPMACCESSR_EL1	2	0	9	13	3
>  UnsignedEnum	63:62	P31
>  	0b00	TRAP_RW
> 
> -- 
> 2.56.0
> 
