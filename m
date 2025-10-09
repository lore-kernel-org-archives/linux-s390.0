Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6C21CC79
	for <linux-s390@vger.kernel.org>; Thu,  9 Oct 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033357; cv=none; b=fVSTjJzLJQ9zivHu/OvbZjGweuRBiKQTlgqmj/UMwxnyeVpKrQK3oP1xeTBHFS7X0B1MYCFFOwPXfqhVR5LBJ7Y/Tjo3z6b7MgQQs375qva+H3OM9FW/brwhCmKhIIW+RkJeYuwFMklgi+bzIS3usaVoMCu08Hr9vdmavr842ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033357; c=relaxed/simple;
	bh=rHrHFKDIXB+Hg0YmzbmR1rzmL1IsBh8r96zV1Wl4vlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rtc19roLIXhqSllH7QtY4tpW86i+X+9gn/syc74gEceh/dqWXH6GIjdPiQqTIyzdaCLyn2ciCcq4RxVflR89vDlTSZ+4EuSMeUM/RYKjxtVb5e99ina0i72hM19apyRq8qPVyVMX41TEpTamxTdX5+qU0pxLLIKl13uaYnmgKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c9picVRd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c9picVRd"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so2521841a12.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Oct 2025 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760033353; x=1760638153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivp4f6TYndCVNWeU6nsb0GGYxvEVlx6N0Z1qdzq6Yco=;
        b=c9picVRdvqBP9wp1TVk6qiH/t/c4WoK7wabF9AOjoIvZkeMo0x7422l05dEiEpHJUA
         bMo7ujfsDGAIUHClkHTSLOT92PXajSYpUwYMIN5EmCguPeBOyo9GHGNWPoCi8Pj/eMVw
         uclQU/AO6ize0NLJQ24MrsZTX4zM3dS5J1/6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760033353; x=1760638153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivp4f6TYndCVNWeU6nsb0GGYxvEVlx6N0Z1qdzq6Yco=;
        b=erknTXVw+L6sv32DpRNQJPtWATntYfSpABZqti5fyfNhmvkfnF6kAAOAsCJ+W3eAuA
         Ly2hStf4PH3ezQh9dPV1+xqOLdK+e79kBTaysVT9Qy0rUeF2NlhbpfT+1qKwAFuklY2W
         O+p6yRbCbqgp/2p+Zb5eg9WcEOEF4lRIPjgkddbhlwAFoe5hHoEJasPUNjYaEiJ3P+5I
         OJmxDkMrcbnussmqPTRX+hgbic8o9X2vJwg4C/MSWCYRRGMk6oVgje04WM+ayXsFqtRO
         PM2YJ7oX7PHYLzhqShQWns/hUeXZ5G/A+9tXFFfETgvMJ9pNkvMUfDz9zunCKhGd3BJO
         ty8w==
X-Forwarded-Encrypted: i=1; AJvYcCUYZ7hiIAaJVy2aKUX3olovZ7+NnyK1pyw62h/Q8dDqN9L8S5cJtnhLmeCPY5KsJf7DtVz/2JeLkxUL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fjS2wOmoBk1pdYrzCXrSBr9aQpXu4+qAeVQbtx0Wrqsq7Cn8
	Tlz3lyh2dKjklO/aPRwr65q+sgOqoDKkOWhvwQFV/hq3QgUgEWm3tpiXh4QIgF90zQsz+jCGzDi
	RQSrI3io=
X-Gm-Gg: ASbGnct500k+cHfEAX608sAgXEyXtDoq80CAprTKH+K55ElDMk66xkQTWFCPlBsouuf
	WNchTAwoB/ZvUSC8YFFCa9Viz6cK1yACT1nVXYFhvJvfskn9+PRnJPBAsbTsA+Hmd+PhMToGUha
	3XN36sQbRz230VV1kvRea00Bjgj6eXZHbFxdFMc3K+IE8gx9cQ1G4fAp6p59aW0Y7VACmhH6B75
	pgd5kLgX5NWcsUkXco3Zuk25CO+BYWkxrihUjSTLU3OkeQPBv3CUL9fc0qHaxES3D/L7SGh9n9L
	N7Zxc34e9KbiYvZHd8rp27esEd0N0s2DoEF9lL700D3C92rEiLOJ5Vv4wKIcEVF3uDfx82nivZ3
	qrRmw2Zysa/hbMc7v1D99D15vDoqDV6FaohXA/FBK5Wn79auhKYqDx6q21FQ+GaC+cRFUunXFK5
	NLXFm3s3LA1eS2YkLQ5IJw4Osy6FJ0cwA=
X-Google-Smtp-Source: AGHT+IFxI/ziBigzzZ/5Y4j22P35zFYXjDiI4kgBpXyssgr+GS6FsCYTa4iX6/iwYAwHr1mnjcOpXQ==
X-Received: by 2002:a17:907:26c8:b0:b3d:30d8:b8a0 with SMTP id a640c23a62f3a-b50ac5d1de5mr967841666b.52.1760033353230;
        Thu, 09 Oct 2025 11:09:13 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951ceb4sm26044166b.72.2025.10.09.11.09.12
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 11:09:12 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so2521803a12.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Oct 2025 11:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAiJkV/AWOkjIbEGCKQ9YL40GJgdtq6FnBVHU19SwUn1xEJ2HASGRBcPiMVvCEBfKq0jsJBrRNzuan@vger.kernel.org
X-Received: by 2002:a05:6402:57:b0:636:6801:eed7 with SMTP id
 4fb4d7f45d1cf-639d5c5a767mr6448801a12.32.1760033352025; Thu, 09 Oct 2025
 11:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009131240.3363697A73-agordeev@linux.ibm.com>
In-Reply-To: <20251009131240.3363697A73-agordeev@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 11:08:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB4OTWTDf0oEkWtWEms8KY0KNrwMj5x+NhhTbAUGy-DA@mail.gmail.com>
X-Gm-Features: AS18NWCKrCSUgJkK3SzlTaV7D8pRpwBhRtFw98jE6dWOIBVAFHIJLlAe9kYHNOY
Message-ID: <CAHk-=wiB4OTWTDf0oEkWtWEms8KY0KNrwMj5x+NhhTbAUGy-DA@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.18 merge window
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 06:12, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> - Remove superfluous newlines from inline assemblies to improve
>   compiler inlining decisions

I've pulled this all, and this commit probably makes the generated asm
look better to humans too, but I thought I'd just mention that quite
often the solution for "compiler does it wrong" is to just use "asm
_nline" to tell the compiler to just not count lines of asm at all
(horrible "count instructions" heuristic)

Because often the asm may be multiple lines due to things like section
directives or out-of-line things like exception table entries etc.

In the kernel, we almost never have truly *big* inline asms where not
inlining things would make any sense at all.

In fact, it might make sense to just make "asm inline" be the default
"asm", and do something like

   #define asm asm_inline

and if somebody *really* wants the compiler size heuristics for some
case, they might want to use an explicit __asm__ for that.

But from a quick look, we really have very few larger "true asm"
statements. I found some disgusting "write the whole function as an
asm" cases for alpha, where for some reason it wasn't made into a
separate '*.S' file, but that was a top-level asm, not even inlined.

Sparc has a few cases of "33 mulscc instructions in a row" due to
horrendous instruction set, and I found a couple of bigger "copypage"
implementations, but none of those actually struck me as "the compiler
shouldn't inline this".

Everything else I saw was in the "handful of instructions" range,
possibly with extra noise due to section tables etc.

All of which makes me go "we shouldn't have to even think about the
compiler not inlining these things".

             Linus
