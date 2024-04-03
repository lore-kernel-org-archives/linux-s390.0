Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BD4CB41
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124004; cv=none; b=ptJ4ptHCuEp0dYytn2lbMG6350WMYinbHCPncbv7NDyNMX4FJmRgjeaR4kHxdyBPOPL6Y141s6C32/SpcBTodH9/I5JLvlv2vvAgE8LGDi2Hfdd88f5eVMDzZ/Dv6VMlTdX1d5U1b2mVrC8I1Zo2iwe0Q3rpwASSl+pZl8OJygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124004; c=relaxed/simple;
	bh=sC4quRKyv3EoHEg9KSNKP7RaKswiQpiIPoZ8MeXoh3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJgC1hHDJMTptIqOuwAmkPam2HRKpbLuPi7as75L8RCIkt/Ed3mUsMsKDzkckXJOzNXt9BO999n85oKMxIcLlKbBYLFZCi2NznlZRoK53+/7Op9/WZBzMbrPl9WuUwKNWgvi2w25Kd0geBCn0gXol8Xfk1u6nVvOsJdg7anB2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIrXutSo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIrXutSo"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso5572320276.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712124001; x=1712728801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxJSXITYZ9pShDuxFQvxpaL2/3sgcxNx/8xBOuQ2iCk=;
        b=vIrXutSoazx2nkXN/38PR+ZbrUte9x/cUjRuCdCGjDOWgSXxWQqVbdTjXqdeog+5gZ
         Tk0LO67ZdumH+27caSy8ODfVY3SDdGCooKhHr0ZW0SSG3BGkkZGtLUAzuU7LlY5IAtnf
         0XDVO0RlCl1u09CVtZgR2lclURbn14GfhiOaYA/ARI6u4F/maCX1T9YPZt4HCscc/P0V
         iOltTVsyraZ9XxcfNQbVctDuVV/Kayxtoux1u/fuUmjFNRhnW0qdymUkQHwSvdk8Qk3Q
         KKOX430O6xfr3tI9eV8H7mA9cjoMYXMGZt/yFrfaV8YVMQWeLTGNDzPpSby/8VWQD7re
         yxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712124001; x=1712728801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxJSXITYZ9pShDuxFQvxpaL2/3sgcxNx/8xBOuQ2iCk=;
        b=JA5UjmMR7TWnj4xba0aeEa96bd0sqRlXNN0S6+ZPGG/exOIJ6321N9b4hR+MT0+6eL
         pY5kPt5O8gMOEp4KHf89Py9yXjEgDwQiUyIna5LOF++JGzYAqChsowtUOwFerNTZ4M+n
         /O7GRo34+mLKSJDTKMFJYzEmO92ZpwhjSaMScASl09zhF2f0Fg/fg0YRN9tPtP5oItjY
         EDi7ceHn9AXUG/W6f4eDAxZq8sYbWDAysfUHtwWBgicIoTh1pS/s4hBvWp5vzNLG4x/S
         xOVl9QPEnR0yu7RfxUKsOZwH8yN0agTHu0cU6PbMoIdOR1SHpQ/C6GxOuGJXuNpIDw6e
         8P+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGeC+ezCsBANDJXkoB28v3lBIicemnVwuGEM+Lhmy40GCMueAwd7XV9G4Z4Ww0aXUz/tq0OnPHHraMWCWJjgINS5aDjpLWx6ClHg==
X-Gm-Message-State: AOJu0YyFVa4BR21/cb/+rydm7dapE8nBGF/BVhkZwWC8pSTHfIpC9ycf
	wjkcgHTJE6ZeT/wEOfxPfJrNFJn016Z0I1rHMqMOmNfVYGGRuJcDqcdZT7w1yTOVXBlnAD6OrhX
	TTfaAAL821wvsFZFs4dEPBO0lcw0VctHcp6VY
X-Google-Smtp-Source: AGHT+IHF6yOPrbaSAup7jCog58WXJbC6NgZDiM+ULwuH0tlVvkyDWba5Ohyci7jQvdo5tO0oB+yC5pt2quv+tZIAonY=
X-Received: by 2002:a25:ef43:0:b0:dcc:4cdc:e98e with SMTP id
 w3-20020a25ef43000000b00dcc4cdce98emr6405675ybm.5.1712124001329; Tue, 02 Apr
 2024 23:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-8-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-8-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:59:50 -0700
Message-ID: <CAJuCfpFoxP78+P1+4WQcCqMzGv7jpC9V8pR_-R8t8zPUg-t+aA@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86: mm: accelerate pagefault when badaccess
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

Looks safe to me.
Using (mm !=3D NULL) to indicate that we are holding mmap_lock is not
ideal but I guess that works.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/x86/mm/fault.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index a4cc20d0036d..67b18adc75dd 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -866,14 +866,17 @@ bad_area_nosemaphore(struct pt_regs *regs, unsigned=
 long error_code,
>
>  static void
>  __bad_area(struct pt_regs *regs, unsigned long error_code,
> -          unsigned long address, u32 pkey, int si_code)
> +          unsigned long address, struct mm_struct *mm,
> +          struct vm_area_struct *vma, u32 pkey, int si_code)
>  {
> -       struct mm_struct *mm =3D current->mm;
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
>         __bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
>  }
> @@ -897,7 +900,8 @@ static inline bool bad_area_access_from_pkeys(unsigne=
d long error_code,
>
>  static noinline void
>  bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
> -                     unsigned long address, struct vm_area_struct *vma)
> +                     unsigned long address, struct mm_struct *mm,
> +                     struct vm_area_struct *vma)
>  {
>         /*
>          * This OSPKE check is not strictly necessary at runtime.
> @@ -927,9 +931,9 @@ bad_area_access_error(struct pt_regs *regs, unsigned =
long error_code,
>                  */
>                 u32 pkey =3D vma_pkey(vma);
>
> -               __bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
> +               __bad_area(regs, error_code, address, mm, vma, pkey, SEGV=
_PKUERR);
>         } else {
> -               __bad_area(regs, error_code, address, 0, SEGV_ACCERR);
> +               __bad_area(regs, error_code, address, mm, vma, 0, SEGV_AC=
CERR);
>         }
>  }
>
> @@ -1357,8 +1361,9 @@ void do_user_addr_fault(struct pt_regs *regs,
>                 goto lock_mmap;
>
>         if (unlikely(access_error(error_code, vma))) {
> -               vma_end_read(vma);
> -               goto lock_mmap;
> +               bad_area_access_error(regs, error_code, address, NULL, vm=
a);
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               return;
>         }
>         fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
>         if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> @@ -1394,7 +1399,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>          * we can handle it..
>          */
>         if (unlikely(access_error(error_code, vma))) {
> -               bad_area_access_error(regs, error_code, address, vma);
> +               bad_area_access_error(regs, error_code, address, mm, vma)=
;
>                 return;
>         }
>
> --
> 2.27.0
>
