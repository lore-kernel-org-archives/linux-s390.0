Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B211E8333;
	Fri,  8 Aug 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635491; cv=none; b=T0ITgoSoxP8AdLWmJhcOkdoRB45gCMi2ryGsqfCTUughLeXV+LgLnJQHLuUI2FCeZJ74D9BDMUcW0GziQ71ocj4K1i0J27r81GDylNGy3h+kU1g1ApbLy+eORzv5n0fSHh8tCd1wlaR0yIakOuzqq4NCacDTWNDVlwrtIGdSNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635491; c=relaxed/simple;
	bh=gzV0wasCW3/mOk7PL6Q5f26YKQva4ySfdYI4tn5RkcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLdV6YbnbqKJbiRXHqM85//pnZzTZdwr+PaIAvb21y51C39STmm85eniiUV0FKrXn723WT+IVUVFNSDtCXjVl3XuvTVbdAW//o8snrAmKGbI1t5Nm0nUhtqF2AxEWxiwqLbxd1KN2I/H1iurzgAXOFxMR2QlqMC38ZBiUeGsbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZIACaoc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZIACaoc"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3322fef6d72so14854181fa.0;
        Thu, 07 Aug 2025 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754635488; x=1755240288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bygktD0fqAfBcULD1cv//efBpJOrdPBFdY6zXSYR1E=;
        b=hZIACaocko6RY44WDidBrk74v+IUdkCORp8TXmruUfqm00nHJH69pbF20yJUpMwtPT
         1i1WN/B+jKD+HPRE64aylfWajkFOblygdqnW50TPUe363YXrTss0V6q+bgGU6EnwelYW
         6t11tgiUeqy1jX0K71NPSz2ISam2slH9sYJnF0ARflXzJXzlaRAXZ3XCS53xb9UCSlCF
         uyGUI/btWyqhtptr5/OMcWBWXaiQDzYOq36wfsi8qEkrXoZ2qnw8gKcZ0IIodRekFLd8
         vSSwwKH6EKLna63s1GjdfnmkGCDQUBlm2Iuqs3aMQVf35bGi1DtFFiV+W9QtiAoYBnDh
         ZY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754635488; x=1755240288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bygktD0fqAfBcULD1cv//efBpJOrdPBFdY6zXSYR1E=;
        b=JP/impAMseLfK5XEDwKD/LGuteA1U4sdWvWW07Mcda9Tb9jHEFA92rgVufCeREbL3F
         H/E0VHA1b3ptJTLkVo6wCA0Fmb+GxsnnAzM10BpIFIh78rUNtL/t6AwbaJxqL/UfZy17
         UuJ2ckIAYoPZP4gQ8eGlrcuO/eA934SA+9eu+G2x+Q2XDvNVQb2HvIbtMhoOiD2FtqFo
         LTmKvh424C5+rSu/TgpeeIVgQKJCpdRd+4+9jqLPoDUUPlIRllpVRjAT79xL5t2SWNH8
         KCFLxFJ8hV8F0L5lerauRCb1Q9d4ZYl78AzdhP4eyuv2mqyFXeBWyyb2LqIgp8Pn+ARD
         vFSA==
X-Forwarded-Encrypted: i=1; AJvYcCVMMS1PBOvvHEPj9+JsaDeDzj/pT45yRh4s4Ea/ZUgwN4RyqdXmaFDUhZvszPzIdLcqNQ1vf+2WNG+J7w==@vger.kernel.org, AJvYcCXtKlui+93wueN5JmOsQ+S/G35EboTe6zgF1sIczS91A2N/E3/AknyAnnvN2yjUd+HxKtGg91qHzdHrbYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzrCzUrqWeWW6T2DSuPFBOUNDRZ75/dszMNvwKbBQUhzYg+C/
	lTIxTrj6D79o0pWWOjzfmDGQ92iVREOKFlb48jiKyQHfJX+geHa0FGvHD2MlOtQaixB1cuJgCRI
	CNjkyoykLlAvmcUjIgB4R3SbBUBXRBcA=
X-Gm-Gg: ASbGncuK2shiWkvM2uno/eimszg6XwtZIXsHDU3ckaNFeIi0+YmCdbRf9MgbICiAhV4
	TTC7bUgzBeyjFTK8PYahk/uHz5CcjlBcv6JNThCAGZjgebiys832xmMoV/Rzh2HI5JOo4IDujdW
	cIWu0M3oDvlopZ5OYRqrz7KFKd8yp92/A9/8Olk39p9vmoVOpGfX4FH+GkoETDXGt/ZWYsGaF7G
	AUyDOcFxdRL8A==
X-Google-Smtp-Source: AGHT+IFs71M36/AELdEQHAnmGYL1flS4Z16XX46ZSXB/yJtln5z+7ajdXBk68gahFV3tPaDyZV4i3858ZjCNgBJDsz4=
X-Received: by 2002:a05:651c:4010:b0:332:2df3:f8ac with SMTP id
 38308e7fff4ca-333a222c31amr3330341fa.32.1754635487960; Thu, 07 Aug 2025
 23:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807194012.631367-1-snovitoll@gmail.com> <20250807194012.631367-3-snovitoll@gmail.com>
 <07ffb27c-3416-43c9-a50a-164a76e5ab60@csgroup.eu>
In-Reply-To: <07ffb27c-3416-43c9-a50a-164a76e5ab60@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 8 Aug 2025 11:44:30 +0500
X-Gm-Features: Ac12FXy3j3jcHWv5quQse7L5XRgGZZuU0Dnwj-G3jWlUZ0ijDblLaDUsIz_V-Q8
Message-ID: <CACzwLxhahYWfRc5xKshayniV6SuFFnMT0NfHttippcASzZgtRw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] kasan: call kasan_init_generic in kasan_init
To: Christophe Leroy <christophe.leroy@csgroup.eu>, alex@ghiti.fr
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com, 
	andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, davidgow@google.co, glider@google.com, 
	dvyukov@google.com, agordeev@linux.ibm.com, vincenzo.frascino@arm.com, 
	elver@google.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:07=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 07/08/2025 =C3=A0 21:40, Sabyrzhan Tasbolatov a =C3=A9crit :
> > Call kasan_init_generic() which handles Generic KASAN initialization.
> > For architectures that do not select ARCH_DEFER_KASAN,
> > this will be a no-op for the runtime flag but will
> > print the initialization banner.
> >
> > For SW_TAGS and HW_TAGS modes, their respective init functions will
> > handle the flag enabling, if they are enabled/implemented.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> > Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
> > ---
> > Changes in v5:
> > - Unified arch patches into a single one, where we just call
> >       kasan_init_generic()
> > - Added Tested-by tag for riscv (tested the same change in v4)
> > - Added Acked-by tag for s390 (tested the same change in v4)
> > ---
> >   arch/arm/mm/kasan_init.c    | 2 +-
> >   arch/arm64/mm/kasan_init.c  | 4 +---
> >   arch/riscv/mm/kasan_init.c  | 1 +
> >   arch/s390/kernel/early.c    | 3 ++-
> >   arch/x86/mm/kasan_init_64.c | 2 +-
> >   arch/xtensa/mm/kasan_init.c | 2 +-
> >   6 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> > index 111d4f70313..c6625e808bf 100644
> > --- a/arch/arm/mm/kasan_init.c
> > +++ b/arch/arm/mm/kasan_init.c
> > @@ -300,6 +300,6 @@ void __init kasan_init(void)
> >       local_flush_tlb_all();
> >
> >       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> > -     pr_info("Kernel address sanitizer initialized\n");
> >       init_task.kasan_depth =3D 0;
> > +     kasan_init_generic();
> >   }
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index d541ce45dae..abeb81bf6eb 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -399,14 +399,12 @@ void __init kasan_init(void)
> >   {
> >       kasan_init_shadow();
> >       kasan_init_depth();
> > -#if defined(CONFIG_KASAN_GENERIC)
> > +     kasan_init_generic();
> >       /*
> >        * Generic KASAN is now fully initialized.
> >        * Software and Hardware Tag-Based modes still require
> >        * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
> >        */
> > -     pr_info("KernelAddressSanitizer initialized (generic)\n");
> > -#endif
> >   }
> >
> >   #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> > index 41c635d6aca..ba2709b1eec 100644
> > --- a/arch/riscv/mm/kasan_init.c
> > +++ b/arch/riscv/mm/kasan_init.c
> > @@ -530,6 +530,7 @@ void __init kasan_init(void)
> >
> >       memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
> >       init_task.kasan_depth =3D 0;
> > +     kasan_init_generic();
>
> I understood KASAN is really ready to function only once the csr_write()
> and local_flush_tlb_all() below are done. Shouldn't kasan_init_generic()
> be called after it ?

I will try to test this in v6:

        csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
        local_flush_tlb_all();
        kasan_init_generic();

Alexandre Ghiti said [1] it was not a problem, but I will check.

[1] https://lore.kernel.org/all/20c1e656-512e-4424-9d4e-176af18bb7d6@ghiti.=
fr/

>
> >
> >       csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
> >       local_flush_tlb_all();
> > diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> > index 9adfbdd377d..544e5403dd9 100644
> > --- a/arch/s390/kernel/early.c
> > +++ b/arch/s390/kernel/early.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/kernel.h>
> >   #include <asm/asm-extable.h>
> >   #include <linux/memblock.h>
> > +#include <linux/kasan.h>
> >   #include <asm/access-regs.h>
> >   #include <asm/asm-offsets.h>
> >   #include <asm/machine.h>
> > @@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
> >   {
> >   #ifdef CONFIG_KASAN
> >       init_task.kasan_depth =3D 0;
> > -     pr_info("KernelAddressSanitizer initialized\n");
> > +     kasan_init_generic();
> >   #endif
> >   }
> >
> > diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> > index 0539efd0d21..998b6010d6d 100644
> > --- a/arch/x86/mm/kasan_init_64.c
> > +++ b/arch/x86/mm/kasan_init_64.c
> > @@ -451,5 +451,5 @@ void __init kasan_init(void)
> >       __flush_tlb_all();
> >
> >       init_task.kasan_depth =3D 0;
> > -     pr_info("KernelAddressSanitizer initialized\n");
> > +     kasan_init_generic();
> >   }
> > diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
> > index f39c4d83173..0524b9ed5e6 100644
> > --- a/arch/xtensa/mm/kasan_init.c
> > +++ b/arch/xtensa/mm/kasan_init.c
> > @@ -94,5 +94,5 @@ void __init kasan_init(void)
> >
> >       /* At this point kasan is fully initialized. Enable error message=
s. */
> >       current->kasan_depth =3D 0;
> > -     pr_info("KernelAddressSanitizer initialized\n");
> > +     kasan_init_generic();
> >   }
>
