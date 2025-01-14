Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2A20F97A;
	Tue, 14 Jan 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857387; cv=none; b=n4TIHhbdV9k4IYYamWjUT4S5rmCBHiZoq53NHNgzPcYhm5UGxlhadmH5dfaJOqhhtnkwX3QsdkBnDyk1kH1HY1JCXqWv5qdDgOvdzRpLzwNCQqBEboEu/4vJjGko50C5VEm5P+RAzzIWtX3GSPyQc+FB5yEXYHj9xnp9hp+0MSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857387; c=relaxed/simple;
	bh=ZzCXVRp7Y2M3i9IvKQXzgNgjDcvmGViTK4O3p/wxtMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSi0/ygZYyODjcQ4EyPMYvBubO05cV6q7zY3BhZyAAzbyFEUMrHag9qHYu/VEaTzluOoXIIOSfW6wpFHmEWMBp0+ac1H3BFmrLKiIygnmFOkXgSKyDJpwIVwu7MAHJdHmuIHoPdeVSsTXxPHIhuV6y/kp0SccGA/pHnhlRdAhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607DC1424;
	Tue, 14 Jan 2025 04:23:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2EDF3F66E;
	Tue, 14 Jan 2025 04:23:02 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:00 +0000
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
Subject: Re: [PATCH v4 3/6] powerpc: Use note name macros
Message-ID: <Z4ZXJAn2A5Tawy5/@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>

Hi,

On Sat, Jan 11, 2025 at 02:48:46PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.

Note, there seems to be some manual encoding of some arch-specific
notes in arch/powerpc/boot/addnote.c, but since this is all hard-coded
and the note types are not taken from elf.h anyway, I think this is
probably out of scope for this series.  I haven't tried to understand
fully what that code is doing.

Anyway:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/powerpc/kernel/fadump.c               | 2 +-
>  arch/powerpc/platforms/powernv/opal-core.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4b371c738213..d44349fe8e2b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -751,7 +751,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
>  	 * prstatus.pr_pid = ????
>  	 */
>  	elf_core_copy_regs(&prstatus.pr_reg, regs);
> -	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
> +	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
>  			      &prstatus, sizeof(prstatus));
>  	return buf;
>  }
> diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
> index c9a9b759cc92..a379ff86c120 100644
> --- a/arch/powerpc/platforms/powernv/opal-core.c
> +++ b/arch/powerpc/platforms/powernv/opal-core.c
> @@ -149,7 +149,7 @@ static Elf64_Word *__init auxv_to_elf64_notes(Elf64_Word *buf,
>  	/* end of vector */
>  	bufp[idx++] = cpu_to_be64(AT_NULL);
>  
> -	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
> +	buf = append_elf64_note(buf, NN_AUXV, NT_AUXV,
>  				oc_conf->auxv_buf, AUXV_DESC_SZ);
>  	return buf;
>  }
> @@ -252,7 +252,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  	 * crashing CPU's prstatus.
>  	 */
>  	first_cpu_note = buf;
> -	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
> +	buf = append_elf64_note(buf, NN_PRSTATUS, NT_PRSTATUS,
>  				&prstatus, sizeof(prstatus));
>  
>  	for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_per_thread) {
> @@ -279,7 +279,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  		fill_prstatus(&prstatus, thread_pir, &regs);
>  
>  		if (thread_pir != oc_conf->crashing_cpu) {
> -			buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
> +			buf = append_elf64_note(buf, NN_PRSTATUS,
>  						NT_PRSTATUS, &prstatus,
>  						sizeof(prstatus));
>  		} else {
> @@ -287,7 +287,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  			 * Add crashing CPU as the first NT_PRSTATUS note for
>  			 * GDB to process the core file appropriately.
>  			 */
> -			append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
> +			append_elf64_note(first_cpu_note, NN_PRSTATUS,
>  					  NT_PRSTATUS, &prstatus,
>  					  sizeof(prstatus));
>  		}
> 
> -- 
> 2.47.1
> 
> 
