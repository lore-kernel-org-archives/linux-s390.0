Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC033D8;
	Sun, 10 Aug 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810452; cv=none; b=HYQgLJfF+fndYQHTdcjz391G8XeENXTb3VczELyI5BefBa+Zaf6/xe1I3aWTCDMYJRzDxAAjq4//NePgzyImlajd6czax+zFV+rW5n+dlWB4gyeI6dfhrsmnbQXjbZmAUA3puCcl65zY/wgp/USdGQCf71MWbPNEzv64pRausM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810452; c=relaxed/simple;
	bh=scfy66HRB7KvLXp7opCve0WZSjDyLXKK8JYRci2APzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyUcS56LVDtLcz/Bpo+E3H+f/FB2DtKj6DXJaJz5tZHdJ79rfUNsT8PBMdPZW8Iuh1tDEkJsLWh236kith+OqxF8JsWJOlhNnWGSS1v8DRkJ9ftoAk/UNwPuEko6i4Qf7so+03rDm4Qe20+zLGq38gVIR/hmfNCqVNS3+drAavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik4+gsqc; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik4+gsqc"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3322bb2ac6eso26310361fa.0;
        Sun, 10 Aug 2025 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754810449; x=1755415249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpwULXc7N4PVrAxnhzJUCLFsDhMEPa8K20pRMtf9QU4=;
        b=Ik4+gsqcMAszW0zthiBROopvxQPHyKN8riQyF7zaVDf8CwQwwXNrHV76qFEeRaQMtj
         SX47gE7/jFjGsJdLJKRo0wTaT/6YnlZx2l9OMq6CgqHHUa8IzhnA3PmRx3nxgEEax9Zb
         EN5cOzB1UAOjdjuRVRfu5ZLkcwQTdgeyh0ZpKS2tkd23YwZY5zL7BsbRoCeQaaAhTVKI
         sazyyoEhcMRS8uhAb+AqilEqEezEL8pVTxaGnjJh2hST4CQi41HAZ0UwYl5PJz9bcqEE
         a6Mv9YftBRL++r4lGkAr/1y2/wdUZLCO4WhuxHCRPpkSN/Y+VChO0ZGC/lu3pAIe2kCX
         Ab9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810449; x=1755415249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpwULXc7N4PVrAxnhzJUCLFsDhMEPa8K20pRMtf9QU4=;
        b=GNUvdezzyyusUI0QXlO9IWbjx+ShwFFqM0VY64Pc6dZOMbp2fPRffEZ5UQxu1GjkvO
         pCqsXKBA/iIk4aH2QY+Gldl2FR7sbEMDC7jI2JkIwK73cf4JBWDc+HP0cBvIa3OuLU4q
         D7yaFzQ7IE77RbjaZyB/M40F+Wqv/oM2qnODe7AladLiA07bkE+D4ulagtHR7Xwt8/HN
         eYCmpQsbtbcA1QQGU3aroHtDohJWVvga/za0EwQGtwTFhZQuCY62U13P+xH7qIHjXnrn
         BbiooG4+3ahaWTSkorYWA6KNlTtAdWppZSPjjXBvTsnN8KsBcNhGkGHH6/tCFDNAtpjX
         vMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ptgk+6Fbo8gf5vpnwO+qlGa3N0sm3fZG311ctzAKCqv/BNyNOQjutjJ5lWuI/25ES/UR+sswENhK0Q==@vger.kernel.org, AJvYcCXGVylT28H3M3S8oEd2z3VqwLDRzFKw4Os5hEKElD5vkzE5n89a4t4DwuYesUOW7AXRFIpXzM5fN8xMCOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCM29c5pJrhcVwUcciAvAB1j3ChkIkdSEz2U3b9i5TpQ6Pctxv
	oF+YUU1hID4fRTiNvcp2tpklNozMW7Sk4UJXYgjq8/KHt0r29Wx3w0TTwEVYXTYS5QzKz1BTvJK
	fJAjNUP7t4vWXfd/+r1bsfIbG5CGuNMk=
X-Gm-Gg: ASbGncst3/UjgU5BzMU6/F7L/iG3c8m4qxvyOc1WjcgySz1toAr+Lr0nbrfK0yMWuL8
	WBOtfTPbPbDJkTsQH4PINj688fm7XE3qDlquX5tBtOL1+N9LP60FL6sder6FrzU9QEY99HttPLp
	BE50dJEMD+Cw2WfqfU+5RYv1hchL2Al2YBV6fHyh3yIU0xbpqFYmQgJbCj1FoPEfwDES4g4vazT
	+X7zAAizz6JmfMO8KOdQaFBgnj0xUlP82nd/XU=
X-Google-Smtp-Source: AGHT+IEATVB+zShs5UtXixRak2GiQ/zc6xtl1NlPiWHkLLcdmonSWNJDigg98acT6MlYwLuyv4giEoaQ9ZJ5gULbnFg=
X-Received: by 2002:a2e:96cc:0:b0:32f:425b:3278 with SMTP id
 38308e7fff4ca-333a22ede04mr18232851fa.25.1754810448509; Sun, 10 Aug 2025
 00:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807194012.631367-1-snovitoll@gmail.com> <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu> <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
 <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu>
In-Reply-To: <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 10 Aug 2025 12:20:31 +0500
X-Gm-Features: Ac12FXxZS7GKPiKLVRILyIcM2smc0R0yETsf0Ytt07yeIUtr59o1Bn8VVZobpbU
Message-ID: <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com, 
	andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, davidgow@google.co, glider@google.com, 
	dvyukov@google.com, alex@ghiti.fr, agordeev@linux.ibm.com, 
	vincenzo.frascino@arm.com, elver@google.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:03=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/08/2025 =C3=A0 17:33, Sabyrzhan Tasbolatov a =C3=A9crit :
> > On Fri, Aug 8, 2025 at 10:03=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 07/08/2025 =C3=A0 21:40, Sabyrzhan Tasbolatov a =C3=A9crit :
> >>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that =
need
> >>> to defer KASAN initialization until shadow memory is properly set up,
> >>> and unify the static key infrastructure across all KASAN modes.
> >>
> >> That probably desserves more details, maybe copy in informations from
> >> the top of cover letter.
> >>
> >> I think there should also be some exeplanations about
> >> kasan_arch_is_ready() becoming kasan_enabled(), and also why
> >> kasan_arch_is_ready() completely disappear from mm/kasan/common.c
> >> without being replaced by kasan_enabled().
> >>
> >>>
> >>> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
> >>>
> >>> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D217049&data=3D05%7C02%7Cch=
ristophe.leroy%40csgroup.eu%7Cfe4f5a759ad6452b047408ddd691024a%7C8b87af7d86=
474dc78df45f69a2011bb5%7C0%7C0%7C638902640503259176%7CUnknown%7CTWFpbGZsb3d=
8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbC=
IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUM4uvQihJdeWwcC6DIiJXbn4wGsrijjRcHc=
55uCMErI%3D&reserved=3D0
> >>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> >>> ---
> >>> Changes in v5:
> >>> - Unified patches where arch (powerpc, UML, loongarch) selects
> >>>     ARCH_DEFER_KASAN in the first patch not to break
> >>>     bisectability
> >>> - Removed kasan_arch_is_ready completely as there is no user
> >>> - Removed __wrappers in v4, left only those where it's necessary
> >>>     due to different implementations
> >>>
> >>> Changes in v4:
> >>> - Fixed HW_TAGS static key functionality (was broken in v3)
> >>> - Merged configuration and implementation for atomicity
> >>> ---
> >>>    arch/loongarch/Kconfig                 |  1 +
> >>>    arch/loongarch/include/asm/kasan.h     |  7 ------
> >>>    arch/loongarch/mm/kasan_init.c         |  8 +++----
> >>>    arch/powerpc/Kconfig                   |  1 +
> >>>    arch/powerpc/include/asm/kasan.h       | 12 ----------
> >>>    arch/powerpc/mm/kasan/init_32.c        |  2 +-
> >>>    arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
> >>>    arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
> >>>    arch/um/Kconfig                        |  1 +
> >>>    arch/um/include/asm/kasan.h            |  5 ++--
> >>>    arch/um/kernel/mem.c                   | 10 ++++++--
> >>>    include/linux/kasan-enabled.h          | 32 ++++++++++++++++++----=
----
> >>>    include/linux/kasan.h                  |  6 +++++
> >>>    lib/Kconfig.kasan                      |  8 +++++++
> >>>    mm/kasan/common.c                      | 17 ++++++++++----
> >>>    mm/kasan/generic.c                     | 19 +++++++++++----
> >>>    mm/kasan/hw_tags.c                     |  9 +-------
> >>>    mm/kasan/kasan.h                       |  8 ++++++-
> >>>    mm/kasan/shadow.c                      | 12 +++++-----
> >>>    mm/kasan/sw_tags.c                     |  1 +
> >>>    mm/kasan/tags.c                        |  2 +-
> >>>    21 files changed, 100 insertions(+), 69 deletions(-)
> >>>
> >>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >>> index f0abc38c40a..cd64b2bc12d 100644
> >>> --- a/arch/loongarch/Kconfig
> >>> +++ b/arch/loongarch/Kconfig
> >>> @@ -9,6 +9,7 @@ config LOONGARCH
> >>>        select ACPI_PPTT if ACPI
> >>>        select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> >>>        select ARCH_BINFMT_ELF_STATE
> >>> +     select ARCH_DEFER_KASAN if KASAN
> >>
> >> Instead of adding 'if KASAN' in all users, you could do in two steps:
> >>
> >> Add a symbol ARCH_NEEDS_DEFER_KASAN.
> >>
> >> +config ARCH_NEEDS_DEFER_KASAN
> >> +       bool
> >>
> >> And then:
> >>
> >> +config ARCH_DEFER_KASAN
> >> +       def_bool
> >> +       depends on KASAN
> >> +       depends on ARCH_DEFER_KASAN
> >> +       help
> >> +         Architectures should select this if they need to defer KASAN
> >> +         initialization until shadow memory is properly set up. This
> >> +         enables runtime control via static keys. Otherwise, KASAN us=
es
> >> +         compile-time constants for better performance.
> >>
> >
> > Actually, I don't see the benefits from this option. Sorry, have just
> > revisited this again.
> > With the new symbol, arch (PowerPC, UML, LoongArch) still needs select
> > 2 options:
> >
> > select ARCH_NEEDS_DEFER_KASAN
> > select ARCH_DEFER_KASAN
>
> Sorry, my mistake, ARCH_DEFER_KASAN has to be 'def_bool y'. Missing the
> 'y'. That way it is automatically set to 'y' as long as KASAN and
> ARCH_NEEDS_DEFER_KASAN are selected. Should be:
>
> config ARCH_DEFER_KASAN
>         def_bool y
>         depends on KASAN
>         depends on ARCH_NEEDS_DEFER_KASAN
>
>
> >
> > and the oneline with `if` condition is cleaner.
> > select ARCH_DEFER_KASAN if KASAN

Hello,

Have just had a chance to test this.

lib/Kconfig.kasan:
        config ARCH_NEEDS_DEFER_KASAN
                bool

        config ARCH_DEFER_KASAN
                def_bool y
                depends on KASAN
                depends on ARCH_NEEDS_DEFER_KASAN

It works for UML defconfig where arch/um/Kconfig is:

config UML
        bool
        default y
        select ARCH_NEEDS_DEFER_KASAN
        select ARCH_DEFER_KASAN if STATIC_LINK

But it prints warnings for PowerPC, LoongArch:

config LOONGARCH
        bool
        ...
        select ARCH_NEEDS_DEFER_KASAN
        select ARCH_DEFER_KASAN

$ make defconfig ARCH=3Dloongarch
*** Default configuration is based on 'loongson3_defconfig'

WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
  Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
  Selected by [y]:
  - LOONGARCH [=3Dy]


config PPC
        bool
        default y
        select ARCH_DEFER_KASAN if PPC_RADIX_MMU
        select ARCH_NEEDS_DEFER_KASAN

$ make ppc64_defconfig

WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
  Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
  Selected by [y]:
  - PPC [=3Dy] && PPC_RADIX_MMU [=3Dy]


> >
>
> I don't think so because it requires all architectures to add 'if KASAN'
> which is not convenient.
>
> Christophe
