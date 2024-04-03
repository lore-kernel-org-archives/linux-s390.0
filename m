Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6D14A098
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154218; cv=none; b=bvCQUyZRJqu/xm3D+V8PnawRVlyqf7SPwzII8B3Y5tUDhaGXpwUDtwyFNR4lzxIxb44ff6joGDIQXj+m1Siu1k5QyaOuyA311DQmJtBBOAqes0ZAvGHbstwIsLH8g+1QTuzWX21igGPXr4yt06tSj3EEitMBZQYe3xD01ki3+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154218; c=relaxed/simple;
	bh=4z2X6f4byCORZ+98tGQMFxTRKTmnwzsg9rbx++Rxgv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO2rbX4KYNAZHVBLABHvNIWPe4p6ZqBrVvmMUXvkSoIruZaoDqLr/vftfgvrmktjQETPYEuuL+bm2uGbtUsjWmgU9BjVAqtuhYMBsGDtRdT7uzvJdHSx2A/yPMPL694HhYmwXRgloedeHoNCSpgAnUCeOVBB4/XLGrrnUCRi7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vCFNrQxc; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCFNrQxc"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098a20ab22so57158287b3.2
        for <linux-s390@vger.kernel.org>; Wed, 03 Apr 2024 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712154216; x=1712759016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwJNuwyQp3Yvzu+935Rba/rHkgr+XgKaeFBH6ggamVo=;
        b=vCFNrQxcr3suPfrK3riBgo8DjCkhRgEyqhRgf6CPNAXn5uGQ4qtNpU6j1ZelLazqw9
         McV7nZp5klk5In7eEoP1et03D+UnUm1i6puJlMdHdTznAoEt4e2j9l0jIVQb3ye6tXO8
         LFdAoDQ0Y90UqNbEmHhU3KgT3oTdsVEPWi9XtF0dg5HHkDXOvQWqUmDMtREZJTkAHcWn
         b+uH+q3c1l4fQjnOhqVKlkP0zeS3/Aa00/bqasGAUEzIqjRwb3YNWS0ayXWkzMWM9fPI
         xI8M3FTnVCXWUWA2r85EWgnOm12zqT4GbgGqjKynD7pYOqcMfubSj5pDj1IvKaO1zfAm
         GLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154216; x=1712759016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwJNuwyQp3Yvzu+935Rba/rHkgr+XgKaeFBH6ggamVo=;
        b=bnXeplABaM43iJGSTzHLj6+ILS07/ZQ0FEMOWwI6uKBkCLA5HeqXJ8DOYa34pSrxcR
         9VzWep96Zc6Pk7aviSCzPbbOq8xm4NFRjDw4oXNXMdg+BMhbz5ok+EJyNWAB4KKm4II0
         PRDuNgTZfOjajJwvuRlVymyvLTEql+6raDjebwGaznkWseLvFsdC5DfnhW1zlcf3v339
         zi/U2xU1+KA+ABd2vf4OPhFdFk91iDjGZtl0mlsbQSlyLiVZhpUenL/atq+/j5w9ZfTO
         ORbPm9G4tjQGfzb18qbA7h5FQL49ayz/zA/mrnn88VkMmkQH1ZweHewNcKh9CjgEQjwC
         35Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXocm8eQnuwZD4IeOeXOZ7dP64duMqh5kWm+P8P/ghY5qoWOWbHfj/l6hvuo/dnir4TL2KEywOMQAmqa3Ft2QoEQw9vTfIvqbVSLA==
X-Gm-Message-State: AOJu0YxKp42IQXKibajmZUpOSGGQyENBS9RAFipAeRmgNK1EsieTlFwy
	kn6qMj2MPBD9tH7kE9VZjb7Kwxvc8gEeK4d4AVsxaBQA4jCPL4ijsNPghEWA1Jr6pb+/Kqyv6X5
	o8Xua1iU49lcZWAwjM6v/7AH4sC1ixpmjsjLX
X-Google-Smtp-Source: AGHT+IHARpbXZVqsZEoa5xySsc3G5/CcR814bUWxWQ15mbjsPwETu+5wjQAHS1k9Hq1FLB9FQjXK6aME+vDVPH/zVfk=
X-Received: by 2002:a25:ab41:0:b0:dcf:a52d:6134 with SMTP id
 u59-20020a25ab41000000b00dcfa52d6134mr2682792ybi.26.1712154215477; Wed, 03
 Apr 2024 07:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
 <20240402075142.196265-8-wangkefeng.wang@huawei.com> <CAJuCfpFoxP78+P1+4WQcCqMzGv7jpC9V8pR_-R8t8zPUg-t+aA@mail.gmail.com>
 <d5177b0f-db4e-4c78-81f1-5761f08f076d@huawei.com>
In-Reply-To: <d5177b0f-db4e-4c78-81f1-5761f08f076d@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Apr 2024 07:23:23 -0700
Message-ID: <CAJuCfpEKg1wxNwhu9JOsvq9kZM9WUA2MNfH_jb6ZQ0jpGJzEdw@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 12:58=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
>
>
> On 2024/4/3 13:59, Suren Baghdasaryan wrote:
> > On Tue, Apr 2, 2024 at 12:53=E2=80=AFAM Kefeng Wang <wangkefeng.wang@hu=
awei.com> wrote:
> >>
> >> The vm_flags of vma already checked under per-VMA lock, if it is a
> >> bad access, directly handle error and return, there is no need to
> >> lock_mm_and_find_vma() and check vm_flags again.
> >>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > Looks safe to me.
> > Using (mm !=3D NULL) to indicate that we are holding mmap_lock is not
> > ideal but I guess that works.
> >
>
> Yes, I will add this part it into change too,
>
> The access_error() of vma already checked under per-VMA lock, if it
> is a bad access, directly handle error, no need to retry with mmap_lock
> again. In order to release the correct lock, pass the mm_struct into
> bad_area_access_error(), if mm is NULL, release vma lock, or release
> mmap_lock. Since the page faut is handled under per-VMA lock, count it
> as a vma lock event with VMA_LOCK_SUCCESS.

The part about passing mm_struct is unnecessary IMHO. It explains "how
you do things" but changelog should describe only "what you do" and
"why you do that". The rest we can see from the code.

>
> Thanks.
>
>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >
> >> ---
> >>   arch/x86/mm/fault.c | 23 ++++++++++++++---------
> >>   1 file changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> >> index a4cc20d0036d..67b18adc75dd 100644
> >> --- a/arch/x86/mm/fault.c
> >> +++ b/arch/x86/mm/fault.c
> >> @@ -866,14 +866,17 @@ bad_area_nosemaphore(struct pt_regs *regs, unsig=
ned long error_code,
> >>
> >>   static void
> >>   __bad_area(struct pt_regs *regs, unsigned long error_code,
> >> -          unsigned long address, u32 pkey, int si_code)
> >> +          unsigned long address, struct mm_struct *mm,
> >> +          struct vm_area_struct *vma, u32 pkey, int si_code)
> >>   {
> >> -       struct mm_struct *mm =3D current->mm;
> >>          /*
> >>           * Something tried to access memory that isn't in our memory =
map..
> >>           * Fix it, but check if it's kernel or user first..
> >>           */
> >> -       mmap_read_unlock(mm);
> >> +       if (mm)
> >> +               mmap_read_unlock(mm);
> >> +       else
> >> +               vma_end_read(vma);
> >>
> >>          __bad_area_nosemaphore(regs, error_code, address, pkey, si_co=
de);
> >>   }
> >> @@ -897,7 +900,8 @@ static inline bool bad_area_access_from_pkeys(unsi=
gned long error_code,
> >>
> >>   static noinline void
> >>   bad_area_access_error(struct pt_regs *regs, unsigned long error_code=
,
> >> -                     unsigned long address, struct vm_area_struct *vm=
a)
> >> +                     unsigned long address, struct mm_struct *mm,
> >> +                     struct vm_area_struct *vma)
> >>   {
> >>          /*
> >>           * This OSPKE check is not strictly necessary at runtime.
> >> @@ -927,9 +931,9 @@ bad_area_access_error(struct pt_regs *regs, unsign=
ed long error_code,
> >>                   */
> >>                  u32 pkey =3D vma_pkey(vma);
> >>
> >> -               __bad_area(regs, error_code, address, pkey, SEGV_PKUER=
R);
> >> +               __bad_area(regs, error_code, address, mm, vma, pkey, S=
EGV_PKUERR);
> >>          } else {
> >> -               __bad_area(regs, error_code, address, 0, SEGV_ACCERR);
> >> +               __bad_area(regs, error_code, address, mm, vma, 0, SEGV=
_ACCERR);
> >>          }
> >>   }
> >>
> >> @@ -1357,8 +1361,9 @@ void do_user_addr_fault(struct pt_regs *regs,
> >>                  goto lock_mmap;
> >>
> >>          if (unlikely(access_error(error_code, vma))) {
> >> -               vma_end_read(vma);
> >> -               goto lock_mmap;
> >> +               bad_area_access_error(regs, error_code, address, NULL,=
 vma);
> >> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> >> +               return;
> >>          }
> >>          fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VM=
A_LOCK, regs);
> >>          if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> >> @@ -1394,7 +1399,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> >>           * we can handle it..
> >>           */
> >>          if (unlikely(access_error(error_code, vma))) {
> >> -               bad_area_access_error(regs, error_code, address, vma);
> >> +               bad_area_access_error(regs, error_code, address, mm, v=
ma);
> >>                  return;
> >>          }
> >>
> >> --
> >> 2.27.0
> >>
