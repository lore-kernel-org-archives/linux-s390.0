Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FC18FC8F
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064958; cv=none; b=PhRl17rwkKOw+/75mvCVx8HWt3XyNEJRAifID40tMcr3138bpXd+Ble7aQdSzzcauEeoVRMQ79lJhhqyNQUPzOLBFL55vxItE1kL4F5N+/qczy0T0uvhr2sCmXB+3Of6mUjStlrhC/HBTbrt9hSgncUxEjgVMhR7Ev0z3GdF15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064958; c=relaxed/simple;
	bh=LXml806C/TOBeEr046OC0OvZkBEk1w1exWNnDPQeFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/ZEKeQw5sg0WzuwI3P+ijyIi+awjLeg4ulD+0MXkbSdTeZXfgc1giUYqlpkgmyYvMhK5Z3AXxLrMcthRlPaPqpMEaW4ZqE09QwEEMxbFQKrhGszAq/Y+Jlkw86X7mpcgi+hjJ7sSgSAQ5R2vhb8uY5/gBDkoo6oW2wgRWjR8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RbUeOTfL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RbUeOTfL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so27608615ad.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737064956; x=1737669756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9HyN5fzzsxjX7rL5WN4+ekEIWemc4MJvOPgL3AWRJU=;
        b=RbUeOTfLhm/1YsDniGZwLjZ0Ks4t4jCfMkdNdXg/MqZTSp75+pCTKerXggYIlgBQFQ
         5DvMQ4L1j7eiOxKp048zt015zgK0/7TtWvArxExuX4OnjHeoJczGo44RuQPLOPrPcn2K
         LztXyGm+/aqxjLdBI7Wbxc6XflnQd8BW3gSjaPpvVu2pGyCazKiQgsK98nWJVeTylItN
         yE1sAT+Ga9mZmeDJ+VnZVqKC6NkYPwvG76OQCfXr0mFz6ehGKxLVGKuEXEenNhAVVKfE
         +esdvad+6szRSTLwMUZOWZyNSgVatDCWlrUufbXGLDSenENOvsz2lJQA7wSsz7D4kS2J
         b0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737064956; x=1737669756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9HyN5fzzsxjX7rL5WN4+ekEIWemc4MJvOPgL3AWRJU=;
        b=v7pVn8+t9pdBhULYpNTOjE18doXKwM8NoithXWa84WUnFTGYojPL1ITAbJd94q8znn
         N+z/DKL0/5+9Iy8FnBlFuynekd15kPEexlqsfOYydWNHiIVtKQ/TMp7mWkRYIniyxTvw
         o2NE8BIBCyXtrFuj10+Z7Nu9+ZdL4hSg+y/T82/63VqHo7WXBXZaej12kuNWI65d1azN
         Yj//K8SCS06tvpmECci9l+fewcDriY8NlFO7VIutea96rK8lzVUHTq0d3MLlDLuCXS+H
         5pKPsF6YONl1OGXjE0EYhaiNi0n6tvN53Up6Suc9D8kEDIoJAeKDo9tPi2m+OJE4yC4b
         3yEA==
X-Forwarded-Encrypted: i=1; AJvYcCXtnS1aTxIYMZiNgGvHrUkqJmZRYd90LRRGJHBFN6SMhL+wzQBkuMfUvz2107Ilrt71z8+/vf+S2kSu@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZZxdmgdMDY1KV5E3Um/ZvwIXwZzYp8gU5RUktRmd6wnZsOZ7
	/HliVgTfBgfccpn8yPdbs4xs4+UlozMXXXk4GWIUBeOXK0Lz+jgvXfNN/6WuoTk=
X-Gm-Gg: ASbGncvgoN24SLbGb51SM1lxbu540XcfmsQ22lrc/DgZsVE5mvtky00D5Gmon+w54Uz
	PYY2SYtH/IOMEUvESwXM7+briPhBErJzDa/DYOLNXbcPc/q52oN/jWl36fj1u/a+B8SNKXR6YuA
	VXQk3oAOUiD5IHQdHXwo8JxZ40151GaVTEtXYjkq5sv3nxsPgFHCQUKBozQzvrV12FdUjl8sK7A
	m0KDuSMHwoMMPLKgO1jA2ScGJkv0aGW/eQewnT9OsbJnR8=
X-Google-Smtp-Source: AGHT+IFU/8awlpMa01JGFciAUeb1+31NMw3m/BNIqOBK6PrwzwYa7UYwhd6+mC4PgxTTkBxFrumquQ==
X-Received: by 2002:a05:6a20:8423:b0:1e1:aa24:2e58 with SMTP id adf61e73a8af0-1eb2145dc65mr527617637.7.1737064955823;
        Thu, 16 Jan 2025 14:02:35 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabace1bdsm488740b3a.171.2025.01.16.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 14:02:35 -0800 (PST)
Date: Thu, 16 Jan 2025 14:02:32 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Ron Economos <re@w6rz.net>
Subject: Re: [PATCH v3] kbuild: Strip runtime const RELA sections correctly
Message-ID: <Z4mB-I5jeGithAQX@ghost>
References: <20250113155306.1922992-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113155306.1922992-2-ardb+git@google.com>

On Mon, Jan 13, 2025 at 04:53:07PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Due to the fact that runtime const ELF sections are named without a
> leading period or double underscore, the RSTRIP logic that removes the
> static RELA sections from vmlinux fails to identify them. This results
> in a situation like below, where some sections that were supposed to get
> removed are left behind.
> 
>   [Nr] Name                              Type            Address          Off     Size   ES Flg Lk Inf Al
> 
>   [58] runtime_shift_d_hash_shift        PROGBITS        ffffffff83500f50 2900f50 000014 00   A  0   0  1
>   [59] .relaruntime_shift_d_hash_shift   RELA            0000000000000000 55b6f00 000078 18   I 70  58  8
>   [60] runtime_ptr_dentry_hashtable      PROGBITS        ffffffff83500f68 2900f68 000014 00   A  0   0  1
>   [61] .relaruntime_ptr_dentry_hashtable RELA            0000000000000000 55b6f78 000078 18   I 70  60  8
>   [62] runtime_ptr_USER_PTR_MAX          PROGBITS        ffffffff83500f80 2900f80 000238 00   A  0   0  1
>   [63] .relaruntime_ptr_USER_PTR_MAX     RELA            0000000000000000 55b6ff0 000d50 18   I 70  62  8
> 
> So tweak the match expression to strip all sections starting with .rel.
> While at it, consolidate the logic used by RISC-V, s390 and x86 into a
> single shared Makefile library command.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: Ron Economos <re@w6rz.net>
> Link: https://lore.kernel.org/all/CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3: put back missing 'endif' to fix the RISC-V build
> v2: add missing include of scripts/Makefile.lib
> 
>  arch/riscv/Makefile.postlink |  8 ++------
>  arch/s390/Makefile.postlink  |  6 +-----
>  arch/x86/Makefile.postlink   |  6 +-----
>  scripts/Makefile.lib         |  3 +++
>  4 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
> index 829b9abc91f6..750d2784f69e 100644
> --- a/arch/riscv/Makefile.postlink
> +++ b/arch/riscv/Makefile.postlink

When I compile x86 as relocatable I see the problem that you are fixing
here, but I don't see it on riscv. It's probably better to keep around
this code for riscv, but I don't think it even needs this stripping? I
am adding Alex since he added this for riscv.

Anyways this works as expected:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> @@ -10,6 +10,7 @@ __archpost:
>  
>  -include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> +include $(srctree)/scripts/Makefile.lib
>  
>  quiet_cmd_relocs_check = CHKREL  $@
>  cmd_relocs_check = 							\
> @@ -19,11 +20,6 @@ ifdef CONFIG_RELOCATABLE
>  quiet_cmd_cp_vmlinux_relocs = CPREL   vmlinux.relocs
>  cmd_cp_vmlinux_relocs = cp vmlinux vmlinux.relocs
>  
> -quiet_cmd_relocs_strip = STRIPREL $@
> -cmd_relocs_strip = $(OBJCOPY)   --remove-section='.rel.*'       \
> -                                --remove-section='.rel__*'      \
> -                                --remove-section='.rela.*'      \
> -                                --remove-section='.rela__*' $@
>  endif
>  
>  # `@true` prevents complaint when there is nothing to be done
> @@ -33,7 +27,7 @@ vmlinux: FORCE
>  ifdef CONFIG_RELOCATABLE
>  	$(call if_changed,relocs_check)
>  	$(call if_changed,cp_vmlinux_relocs)
> -	$(call if_changed,relocs_strip)
> +	$(call if_changed,strip_relocs)
>  endif
>  
>  clean:
> diff --git a/arch/s390/Makefile.postlink b/arch/s390/Makefile.postlink
> index df82f5410769..1ae5478cd6ac 100644
> --- a/arch/s390/Makefile.postlink
> +++ b/arch/s390/Makefile.postlink
> @@ -11,6 +11,7 @@ __archpost:
>  
>  -include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> +include $(srctree)/scripts/Makefile.lib
>  
>  CMD_RELOCS=arch/s390/tools/relocs
>  OUT_RELOCS = arch/s390/boot
> @@ -19,11 +20,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/relocs.S
>  	mkdir -p $(OUT_RELOCS); \
>  	$(CMD_RELOCS) $@ > $(OUT_RELOCS)/relocs.S
>  
> -quiet_cmd_strip_relocs = RSTRIP  $@
> -      cmd_strip_relocs = \
> -	$(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
> -		   --remove-section='.rela.*' --remove-section='.rela__*' $@
> -
>  vmlinux: FORCE
>  	$(call cmd,relocs)
>  	$(call cmd,strip_relocs)
> diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
> index fef2e977cc7d..8b8a68162c94 100644
> --- a/arch/x86/Makefile.postlink
> +++ b/arch/x86/Makefile.postlink
> @@ -11,6 +11,7 @@ __archpost:
>  
>  -include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> +include $(srctree)/scripts/Makefile.lib
>  
>  CMD_RELOCS = arch/x86/tools/relocs
>  OUT_RELOCS = arch/x86/boot/compressed
> @@ -20,11 +21,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/$@.relocs
>  	$(CMD_RELOCS) $@ > $(OUT_RELOCS)/$@.relocs; \
>  	$(CMD_RELOCS) --abs-relocs $@
>  
> -quiet_cmd_strip_relocs = RSTRIP  $@
> -      cmd_strip_relocs = \
> -	$(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
> -		   --remove-section='.rela.*' --remove-section='.rela__*' $@
> -
>  # `@true` prevents complaint when there is nothing to be done
>  
>  vmlinux: FORCE
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 7395200538da..f604f51d23ca 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -374,6 +374,9 @@ quiet_cmd_ar = AR      $@
>  quiet_cmd_objcopy = OBJCOPY $@
>  cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
>  
> +quiet_cmd_strip_relocs = RSTRIP  $@
> +cmd_strip_relocs = $(OBJCOPY) --remove-section='.rel*' $@
> +
>  # Gzip
>  # ---------------------------------------------------------------------------
>  
> -- 
> 2.47.1.688.g23fc6f90ad-goog
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
