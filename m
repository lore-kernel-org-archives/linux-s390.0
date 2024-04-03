Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389046425
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122459; cv=none; b=UFdGQUBeJ80TXX9Lub11LpB+lSL23JF3HF5SgjuLHn/8ShXdg24ywzq/9XySjZeDrMnTFWvYDPskoaI5/St6bXhyyliC446W+1Rm2/x12rwap2ewDEhGO4+PlNTf1P+bDwzX+JP3uglEpkgv/PGVnQBOeYv0UlWYt0vWMMdGE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122459; c=relaxed/simple;
	bh=g2433262rfiIDw2tKiUj8pVtr0AB+Ckz6n38HXE8CnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+cIv9QTpCQpYCxUkGlWy/+RLSNkSBV7ioMaXmgncGVxX1QcVDtNeJ6+Fy9bcy+QNL/dmi30uvaPwXUprzO38YCQ6ixt+O1jS+wxnJARaB6mpM24t0SY4YjUzmS3ZdNT+DbSntOTiZBzR47B3pm/V2GfJejnu7X6rO5rDzLc9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiKUJp/i; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiKUJp/i"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc742543119so5873699276.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712122456; x=1712727256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMhJUAqYdUyXE6Qj5LLiAEui3/1WTCPuc8rsDHLD3M0=;
        b=BiKUJp/i1YGtbRQkXO8nQ4UDXhjaRpNMnN4f/O/uaNbRIB93PJr88w24FXCOGC1i3L
         fMKWa2LzhUSvuHxEykpvkf0Yf0WU6Lg2IPTEdNlvqRuM1EW4jqGwueFqdEswiU47qQKG
         MngG43YwOLy5apqFDuNtnQVAYuwZO/Jk5TU5SzmAQmupynql+P8QO2vQeu8mCf7ERfKt
         B/6pOw97qM83+f7s5RJGLGzvomXVz69nN9gs53xDgzjbpGLxH8AafqGhqY47vnHw9lR4
         zIddT+ZrY51NZN9KdlUMAyY1PlTrzfhi7Hw2cu/6V6KGSy46aktht++5E2h3Z1RjsCYx
         cTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122456; x=1712727256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMhJUAqYdUyXE6Qj5LLiAEui3/1WTCPuc8rsDHLD3M0=;
        b=CmAoBkW+VnYJuwI3v+DeaOby9Wk87aeUShhM56FINmyDl7PYt7moFCg7wuDlq/TAd8
         IBnYgH694DJNjo15M9pOuG4wC/Ij2bxSYOgQU+l8VXmljDZlfBAbMVmaERbHQI2ghVyD
         NUoUn/8O+Z9bXzq0MyMmD3xPd5ce3HLkswXglVnZQsxXamdPh6rpNBQeC468HAIu/4hp
         Una1HWIg2d89fxUmTHPHW7cvmhHZcJbpwMzfRjq9SF+V/WAejpHZ7Fzxa1Qejz/2duaa
         sqSHFheLqyBR5sop/joiOiSlc54k9Jd8Fh7R0kkqbG2e8VAHm59FPUMxCWbMcAJ+e7vj
         ngjg==
X-Forwarded-Encrypted: i=1; AJvYcCW04XT5w0WO45PlDOhy+VUxRiMO9Y6SO1AIww4TuNf4yAftNi4YI8KRKALYutFGF5Ub4kn4skjEkttOnKlhCFjO1FcLsGFfuGOObg==
X-Gm-Message-State: AOJu0YxeSKR4jjy/uvZYWNlc7dHEdCjxW1txnL161Ix8PdSQrSTsmCtc
	jBoW3EpaD+jbqy1jg5cp5VUWtfudz8sS+9KNg2pwya0kldmFmNM3AwXdgPJcUF8fFKQsQ259td2
	TyIZBDKnafdTdKH1vOs8V2ODqHZ2gPIHFdDCy
X-Google-Smtp-Source: AGHT+IFHtHI+kOgQbA0jN0HDYS831HEs6w0y5y/YrI4Iocm+EMqRSzcSDQggfc1RbHP4jEbfZEvpbo6dJNCJOpQwGVo=
X-Received: by 2002:a25:a28a:0:b0:dcd:3575:db79 with SMTP id
 c10-20020a25a28a000000b00dcd3575db79mr1551217ybi.6.1712122456055; Tue, 02 Apr
 2024 22:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-5-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-5-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:34:02 -0700
Message-ID: <CAJuCfpGhF9xLhJ1_fWKRirVdeT2C0QCMsWht2sB62q3ZaWA2wQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] powerpc: mm: accelerate pagefault when badaccess
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:53=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly handle error and return, there is no need to
> lock_mm_and_find_vma() and check vm_flags again.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Code-wise looks correct to me and almost identical to x86 change but
someone with more experience with this architecture should review.

> ---
>  arch/powerpc/mm/fault.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 53335ae21a40..215690452495 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -71,23 +71,26 @@ static noinline int bad_area_nosemaphore(struct pt_re=
gs *regs, unsigned long add
>         return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
>  }
>
> -static int __bad_area(struct pt_regs *regs, unsigned long address, int s=
i_code)
> +static int __bad_area(struct pt_regs *regs, unsigned long address, int s=
i_code,
> +                     struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -       struct mm_struct *mm =3D current->mm;
>
>         /*
>          * Something tried to access memory that isn't in our memory map.=
.
>          * Fix it, but check if it's kernel or user first..
>          */
> -       mmap_read_unlock(mm);
> +       if (mm)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>
>         return __bad_area_nosemaphore(regs, address, si_code);
>  }
>
>  static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long =
address,
> +                                   struct mm_struct *mm,
>                                     struct vm_area_struct *vma)
>  {
> -       struct mm_struct *mm =3D current->mm;
>         int pkey;
>
>         /*
> @@ -109,7 +112,10 @@ static noinline int bad_access_pkey(struct pt_regs *=
regs, unsigned long address,
>          */
>         pkey =3D vma_pkey(vma);
>
> -       mmap_read_unlock(mm);
> +       if (mm)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>
>         /*
>          * If we are in kernel mode, bail out with a SEGV, this will
> @@ -124,9 +130,10 @@ static noinline int bad_access_pkey(struct pt_regs *=
regs, unsigned long address,
>         return 0;
>  }
>
> -static noinline int bad_access(struct pt_regs *regs, unsigned long addre=
ss)
> +static noinline int bad_access(struct pt_regs *regs, unsigned long addre=
ss,
> +                              struct mm_struct *mm, struct vm_area_struc=
t *vma)
>  {
> -       return __bad_area(regs, address, SEGV_ACCERR);
> +       return __bad_area(regs, address, SEGV_ACCERR, mm, vma);
>  }
>
>  static int do_sigbus(struct pt_regs *regs, unsigned long address,
> @@ -479,13 +486,13 @@ static int ___do_page_fault(struct pt_regs *regs, u=
nsigned long address,
>
>         if (unlikely(access_pkey_error(is_write, is_exec,
>                                        (error_code & DSISR_KEYFAULT), vma=
))) {
> -               vma_end_read(vma);
> -               goto lock_mmap;
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               return bad_access_pkey(regs, address, NULL, vma);
>         }
>
>         if (unlikely(access_error(is_write, is_exec, vma))) {
> -               vma_end_read(vma);
> -               goto lock_mmap;
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               return bad_access(regs, address, NULL, vma);
>         }
>
>         fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> @@ -521,10 +528,10 @@ static int ___do_page_fault(struct pt_regs *regs, u=
nsigned long address,
>
>         if (unlikely(access_pkey_error(is_write, is_exec,
>                                        (error_code & DSISR_KEYFAULT), vma=
)))
> -               return bad_access_pkey(regs, address, vma);
> +               return bad_access_pkey(regs, address, mm, vma);
>
>         if (unlikely(access_error(is_write, is_exec, vma)))
> -               return bad_access(regs, address);
> +               return bad_access(regs, address, mm, vma);
>
>         /*
>          * If for any reason at all we couldn't handle the fault,
> --
> 2.27.0
>
