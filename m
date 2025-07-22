Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41F2EBDD9;
	Tue, 22 Jul 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193369; cv=none; b=tqw0qqn9ByJXT/uukD8/YvpFt+LJ+5t13/IbBXWICtwEpXRhfxPeeMoQWIlzGkppAZzQ5Rgty5ay12isQjBVwIA5AQTdWMx4IxlLhfJVbIUCKA5CqjEtgape6cBkwRTD5wcyL0bSGix6505lia/Rv5TJfF5ppJMK4uxcWi314Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193369; c=relaxed/simple;
	bh=USZCbimKAI5U38SQkb+cFApM81Y/jORMtvbYcAo1IlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIEWeatXrg1rLT+biKLkv2pOOSswVg44lzKpsM+ysT4MP+YD//1YPcpSFvESsTv8H+PBjOs5S3O4eDRxkPgKzQ8Mt1bQxGvnHV3YBL/jdp0fJMlXneL+TE8SALauTqNdCM2Lsc/gQFvEe5gfTsjj8dc4vMywcBNqH/XG8WfmhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2g74rON; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2g74rON"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so49812511fa.0;
        Tue, 22 Jul 2025 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753193365; x=1753798165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z72Y4lywtzmWJK50j4gaS5KcylDNvYHYQchCkK6Shzo=;
        b=Y2g74rONrzYf4BE+ohSv9EX13OSys6RMvWJcoZmjTavLdDXWSV+Ie69dvXEeZE41Lp
         xPGX1iyZAXm6+dlArPXirTi4lyDDN2ftliPdFtSDPmP4VjYyNIcDkZvmgr/IC+jVaF9u
         olElwhF1zLyhaNgmmMQPekEK6AdOrgNdKvRNAu0wX7Xt7dfRNUyQqVepUEq1UgqYf1cI
         U3vy765qga0eSYZofNTxSN7WDuz2U1S+9yupAMQr1HrdolrZksgklnhIEjX1d0cA6QTW
         8lxnBld0otqxgoNGZXopew/rgg+058u4PraDo/PBj+PgSQefhgtRwQy5d8ymn/lKsRU3
         ijnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193365; x=1753798165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z72Y4lywtzmWJK50j4gaS5KcylDNvYHYQchCkK6Shzo=;
        b=mHMrbVhntkDndEQdyeLjesEk+mOHcCBkvKJMDWVbE7X4QeNKrdOGsdkQ7qn+3mav/B
         Su2Oucyz4MzmLMkqg47NuajYTnfypOfvH4TUqrnPJCIeTwZxJeth4c0lA/K9yr2U9ncl
         vjW5uAbRjwIHayWXfooC7HgPjW+1Ye3tL+asYqD8SdB7zfnsOFvTXunjVRzgDgi0EC0H
         R1iaohjcRspBrb/6eo/nvH8Myh5jnV2tOvaOtsfHcv5Pzqu2/yc25a7/WEBXAGuhGzpv
         vzbHLFJUYLEx4fhoMtdrt9L0Ng2WosrEWAYpgOhjpjxyDb1crkcSjqdjlQTo4pHvBRGK
         YMfg==
X-Forwarded-Encrypted: i=1; AJvYcCUhxQzwk9nR8oaAnz84VRnCVN92gBPjU+nkRM+tzyZlBK+xKKB3L9GuYDlP1Q08y/Z8WJqQthzqwb/kwsA=@vger.kernel.org, AJvYcCXVDhB6yZZ6dEulhh55sqIPnP0l57+2iUV30MnTfFcseq7sg2X7TNWAt7s8vXehn7WyhfOzj14AqAmNAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaBL/IGXzQd8ovVCVUme2OIjYjtZWI15PYBmmj4FwteiUJGRf
	kwy0XBPQ5fU7sUplxldAgUMghhLPzk54yw/HRX462ueqMnQZP5UWO1DH2i6f7RTuGPj0QNL6C2c
	xR4n0UL2X1HxS+XzbKMMsZbxJhBzMgjs=
X-Gm-Gg: ASbGncu+AmxD5g545jrzpW1yG6oKN/CyRbCFuz+e/jLaAHFhiqzZqA1qx+pfYHiJl94
	4FznoSk5oiwlwsXAOhgrz47DcG66k4ErgUGiEYPq8OUZeofKCJAkDC6BFzh89l8ADT+gtU95OYl
	os+zTp0F3BHvR0cGB5x6ryAZ1C0lauctinAaxm9H2YUdr2C/fGSVrqkZP0F5D16SYSN52+65f3A
	MhRiCM=
X-Google-Smtp-Source: AGHT+IHxVK00NMC1GHSpVq/sT2EfSuq7omX6wX24xSvgGhrc9yg0F8isqB5neLuF1et0yPorDOiVEfN1u9rtptu/xSU=
X-Received: by 2002:a05:651c:4110:b0:32a:885b:d0f with SMTP id
 38308e7fff4ca-3308f5e2852mr36383791fa.24.1753193364861; Tue, 22 Jul 2025
 07:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-8-snovitoll@gmail.com>
 <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
In-Reply-To: <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 19:09:07 +0500
X-Gm-Features: Ac12FXxpDsEYsUfFuRK9xdlLStcuqGTW4Nrf9JrgjFdTiyEs4CW8gE7SGsQYdo4
Message-ID: <CACzwLxgjKz-bc1w4SvGu-EeoMvK9Dh=2WpB-A_zC-u7H38QqVg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] kasan/loongarch: select ARCH_DEFER_KASAN and
 call kasan_init_generic
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
>
> > diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/includ=
e/asm/kasan.h
> > index 62f139a9c87..0e50e5b5e05 100644
> > --- a/arch/loongarch/include/asm/kasan.h
> > +++ b/arch/loongarch/include/asm/kasan.h
> > @@ -66,7 +66,6 @@
> >  #define XKPRANGE_WC_SHADOW_OFFSET    (KASAN_SHADOW_START + XKPRANGE_WC=
_KASAN_OFFSET)
> >  #define XKVRANGE_VC_SHADOW_OFFSET    (KASAN_SHADOW_START + XKVRANGE_VC=
_KASAN_OFFSET)
> >
> > -extern bool kasan_early_stage;
> >  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> >
> >  #define kasan_mem_to_shadow kasan_mem_to_shadow
> > @@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
> >  #define kasan_shadow_to_mem kasan_shadow_to_mem
> >  const void *kasan_shadow_to_mem(const void *shadow_addr);
> >
> > -#define kasan_arch_is_ready kasan_arch_is_ready
> > -static __always_inline bool kasan_arch_is_ready(void)
> > -{
> > -     return !kasan_early_stage;
> > -}
> > -
> >  #define addr_has_metadata addr_has_metadata
> >  static __always_inline bool addr_has_metadata(const void *addr)
> >  {
> > diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_i=
nit.c
> > index d2681272d8f..cf8315f9119 100644
> > --- a/arch/loongarch/mm/kasan_init.c
> > +++ b/arch/loongarch/mm/kasan_init.c
> > @@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata _=
_aligned(PAGE_SIZE);
> >  #define __pte_none(early, pte) (early ? pte_none(pte) : \
> >  ((pte_val(pte) & _PFN_MASK) =3D=3D (unsigned long)__pa(kasan_early_sha=
dow_page)))
> >
> > -bool kasan_early_stage =3D true;
> > -
> >  void *kasan_mem_to_shadow(const void *addr)
> >  {
> > -     if (!kasan_arch_is_ready()) {
> > +     if (!kasan_enabled()) {
>
> This doesn't make sense, !kasan_enabled() is compile-time check which is =
always false here.

I should've used `!kasan_shadow_initialized()` check here which provides
the needed runtime behavior that kasan_early_stage used to provide.
Will do in v4. Thanks!

>
> >               return (void *)(kasan_early_shadow_page);
> >       } else {
> >               unsigned long maddr =3D (unsigned long)addr;
