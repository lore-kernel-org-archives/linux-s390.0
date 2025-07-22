Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EE2EAB81;
	Tue, 22 Jul 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193845; cv=none; b=NYs/N7oO8Zf03U1cOdPHWi2V5ixOolldJeLEhv8PMn91BzNrMvS/bV9mwkGvEYQEXV8lFFdjg781y+AwRt2ZV7TmFQ2wtgJgHkTekDCePzpl5Tt3Np9ODtzG/NKN/ZVybIrfgcp5vNi4sRGQxb4UB+KT3e2p6uqWHqZuS1ro9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193845; c=relaxed/simple;
	bh=axJYq4Frwz+HCXgH3qKDKlCyZ6fEwVHXZlEM3IuVC/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8P+CAYXI/Wovyo9OcNSbvyaKzDwAbjUWBxBo1eEeZVnHWWkiajhgwqJO9itATjy4yGC2KzaxzW2GeZw01nhKQPk57D19w6HMPTshdpshJfAkrRQg0yP5xdRThNMrEuwxJ+zAv280eR3fhs1f+Zyq5UnvweCN1Qk/lgL67LW0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMNFtWgS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMNFtWgS"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso43279181fa.1;
        Tue, 22 Jul 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193842; x=1753798642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GboL0eWXtD3fDsEKzgJ1xepA1JQohVF9co6pstDgRM8=;
        b=hMNFtWgSkgTtaVAA7JxBo9YxeBorffJV0d6XUsSWPsXVpwMmVCcKErBjVS/j/iFI2f
         mXuYW0dJf2slhe41dFIQjacxF4qWaP4crDRdafMnB+iUvMhXjbRYggBERVKcqQEcWUTi
         xLV5EY1bWZV+5U7Afstl6uOhaIBMbs+RmZRDYXiXHdS291rqltJ6CNCuAanvaqsGyslE
         iQ6Zt8aV0pkq3+SsaP+m5N+aWtdjK8uylqj8bjgCShz4BMMVUbbZNrT1icbYzvP9NYCH
         HIeO0AyYwssR5C5jpYtUWZo/PZhHBHZAIxsQ5i2shkO21C8qf0AruK9JnD65Bwq+xe5M
         xuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193842; x=1753798642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GboL0eWXtD3fDsEKzgJ1xepA1JQohVF9co6pstDgRM8=;
        b=ufA5j1thl48fvZN94kzkwg8b9hXoar6R+DacUQcS+ayb+p+tNvj6Rkb2iwxD3qS+q3
         R+fWQwUchOsl86NH/ah/9T+WkmdaMthYNmqsjbZNovyVNdv7Ux008MjTC5lJTjqk28/I
         ErbD6MdsrDvb0k6fDE9OFZnX7+Emkix6ambMl9tz0FH9vsF4hCy4sH6LVLom2Xtp6ngZ
         vN3N7eKPOe6n586QxdBmuG4K+Q3U6LMUytmWbwj7JjH5vF+c4Pso81uI4MKNgIvYMUpT
         iyWSU67QgchOT9Rpkm1SD8Fpz8HB/oKZ8C8Ys4FJcQR1d2ueJTfNy2rqahRgRaBbpI0R
         R2UA==
X-Forwarded-Encrypted: i=1; AJvYcCVI5yFGZu4dhS1K2Cylf8nV64u5og/gxJjw0xNr2yTYK6SKfoVVcq9DgVJ8dm7uPPCiPseaedXJloeqh3o=@vger.kernel.org, AJvYcCX5cjdo65S/ZMnJFQvUqGKD3QlqWa2cYbmqR1+bKvu43APe3+7yBEN8/yPCTsqT5Vs4Imhp8J7f9j6dRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRqNgBTpbSPY1OFWcYXMwJl+h1T7KovFvKXFOcbO1U4yeEtwI
	SyEJ8c6ASo9952wZ7rvNJLMuycnoycNulRZq07QIkali9kQQ3M/Rr/Y6yH1ArcXz1QLPyKs4bep
	9/6AKzC8N39qKxmGWOD3XjSqMGtwhU1A=
X-Gm-Gg: ASbGncvm4eyj/OXXO4T5GoLd8Ilx4wOpuCZPJ883lrgz/gXEuq2R7DYCOywOPlVwOgy
	Ifs/RLsb1by8Yq8M+ktUdnG3bCQbPAGPCr4cQMmOc/9Z9vqDgnLA7aahTKgZyurzM3WJtWJHwJf
	1VykFVMpk9EPHmN4JA0jSx5WWMBumpfqcbl5gLTZ87XmvPAsjwFolhutogs3YbXksNbzRaXSbG/
	bOnLRU=
X-Google-Smtp-Source: AGHT+IHWyFSdlAJ08NCU6ABmF9BGYFP4zXRYUy0aJCm6G+P21nbWRd00HVhqfmwkvmBdoun3tyqTRuImHuMXXJuHVwM=
X-Received: by 2002:a05:651c:110d:b0:32b:75f0:cfa4 with SMTP id
 38308e7fff4ca-3308f5c95f9mr70998461fa.25.1753193841372; Tue, 22 Jul 2025
 07:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-9-snovitoll@gmail.com>
 <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
In-Reply-To: <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 19:17:03 +0500
X-Gm-Features: Ac12FXzF_nEInn7KovIF1rCbPeOEkryRpoS2Hx7q1NkLYIXq7eXxsmx3CUCidIg
Message-ID: <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:00=E2=80=AFAM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> > UserMode Linux needs deferred KASAN initialization as it has a custom
> > kasan_arch_is_ready() implementation that tracks shadow memory readines=
s
> > via the kasan_um_is_ready flag.
> >
> > Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> > for runtime KASAN control. Call kasan_init_generic() which handles
> > Generic KASAN initialization and enables the static key.
> >
> > Delete the key kasan_um_is_ready in favor of the unified kasan_enabled(=
)
> > interface.
> >
> > Note that kasan_init_generic has __init macro, which is called by
> > kasan_init() which is not marked with __init in arch/um code.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > Changes in v3:
> > - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
> > ---
> >  arch/um/Kconfig             | 1 +
> >  arch/um/include/asm/kasan.h | 5 -----
> >  arch/um/kernel/mem.c        | 4 ++--
> >  3 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index f08e8a7fac9..fd6d78bba52 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -8,6 +8,7 @@ config UML
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_HAS_CPU_FINALIZE_INIT
> >       select ARCH_HAS_FORTIFY_SOURCE
> > +     select ARCH_DEFER_KASAN
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >       select ARCH_HAS_KCOV
> >       select ARCH_HAS_STRNCPY_FROM_USER
> > diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> > index f97bb1f7b85..81bcdc0f962 100644
> > --- a/arch/um/include/asm/kasan.h
> > +++ b/arch/um/include/asm/kasan.h
> > @@ -24,11 +24,6 @@
> >
> >  #ifdef CONFIG_KASAN
> >  void kasan_init(void);
> > -extern int kasan_um_is_ready;
> > -
> > -#ifdef CONFIG_STATIC_LINK
> > -#define kasan_arch_is_ready() (kasan_um_is_ready)
> > -#endif
> >  #else
> >  static inline void kasan_init(void) { }
> >  #endif /* CONFIG_KASAN */
> > diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> > index 76bec7de81b..058cb70e330 100644
> > --- a/arch/um/kernel/mem.c
> > +++ b/arch/um/kernel/mem.c
> > @@ -21,9 +21,9 @@
> >  #include <os.h>
> >  #include <um_malloc.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/kasan.h>
> >
> >  #ifdef CONFIG_KASAN
> > -int kasan_um_is_ready;
> >  void kasan_init(void)
> >  {
> >       /*
> > @@ -32,7 +32,7 @@ void kasan_init(void)
> >        */
> >       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> >       init_task.kasan_depth =3D 0;
> > -     kasan_um_is_ready =3D true;
> > +     kasan_init_generic();
>
> I think this runs before jump_label_init(), and static keys shouldn't be =
switched before that.>  }

I got the warning in my local compilation and from kernel CI [1].

arch/um places kasan_init() in own `.kasan_init` section, while
kasan_init_generic() is called from __init.
Could you suggest a way how I can verify the functions call order?

I need to familiarize myself with how to run arch/um locally and try
to fix this warning.

[1] https://lore.kernel.org/all/CACzwLxicmky4CRdmABtN8m2cr2EpuMxLPqeF5Hk375=
cN2Kvu-Q@mail.gmail.com/

> >
> >  static void (*kasan_init_ptr)(void)
>
