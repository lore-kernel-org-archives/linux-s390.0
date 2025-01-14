Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967C1ADC82;
	Tue, 14 Jan 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857413; cv=none; b=VGGxh6VDussaziFpEVPrKB/cOGuvw1773n0Umu4BiYFAn/BUlgUFiLDojLHKKKeLooX2pSOL+suCC+738yCWBrMFvab0Da/IvnFXzc/fAvwTV37IdVpsDAmzrQPBmMbhQTchbevt+jWBTw2qoXdMcnTDHzrse455nFjcUOx4MYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857413; c=relaxed/simple;
	bh=uZbeWpR7F3CQJPFb3oVT934UHIdqxBOZIzdhmyPMRyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcDlZKmXc70sd7YNnbfSO62wBDrBS5EulqO16VcOSAmNbuSjOHeOaiNn9c/ZpCy4ncPUNWd/6h5z93JLIXCGwUpqYgZxITMU1DLVExjGrbskrKw6bA64xNZHTbjxr5/q13WCR5b0zdb5ja7W3rGn1Rh2qgkjv/2XlOZquDQa7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB2511FB;
	Tue, 14 Jan 2025 04:23:59 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0623F66E;
	Tue, 14 Jan 2025 04:23:28 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4 5/6] s390/crash: Use note name macros
Message-ID: <Z4ZXPp76UiLtBCLA@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-5-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-5-b3841fa0dcd9@daynix.com>

Hi,

On Sat, Jan 11, 2025 at 02:48:48PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(I'm not in a position to test this, though.)

> ---
>  arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cd0c93a8fb8b..022f4f198edf 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -248,15 +248,6 @@ bool is_kdump_kernel(void)
>  }
>  EXPORT_SYMBOL_GPL(is_kdump_kernel);
>  
> -static const char *nt_name(Elf64_Word type)
> -{
> -	const char *name = "LINUX";
> -
> -	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
> -		name = KEXEC_CORE_NOTE_NAME;
> -	return name;
> -}
> -
>  /*
>   * Initialize ELF note
>   */
> @@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
>  	return PTR_ADD(buf, len);
>  }
>  
> -static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
> -{
> -	return nt_init_name(buf, type, desc, d_len, nt_name(type));
> -}
> +#define nt_init(buf, type, desc) \
> +	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type)
>  
>  /*
>   * Calculate the size of ELF note
> @@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
>  	return size;
>  }
>  
> -static inline size_t nt_size(Elf64_Word type, int d_len)
> -{
> -	return nt_size_name(d_len, nt_name(type));
> -}
> +#define nt_size(type, desc) nt_size_name(sizeof(desc), NN_ ## type)
>  
>  /*
>   * Fill ELF notes for one CPU with save area registers
> @@ -324,18 +310,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
>  	memcpy(&nt_fpregset.fpc, &sa->fpc, sizeof(sa->fpc));
>  	memcpy(&nt_fpregset.fprs, &sa->fprs, sizeof(sa->fprs));
>  	/* Create ELF notes for the CPU */
> -	ptr = nt_init(ptr, NT_PRSTATUS, &nt_prstatus, sizeof(nt_prstatus));
> -	ptr = nt_init(ptr, NT_PRFPREG, &nt_fpregset, sizeof(nt_fpregset));
> -	ptr = nt_init(ptr, NT_S390_TIMER, &sa->timer, sizeof(sa->timer));
> -	ptr = nt_init(ptr, NT_S390_TODCMP, &sa->todcmp, sizeof(sa->todcmp));
> -	ptr = nt_init(ptr, NT_S390_TODPREG, &sa->todpreg, sizeof(sa->todpreg));
> -	ptr = nt_init(ptr, NT_S390_CTRS, &sa->ctrs, sizeof(sa->ctrs));
> -	ptr = nt_init(ptr, NT_S390_PREFIX, &sa->prefix, sizeof(sa->prefix));
> +	ptr = nt_init(ptr, PRSTATUS, nt_prstatus);
> +	ptr = nt_init(ptr, PRFPREG, nt_fpregset);
> +	ptr = nt_init(ptr, S390_TIMER, sa->timer);
> +	ptr = nt_init(ptr, S390_TODCMP, sa->todcmp);
> +	ptr = nt_init(ptr, S390_TODPREG, sa->todpreg);
> +	ptr = nt_init(ptr, S390_CTRS, sa->ctrs);
> +	ptr = nt_init(ptr, S390_PREFIX, sa->prefix);
>  	if (cpu_has_vx()) {
> -		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
> -			      &sa->vxrs_high, sizeof(sa->vxrs_high));
> -		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
> -			      &sa->vxrs_low, sizeof(sa->vxrs_low));
> +		ptr = nt_init(ptr, S390_VXRS_HIGH, sa->vxrs_high);
> +		ptr = nt_init(ptr, S390_VXRS_LOW, sa->vxrs_low);
>  	}
>  	return ptr;
>  }
> @@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
>  	struct save_area *sa = NULL;
>  	size_t size;
>  
> -	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
> -	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
> -	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
> -	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
> -	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
> -	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
> -	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
> +	size =	nt_size(PRSTATUS, struct elf_prstatus);
> +	size += nt_size(PRFPREG, elf_fpregset_t);
> +	size += nt_size(S390_TIMER, sa->timer);
> +	size += nt_size(S390_TODCMP, sa->todcmp);
> +	size += nt_size(S390_TODPREG, sa->todpreg);
> +	size += nt_size(S390_CTRS, sa->ctrs);
> +	size += nt_size(S390_PREFIX, sa->prefix);
>  	if (cpu_has_vx()) {
> -		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
> -		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
> +		size += nt_size(S390_VXRS_HIGH, sa->vxrs_high);
> +		size += nt_size(S390_VXRS_LOW, sa->vxrs_low);
>  	}
>  
>  	return size;
> @@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
>  	memset(&prpsinfo, 0, sizeof(prpsinfo));
>  	prpsinfo.pr_sname = 'R';
>  	strcpy(prpsinfo.pr_fname, "vmlinux");
> -	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
> +	return nt_init(ptr, PRPSINFO, prpsinfo);
>  }
>  
>  /*
> @@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
>  	/* PT_NOTES */
>  	size += sizeof(Elf64_Phdr);
>  	/* nt_prpsinfo */
> -	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
> +	size += nt_size(PRPSINFO, struct elf_prpsinfo);
>  	/* regsets */
>  	size += get_cpu_cnt() * get_cpu_elf_notes_size();
>  	/* nt_vmcoreinfo */
> 
> -- 
> 2.47.1
> 
> 
