Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459721F1315
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194637; cv=none; b=k6lIfijhufc+1CywvOkZh+noirG0b5gLIUQ2+bHKd9b4xIFLEyRU6W6zEcn3HEyVMZyHHp1zbcRpCckhmKsAeElGFWl/8Tsy1EI8ZykqoPi040kGza3Tuvubu6llOjYF8OjLc1b8CmJAVUUDJnfmCMDI/6LMA1XOUDPmBWHEM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194637; c=relaxed/simple;
	bh=ir2qXEQz0ITQfoN65/zED7gUfzbFZUXr94ByJGJvwQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUw4IXJgQy/Ui/Owxip44mBVu9jNjCHqA3DtWvfNShGRifWDqPWvcWYCJWLvd300MTzoZxwrHuXlPGt1TKRGBSKjzi0tH994UwD4Z4x96CUOORKn4lEWnkFLlqPt5F1kWsTTWJHHaID9qXZdSeupziPMRGDCMFiJ/pADR84JL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HMsC5FfB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HMsC5FfB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so9004412a12.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750194633; x=1750799433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NscEjg9Y1LWinfHLpsahI5dfBkkxck14FsEzSEH/mHM=;
        b=HMsC5FfBBK8m1OzFzla6fblWwkNIzUHDmGhhJ8yI7xn5y17BmMGS+n9v0OX3/0ZUok
         05Ye3ty1blfiv0qAEkOtr0rGdneAksgoWTKeUx1NmzyaJCi2GjCR2iMXQ3sjkl0sGEcj
         uxMct+ygdjDVcBLicGWBCL8TFCeFJsYuQOOG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194633; x=1750799433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NscEjg9Y1LWinfHLpsahI5dfBkkxck14FsEzSEH/mHM=;
        b=pjU2UyGYOnQdSsmPOfpOsPzLdOmAN35F0zwjo0/A1t4n5vjisTul71uH1OPWxf2QkG
         RrdnO5K/RpY7MtiPWajQtbczxmpx+A+bIEWBOZVsb90S6P/y9V4OJnTvqfNMQCi+R+Es
         vY9J6e/FHLrmjJhwe1gIgSV+KMRR4A9USoMZdpT27bN86DZuceqdbAKaRWqIXw4KKzqZ
         EMZ/OaloKr5yu7y8jh1ZPQUJLS4iCaIYT51L6if2jm8topbQSSf3V8Yy2jlv5zTgk1ju
         G0T2jIpYHWyAO3Yy6VRavp0yfdYdNfJwqQ9nONz6qLFsah0ztBN0qtAPoXSvtgv2vcee
         OK+w==
X-Forwarded-Encrypted: i=1; AJvYcCWftm9hGxzLNgPlG98K33aBmzPxQEc4oSDSFRuVzLFGGD9LKLQ3Jof75jfdJoUinIcou2xEHILQD3GL@vger.kernel.org
X-Gm-Message-State: AOJu0YwELLjx4pZTRils6NBhAdnnAbAnwyCyD8AjymdydaA5wv9TsF2U
	84IVX5inA/jjhKgxm2XgjCufRtLy6EpY9rrP3vYqKcQnUAwjOBCQybESqj0QOE3ogLCmXKzY5ZT
	xN21owHw=
X-Gm-Gg: ASbGncsU3jr1bDH6b4LN6bZRDX2OMXXO5kjDevT2vF46RB40739sTxIE4tavX+v9Z8h
	q+6rH/I0Pcfxo7djyFHMQy2WBZ1PTlR7xUpjjQFvzX/05QH3DKoV4dX1bFuAufVzWdk7X2Y2wZy
	W4jZdRaobc/HDrjwKsWt7x9gyJQ2DOnfVMUm5q0A+kOZ+vZdKJkxdq+DDiUlpawgSEXSLXpFCKR
	MhfGF5EeoDkK9UZGFiACWcHBo1mdbd9kbB0EF0+/oonbAj6DI9TabjUqhlnaaYxdnrIGn6gNKUp
	Lf4fxWA6qeZgoDTNsVN716xTqHb50aYBhEJ8iQCM599nLFJZsT0PF5DcPa3yxVgGifO+PA/BquJ
	co4T3ZELS9R+JD28v2xW/q59sBtjPMlhvdnuj
X-Google-Smtp-Source: AGHT+IGAOuGqxFg/Ry0q4Hzxgp49MDxExdOFLypHauAcTuHVvWje1JC2pxnyOsGsui1F8ruOenMIZw==
X-Received: by 2002:a17:907:930a:b0:ad2:2fa8:c0a7 with SMTP id a640c23a62f3a-adfad3281d2mr1476031666b.21.1750194633153;
        Tue, 17 Jun 2025 14:10:33 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8928c20sm927192966b.111.2025.06.17.14.10.32
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:10:32 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso10773287a12.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 14:10:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/x39vYI7DnAn0qlMSS5vU/HRpH9usD3VzMSxWRBqQ8kWdKaKiMZicOx4tGsK5e3apZXgR852bngwP@vger.kernel.org
X-Received: by 2002:a05:6402:5188:b0:607:f55d:7c56 with SMTP id
 4fb4d7f45d1cf-608d097a0a3mr14798722a12.25.1750194632040; Tue, 17 Jun 2025
 14:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
 <20250617192212.GA1365424@google.com> <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
 <20250617195858.GA1288@sol> <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
 <20250617203726.GC1288@sol>
In-Reply-To: <20250617203726.GC1288@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 14:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLENPVgWtHg5jt42he8Eb2pFzZngbvfSWXUmq64cyaAw@mail.gmail.com>
X-Gm-Features: AX0GCFteh8AxHdG-O3SktB-Vd7hTjMUC_EBJsHwrbakY8eEhqvV4OBO-zVcDyV4
Message-ID: <CAHk-=whLENPVgWtHg5jt42he8Eb2pFzZngbvfSWXUmq64cyaAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 13:37, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Okay.  For now I'll keep the test commits last and plan for a separate pull
> request with them, based on the first.  I fear I'll quickly run into
> interdependencies, in which case I'll need to fall back to "one pull request and
> spell things out very clearly".  But I'll try it.

Thanks.

Note that this "split it out" is really _only_ for when there's big
code movement and re-organization like this - it's certainly not a
general thing.

So you don't need to feel like I'm going to ask you to jump through
hoops in general for normal crypto library updates, this is really
only for these kinds of initial "big code movement" things.

> Just so it's clear, this is the diffstat of this patchset broken down by
> non-test code (patches 1-3 and 6-17) and tests (4-5):
>
>     Non-test:
>          65 files changed, 1524 insertions(+), 1756 deletions(-)
>
>     Test:
>          14 files changed, 2488 insertions(+)

Looks good. That's the kind of diffstat that makes me happy to pull:
the first one removes move code than it adds, and the second one very
clearly just adds tests.

So yes, this is the kind of thing that makes my life easy..

> Note that the non-test part includes kerneldoc comments.  I'll assume you aren't
> going to insist on those being in a separate "documentation" pull request...

Naah, they're relatively tiny, and don't skew the diffstat in huge ways.

             Linus
