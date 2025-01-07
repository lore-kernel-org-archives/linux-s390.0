Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC917B50A;
	Tue,  7 Jan 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266678; cv=none; b=f7dAGT+IdjNRDkiuPhoxBIRGOV9AHt3pxPWSUWeiWFWb2pY+Z5jAD/SEv2wR7+jUjQICRODeUpmkkcOLRQVDgl1Kemk9b70PpcdbHNSwM4hExBrm4SVB9o3gOob98ELGisDgUrK3vyguxkzXGJM9E9Iz5zhQ0K/jcsVCHXoSmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266678; c=relaxed/simple;
	bh=NM2EcyNIVc1ZahKtXkc9ZQlgiuOoW42u7SuDt/ozCdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBeavfrGJXzyOPMFguucBUmd73pMV+7AmIn/JoSLmZ4vQeTUsg8Q+OupFHKdDma6DwcABos4jzl9XIQ081S1vaEbXDSBkW0zYeJsvr26ehF1pJhiyutegRMfBQY7C9aUcqy7717ENhjeOOnWYBLCfi9k6V7c0oD67p3J8/uzpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955311424;
	Tue,  7 Jan 2025 08:18:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FDFC3F59E;
	Tue,  7 Jan 2025 08:17:52 -0800 (PST)
Date: Tue, 7 Jan 2025 16:17:43 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
Message-ID: <Z31Tp0nMhb/ntUW0@e133380.arm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-elf-v3-5-99cb505b1ab2@daynix.com>

Hi,

On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c

[...]

> @@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
>  	return PTR_ADD(buf, len);
>  }
>  
> -static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
> -{
> -	return nt_init_name(buf, type, desc, d_len, nt_name(type));
> -}
> +#define NT_INIT(buf, type, desc) \
> +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))

Nit: this macro name clashes with the naming scheme in elf.h.

I think that there is a (weak) convention that macros with upper-case
names don't expand to a C function call; thus, a macro with an upper-
case name can be invoked in places where a C function call would not be
allowed.  (This convention is not followed everywhere, though -- it's
up to the maintainer what they prefer here.)

(Note also, the outer parentheses and the parentheses around (buf)
appear redundant -- although harmless?)

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
> +#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))

Nit: name prefix clash (again); possibly redundant parentheses.

[...]

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
> +	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
> +	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
> +	size +=  NT_SIZE(S390_TIMER, sa->timer);
> +	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
> +	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
> +	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
> +	size +=  NT_SIZE(S390_PREFIX, sa->prefix);

It might be worth fixing the funny spacing on these lines, since all
the affected lines are being replaced.

>  	if (cpu_has_vx()) {
> -		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
> -		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
> +		size += NT_SIZE(S390_VXRS_HIGH, sa->vxrs_high);
> +		size += NT_SIZE(S390_VXRS_LOW, sa->vxrs_low);
>  	}
>  
>  	return size;
> @@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
>  	memset(&prpsinfo, 0, sizeof(prpsinfo));
>  	prpsinfo.pr_sname = 'R';
>  	strcpy(prpsinfo.pr_fname, "vmlinux");
> -	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
> +	return NT_INIT(ptr, PRPSINFO, prpsinfo);
>  }
>  
>  /*
> @@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
>  	/* PT_NOTES */
>  	size += sizeof(Elf64_Phdr);
>  	/* nt_prpsinfo */
> -	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
> +	size += NT_SIZE(PRPSINFO, struct elf_prpsinfo);
>  	/* regsets */
>  	size += get_cpu_cnt() * get_cpu_elf_notes_size();
>  	/* nt_vmcoreinfo */

Otherwise, this looks sensible to me.

Cheers
---Dave
