Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BE39A057
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023186; cv=none; b=CMjkCSd46JKVGWOIgr+mnqLihyS7LFi+jqImiCqDF6RGV2okLernP62ucZpiwqaLHiBl2+gVcVMWhng9ZQDhIiGxGRhFKwqWQoDM3uuj3LJ2Jd138WV9XPZVjf7X1Ci2b6Q13SI7rLkmOJG75zLXr6d5XsVPFbPa4QJAPz+ACsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023186; c=relaxed/simple;
	bh=OG8nqpVIiVaUDqsBzlwBd7F+WF7t4IRbr3zHcFb5WRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+htayg+tlpiEvjcJOfZx0QWgJzks4vhyEX7ey9OzjTk7DtkXEoERLotwuAo1zB/LVuN1sxs7vJZE9SEa3RvLsObzNZsDY8PfZeh0ZvnCojkO4qbcCLoeJyJDbchTFkK/tOf9sgHfvYLxA6ZXJEHyCmRAXle3hpO0qimeGJFUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERQBxovg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERQBxovg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a5aad413so5654871a91.3
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789023178; x=1789627978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=ERQBxovgElPNzqrI4q5qwQ/NQeCCz0ZveLXjgzOJsg4d7n0jiouChI82la5qAJ7T0z
         U6E0Lq6tRszoQ5JZCTVw2q1DQKImfMwCYXJd0JGWC4SXbUU+SyS30bDesqNWu51dlzG0
         sUob9Upp1Qz/OvRqbouf+YSd+bn+Ha/oAsvEm+puakpJ9hjP/zr7Myw9FWJbm2Mnpy+q
         0B5eWS+pNtdrtyjzEU5mElqOZHn+7GDL0XhNimnkoPnMP8zSaoDYqqxatB/JuC+dI3RL
         SpbutMHh1eVhl14Rj1Bkjnk9Uclydn72Z6iDTwRIuCZvgporHTPtt2JXg83SJpi71mgB
         Wnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789023178; x=1789627978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=VR0Xdnm3BzLFlpmrcMWl1SOre4wqseqJcYzTyVJUn4U6XFivPghoryUd8UpDeOgGms
         qkAc4dM2Ty5ebfIcfVJp6CFJz6P7uVs1lrSuvSI3hS6LbqJgIGflfUj9R1vmmJzEn6v5
         exTkX2xKlrVctFJRt4AxBWdfebi1NxOO3XvaXPlJhzXTtXOMkbaOk0jU522TFAq/qHI4
         RJ1Xor6+h9mWXSDG8U5TcQ6muUghzNvpc8kMCdbAAV9OBPFul9kHCUmXOgT+1c/wAHQK
         LbR9rw/Kj2OjhL3Z3hmW+iY4nA+O/48GYMeingxFyCyMVSl1GLRw++Hr8xoksq8l2hCQ
         /O6w==
X-Forwarded-Encrypted: i=1; AKwUvBxBO0Z7i0WglU5lAEtf5gdFwk0dANqU6/as1lreaoh6AZxy8ghe7a44L3WyA9fTG02uCG6+wKQEAd0S@vger.kernel.org
X-Gm-Message-State: AFuF++k7sf7D6tiOSAkboOVI8+Xcol2yHjJizNWgr1Ih4KfJD86i+jc7
	NxzGdHyTlfA6Ov+B9SZkJ8aq094GlhFqScWV5Rc5nZvKjNw/1+WsVFEB
X-Gm-Gg: AYBFou2aiVM/j6gUxXKfJB6LejLJrYYzqavlHLhugsCPGpmKZwVXbR7Zq+ee9Xm6Qca
	LRMp3USTo4CKUP1NkuBrQMJepMi6cJIznJJ5Lb+xcGY114guR0cDZZWcvmoxSTXH+tQ9s0+ww/W
	6aOvmZCa5WDcrElnfDJ4DNQ0872ZSfqaUoTczGLut8pZoetFLUesMxz46L18JAADFXRhP4BQ22e
	YdaUvNDYAqxbhT9EEpyip1RCBr3ku7KdE2QEPzo386m170Cd+744lOEa5xYOKkKrcaVFjG1L8ga
	fs909xRunwGZGDkmZR7HE2nbtq/I1cNMW3apZsvU3S0azYFNt0xJ8LxSmfAduRr69vLmxcR5rjg
	DCHH/F8h0yoUE9EPerqFtq92HGJOPhg5mRMv3fP2spM8BcWlffMveKkk/79sEa8NJwKiQSw/LGZ
	SFAdWfHq4bpCde00YiJa8FLto3HkLbGCOafYGlP9nAm3qzxFvWzkrmLMZmwYycx45sNnOqgiXAr
	vM/Qc+R36ju+DuWzqGoeoPUnFl/YWU8+AyUe+jXb7k=
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39b2614df9dmr61606265a91.2.1789023178292;
        Wed, 09 Sep 2026 23:52:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e77498csm2694423a91.3.2026.09.09.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:52:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:22:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <aqJS61DbuUI3xoY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>

On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> All vDSO code needs to be completely position independent. Symbol
> references are marked as hidden so the compiler emits PC-relative
> relocations. However there are cases where the compiler may still
> emit absolute relocations, as they are valid in regular PIC DSO code.
> These would be resolved by the linker and will break at runtime.
> This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> Work around invalid absolute relocations from GCC")
> 
> Introduce a tool to check for absolute relocations during the build,
> as the current inline-shell logic is not expressive enough.
> The check is done on the object files as the relocations will not exist
> anymore in the final DSO. As there is no extension point for the
> compilation of each object file, perform the validation in vdso_check.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile                    |  19 ++
>  lib/vdso/Kconfig            |   5 +
>  lib/vdso/Makefile           |   2 +
>  lib/vdso/Makefile.include   |  14 ++
>  lib/vdso/check/.gitignore   |   3 +
>  lib/vdso/check/Makefile     |  34 +++
>  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
>  8 files changed, 729 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 4ad67b737af7..e6e0dd7818ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1559,6 +1559,25 @@ vdso_install: export INSTALL_FILES = $(vdso-install-y)
>  vdso_install:
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vdsoinst
>  
> +# ---------------------------------------------------------------------------
> +# vDSO check
> +
> +ifdef CONFIG_RUST_IS_AVAILABLE
> +ifdef CONFIG_VDSO_CHECK
> +
> +# Build the checker early.
> +prepare: vdsocheck
> +
> +# If the architecture builds the vDSO early, make sure to be earlier.
> +PHONY += vdso_prepare
> +vdso_prepare: vdsocheck
> +
> +PHONY += vdsocheck
> +vdsocheck:
> +	$(Q)$(MAKE) $(build)=lib/vdso/check $@
> +endif
> +endif
> +
>  # ---------------------------------------------------------------------------
>  # Tools
>  
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 597f5f0f9681..112b42a5aeb1 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -23,3 +23,8 @@ config VDSO_GETRANDOM
>  	select VDSO_DATASTORE
>  	help
>  	  Selected by architectures that support vDSO getrandom().
> +
> +config VDSO_CHECK
> +	bool
> +	help
> +	  Selected for architectures that are supported by the 'vdsocheck' progam.
	s/progam/program

Regards,
Mukesh
