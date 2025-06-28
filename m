Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542E19597F;
	Sat, 28 Jun 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751117141; cv=none; b=he7jtuZlpwDcbkVWuTUmTKXD+aTILBjnuX0i3mGUUsUgZfBygzTGV/lHoz8tpJm8Nb4Br26m6Bnr7iEcSmb3FDfSwrLdJ99wXnSfMWf3/JWyPIfNxc29gYGfr3HRw15fK3nFyJa8wtt6VlZ/ZEwlvCjpbzT7rEOc7zBTacadCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751117141; c=relaxed/simple;
	bh=L9hXJHuBvyYPVmVbLpoMFR4H07JOmA06RF+Wl4Z/7RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu31DcXjXkeBCEW80dpHVEGaiyjBQS/9osdH/vV7ePQuYxtdijkGE7H4/nt6uDTmHrFLAz2khjldPhyp7ofQimCWMWATHvUEDk+JEe202K7V4zgskahyrGOr0QjkozpFVf84PuH67aiNY1/AjQnMqNjtQCEjDqts5jUGU6r8ydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/f7AyjI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/f7AyjI"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5535652f42cso3591522e87.2;
        Sat, 28 Jun 2025 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751117135; x=1751721935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9hXJHuBvyYPVmVbLpoMFR4H07JOmA06RF+Wl4Z/7RE=;
        b=d/f7AyjIMU+oDa7x4RBDKy1GUdVqLktnNHVDdpvD7ad4vQOiGuXJeqWVzkLIC891lR
         d4MFYemwDx9pC9s4bWleShtQ1tj+IiDM02juYWpyaAPbZfDzRfD1eG+UFtlLdJ9GYzy8
         wW7XaiIdvfID4YAhIO2nVgiPMwtd+KTsP1MM2N5v/hjRQbKI7UYTPvqoCOBUiETe6sXO
         tonCDI2b1qgxovmCQvJG2hIyZbOhQiPGQ5zmx3KHTN+ofraSamXAT/WOHgtWxXWWtpSF
         +D8QLBWmqF3Se1Mecjmo5C6IvCEXQaKMYsbB9A5iS9T6hSLBYBzIqCIiR9YhOy6JOOQ9
         R77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751117135; x=1751721935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9hXJHuBvyYPVmVbLpoMFR4H07JOmA06RF+Wl4Z/7RE=;
        b=sEmr6WOBvw1kYYKoR/Gg9utHy6DJ8yviSIzs2PWO+qLsp5E0FWuwTJh9w4sShDUo58
         txRz2UoFZCJB0Pj2am2Hwi3DWLJV/zB3CHu5Bmqtbfw8CZw22g/IxO0rT8FUrLiunPnH
         UOf0Y9pRh9VR4LRiSqcekJAf0NdgJYl6fXpSOUBDr1FmeOXqa58Qz0VE4WLuhyyNJclz
         PJQIrvoRE2hHO46EpZGvGCrDy4xcg84XzUhYQiOiahsHpdigX5n2d2zns/d96sSVinOQ
         tSRVl9tL4JX/0tCGJEdRlzolBcM6F9mjAx3L+AHxV5H5jGxG2z2Z/obzb4koQ6Tu+X0u
         G5rw==
X-Forwarded-Encrypted: i=1; AJvYcCW5HDFevWPT7TEMXps9DdaVCLQpBRsPNxH3JYoV9BtpWd2eN67k+rpVHH47gkctWnt50PPrhyy6kP0QKiM=@vger.kernel.org, AJvYcCWPUgrpzuL9vqlWCLnijJ2rgZeeRo+GkFEP52nKQW5jD9DiCA4uuokoH+97LpWv4HiU3BtF8uZ09gpvVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhUCOh2ibiN8YISbxs6Gvobz6c3TlskJXKVOdwBZq2BWYo0+X
	lHwYKbTQrja3KsAZNnLJ4guTWlJviXD7j5NlWxS7+Ht35xh5J8spGKhWTeGCmYcBBaYrWqPJWlC
	vXM1lwQosNfJiQQH1fhXRA+uLCPBazl0=
X-Gm-Gg: ASbGncvaYHnMQ20o9IRwxGlGDN6FA3993QIDKObfAI8ZUjAag4SKsCc/bSVhU/pnljZ
	FS7WylvwycTObAuDjo0wE3zMft5nbkN2rcF2AEq2MRPPLBkMrHAmmji0UqMJOlCGtNOheencE5U
	bpqjbe8+WyR2xkGPVaqiD1RnxounPywpDJ/m5zFC2SLrfemKA=
X-Google-Smtp-Source: AGHT+IGcgqdYgD7HxbDyPqcYV3Heu4fL1zBBGlE2pOeLSvkf48pz8fpRePfbVo/DnCDwvNyc5box4+f/veOvw14SJEw=
X-Received: by 2002:a05:6512:401e:b0:553:d1b0:1f1f with SMTP id
 2adb3069b0e04-5550b817bf9mr2031982e87.21.1751117135042; Sat, 28 Jun 2025
 06:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626153147.145312-1-snovitoll@gmail.com> <CA+fCnZfAtKWx=+to=XQBREhou=Snb0Yms4D8GNGaxE+BQUYm4A@mail.gmail.com>
In-Reply-To: <CA+fCnZfAtKWx=+to=XQBREhou=Snb0Yms4D8GNGaxE+BQUYm4A@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sat, 28 Jun 2025 18:25:17 +0500
X-Gm-Features: Ac12FXz_1yZEfUGAygYOxkSS_g1GpWf3Y2t1PdPyYRlgb0h3dTvUyL8mVDVK8Qk
Message-ID: <CACzwLxgsVkn98VDPpmm7pKcbvu87UBwPgYJmLfKixu4-x+yjSA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with kasan_enabled
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, arnd@arndb.de, rppt@kernel.org, 
	geert@linux-m68k.org, mcgrof@kernel.org, guoweikang.kernel@gmail.com, 
	tiwei.btw@antgroup.com, kevin.brodsky@arm.com, benjamin.berg@intel.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 3:57=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Thu, Jun 26, 2025 at 5:32=E2=80=AFPM Sabyrzhan Tasbolatov
> <snovitoll@gmail.com> wrote:
> >
> > This patch series unifies the kasan_arch_is_ready() and kasan_enabled()
> > interfaces by extending the existing kasan_enabled() infrastructure to
> > work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).
> >
> > Currently, kasan_enabled() only works for HW_TAGS mode using a static k=
ey,
> > while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-time
> > constant) or rely on architecture-specific kasan_arch_is_ready()
> > implementations with custom static keys and global variables.
> >
> > This leads to:
> > - Code duplication across architectures
> > - Inconsistent runtime behavior between KASAN modes
> > - Architecture-specific readiness tracking
> >
> > After this series:
> > - All KASAN modes use the same kasan_flag_enabled static key
> > - Consistent runtime enable/disable behavior across modes
> > - Simplified architecture code with unified kasan_init_generic() calls
> > - Elimination of arch specific kasan_arch_is_ready() implementations
> > - Unified vmalloc integration using kasan_enabled() checks
> >
> > This addresses the bugzilla issue [1] about making
> > kasan_flag_enabled and kasan_enabled() work for Generic mode,
> > and extends it to provide true unification across all modes.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
>
> Hi Sabyrzhan,
>
> Thank you for working on this!
>
> One aspect that is missing from the patches is moving the
> kasan_arch_is_ready() calls into the include/linux/kasan.h (this is
> not explicitly mentioned in the issue, but this is what the "adding
> __wrappers" part is about).
>
> Another thing that needs careful consideration is whether it's
> possible to combine kasan_arch_is_ready() and kasan_enabled() into the
> same check logically at all. There's one issue mentioned in [1]:

Hello,
I've removed kasan_arch_is_ready() at all in this series:
[PATCH v2 11/11] kasan: replace kasan_arch_is_ready with kasan_enabled

Is it not what's expected by unification?

>
> > In kasan_cache_create() we unconditionally allocate a metadata buffer,
> > but the kasan_init_slab_obj() call to initialise it is guarded by
> > kasan_enabled(). But later parts of the code only check the presence of
> > the buffer before using it, so bad things happen if kasan_enabled()
> > later turns on (I was getting some error about invalid lock state).
>
> And there might be other callbacks that should be executed even before
> kasan_init_...() completes. But then for the HW_TAGS mode, if
> kasan_enabled() is off, then we don't want to execute any callbacks.
>
> So maybe we do actually need a separate static key for
> kasan_arch_is_ready(). But even if so, it still makes sense to move
> kasan_arch_is_ready() into the __wrappers for the affected callbacks.
>
> Thanks!
>
> [1] https://lore.kernel.org/linux-mm/CA+fCnZf7JqTH46C7oG2Wk9NnLU7hgiVDEK0=
EA8RAtyr-KgkHdg@mail.gmail.com/
