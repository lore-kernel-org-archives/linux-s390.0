Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA029292C
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549696; cv=none; b=KDZubF6399md0qhUk8dm6EKDsXQKRmhCOQehf0/0xMk+GbdxTI1PqOZFnHUqH3ASl6xkxstoNrNvSH/7uqThbUlAj4YTYcSp7kJxZFDvGaUiHuRQC6wdcSamAwx3DkUOPAAKUEUT6Rwi4xQIhQy05FJIaHltZ7GPmoLQ0E2ldws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549696; c=relaxed/simple;
	bh=pEGh+FyMPK3zT/zV3uCRaiREChKfcHdnfIXKiv+KGVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHs+cA3OkarERiiaXSMXN8pYrLhAE38lMO6/d9yrAmr3gxtXTgZNnCoLeLBxOqQCDtDdKqOkgicwKNn4cY1jWKAoOmMXe4Sta9qEmYhdiv+rOk5KTdE4BvmY0seoX2I6WeG46g/GkWIIP+yH7VXptIBeRfL4OlysxA2670bvsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BdPbfjkL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BdPbfjkL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89f9bb725so261806166b.2
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748549690; x=1749154490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=BdPbfjkLjjkO1/oLlwT3lAWZPfHD13gdaYU3q6sVGjzcvPH9gqr0k0ksLcw60W53rM
         60gGnVpZc7PYhL41D23BcS+a/08BEXMYeDijNeXA1CiEBXc7RLACJZq0LyrXhNWMR3Yx
         WAlfO0WlPnwPxO+XWdYb7sperMTrYrkefisfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549690; x=1749154490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=JRLwIvJTH5//Q+TBhMqTetESq5SoIqCX/gjFTE/Mev00KnJ7F8MT30RLqdLwnA92FS
         fWWSUmM1r4Xs3DaPfR1CtRghZbu2DZhjuMt47F9cBVPA/KmLh8RAdmiLVsoD4yqxxrZR
         D6PqkRe7UYf+jxe6M4wjI5pA2Cw2fejYz12eSK2RFfkODg4Rel8XASBq85RJNZKoWly4
         3f8Q+TuEx5VKXSslTWZHiBR44C7IM77hxxPX4XMtfXDLqmO7CDQ+CZ09NCUyG07LKUfs
         11jZByV2aGYJTwBPTpJy9Jf3G+v7mVWBPu2drNUpjvtZgIfA1YNB/FO7PFMBV8KSDSij
         VfOg==
X-Forwarded-Encrypted: i=1; AJvYcCWRFQ8DCNXYXpI/qeNlZmkMrpi1r/QMAIS2352kRfc8hsMW9e4g96gVhUK1ezCrMWBXfCbyczFh9FGt@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbKT9TF3ysgDXvjcoN9ilaBS7Izd/Ze8+JyFfhiscKOgitH8Q
	wnx/j/cTYkp5U47S35DpXga6sOxGt8FTDqrjW5agM1F9hnSNwvsSE2bctM76HESOTBIQFNEdwWK
	4Tc8vQbg=
X-Gm-Gg: ASbGncu6iwIY99pk8seFle9nj+kFRgHBiRh8YGGjnJQ4j5lWPklCeaekuMh+YI8EUvG
	g+8dR97W2wrWW8AdU5+RkwTmGmrocdhzD6QStdAwVohZQDxN4yWEknEhdaDWvLkcl4Lg/ZLl6N4
	596Rp46+0k1UKjnZwCvnRVlvtqClVhhxON7k43TDOUo8KAwA7ndxrbvAhklflSZcQ0IpDhzLLqj
	01XpjKx9DQdeZmJBd2TIB+jFjNvQMPiT6yf583jY6CGi5WIHNkP+bJCiywnWZlNRZWIm5zLe7IA
	z2YfgoXjw5FcxzQuPvTgWTbfVIX9X3YCM/gdjyWSOk95dhtv5wB1J+Ie3YllhXqYMT6IVkg6Cij
	RIU2b6t8BKZz65YRZtB0c3tWP74tA/QZilrNV
X-Google-Smtp-Source: AGHT+IE1POOYtayVg0hLxQZAwPPjl/iZ0mR2Js47/kG4Zg6q0i2sfNuEAAkUoAYR7U/CrkA5h0xssQ==
X-Received: by 2002:a17:907:3d16:b0:ad8:9ff4:c047 with SMTP id a640c23a62f3a-adb3225d2f1mr72770366b.35.1748549690337;
        Thu, 29 May 2025 13:14:50 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2dbcd459sm81255466b.167.2025.05.29.13.14.48
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 13:14:48 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so2562149a12.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 13:14:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFQ2TtWJe3bRdg1SugqO7cF/qDlWSqyslHA1lAkoHjYB1u79gpWntsRzSxZcc0gAprXCWRIhSkdZ1R@vger.kernel.org
X-Received: by 2002:a05:6402:2346:b0:602:1d01:2883 with SMTP id
 4fb4d7f45d1cf-6056db10b4emr581444a12.1.1748549687775; Thu, 29 May 2025
 13:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
In-Reply-To: <20250529173702.GA3840196@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 13:14:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
X-Gm-Features: AX0GCFuiJcryO_X7sE1ePk8yCEY5HNa9j_jPT14Gm93VGY22kOHLk2kIn44ZkWY
Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 10:37, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Long-term, I'd like to find a clean way to consolidate the library code for each
> algorithm into a single module.

No, while I think the current situation isn't great, I think the "make
it one single module" is even worse.

For most architectures - including s390 - you end up being in the
situation that these kinds of hw accelerated crypto things depend on
some CPU capability, and aren't necessarily statically always
available.

So these things end up having stupid extra overhead due to having some
conditional.

That extra overhead is then in turn minimized with tricks like static
branches, but that's all just just piling more ugly hacks on top
because it picked a bad choice to begin with.

So what's the *right* thing to do?

The right thing to do is to just link the right routine in the first
place, and *not* have static branch hackery at all. Because you didn't
need it.

And we already do runtime linking at module loading time. So if it's a
module, if the hardware acceleration doesn't exist, the module load
should just fail, and the loader should go on to load the next option.

Not any silly "one module to rule them all" hackery that only results
in worse code. Just a simple "if this module loads successfully,
you'll link the optimal hw acceleration".

Now, the problem with this all is the *non*modular case.

For modules, we already have the optimal solution in the form of
init-module error handling and runtime linking.

So I think the module case is "solved" (except the solution is not
what we actually do).

For the non-module case, the problem is that "I linked this
unconditionally, and now it turns out I run on hardware that doesn't
have the capability to run this".

And that's when you need to do things like static_call_update() to
basically do runtime re-linking of a static decision.

And currently we very much do this wrong. See how s390 and x86-64 (and
presumably others) basically have the *exact* same problems, but they
then mix static branches and static calls (in the case of x86-64) and
just have non-optimal code in general.

What I think the generic code should do (for the built-in case) is just have

        DEFINE_STATIC_CALL(sha256_blocks_fn, sha256_blocks_generic);

and do

        static_call(sha256_blocks_fn)(args..);

and then architecture code can do the static_call_update() to set
their optimal version.

And yeah, we'd presumably need multiple versions, since there's the
whole "is simd usable" thing. Although maybe that's going away?

                   Linus
