Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A33563F6
	for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790492551; cv=none; b=soMteg5tOxHfyuHNkx4byCzWUiC3D+FYaWHqoCT/1wqljqaO+Z72eaYV5r8NQi10p11HvGERnENWUfeEY65+sfvdDmYE1RwYnWrSdyoHZjFgAb4qQeYb2vqH5iqMBkaWGiFa6kghk3TivSS2PKpSI9P/DT18dt93tRc3TtiLeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790492551; c=relaxed/simple;
	bh=EZBGaGu7g268yBeLa/NPbPJzutiCHGfKPegWoTP0nS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFppAxpwezyQdSjLSv5vbSN9C+Pll1dLcDNwAi1tmLljzgMwFgn+Rrhr0Na00kyteTRX7r76vaZxfjDhk0rqGyPv4AWzHNQHvkthY8tzn5dI6GhhWWBneL+PHfz0YKBvyrNuPmBdf/LdEXSDhk2CxjLcPKMOCK3LyerPyO5EjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhhbGWcS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhhbGWcS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso2810335e9.1
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790492548; x=1791097348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJKp/brBpZ8U6kwJIcmM4FiZnVhsdc/GYabd2hj9ep0=;
        b=fhhbGWcSs98KWNIPjQAwwy2Yzwiu5DdepGYGIryjir0puqjg/9ax8hBsUb14n4wWBn
         8/MqsllnNi5kpq79icgdS4NmoAWnuLTQpDPY9Zs7HYADGy2VjYEdHzkMYQu8dWggLjJq
         9swI1XBLBjnEVsGoMV5b3e4jtkhvmTswyFxQLcoDEddYigQ6xn8YXWDj5xGSyU87Fn/j
         GyeNGdi56lUom7g/riLoAaddFOVw2U7u+q7SXU2tn4dm5gsALpXWfnOUbhjh1282tE/P
         WVgPhbVvuHe/LsVhRDPywC8+lBvqoMD7t6xh0CkWhIo0amWuUHNnV2m2KpNAliIvZHaA
         0NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790492548; x=1791097348;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJKp/brBpZ8U6kwJIcmM4FiZnVhsdc/GYabd2hj9ep0=;
        b=th4nNpACtDsYPiV944MYT8F1nmKS2YdM9agzDeQ99SjdryeHVoQwoO32SC+unVVDtK
         JtWb4dk+pHAYfEwdiSwWtcgPi4p9TsPJCK68Qgnid7e7Tqp6vSBLvjqCVenSwppPBqYB
         gjUS0HawU64S3wITCs0TWpKRHbkrCktLbDJxSlSMgpBr+wqb6D4KSB5YkfRim1+RZZWc
         vVrIXmZ/iBxrP+WsyfDnezCzYybyAygdSzTHMWhuMQW3xVteCKV+CkqK4BDT5rkpSDpG
         KUZf+09b+VRGMaMgyukjjGUyFLW+lfBLs8kppccyfpB93tRMFiV0RiG/9gu8dY9y12QH
         cnUA==
X-Forwarded-Encrypted: i=1; AKwUvBz1w1EU8aIzQIRANjg382NxD3fhsVqE795UTTy3KTL/d8Dob/IIFyEAz7Axzr7m4YSTFUuNkRb2Ysvx@vger.kernel.org
X-Gm-Message-State: AFuF++mNkp82XsimxHapQwiqs+r1bD8Qm4b5nuT7WticC6COiiFd3C03
	/hgpSBNQnnpfh/9g7DZawWNtpEgzpBVEq82A3t5XaoGSeM6WPStK5IrI
X-Gm-Gg: AYBFou25NLj/etCgZY9+XTwp7uY/eh8cl+A6YiyK5+7R8pcHYDxpnZVZLKlvj/xOdxW
	mr9I73+RwByfIjTKtiankTe8Y5EYkZY1ppPL3Jad1GOKPrHEvA2UU8DlDyIpNNd5frWZTfra4Lq
	sVpn896v+ksFfnDYzhYwWi7lH1sHdY4ahGN5fUEztErNRY3srCAsWTkzpDXmsCqldyP5iXRPgBV
	CRI7aBdiFwwH7QIxhvcBkujeGdtMPv8/IH2P8BKNXpXbzZlQwPOB4ej8iWU54nrHVdozjIXnKok
	S+U6M4IdyHTfC+CNfVl8mnosDhxefZ3UBanlnbSHQCBBna0rziULnWX1nI/v34nKBqNfm6hKcxS
	MOZ4gc2U583+ImrpOa5tyrBkkP8p/RvggCzhvGmOhGciLvYKzmwWmJZYXb5Pz1tXjXhzTU2kxcS
	A3xeofjz9xLZv5pkIT9L5oxbOO1vM/9LY+OyShpHV8UUik+VGYhO972Q1xxy73V6elWKOi/pvkz
	P2WgZcA9lPrJ0ZF5pq+XK7E80X9tsx858N3
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr175447355e9.3.1790492548064;
        Sun, 27 Sep 2026 00:02:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f0e79sm57015315e9.7.2026.09.27.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:02:27 -0700 (PDT)
Date: Sun, 27 Sep 2026 08:02:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260927080225.37534e7c@pumpkin>
In-Reply-To: <are7cfMIHZZn6jLz@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
	<87zex4ic68.fsf@linux-m68k.org>
	<20260926121927.GA1486962@ax162>
	<are7cfMIHZZn6jLz@zx2c4.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 14:32:49 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> On Sat, Sep 26, 2026 at 01:19:27PM +0100, Nathan Chancellor wrote:
> > On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:  
> > > On Sep 25 2026, Nathan Chancellor wrote:
> > >   
> > > > +#if __has_builtin(__builtin_memset_inline)
> > > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > > +#else
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +	char *d = dst;
> > > > +
> > > > +	while (size--)
> > > > +		*d++ = value;
> > > > +
> > > > +	return d;
> > > > +}
> > > > +#endif
> > > > +  
> > > 
> > > memset actually returns the original pointer, not the incremented one.
> > > Nothing uses the return value of memset_inline here, but it is
> > > confusing.  
> > 
> > Whoops, good catch, I guess my fingers gave up on those last two
> > characters :) I will fix this for v3 once there has been some time for
> > further review.  
> 
> Do we even need to return a value at all? Might as well just make the
> function two lines:
> 
> +       for (char *d = dst; size--;)
> +               *d++ = value;

Wouldn't it be better to add a barrier() or similar in there to
stop the compiler playing unwanted games>

David

> 
> (Technically that could even be one, but maybe that sort of golf loses
> clarity. Your choice.)
> 

