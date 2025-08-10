Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A374A21;
	Sun, 10 Aug 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811150; cv=none; b=me4Jguy7oSuTwTxU1qx/NG/ddM9oH0SaXqoWIQSkegL1dshGzKCPA72puniK1XQxK8Xekmwf4fABjQamj2RKZIztWJFqndbe6EJKi4Fk9hacH/Q19Pd4DbUFJFSFVMETNmXezXfTVjlhCV93ujvLkTC4Nc3SrP+Fc/CyWhV+wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811150; c=relaxed/simple;
	bh=k+5Y5DIWW+k7nAVqGwj4LUDFaTh1BhxGyeX9b2Dhj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDcfrkKkruwKAPmCBzgK06r5C8eojMlqWkJknY8z+X23b+5L2bONIUo8SxFI/Ag273O7aa9kaS1r4uRiYckVO5Bw5ZVwHpJUkbyHvJBezrehYLDwnkhQqXGJT2X44yuC1WW6SMTOJ+ArT0s0wwNk6+pg7YhIj0UZtZ1sd+zRg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF/gQYDW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/gQYDW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b93104888so4356310e87.1;
        Sun, 10 Aug 2025 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754811147; x=1755415947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to3a2j5jgrrDRsoCDy9JGxvNqhRLdP/C+mURmWO4ysI=;
        b=OF/gQYDWtmNesOh4W0iaMqkB56ycXRS/K1P7ip6T2rKCmhPOG2Y3lriTiCoXRv1CH/
         GvbfHTZtQ1bo7bXcU9glR+MEC66IavrXOdvjAtvqVbNx7efdo4Dl7EfSW2RQ2CecmzWy
         WDsGOZMqwMb6entF6IV33e8DPYRMrPDCtJdpLyJQFpKbcZfqlmKapxBbsbrUAAx2DmQf
         +zSc3rE8SoZB19ItTKQtuVa9JtqKc9Z5O+liOp3uPIBrQdNgn0IanjmyiSNk3Gn8ACL1
         u4iC+axg9UzbQLTVwhfU2/rHuaMwK7lPb+LJlmW0Pi7O9p2eskMElxmoQzDspMUulSuE
         09kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811147; x=1755415947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to3a2j5jgrrDRsoCDy9JGxvNqhRLdP/C+mURmWO4ysI=;
        b=HMoyouDUIljLoIoqlxm0dJ4k10xdXaFZ46mPZUTSRVsXRLm9XCRcPsSlIAPKJ7pzLI
         U7PdlfTHjX383j8UC06rEq5+ctHyy3TEvW1PapISpxJTEJ3FEi0UVLNDVEENraVLALiH
         0lG2jML7Zhz4HWGQ8Y1uDR6/ubc/JlbEeTO5nJRI6CurcrUdSoemgpVqnIqCFCHdfvDO
         lRq0lN7wq7OWHoeLWZW6KL/JdV/CpUDfZ4xZdZgz4RYBWofwln21RkBFl3a24pPpw6cs
         MJL7ocAvrfGot8Beu6XUD2MHWoUSraCYI1kMSjWiQC70O2ujyQJqLqVL7cQAzTL3EexG
         u8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUVLcJvIwqPkwz1jZqb2eFyehM0dlt1m0kvgd2Z2AY/6rBb7cam0M5MFNDGoIaPcVh3dBZ1TIc5bblJ4w==@vger.kernel.org, AJvYcCWwSrSjYrni01vU1dtjuDTx8q62MTxq3tal+CxcfLri54Tn7p435Dnq+TFcCy+Y8VtN4nGRUkAnQaitp3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobY4txk9dOx1DGJD1FjdzYOG1+5YJQvalr70jxkLSXtI2w9tA
	YGngRCjnifdmQlEN+g/y8wE8BJqXeTE+sO9NwtRddViywkd2zChHa8vHQR+OK6t3TyblT3LUIsE
	fi+KON6UdIe4kJxmYqDEeGDF4bANcPGo=
X-Gm-Gg: ASbGnctJB2C/h95j2bU99AoDXiE0pOPlCs+uZNL2ohLzqbNwkMa7fwuzcycZNTu/ylu
	oGOTrgdSiSWL43xD1GaDWcATZdnkP0tEtyRwI68eXUOCvPjZCn1Oo9BVluqEnwhn8iYHilIgNrD
	wLHP3qvF+CstkJiQL+irKm88NooGBL5VYOlYwgorsEvn647gKJgMB+Us2dkwoJOhg23YTdbbjOb
	M+I6/BWwtJWScYn15t4mtC1/JQ1JxVrSqrGEJRBm43HGlQmCQ==
X-Google-Smtp-Source: AGHT+IHSiW6flEmK0NWVDywJ0JDvDzDflYl3FPZq6Arom7yJiee4WZtdkHowtUkS6j3k/g3AhngqPPQBa36CQfXo8jE=
X-Received: by 2002:a05:6512:1052:b0:553:2480:2308 with SMTP id
 2adb3069b0e04-55cc00eb7eemr2065404e87.21.1754811146600; Sun, 10 Aug 2025
 00:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807194012.631367-1-snovitoll@gmail.com> <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu> <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
 <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu> <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
In-Reply-To: <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 10 Aug 2025 12:32:08 +0500
X-Gm-Features: Ac12FXzPCnTCatZw8a7ccc080L84VXsdNPtKeE-8RXfhfS3owZfq0geCNjkMt-Q
Message-ID: <CACzwLxi5AKT_81ej4AZ1ztsncBDY4jDJCyWboF0X9-kiH_=NMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com, 
	andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, glider@google.com, dvyukov@google.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	davidgow@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 12:20=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> On Fri, Aug 8, 2025 at 10:03=E2=80=AFPM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 08/08/2025 =C3=A0 17:33, Sabyrzhan Tasbolatov a =C3=A9crit :
> > > On Fri, Aug 8, 2025 at 10:03=E2=80=AFAM Christophe Leroy
> > > <christophe.leroy@csgroup.eu> wrote:
> > >>
> > >>
> > >>
> > >> Le 07/08/2025 =C3=A0 21:40, Sabyrzhan Tasbolatov a =C3=A9crit :
> > >>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] tha=
t need
> > >>> to defer KASAN initialization until shadow memory is properly set u=
p,
> > >>> and unify the static key infrastructure across all KASAN modes.
> > >>
> > >> That probably desserves more details, maybe copy in informations fro=
m
> > >> the top of cover letter.
> > >>
> > >> I think there should also be some exeplanations about
> > >> kasan_arch_is_ready() becoming kasan_enabled(), and also why
> > >> kasan_arch_is_ready() completely disappear from mm/kasan/common.c
> > >> without being replaced by kasan_enabled().
> > >>
> > >>>
> > >>> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
> > >>>
> > >>> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D217049&data=3D05%7C02%7C=
christophe.leroy%40csgroup.eu%7Cfe4f5a759ad6452b047408ddd691024a%7C8b87af7d=
86474dc78df45f69a2011bb5%7C0%7C0%7C638902640503259176%7CUnknown%7CTWFpbGZsb=
3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp=
bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUM4uvQihJdeWwcC6DIiJXbn4wGsrijjRc=
Hc55uCMErI%3D&reserved=3D0
> > >>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > >>> ---
> > >>> Changes in v5:
> > >>> - Unified patches where arch (powerpc, UML, loongarch) selects
> > >>>     ARCH_DEFER_KASAN in the first patch not to break
> > >>>     bisectability
> > >>> - Removed kasan_arch_is_ready completely as there is no user
> > >>> - Removed __wrappers in v4, left only those where it's necessary
> > >>>     due to different implementations
> > >>>
> > >>> Changes in v4:
> > >>> - Fixed HW_TAGS static key functionality (was broken in v3)
> > >>> - Merged configuration and implementation for atomicity
> > >>> ---
> > >>>    arch/loongarch/Kconfig                 |  1 +
> > >>>    arch/loongarch/include/asm/kasan.h     |  7 ------
> > >>>    arch/loongarch/mm/kasan_init.c         |  8 +++----
> > >>>    arch/powerpc/Kconfig                   |  1 +
> > >>>    arch/powerpc/include/asm/kasan.h       | 12 ----------
> > >>>    arch/powerpc/mm/kasan/init_32.c        |  2 +-
> > >>>    arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
> > >>>    arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
> > >>>    arch/um/Kconfig                        |  1 +
> > >>>    arch/um/include/asm/kasan.h            |  5 ++--
> > >>>    arch/um/kernel/mem.c                   | 10 ++++++--
> > >>>    include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--=
------
> > >>>    include/linux/kasan.h                  |  6 +++++
> > >>>    lib/Kconfig.kasan                      |  8 +++++++
> > >>>    mm/kasan/common.c                      | 17 ++++++++++----
> > >>>    mm/kasan/generic.c                     | 19 +++++++++++----
> > >>>    mm/kasan/hw_tags.c                     |  9 +-------
> > >>>    mm/kasan/kasan.h                       |  8 ++++++-
> > >>>    mm/kasan/shadow.c                      | 12 +++++-----
> > >>>    mm/kasan/sw_tags.c                     |  1 +
> > >>>    mm/kasan/tags.c                        |  2 +-
> > >>>    21 files changed, 100 insertions(+), 69 deletions(-)
> > >>>
> > >>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > >>> index f0abc38c40a..cd64b2bc12d 100644
> > >>> --- a/arch/loongarch/Kconfig
> > >>> +++ b/arch/loongarch/Kconfig
> > >>> @@ -9,6 +9,7 @@ config LOONGARCH
> > >>>        select ACPI_PPTT if ACPI
> > >>>        select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> > >>>        select ARCH_BINFMT_ELF_STATE
> > >>> +     select ARCH_DEFER_KASAN if KASAN
> > >>
> > >> Instead of adding 'if KASAN' in all users, you could do in two steps=
:
> > >>
> > >> Add a symbol ARCH_NEEDS_DEFER_KASAN.
> > >>
> > >> +config ARCH_NEEDS_DEFER_KASAN
> > >> +       bool
> > >>
> > >> And then:
> > >>
> > >> +config ARCH_DEFER_KASAN
> > >> +       def_bool
> > >> +       depends on KASAN
> > >> +       depends on ARCH_DEFER_KASAN
> > >> +       help
> > >> +         Architectures should select this if they need to defer KAS=
AN
> > >> +         initialization until shadow memory is properly set up. Thi=
s
> > >> +         enables runtime control via static keys. Otherwise, KASAN =
uses
> > >> +         compile-time constants for better performance.
> > >>
> > >
> > > Actually, I don't see the benefits from this option. Sorry, have just
> > > revisited this again.
> > > With the new symbol, arch (PowerPC, UML, LoongArch) still needs selec=
t
> > > 2 options:
> > >
> > > select ARCH_NEEDS_DEFER_KASAN
> > > select ARCH_DEFER_KASAN
> >
> > Sorry, my mistake, ARCH_DEFER_KASAN has to be 'def_bool y'. Missing the
> > 'y'. That way it is automatically set to 'y' as long as KASAN and
> > ARCH_NEEDS_DEFER_KASAN are selected. Should be:
> >
> > config ARCH_DEFER_KASAN
> >         def_bool y
> >         depends on KASAN
> >         depends on ARCH_NEEDS_DEFER_KASAN
> >
> >
> > >
> > > and the oneline with `if` condition is cleaner.
> > > select ARCH_DEFER_KASAN if KASAN
>
> Hello,
>
> Have just had a chance to test this.
>
> lib/Kconfig.kasan:
>         config ARCH_NEEDS_DEFER_KASAN
>                 bool
>
>         config ARCH_DEFER_KASAN
>                 def_bool y
>                 depends on KASAN
>                 depends on ARCH_NEEDS_DEFER_KASAN

Setting Kconfig.kasan without KASAN works fine for 3 arch that selects
ARCH_DEFER_KASAN:

config ARCH_DEFER_KASAN
       def_bool y
       depends on ARCH_NEEDS_DEFER_KASAN

Going to send v6 soon.

P.S.: Fixed email of David Gow.

>
> It works for UML defconfig where arch/um/Kconfig is:
>
> config UML
>         bool
>         default y
>         select ARCH_NEEDS_DEFER_KASAN
>         select ARCH_DEFER_KASAN if STATIC_LINK
>
> But it prints warnings for PowerPC, LoongArch:
>
> config LOONGARCH
>         bool
>         ...
>         select ARCH_NEEDS_DEFER_KASAN
>         select ARCH_DEFER_KASAN
>
> $ make defconfig ARCH=3Dloongarch
> *** Default configuration is based on 'loongson3_defconfig'
>
> WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
>   Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
>   Selected by [y]:
>   - LOONGARCH [=3Dy]
>
>
> config PPC
>         bool
>         default y
>         select ARCH_DEFER_KASAN if PPC_RADIX_MMU
>         select ARCH_NEEDS_DEFER_KASAN
>
> $ make ppc64_defconfig
>
> WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
>   Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
>   Selected by [y]:
>   - PPC [=3Dy] && PPC_RADIX_MMU [=3Dy]
>
>
> > >
> >
> > I don't think so because it requires all architectures to add 'if KASAN=
'
> > which is not convenient.
> >
> > Christophe
