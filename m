Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410A2C11F0
	for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844855; cv=none; b=AOSXZj1ZDBnp8C8Cqlo1qtGAN/bjrjUwSqx0SYd6zKvcWHwHIyzEoH9wRszUn5KgXfsdIHBsjNHVvkYjCMtjVReAlW97E9DFA58hCV+vHxm9Q1RNRrCmJQBtsUnXinfX6icxfOkD5H5lDYpnxDs3XHF7mQq50l85SKR/BSF0Cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844855; c=relaxed/simple;
	bh=uFWIzT/NGXdCZyvcgR0/FUoFNBord156hv8OfVms58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAOc5Pm+S3e0X5RJr1ailbFwx+e/khZADmZdLMFk3lEMXvMipc+g0ZCKMkkx8pSSYek8pHu3KzUY/xar+hvdNluvq4ZSQradSAEyK59L//MHJvLIXf0mQm3rJbRRbSLrNmZ/0CcddNMbMh00ZjcVnhOCeAXGU8+GPJrALfzQHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMtYY/zm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMtYY/zm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801bc328easo37302385e9.3
        for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768844853; x=1769449653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=GMtYY/zmJhPX5Xs7FJm3rgdUKdWIuhIklepJ1p4sddiSk/m48GgcuCFWYojivUWl0S
         ItcXWhV3LEwOv4TzwJv2L8CLKQ44AK3D7QBES/aeXyukZebzf2e+NZ46lwP+vS2RJDr5
         Fas+NRvNzp81+95dkDBYnUxXK/nnySKrAwae2kWZV4CNSP878KpANRKljUJLJ2uB15oC
         sAxiISTwz31imERKHeIZ9AEFL9R6RLEjaJRY0JjT2sDdN+s30Rb5I1AXTdLHzspGThuB
         tiCttjFFxbiQp8IPlnnIJDSDi/RKZC4j2b5/myFO+GiYQyFzJrxUbAtTdQo9bs/p5O/b
         sM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768844853; x=1769449653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=G7Hi0/6br52x6Z4SmMfn5Ss110ETQEyYufh/2iVTOT/HV/D+gWx0ZZqz5D4wk2eQql
         gG9TxjLg9adlvjWdFjknBEyZjeiqCHZeFQs8WXgY4bkAmXWhBabGBnsYqmL2MBOfEMiY
         E3QMfkEZ7h6DQ8I2qPPhKAKrFVDum/ZasAyb4W8iQOJW47YYcor55NxKtm1Ze/qTwajA
         LvQs1bQgSjUMXWydgN+pQnfBrtk85HUCqCvvmYvXj2OCF2QpE36zI/ZfDorvd4DTnPg+
         eoZzc7FVxA0exqPE+WXOYFArbH1DFJsqFDHfN54pQn7jnWj5ro6hmkFTj/kShyYJ6vCY
         U3ow==
X-Forwarded-Encrypted: i=1; AJvYcCWyDsD0hXHiw19RAI88BnFgyc1SEp5mbPlCHuF7j+RAb6YEo+8qOselVukn5k6W8HAKZtK5miiMpJbY@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDG2L6yunEauBgwtFSLOGsrkNtaCrmM21o6zdInWNde4hWIxT
	Y6q52y1vI27jg2k8hT2GC/mC4s04mGSzGKrPfAmAD4up5McBoi0dntaB
X-Gm-Gg: AZuq6aKIXecoxt5Cfu3M8y1YQK9sSn6a4Wz9NBzykgqnUVU2VIJEFSfcjbgsj6aSNWy
	GFIxhR1Nrjsnp2N/Pd3rDeOIGZjzlp8V3dryut/q5S3RNEk66JZuAEYKuIFxtgupMc7plWBb8Dh
	wA+2kfd5z5bF702uTwBDaEeUPNyrygn5R53ReTSBdq8tr0S1Ul/lebs7sSygRSNYLB+O84CfoCz
	Qww6M9rbaF9QrzSDoygIiFD7ZNf77wPszPPNjRK+PmQDUnRg+mHPpd0Qa80GUd8NKVoqy0VpNRx
	BEjJuh9kmhpj60C4yuZ3WytqUS536yxUHS6Cfs2jjknJc8C4er0A3odfh2t+DPhTnigb5e/B8F2
	Ru4iusa1+CYgqldBDjDW9bYUqtgE7oFI+5s79ShoUJrBxtzBVcv3uYGm/OaTUm47mRwIW9fSi6x
	LYhxAeQfJ+F3/YvWrdnybo4j5WZEYqeqqM5u89ry0D2G2r1k69F0R4
X-Received: by 2002:a5d:588e:0:b0:431:9b2:61b0 with SMTP id ffacd0b85a97d-4356a03dd73mr15899699f8f.25.1768844852626;
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dedsm24242699f8f.9.2026.01.19.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>, "Andreas Larsson"
 <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119174730.5a20169d@pumpkin>
In-Reply-To: <4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<20260119100619.479bcff3@pumpkin>
	<20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
	<20260119103758.3afb5927@pumpkin>
	<20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
	<72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
	<20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
	<4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 15:57:49 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 14:41, Thomas Wei=C3=9Fschuh wrote:
> > On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote: =20
> >> On Mon, Jan 19, 2026, at 11:56, Thomas Wei=C3=9Fschuh wrote: =20
> >> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote: =20
> >> >>=20
> >> >> Don't you need a check that it isn't wrong on a user system?
> >> >> Which is what I thought it was doing. =20
> >> >
> >> > Not really. The overrides defined by arch/*/include/uapi/asm/bitsper=
long.h are
> >> > being tested here. If they work in the kernel build I assume they al=
so work
> >> > in userspace. =20
> >>=20
> >> I think You could just move check into include/asm-generic/bitsperlong=
.h
> >> to make this more obvious with the #ifdef __KERNEL__, and remove the
> >> disabled check from my original version there. =20
> >
> > Ok. I'd like to keep your existing test though, as it tests something d=
ifferent
> > and it would be nice to have that too at some point. =20
>=20
> Sure, that works too. I wonder if one of the recent vdso cleanups
> also happened to address the problem with the incorrect BITS_PER_LONG
> being visible in the vdso code. Maybe we can already turn that on again.

There is vdso/bits.h, but everything actually includes linux/bits.h first.

I was wondering what happens if you are actually using the 'uapi' headers
to build programs (may nolibc ones).
On x86-64, 'gcc foo.c' might work, but 'gcc -m32 foo.c' will find exactly
the same headers and go badly wrong unless everything is based on
compiler defines.

An assert (of some kind) that checks the pre-processor BITS_PER_LONG
constant actually matches sizof (long) seems reasonable for all build.
The alternative is to (somehow) manage to avoid needing a pre-processor
constant at all, moving everything to 'integer constant expressions'
instead (good luck with that...).

I'm most of the way through a 'de-bloat' patchset for bits.h.
I'm sure there is a good reason why GENMASK(hi, lo) isn't defined
as '((type)2 << hi) - ((type)1 << lo)'.
Since that definition doesn't need the bit-width in any form.
(Just beat up any static checker that objects to '2 << hi' being zero.)
I've only made that change for ASM files - IIRC the assembler only
supports one size of signed integer.

	David

