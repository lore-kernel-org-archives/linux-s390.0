Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00428D8EB;
	Wed,  6 Aug 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489725; cv=none; b=NYNAsn52vN3vdUL3C0RlWI1vfpzsRkZmxgv8nsgxRXtEZwbQhXOCzjXIVg1NPhEI65/XAzYM906UqKZ509jQzIArwcgxFlab/NtYsFWiYtBc/SqULcN5o5CcPsO/jQuW9j44KVmrZoz4N0nhCj4gMhvxYyC8CSTe0cpk746c6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489725; c=relaxed/simple;
	bh=U7dlzHue4VhWRIDqsRai/aSFudxQE0s2ZhnoNyUgtAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuHOkP/YvADIoqxf9CA83TWZSYxNhRwVghkqmHTdF1N8ohi/xVqp7RKT3Wnnbv7Jrzm4DSOVLmc/bufy4LE+kEmiLN6aPPA1qA4WpGTBXI8bIx44/si3VaEMgl86Ago36vh6OUx9ZTTs5ORMkp0/euc+vTzov5QFlrorsXW440g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKQecTvN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKQecTvN"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b975b459aso5528233e87.3;
        Wed, 06 Aug 2025 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754489718; x=1755094518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHHtXBq5WO+vvcc0f+jtGoFoRXRDF9tjNLE6vwGhp98=;
        b=VKQecTvNTGoIfTL1WP+PzFxkt9bjctekdguwMxH51jYXXlfNFkCEdlAWH6GR+Vh5Ot
         RHlAwbOwdB0qtBUifPNG5kTN3MJ5GeRITY0znmRpRvU/6IPkXfkb3pNRlPpwilZlJ4/X
         26Mlmhv5xzFxmJ+Zlw/O+w3mwDaXLDOTHL4ALG15Aq09Oct1lN1mqx4kEcbTQFjMtB18
         /MMSw+micH8xcZJO928hGW2C6CLVzY1IjBRwfsPsFAI6BZgXcK9EBqaAm2HHFVbigSL2
         nHg3yWQKAXoJlOn6kk0fRZWv5lnOtityi+DSsfh9NmI/IZUoEBfgs0+88B00s2HG2N27
         8JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489718; x=1755094518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHHtXBq5WO+vvcc0f+jtGoFoRXRDF9tjNLE6vwGhp98=;
        b=mD9vaQvRhCrPkviLoU5Nmpae/9bcXEKEbH0Megpgm/oFXU9XFd5nrAi6EUARMSCqTp
         s7I5X+TAXoPkETqyjiplh8Qf50o9HgU1EeTfWoPEATPxI8SgFugR9RLJVce3ET0Yj257
         4KqtvFSYIig75vIJeWvOVasaA3dDNdyyOmd0DTWWSx5DoR9D9LL+hAaOJoy4Gk6t7PQD
         lNeWcJaGGaBG3qkGTIdJrbUwZOMyXZfO8L8v5/iPjHsbwFlnqlqw6BYG+cJWWnto2zUP
         uSW0UOc92oroqhDY4qSkp943aAeTljrgDHr8L5Akd2pPQ+Kq2JOm2kRuG0xPnmjFoLCO
         i+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWF9U1l94CCxwe55PCpgELpwqprOtQrhf/GqhCiVDvd9xcdcSUH/wLBNCznQji0sa9Q/MAoR36rgwqktMw=@vger.kernel.org, AJvYcCWG6YX23Eijs7ckjBRLfJ5TxGw516cOKqO3lxXBgHEGZWRQsQNjMjTJ6df7mDDzpEQ8lSwAx5osKgWaPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdWPoCV04jPVQx666smxyKPiJu+0eu+1Ij3lndxXSeigaZUfd
	9rdE67ba5b7vC0UYWA3ejk+fBHEyG+CofKYMe+lDvjbmmO0a14/AibGOvLnG1KrGtJggC5ocsfM
	B64iKUlLWmM9u84viLaxIPSrNguMIZbk=
X-Gm-Gg: ASbGncuK4ANhzAsZDrzgi+oboBlTUWdT9oqtGPU8ncve2TNejaNOkO4+3pfm+1xEnAN
	Ap0A6pKmdpZ3CceMeMw8Wr0NWItz2tONf4YaYWPQlijyGUgp98iC0SZL1JmzpCktvX3nONVkHKe
	5bhcv5HgW6uMTk45Ar2AZVI95FhQI375zSoyNnPeGfW5x4j8nQll14DbsUEPt8oWBF2YrsIcRJX
	63PWC4pomL2QHi3rw==
X-Google-Smtp-Source: AGHT+IGJIXTvnACCtHBTy4xxxFNjsKAhes5Wv7IRo3RcAz7+56gG6smaMf7pNYbDbu4cgI3F5Fzl+OIwDZB8GhsMAoI=
X-Received: by 2002:a05:6512:144c:10b0:55a:90b:7a37 with SMTP id
 2adb3069b0e04-55caf3b36c2mr652245e87.50.1754489718011; Wed, 06 Aug 2025
 07:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805142622.560992-1-snovitoll@gmail.com> <20250805142622.560992-2-snovitoll@gmail.com>
 <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
In-Reply-To: <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 19:15:01 +0500
X-Gm-Features: Ac12FXyPyQ2NShErRdFgyvw5rZUg2mPvtAtIHmw2QjkFVe_vIUdzA6ST_4dfZTU
Message-ID: <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com, 
	glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 6:35=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
>
>
> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> > Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> > to defer KASAN initialization until shadow memory is properly set up,
> > and unify the static key infrastructure across all KASAN modes.
> >
> > Some architectures (like PowerPC with radix MMU) need to set up their
> > shadow memory mappings before KASAN can be safely enabled, while others
> > (like s390, x86, arm) can enable KASAN much earlier or even from the
> > beginning.
> >
> > Historically, the runtime static key kasan_flag_enabled existed only fo=
r
> > CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
> > architecture-specific kasan_arch_is_ready() implementations or evaluate=
d
> > KASAN checks unconditionally, leading to code duplication.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > Changes in v4:
> > - Fixed HW_TAGS static key functionality (was broken in v3)
>
> I don't think it fixed. Before you patch kasan_enabled() esentially
> worked like this:
>
>  if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>         return static_branch_likely(&kasan_flag_enabled);
>  else
>         return IS_ENABLED(CONFIG_KASAN);
>
> Now it's just IS_ENABLED(CONFIG_KASAN);

In v4 it is:

        #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAG=
S)
        static __always_inline bool kasan_shadow_initialized(void)
        {
                return static_branch_likely(&kasan_flag_enabled);
        }
        #else
        static __always_inline bool kasan_shadow_initialized(void)
        {
                return kasan_enabled(); // which is IS_ENABLED(CONFIG_KASAN=
);
        }
        #endif

So for HW_TAGS, KASAN is enabled in kasan_init_hw_tags().

>
> And there are bunch of kasan_enabled() calls left whose behavior changed =
for
> no reason.

By having in v5 the only check kasan_enabled() and used in current mainline=
 code
should be right. I've addressed this comment below. Thanks!

>
>
> > - Merged configuration and implementation for atomicity
> > ---
> >  include/linux/kasan-enabled.h | 36 +++++++++++++++++++++++-------
> >  include/linux/kasan.h         | 42 +++++++++++++++++++++++++++--------
> >  lib/Kconfig.kasan             |  8 +++++++
> >  mm/kasan/common.c             | 18 ++++++++++-----
> >  mm/kasan/generic.c            | 23 +++++++++++--------
> >  mm/kasan/hw_tags.c            |  9 +-------
> >  mm/kasan/kasan.h              | 36 +++++++++++++++++++++---------
> >  mm/kasan/shadow.c             | 32 ++++++--------------------
> >  mm/kasan/sw_tags.c            |  4 +++-
> >  mm/kasan/tags.c               |  2 +-
> >  10 files changed, 133 insertions(+), 77 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enable=
d.h
> > index 6f612d69ea0..52a3909f032 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -4,32 +4,52 @@
> >
> >  #include <linux/static_key.h>
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > +/* Controls whether KASAN is enabled at all (compile-time check). */
> > +static __always_inline bool kasan_enabled(void)
> > +{
> > +     return IS_ENABLED(CONFIG_KASAN);
> > +}
> >
> > +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> > +/*
> > + * Global runtime flag for KASAN modes that need runtime control.
> > + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
> > + */
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > -static __always_inline bool kasan_enabled(void)
> > +/*
> > + * Runtime control for shadow memory initialization or HW_TAGS mode.
> > + * Uses static key for architectures that need deferred KASAN or HW_TA=
GS.
> > + */
> > +static __always_inline bool kasan_shadow_initialized(void)
>
> Don't rename it, just leave as is - kasan_enabled().
> It's better name, shorter and you don't need to convert call sites, so
> there is less chance of mistakes due to unchanged kasan_enabled() -> kasa=
n_shadow_initialized().

I actually had the only check "kasan_enabled()" in v2, but went to
double check approach in v3
after this comment:
https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=3DApHfOnbAY3NqtFH=
ZvceZw@mail.gmail.com/

Ok, we will have the **only** check kasan_enabled() then in
kasan-enabled.h which

        #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAG=
S)
        static __always_inline bool kasan_enabled(void)
        {
                return static_branch_likely(&kasan_flag_enabled);
        }
        #else
        static inline bool kasan_enabled(void)
        {
                return IS_ENABLED(CONFIG_KASAN);
        }

And will remove kasan_arch_is_ready (current kasan_shadow_initialized in v4=
).

So it is the single place to check if KASAN is enabled for all arch
and internal KASAN code.
Same behavior is in the current mainline code but only for HW_TAGS.

Is this correct?

>
>
> >  {
> >       return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > -static inline bool kasan_hw_tags_enabled(void)
> > +static inline void kasan_enable(void)
> > +{
> > +     static_branch_enable(&kasan_flag_enabled);
> > +}
> > +#else
> > +/* For architectures that can enable KASAN early, use compile-time che=
ck. */
> > +static __always_inline bool kasan_shadow_initialized(void)
> >  {
> >       return kasan_enabled();
> >  }
> >
>
> ...
>
> >
> >  void kasan_populate_early_vm_area_shadow(void *start, unsigned long si=
ze);
> > -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> > +
> > +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> > +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned =
long size)
> > +{
> > +     if (!kasan_shadow_initialized())
> > +             return 0;
>
>
> What's the point of moving these checks to header?
> Leave it in C, it's easier to grep and navigate code this way.

Andrey Konovalov had comments [1] to avoid checks in C
by moving them to headers under __wrappers.

: 1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
: implementation and move these checks into include/linux/kasan.h (and
: add __wrappers when required).

[1] https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=3DApHfOnbAY3N=
qtFHZvceZw@mail.gmail.com/

>
>
> > +     return __kasan_populate_vmalloc(addr, size);
> > +}
> > +
> > +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
> >                          unsigned long free_region_start,
> >                          unsigned long free_region_end,
> >                          unsigned long flags);
> > +static inline void kasan_release_vmalloc(unsigned long start,
> > +                        unsigned long end,
> > +                        unsigned long free_region_start,
> > +                        unsigned long free_region_end,
> > +                        unsigned long flags)
> > +{
> > +     if (kasan_shadow_initialized())
> > +             __kasan_release_vmalloc(start, end, free_region_start,
> > +                        free_region_end, flags);
> > +}
> >
>
> ...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kme=
m_cache *cache, void *object,
> >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> >                               unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
> >               return false;
> >       return check_slab_allocation(cache, object, ip);
> >  }
> > @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache=
, void *object,
> >  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool in=
it,
> >                      bool still_accessible)
> >  {
> > -     if (!kasan_arch_is_ready() || is_kfence_address(object))
> > +     if (is_kfence_address(object))
> >               return false;
> >
> >       poison_slab_object(cache, object, init, still_accessible);
> > @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, vo=
id *object, bool init,
> >
> >  static inline bool check_page_allocation(void *ptr, unsigned long ip)
> >  {
> > -     if (!kasan_arch_is_ready())
> > -             return false;
> > -
>
>
> Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, =
so this breaks
> bisectability.
> Leave it, and remove with separate patch only when there are no users lef=
t.

Will do in v5 at the end of patch series.

>
> >       if (ptr !=3D page_address(virt_to_head_page(ptr))) {
> >               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_F=
REE);
> >               return true;
> > @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsig=
ned long ip)
> >               return true;
> >       }
> >
> > -     if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> > +     if (is_kfence_address(ptr))
> >               return true;
> >
> >       slab =3D folio_slab(folio);
>
>
