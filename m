Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2BC20F97E;
	Tue, 14 Jan 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857375; cv=none; b=gldX955U3uONV4V5eQYKptsp62qniwFp/AdGsnDmiTeJW7/oIgodSHhs8ct5VpOWWAxqLfLIpTBpiw4evJc5CkrNYdg4LUjnfwrpM4wsq/j4IzA4dIXBVGaUatvKENws8KTIHHqJGa82bVIiep7HsstpU8Gx5GFE8nFscJgKZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857375; c=relaxed/simple;
	bh=5gvFFC+e6YZws5ZYcSYXr+q6qind2KNWWJNaAqN8Wr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inj+xBE1ZgeNoweiRmhv+J0Pe7s3/CLBy19FOQlwEtrmiw5cPRJD4iijV2wN2X5IWI2gCUv6/aqpuTRRmphjWYRljDVp8mXJ5wLwVtnFXQkOK1THBK8nbVheR0UWWzJACg2bIw7Be+v/CUEO6Jc1P2QBVfWJp5ZTObM8LXpP9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9524A12FC;
	Tue, 14 Jan 2025 04:23:21 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035FE3F66E;
	Tue, 14 Jan 2025 04:22:50 -0800 (PST)
Date: Tue, 14 Jan 2025 12:22:48 +0000
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
	devel@daynix.com
Subject: Re: [PATCH v4 2/6] binfmt_elf: Use note name macros
Message-ID: <Z4ZXGN6C9J/jibD4@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-2-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-2-b3841fa0dcd9@daynix.com>

On Sat, Jan 11, 2025 at 02:48:45PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  fs/binfmt_elf.c       | 21 ++++++++++-----------
>  fs/binfmt_elf_fdpic.c |  8 ++++----
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 106f0e8af177..5b4a92e5e508 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -762,8 +762,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
>  }
>  
>  #define NOTE_DATA_SZ SZ_1K
> -#define GNU_PROPERTY_TYPE_0_NAME "GNU"
> -#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
> +#define NOTE_NAME_SZ (sizeof(NN_GNU_PROPERTY_TYPE_0))
>  
>  static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>  				struct arch_elf_state *arch)
> @@ -800,7 +799,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>  	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
>  	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
>  	    strncmp(note.data + sizeof(note.nhdr),
> -		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
> +		    NN_GNU_PROPERTY_TYPE_0, n - sizeof(note.nhdr)))
>  		return -ENOEXEC;
>  
>  	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
> @@ -1603,14 +1602,14 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
>  	do
>  		i += 2;
>  	while (auxv[i - 2] != AT_NULL);
> -	fill_note(note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
> +	fill_note(note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
>  }
>  
>  static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>  		const kernel_siginfo_t *siginfo)
>  {
>  	copy_siginfo_to_external(csigdata, siginfo);
> -	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> +	fill_note(note, NN_SIGINFO, NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }
>  
>  /*
> @@ -1706,7 +1705,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  	}
>  
>  	size = name_curpos - (char *)data;
> -	fill_note(note, "CORE", NT_FILE, size, data);
> +	fill_note(note, NN_FILE, NT_FILE, size, data);
>  	return 0;
>  }
>  
> @@ -1767,7 +1766,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  	regset_get(t->task, &view->regsets[0],
>  		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
>  
> -	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
> +	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS,
>  		  PRSTATUS_SIZE, &t->prstatus);
>  	info->size += notesize(&t->notes[0]);
>  
> @@ -1801,7 +1800,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  		if (is_fpreg)
>  			SET_PR_FPVALID(&t->prstatus);
>  
> -		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
> +		fill_note(&t->notes[note_iter], is_fpreg ? NN_PRFPREG : "LINUX",
>  			  note_type, ret, data);
>  
>  		info->size += notesize(&t->notes[note_iter]);
> @@ -1821,7 +1820,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  	fill_prstatus(&t->prstatus.common, p, signr);
>  	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
>  
> -	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
> +	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
>  		  &(t->prstatus));
>  	info->size += notesize(&t->notes[0]);
>  
> @@ -1832,7 +1831,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  	}
>  
>  	t->prstatus.pr_fpvalid = 1;
> -	fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
> +	fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(*fpu), fpu);
>  	info->size += notesize(&t->notes[1]);
>  
>  	return 1;
> @@ -1852,7 +1851,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>  	if (!psinfo)
>  		return 0;
> -	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
> +	fill_note(&info->psinfo, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
>  
>  #ifdef CORE_DUMP_USE_REGSET
>  	view = task_user_regset_view(dump_task);
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index f1a7c4875c4a..96bd9d2f23d7 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1397,7 +1397,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
>  	regset_get(p, &view->regsets[0],
>  		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
>  
> -	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
> +	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
>  		  &t->prstatus);
>  	t->num_notes++;
>  	*sz += notesize(&t->notes[0]);
> @@ -1415,7 +1415,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
>  	}
>  
>  	if (t->prstatus.pr_fpvalid) {
> -		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
> +		fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(t->fpu),
>  			  &t->fpu);
>  		t->num_notes++;
>  		*sz += notesize(&t->notes[1]);
> @@ -1530,7 +1530,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>  	 */
>  
>  	fill_psinfo(psinfo, current->group_leader, current->mm);
> -	fill_note(&psinfo_note, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
> +	fill_note(&psinfo_note, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
>  	thread_status_size += notesize(&psinfo_note);
>  
>  	auxv = (elf_addr_t *) current->mm->saved_auxv;
> @@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>  	do
>  		i += 2;
>  	while (auxv[i - 2] != AT_NULL);
> -	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
> +	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
>  	thread_status_size += notesize(&auxv_note);
>  
>  	offset = sizeof(*elf);				/* ELF header */
> 
> -- 
> 2.47.1
> 
> 
