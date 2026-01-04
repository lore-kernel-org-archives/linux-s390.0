Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AD17BED0
	for <linux-s390@vger.kernel.org>; Sun,  4 Jan 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767567703; cv=none; b=I1GpDEHZ2NuhKCJleXhA6zHWeqKMRbr7J7vnr/Jos957aLMQMyNE3jqX5w7msXKo+z6BlI4DI31bduyQleXGJea/IJrKY/KukiyZn3a0vIcwOy22Oh2lZ74C/74i5Dc7kqXIuLJ+uatDJjL2fN6RuSV4Er0cVeMoNNfIpRNB8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767567703; c=relaxed/simple;
	bh=Dx1KQa5I1r3Fu8oJQBMaJqVN516QSYERTBkF+neq+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k94CZr1fchKADmTqiFLGlK05JfNR8qN0ahBszeRQAgWjtkV0CKWhts6qTgsnsHuCACNYVD5OqOhv7Izjfsbn0BIN4SQCTXsyojiUp9j0ZJEHtoVcxdUpZxrRO062aKAfXEwmPmsL4YSVOaHUoYD5Zsq1H+UI8+N3vEy1FQoq3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QORpXtpr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QORpXtpr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43246af170aso692450f8f.0
        for <linux-s390@vger.kernel.org>; Sun, 04 Jan 2026 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767567700; x=1768172500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjmKR/eiCoAVpyGnbyfS9wTkl7aiV0GxbUH0ODK6l+U=;
        b=QORpXtprTzxVFjNzttfe1J+F6M5o6J8fPl5YT8zBI8gs9NXvWvLCBa5gSr/bCmUzqU
         BlZwZRymUeoa1fO13vvU3wCphRwO9YVqgLM+qzBru6MznL/uur57vJOMFceYch/jR5Mw
         jERuoW90IDdJfHJRfF3iyvlrlG2Ps352DqVpotuuLeZjLuJMTVj2hfXrj3+5yUDyejD3
         xi7H4b2kRFk+CogFRcr7uocYFL6o6sT4QhfB6ahZQpkpntdbywC2vPXgDp8cYtcG5SQ1
         nzeYZeZWz15Iyx21qT90bLvsOaI3mcCVLPPzSSkQdzZkUVuUsS8kavhHyWVQLr4zq18H
         0Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767567700; x=1768172500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjmKR/eiCoAVpyGnbyfS9wTkl7aiV0GxbUH0ODK6l+U=;
        b=VjYxE1QO6oH8qKkZ06cILHzjba22AJl6F/zMuwbTpRiCXQGunipYjf2e15jt+B+Lt4
         jSRnIqyyppTpdLdH/9Lc5bokrmescKzxRju5lRor7zukvIh9onJdu7OjWAp3hX9yhJvM
         wyORF2aJyDvEVPlLd+liR10PhRb3mITuwwHPbYfgYCLsJIUrV41ZnO5oYyu2buyAEgnO
         XJ5yVAiQRTke1WeGRok1xdIWx2d84dQGE8HI8Lt/R7S2/cj1Dp0Nejkb4hIElYFqyuUK
         /najKIQ7e8AI1dPDMn/g9qDPIhocBOq+wAF5Cc02X3skAn6AgvwEyqZYfrQ8zzjzX3hu
         RV3g==
X-Forwarded-Encrypted: i=1; AJvYcCUHSutIzKD+ed/JxnLca3Oe9eRpZ+4lsrzPAj80qM0V2uj/lGNhXCVdrVT/qxV7IrbMhsd5gWTTqH7e@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSU12qxFhbcKI45AZccEurSk0ssjogSf35i+4nDB0nsdMF8om
	OohVCmATxv3mdUmrfa7u0n2nmnt38k+uo2UvrAV0vaH44YpSFMngXgD5
X-Gm-Gg: AY/fxX7xrhtJnYVWQfgl1Kohj0+QGqUuzTfBgTHPcc5vn2J3voT5UOsZO75Zgt1PGP1
	pzmHT5rMFSQGUr6h7fEWu9uXvgIlI4Gs4sjU6vcxMwxERsIkByESIl7i4I9fMqkYP7E9buQ1Bio
	0YK5quUbUaBVyg0ns3nIkpDH/S8AG9o97UOB98l/aOa0NfMifCXvxJlqDgW2AQrE2me8USYWBxa
	VHwieKBQBWd2ZtVvgBW5opm/bg0nnRt7rGJiREfOur5G0QWmq5PYS88yOYx2q5f8bXcITOLnmsX
	J6XovCsq6v2OJ2UUIcOGuI+4Q2k0RfinkRyycQ0Pm6cH8c94BNXKjc+zySCmHNalXgA+dglN1fC
	oiKVeuI5WTIwdDjs6kizbe2zgrjg3b+jj1mz6rRj+16MB7StyregByaH4qyGeLbXkAc2tf1pXTX
	C+sXvaWLnO9Gbfq02pHAZ0PLXQbqtdOfRFTcyin7eCqDdYfBlApClE
X-Google-Smtp-Source: AGHT+IEPxlgtmoJsOcbnrDXHkchjsFc7moeHiVQTpzEoBA2t+H1hGAq+A791EuxHgrzC5U6Ox/NHuQ==
X-Received: by 2002:a05:6000:3111:b0:430:fe6c:b1aa with SMTP id ffacd0b85a97d-432aa434e77mr7977363f8f.26.1767567699992;
        Sun, 04 Jan 2026 15:01:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm99650545f8f.17.2026.01.04.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 15:01:38 -0800 (PST)
Date: Sun, 4 Jan 2026 23:01:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <20260104230136.7aaf8886@pumpkin>
In-Reply-To: <20260102131156.3265118-4-ryan.roberts@arm.com>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-4-ryan.roberts@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 13:11:54 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> Previously different architectures were using random sources of
> differing strength and cost to decide the random kstack offset. A number
> of architectures (loongarch, powerpc, s390, x86) were using their
> timestamp counter, at whatever the frequency happened to be. Other
> arches (arm64, riscv) were using entropy from the crng via
> get_random_u16().
> 
> There have been concerns that in some cases the timestamp counters may
> be too weak, because they can be easily guessed or influenced by user
> space. And get_random_u16() has been shown to be too costly for the
> level of protection kstack offset randomization provides.
> 
> So let's use a common, architecture-agnostic source of entropy; a
> per-cpu prng, seeded at boot-time from the crng. This has a few
> benefits:
> 
>   - We can remove choose_random_kstack_offset(); That was only there to
>     try to make the timestamp counter value a bit harder to influence
>     from user space.
> 
>   - The architecture code is simplified. All it has to do now is call
>     add_random_kstack_offset() in the syscall path.
> 
>   - The strength of the randomness can be reasoned about independently
>     of the architecture.
> 
>   - Arches previously using get_random_u16() now have much faster
>     syscall paths, see below results.
> 
> There have been some claims that a prng may be less strong than the
> timestamp counter if not regularly reseeded. But the prng has a period
> of about 2^113. So as long as the prng state remains secret, it should
> not be possible to guess. If the prng state can be accessed, we have
> bigger problems.

If you have 128 bits of output from consecutive outputs I think you
can trivially determine the full state using (almost) 'school boy' maths
that could be done on pencil and paper.
(Most of the work only has to be done once.)

The underlying problem is that the TAUSWORTHE() transformation is 'linear'
So that TAUSWORTHE(x ^ y) == TAUSWORTHE(x) ^ TAUSWORTHE(y).
(This is true of a LFSR/CRC and TOUSWORTH() is doing some subset of CRCs.)
This means that each output bit is the 'xor' of some of the input bits.
The four new 'state' values are just xor of the the bits of the old ones.
The final xor of the four states gives a 32bit value with each bit just
an xor of some of the 128 state bits.
Get four consecutive 32 bit values and you can solve the 128 simultaneous
equations (by trivial substitution) and get the initial state.
The solution gives you the 128 128bit constants for:
	u128 state = 0;
	u128 val = 'value returned from 4 calls';
	for (int i = 0; i < 128; i++)
		state |= parity(const128[i] ^ val) << i;
You done need all 32bits, just accumulate 128 bits.  
So if you can get the 5bit stack offset from 26 system calls you know the
value that will be used for all the subsequent calls.

Simply changing the final line to use + not ^ makes the output non-linear
and solving the equations a lot harder.

I might sit down tomorrow and see if I can actually code it...

	David

 
