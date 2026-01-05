Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243330B50A
	for <linux-s390@vger.kernel.org>; Mon,  5 Jan 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624353; cv=none; b=BBhYP30jxFyo0ESRir62xKKt+/2tP9EPO+SA0sryFppRtU1wpWQteU42T0V6dL/klkm3i8qIchPkMATLOAQH6suEjn1kyYeyhJhYYbIlNfsv+ndu6bq3LVuiFt5FfADEIWfBybwRX7TTSk7szQOANVhzY9RUNcgBM06bOxAAgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624353; c=relaxed/simple;
	bh=SHzH2YatMTJEak8gFqKEZdJe9xo/UPeNX1MXbrpo6iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmHaBu0qHt8fdiVXHqw+8MxRpQbDTsy+jG776/OBqjVvX/VRO5t/yay1kW93HFFo/ZXUjaYUJKOgKhLGbgQ/9fNY7DvGTAW6cSeXj0yT8aI1pHLFy19WnnwrbU5VM2n7jAocR18Ni7yJI0dz3TcyYv/v8XRhAejHWc1du7KxD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC3xtS3F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC3xtS3F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso146463065e9.0
        for <linux-s390@vger.kernel.org>; Mon, 05 Jan 2026 06:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767624348; x=1768229148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSwPcNo8o0N6KCcNlfNXq5S6yUSOj9uBi5hsA/QPZGo=;
        b=hC3xtS3FL8GvFdhxwfw8XHSw0if6H1F0E7o6/PUvVFmgvAX65aOGd5FQ+mJMsgUFY+
         7et5IIx63M6W4bgDN7eO1k17HwcOzk7a3XuQ+TSw1xVwlSRtsDmZLrs7COoC1x9C6kmY
         XK1u8bYepv2/3NDOrntjELnrqbSx4osbx1WNy9eILgqE2BgJ9Uwz0jnynJc/Z9In9Sv3
         W1dA3uGiI42/AU3dTgjt0/QtGjwNG1fbxiMVM+GJir2waaNI8IDb7l8CNLUqRuLPQRpe
         FGt+B7rVS6KK/Bwlp4HSC9AgFIj0WrvwluWDyfG6yTcOEtw7wTc5LkNdAZ7Qt9k5Dfdo
         wv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624348; x=1768229148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSwPcNo8o0N6KCcNlfNXq5S6yUSOj9uBi5hsA/QPZGo=;
        b=DW620ySc6TtA8uOSFHdfY7Fj4oTdkiCONbKPUCe7Yb1v6tkBTpQz8v0lb3ztFGjIu3
         /QBJrZELjmT9tSxrBzIUAFZACX9tYTvNwPpmreiN1b0HXfTZTMe0SOReQRS/xgAhv2zA
         bFEqe9xfEtkyG5g8rYkEvC2ppBrCuvLkAjuV1CiP1Uu0krOgAg+79A3Nuf+l3BoC25wV
         wh2EofGUmXpwV5ngLx0lyuTfCCS+mEx30CV6AZcKtgHaf/nTTd1Wf0z/Aeh6brhMrN0Q
         zlyYStVSAaaCvd/ni7jESFem2jt2y6VLzxmWjHL84gs7MjTsadQ4iQ3DAvnyP4LN6xU7
         wQWw==
X-Forwarded-Encrypted: i=1; AJvYcCVhHdgc1l4NDAvhCxb1A6CRcO2GktscflaEA7xJMvs3KQDfMSUoE7g4nZGK/P1O7AGqUyHZlF0t0Apj@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBsehbpj1Fju19nVyJfVUEB1Nv2Psxmh15N8gZlPBZmqPsTdB
	ns9oC9BQQimqg1Fg7rkrZ5l75sMW0WweZTvp/COUYmD7asUzzfdlrcix
X-Gm-Gg: AY/fxX7wWcS3uQP0PrOL5mqQ3i/zeHaYWn/3eROuekcA7OLcTVZUVrvfdR9VWVj0l+q
	5Cd4Ue1e+/G95Zm12aGZsJE9REACr3m5QzSon57aamW7/h6HMhPhH3od35RpOhlrHRPZEqxlQWd
	8bb6Bvd2m7ExS8k/EvlI6pN7QLK/Jtr94Aznc3YG3NtlG7KSOdq4/T9xJd2A0ehh5vnzcpXiP2m
	ynJkKCn+t0XlcYIQ7DQl1LL3luPrjvqT9104TpmlAkLZgHyjp5fVh4EuUHSpPhYx9MI+T4Z+wI/
	2YBf/eyfk1c/lVg2Nqp9zh4QeHO1/pQ/iKLygtti7HXomq4LATKTd557Xt2X3j0n7K0K7iNDcF+
	D8gt9H9trdWqxj0id0rG4ytCv4GMGF7i4ozoLLGBI8OYLcKDGG5JmCp9wO6kuWfSWGe2X8dIDXy
	zHRXUDrWpuobTNngYAc3FRcH4OqRMFPV6Z/EmwSSwkW57Ly04Hyc6OAzYFDam5kaU=
X-Google-Smtp-Source: AGHT+IEzQJ2d8LdW+ZAISEQqtjJZ6hu3kCqntkmy/4NpDB13AhMox7IMuU26/rlmQkOaOYroxoA3pQ==
X-Received: by 2002:a05:600c:1991:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-47d195aa354mr674903875e9.32.1767624347886;
        Mon, 05 Jan 2026 06:45:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d452c69sm195826845e9.9.2026.01.05.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:45:47 -0800 (PST)
Date: Mon, 5 Jan 2026 14:45:45 +0000
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
Message-ID: <20260105144545.45f2b0ba@pumpkin>
In-Reply-To: <60c5d7b1-1ab7-490c-8cb8-dfd50cf23856@arm.com>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-4-ryan.roberts@arm.com>
	<20260104230136.7aaf8886@pumpkin>
	<60c5d7b1-1ab7-490c-8cb8-dfd50cf23856@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 11:05:18 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 04/01/2026 23:01, David Laight wrote:
> > On Fri,  2 Jan 2026 13:11:54 +0000
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
> >   
> >> Previously different architectures were using random sources of
> >> differing strength and cost to decide the random kstack offset. A number
> >> of architectures (loongarch, powerpc, s390, x86) were using their
> >> timestamp counter, at whatever the frequency happened to be. Other
> >> arches (arm64, riscv) were using entropy from the crng via
> >> get_random_u16().
> >>
> >> There have been concerns that in some cases the timestamp counters may
> >> be too weak, because they can be easily guessed or influenced by user
> >> space. And get_random_u16() has been shown to be too costly for the
> >> level of protection kstack offset randomization provides.
> >>
> >> So let's use a common, architecture-agnostic source of entropy; a
> >> per-cpu prng, seeded at boot-time from the crng. This has a few
> >> benefits:
> >>
> >>   - We can remove choose_random_kstack_offset(); That was only there to
> >>     try to make the timestamp counter value a bit harder to influence
> >>     from user space.
> >>
> >>   - The architecture code is simplified. All it has to do now is call
> >>     add_random_kstack_offset() in the syscall path.
> >>
> >>   - The strength of the randomness can be reasoned about independently
> >>     of the architecture.
> >>
> >>   - Arches previously using get_random_u16() now have much faster
> >>     syscall paths, see below results.
> >>
> >> There have been some claims that a prng may be less strong than the
> >> timestamp counter if not regularly reseeded. But the prng has a period
> >> of about 2^113. So as long as the prng state remains secret, it should
> >> not be possible to guess. If the prng state can be accessed, we have
> >> bigger problems.  
> > 
> > If you have 128 bits of output from consecutive outputs I think you
> > can trivially determine the full state using (almost) 'school boy' maths
> > that could be done on pencil and paper.
> > (Most of the work only has to be done once.)
> > 
> > The underlying problem is that the TAUSWORTHE() transformation is 'linear'
> > So that TAUSWORTHE(x ^ y) == TAUSWORTHE(x) ^ TAUSWORTHE(y).
> > (This is true of a LFSR/CRC and TOUSWORTH() is doing some subset of CRCs.)
> > This means that each output bit is the 'xor' of some of the input bits.
> > The four new 'state' values are just xor of the the bits of the old ones.
> > The final xor of the four states gives a 32bit value with each bit just
> > an xor of some of the 128 state bits.
> > Get four consecutive 32 bit values and you can solve the 128 simultaneous
> > equations (by trivial substitution) and get the initial state.
> > The solution gives you the 128 128bit constants for:
> > 	u128 state = 0;
> > 	u128 val = 'value returned from 4 calls';
> > 	for (int i = 0; i < 128; i++)
> > 		state |= parity(const128[i] ^ val) << i;  
> 
> What is const128[] here?

Some values you prepared earlier :-)

> > You done need all 32bits, just accumulate 128 bits.  
> > So if you can get the 5bit stack offset from 26 system calls you know the
> > value that will be used for all the subsequent calls.  
> 
> It's not immediately obvious to me how user space would do this, but I'll take
> it on faith that it may be possible.

It shouldn't be possible, but anything that leaks a stack address would
give it away.
It is also pretty much why you care about the cycle length of the PRNG.
(If the length is short a rogue application can remember all the values.)

> > 
> > Simply changing the final line to use + not ^ makes the output non-linear
> > and solving the equations a lot harder.  
> 
> There has been pushback on introducing new primitives [1] but I don't think
> that's a reason not to considder it.

That is a more general issue with the PRNG.
ISTR it was true for the previous version that explicitly used four CRC.
Jason should know more about whether the xor are a good idea.

> 
> [1] https://lore.kernel.org/all/aRyppb8PCxFKVphr@zx2c4.com/
> 
> > 
> > I might sit down tomorrow and see if I can actually code it...  
> 
> Thanks for the analysis! I look forward to seeing your conclusion... although
> I'm not sure I'll be qualified to evaluate it mathematically.

I need to drag out the brian cells from when I learnt about CRC (actually
relating to burst error correction) over 40 years ago...
 
> FWIW, I previously had a go at various schemes using siphash to calculate some
> random bits. I found it to be significantly slower than this prng. I've so far
> taken the view that 6 bits of randomness is not much of a defence against brute
> force so we really shouldn't be spending too many cycles to generate the bits.
> If we can get to approach to work, I think that's best.

Indeed.
A single 32bit CRC using (crc + (crc >> 16)) & 0x3f could be 'good enough'.
Especially if the value is 'perturbed' during (say) context switch.
The '16' might need adjusting for the actual CRC, especially if TAUSWORTHE()
is used - you don't want the value to match one of the shifts it uses.

prandom_u32_state() is defined as:
#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);
	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
This is equivalent to:
#define TAUSWORTHE(s, a, b, c, d) ((s & ~c) << d) ^ (s >> a) ^ (s >> b)
	state->s1 = TAUSWORTHE(state->s1,  7, 13,   1, 18);
	state->s2 = TAUSWORTHE(state->s2, 25, 27,   7,  2);
	state->s3 = TAUSWORTHE(state->s3,  8, 21,  15,  7);
	state->s4 = TAUSWORTHE(state->s4,  9, 12, 127, 13);
which makes it clear that some low bits of each 's' get discarded reducing
the length of each CRC to (I think) 31, 29, 28 and 25.
Since 'b + d' matches the bits discarded by 'c', two of those shifts are
actually just a rotate, so there isn't really much 'bit stirring' going on.

By comparison CRC-16 (for hdlc comms like x25, isdn and ss7) reduces to:
u32 crc_step(u32 crc, u8 byte_val)
{
    u8 t = crc ^ byte_val;
    t = (t ^ t << 4);
    return crc >> 8 ^ t << 8 ^ t << 3 ^ t >> 4;
}
Much more 'stirring'.

	David


