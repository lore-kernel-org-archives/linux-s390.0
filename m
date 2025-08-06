Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7E4431;
	Wed,  6 Aug 2025 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754454959; cv=none; b=T2NT2/R1NLDnx9/FPmzbSxTr+2cashjmLuT//PBMOM3N1GUHd6T2QatE88C+hiPbT8NZRCIRLGsBjpeIrJWcfqJCKDSmReDD5461Y3nhwW3Z8bXz0xm29pWebJDZ/ADALAGycPveEffWqZ95b+dLXiOOSJlJGb4dQIRV+LmCOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754454959; c=relaxed/simple;
	bh=L4dAMNdxs5fFS1FgCXk66mFhuDrmslz7DTEP0cKO4eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+EFxNyMRV0NWRqEj95F66GmtIbow9n6KKgRti4vj5n4yhWrR6a6V/TdCm8OJ+9rhcq1P96lDYsPgxfUJZzCFFJBQ6vWnO29kbiYlGj1xbCuQyMRj4Xo9qo0Co6zASVKuRh1i16BJLf+2SbwmPAWqLe1CN6SZIbB1i/KKynNh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIIDV+Ar; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIIDV+Ar"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so47908741fa.0;
        Tue, 05 Aug 2025 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754454955; x=1755059755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyl+4iOlTi/aeKebUp39F24cwHyqM1kxjjt1F2AMIE8=;
        b=OIIDV+ArJ7S7uQiKoFRpL6AL1UA4PAt5/ar2iQLf9pQ4jmh7wVchrm5NRle5JJGZia
         cGMgNm+isf7abtee+8opbEWJ3mN9QghLNr5VBfqGSaT+1LZ9U5m7Ya/IEmnvcUvwXy1C
         Od7ZbBeNvEPXWwoeMiN8uMeu9aVypMb9U0FY3rXu4eh9X4c8pYYvhgukp4Ykor01Dgus
         ZF49npEbKccwYKwPFhSgt+IBNamjGJRiizyrTBt0VX3/OrJPxK1B1xFt1D1mODJgTWtT
         9eigMAXPENU9s/Z8JMQOx0rRtQigsZ2UF7QglTPCWlcMDPtLv7qYLyPmrR+E4JsNvP5B
         OaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754454955; x=1755059755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyl+4iOlTi/aeKebUp39F24cwHyqM1kxjjt1F2AMIE8=;
        b=QAIIBRgGI8CIUKiiEmhcjiJfWUQHev5Hy8pCnmfETQZ5VjtzOD9q7kx9l557gYsw4i
         v0xkeEKeDpGBfn6apNcP4eQ6XjQRvr6IGFryM6/bxHMzaZf2phwwDeQQgj8BsQBZ0Cph
         hjZGs39LyGTHdg9Tc4MNAh5K9WBb+1B7W8KuKs7N5/qslPbPwcUy0qE4uFXONjgY9zee
         UbecJTMb31Pcqlq4lVSJzQVtBvoS8J4Fw5d1H2aSmeQPCO7yt97mUbYpek8WP63CqPjS
         hgO5aZ3M/mdy6xwxJjJEW/ShnmsfjByvwcXv0lwI7cfqCsEPh9IaohRjvhsygVBx9Ttu
         NmSg==
X-Forwarded-Encrypted: i=1; AJvYcCX2GPGBJqXYb6nwTNtXMPACs8qynBqslgMwutNH9oEEPr1L0STrQH4TqCtCoDAKOaTregpowX5PZlY6JQ==@vger.kernel.org, AJvYcCXFjHm3+EQ1OHEMs97vtTev1ctXqA8Lb7F2HfyUvRlN2ruYZJTQI3jiPJnQbMHngexBnEBRiQsoP8SuKlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplcyKdeLjlOUbcMjelBj4+kb8f/7fCaqmutnMBPv+z1UGloWk
	XzznefXGNYdaB4pUwr5EpUnVEkrse7sydtlLkjQwGcELzWiU5BZoOn8qDduEXT5o4FtlrFLsCx2
	7K+J1Tr/KW1FK1K2CYqJ0WWepZssUuq0=
X-Gm-Gg: ASbGnct7niJzbCmhVPR9tVhYtXyXKvZUvFlWbAt7E9y9sIIHE/wtKt2O2qgLJA5LiHm
	s7JltfY+JdkeyLDqapszIKeaxck85EAbV6arV5IRAWQEi9J7q6KGrtPsom83pQq0rFzO+N1ullN
	ym6Rg7LjSH4e+loLcLyNhjhNQuqjJqo/A+36DNl03rQib1W1f8grhSvc2Erm8nlMuzai1CnuQVO
	1a0l1k=
X-Google-Smtp-Source: AGHT+IELREFbM69cWDMgkv0oAyeZWfUsogtR626ngafWyGyn4A7prZJUgwVT4kX8m1x5U9hUnIU0ztH0bEfAmGCquxc=
X-Received: by 2002:a05:651c:f0e:b0:32c:e253:20cc with SMTP id
 38308e7fff4ca-3338128c651mr2551171fa.11.1754454955157; Tue, 05 Aug 2025
 21:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805142622.560992-1-snovitoll@gmail.com> <20250805142622.560992-7-snovitoll@gmail.com>
 <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
In-Reply-To: <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 09:35:38 +0500
X-Gm-Features: Ac12FXwBfBQD8yoFidSr60fw7LigvE8ZBweRU29uoAzLmmdybvheO1FdbNA_5DM
Message-ID: <CACzwLxhs+Rt9-q6tKi3Kvu7HpZ2VgZAc4XEXZ4MEB60UbFjDKg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
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

On Tue, Aug 5, 2025 at 10:19=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 9083bfdb773..8d14c8fc2cd 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -5,6 +5,7 @@ menu "UML-specific options"
> >  config UML
> >       bool
> >       default y
> > +     select ARCH_DEFER_KASAN
>
> select ARCH_DEFER_KASAN if STATIC_LINK

As pointed out in commit 5b301409e8bc("UML: add support for KASAN
under x86_64"),

: Also note that, while UML supports both KASAN in inline mode
(CONFIG_KASAN_INLINE)
: and static linking (CONFIG_STATIC_LINK), it does not support both at
the same time.

I've tested that for UML,
ARCH_DEFER_KASAN works if STATIC_LINK && KASAN_OUTLINE
ARCH_DEFER_KASAN works if KASAN_INLINE && !STATIC_LINK

ARCH_DEFER_KASAN if STATIC_LINK, and KASAN_INLINE=3Dy by default from defco=
nfig
crashes with SEGFAULT here (I didn't understand what it is, I think
the main() constructors
is not prepared in UML):

 =E2=96=BA 0       0x609d6f87 strlen+43
   1       0x60a20db0 _dl_new_object+48
   2       0x60a24627 _dl_non_dynamic_init+103
   3       0x60a25f9a __libc_init_first+42
   4       0x609eb6b2 __libc_start_main_impl+2434
   5       0x6004a025 _start+37

Since this is the case only for UML, AFAIU, I don't think we want to change
conditions in lib/Kconfig.kasan. Shall I leave UML Kconfig as it is? e.g.

select ARCH_DEFER_KASAN

>
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_HAS_CACHE_LINE_SIZE
> >       select ARCH_HAS_CPU_FINALIZE_INIT
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
