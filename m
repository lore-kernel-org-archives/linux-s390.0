Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE31B11E
	for <linux-s390@vger.kernel.org>; Wed,  7 Jan 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794740; cv=none; b=U5UYk6M5Qaeng6HEDYtKCRYUAMhDHMA2ZHArZ4WDPboFKQTZVNYagfKyzDDKzmAoL7f/dpxMgYwA0hbYXiAaNR5n1Ewv97vyxndIjdGV18a4nIJu7bOvnVF8xzk1AbMYqS4J5ZV2aUz5h+4doaAUHOVFp7Tx6rRtbAylhB3tFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794740; c=relaxed/simple;
	bh=XhP5nLUztDYAIoAO0lAhA+v0Sp7AtQN0TG10F7Z+85I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyPZWZ0ERoOyzWGm7qM26XLcPS0GCIuxOcgCWJrC7vhZN0MWYDab3o4Y2jr4Ip14UbNKCZL6sFA1fmy9CupI2VGHmqP25FjsdbbPusWobr6D3W0wR7PqAxoPr+Yv4JNKE9NXc6kGhKppIwjvcV70I4psB8xc1Lck96f2LKweZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRy82LdA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRy82LdA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so18058705e9.3
        for <linux-s390@vger.kernel.org>; Wed, 07 Jan 2026 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767794737; x=1768399537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTerFL81XHMixYnvh7u2MldwUCD+ZWdDPLrHKRPjXbw=;
        b=PRy82LdAgq/iXJWmIscUYgGuSCdwXSV/g4BsZy2X7xXeHXz8o1Vf3eZ+2E1H3VSTZb
         nxU+GUe7bvSVVoewfrHd9OfnKBoyh0q+tOuScahipIqYyiAHRyZKxulZpPZkajCq99Og
         CBfaQLmHtcItb3OWEboCpo3ZNb7XDiicjCI9lYzvMI7+Oq83pVPh5psQsfBy0kJudDgP
         Z5n18foIQxD8vJLs6d0BNZMZLrZw/eI22udUetwoURBFTKZuWK6aJuhoJVViw77Eqy6U
         rP6y7snd0xzOuFPpo0Fz/eTR+C1sss8SjZ7hG/NXwz0hX7o43OPeEhFH7dwEjfftLVaZ
         4Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794737; x=1768399537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTerFL81XHMixYnvh7u2MldwUCD+ZWdDPLrHKRPjXbw=;
        b=lZIoK7jQJdLQMz/Dyokc7a06bASfcRgSZYlVAfv8O1b1PqdCQ6GRLMtzOIM6ZIWpDC
         K+oY/28k32XNiCJw/qC4m1uObjz+BjjaJnKMSGdXxPxE42yTI6FnZ3wktiNEbvuDqgIl
         K32atLMeJ2iNQ8Y/xawxv0OJVllCk2c6FLdFy06jzKvJ59tK6my33KPYRG2IHXFDDp7U
         3xcsrDlDNT5kJ64spes5VvUScpjORDFOSKjYWEdz76EiyXqS/E7uuteHW91C95J64FqS
         UL/XtPoZX9TywLCFUSE4gYaBwMNzvCYgbv21J03DganYH8/iunjM8glvB13SGnopwdlo
         lbBg==
X-Forwarded-Encrypted: i=1; AJvYcCWUIwJlfhxHHMEVGz0k5MYWaq6T/JioZ1tpzzZAKdZ7vEMwvbt/xFNtUL319FBCDq3j+zQfYUx3toAF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5s1Sv3s5Cr0alcaiiojcpx2+29zo3jy94OYgg9NFzLUgXB1iS
	jAGD4p7SnRlmQ/Ugv9JwQYH/7NmQYOkvw0WaSrqNinhjKtmNKhP+sSxN
X-Gm-Gg: AY/fxX6Uojf8pBAYe2Zhx6OnTWECV1CCJ9bzIXuzVWohWLQ/qsuPZHgmd0ZybRQt6TD
	bEi0/oApjZcq4XPjrCoetcFW/6FzeBxVhb4tgyHlgaTqcixo+LGgAp82zML7fOK+3ApK0TCSxV8
	2rt/ZYaFQ6JOhjzN0YlrpP0qiU0qBHRRYl4cwoHdJxN3awskX5Ls919yW8MkpXil71afeHPkgrv
	NTwgPQF0JLSLe3Sc+sEAgT1PqEmzc+lNQDeeN8fcmfLWRY9NOyU+8hfYhliAchTbwjgDM0vjJQ/
	szBUO1yHoblXhhKIDTi88TMFR3EmNLBBgYnNLmxZXrGiOuRomnvnWSKZp+LuVmnWRhRbh8Ti3Q8
	8fORtgH38bwEnnqTHSgE0HPhkefultS703Ji1kwB/uo5CicsSEAZBZSOZmUFpE1C1ImCYAbwvUp
	WcNCb2rG59boxOW45aII/oYv47q3beq9rLlFyzWtTKMrDLE1uOGS/o
X-Google-Smtp-Source: AGHT+IFJHEaZoRkhHw4zj9EBxNV/rp8ncSP4Ef47XQLiJPMu3j1wMm2BAE3otGmVGJMIybtQwjSgsQ==
X-Received: by 2002:a05:600c:8b6d:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47d84b4a7b4mr30796025e9.35.1767794736254;
        Wed, 07 Jan 2026 06:05:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87167832sm13555455e9.7.2026.01.07.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:05:35 -0800 (PST)
Date: Wed, 7 Jan 2026 14:05:33 +0000
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
Message-ID: <20260107140533.2b3c46a1@pumpkin>
In-Reply-To: <20260104230136.7aaf8886@pumpkin>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-4-ryan.roberts@arm.com>
	<20260104230136.7aaf8886@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2026 23:01:36 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri,  2 Jan 2026 13:11:54 +0000
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
> > Previously different architectures were using random sources of
> > differing strength and cost to decide the random kstack offset. A number
> > of architectures (loongarch, powerpc, s390, x86) were using their
> > timestamp counter, at whatever the frequency happened to be. Other
> > arches (arm64, riscv) were using entropy from the crng via
> > get_random_u16().
> > 
> > There have been concerns that in some cases the timestamp counters may
> > be too weak, because they can be easily guessed or influenced by user
> > space. And get_random_u16() has been shown to be too costly for the
> > level of protection kstack offset randomization provides.
> > 
> > So let's use a common, architecture-agnostic source of entropy; a
> > per-cpu prng, seeded at boot-time from the crng. This has a few
> > benefits:
> > 
> >   - We can remove choose_random_kstack_offset(); That was only there to
> >     try to make the timestamp counter value a bit harder to influence
> >     from user space.
> > 
> >   - The architecture code is simplified. All it has to do now is call
> >     add_random_kstack_offset() in the syscall path.
> > 
> >   - The strength of the randomness can be reasoned about independently
> >     of the architecture.
> > 
> >   - Arches previously using get_random_u16() now have much faster
> >     syscall paths, see below results.
> > 
> > There have been some claims that a prng may be less strong than the
> > timestamp counter if not regularly reseeded. But the prng has a period
> > of about 2^113. So as long as the prng state remains secret, it should
> > not be possible to guess. If the prng state can be accessed, we have
> > bigger problems.  
> 
> If you have 128 bits of output from consecutive outputs I think you
> can trivially determine the full state using (almost) 'school boy' maths
> that could be done on pencil and paper.
> (Most of the work only has to be done once.)
> 
> The underlying problem is that the TAUSWORTHE() transformation is 'linear'
> So that TAUSWORTHE(x ^ y) == TAUSWORTHE(x) ^ TAUSWORTHE(y).
> (This is true of a LFSR/CRC and TOUSWORTH() is doing some subset of CRCs.)
> This means that each output bit is the 'xor' of some of the input bits.
> The four new 'state' values are just xor of the the bits of the old ones.
> The final xor of the four states gives a 32bit value with each bit just
> an xor of some of the 128 state bits.
> Get four consecutive 32 bit values and you can solve the 128 simultaneous
> equations (by trivial substitution) and get the initial state.
> The solution gives you the 128 128bit constants for:
> 	u128 state = 0;
> 	u128 val = 'value returned from 4 calls';
> 	for (int i = 0; i < 128; i++)
> 		state |= parity(const128[i] ^ val) << i;
> You don't need all 32bits, just accumulate 128 bits.  
> So if you can get the 5bit stack offset from 26 system calls you know the
> value that will be used for all the subsequent calls.

Some of the state bits don't get used, so you only need 123 bits.
The stack offset is 6 bits - so you need the values from 19 calls.

> Simply changing the final line to use + not ^ makes the output non-linear
> and solving the equations a lot harder.
> 
> I might sit down tomorrow and see if I can actually code it...

Finally done:

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

typedef unsigned int u32;
typedef unsigned long long u64;
typedef unsigned __int128 u128;

struct rnd_state { u32 s1; u32 s2; u32 s3; u32 s4; };
u32 prandom_u32_state(struct rnd_state *state)
{
#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
        state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
        state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
        state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
        state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);

        return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
}

#define X(n, hi, lo) [n] = (u128)0x##hi << 64 | 0x##lo
u128 map[128] = {
        X(  1, 23acb122e4a76, e206c3f6fe435cb6),
	...
        X(127, 00d3276d8a76a, e560d1975675be24) };

u128 parity_128(u128 v)                 
{                               
        return __builtin_parityll(v) ^ __builtin_parityll(v >> 64);
}

int main(int argc, char **argv)
{
        struct rnd_state s = {};
        u128 s0, v, r = 0;

        read(open("/dev/urandom", O_RDONLY), &s, sizeof s);
        // Remove low bits that get masked by the (s & c) term.
        s.s1 &= ~1; s.s2 &= ~7; s.s3 &= ~15; s.s4 &= ~127;
        s0 = (((u128)s.s4 << 32 | s.s3) << 32 | s.s2) << 32 | s.s1;
        v = prandom_u32_state(&s);
        v |= (u128)prandom_u32_state(&s) << 32;
        v |= (u128)prandom_u32_state(&s) << 64;
        v |= (u128)prandom_u32_state(&s) << 96;

        for (int n = 0; n < 128; n++)
                r |= parity_128(v & map[n]) << n;

        printf("%016llx%016llx\n", (u64)(s0 >> 64), (u64)s0);
        printf("values%s match\n", r == s0 ? "" : " do not");

        return r != s0;
}

I've trimmed the initialiser - it is very boring.
The code to create the initialiser is actually slightly smaller than it is.
Doable by hand provided you can do 128bit shift and xor without making
any mistakes.

I've just done a quick search through the kernel sources and haven't found
many uses of prandom_u32_state() outside of test code.
There is sched_rng() which uses a per-cpu rng to throw a 1024 sized die.
bpf also has a per-cpu one for 'unprivileged user space'.
net/sched/sch_netem.c seems to use one - mostly for packet loss generation.

Since the randomize_kstack code is now using a per-task rng (initialised
by clone?) that could be used instead of all the others provided they
are run when 'current' is valid.

But the existing prandom_u32_state() needs a big health warning that
four outputs leak the entire state.
That is fixable by changing the last line to:
        return state->s1 + state->s2 + state->s3 + state->s4;
That only affects the output value, the period is unchanged.

	David


