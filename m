Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163513635E
	for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910481; cv=none; b=Pf4u6MH16G1YSiMdoHM7zgEHttkcgw7NT6oxnVTX3LcgY/WrzFkbRJF8VLWORWZ348wU2As+vdcs6uSodRLzzT5OSa6P6xezo/OzQbQGbTmyUHgeRdJzgeuHdEDt3CWFzD356vgWWGFFTjUnY1XHUcp8t7x8L3rJL6ShZ6XqUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910481; c=relaxed/simple;
	bh=rOd9yTpdEpOmqr8gV3Zvtz93VcNjmSVSiEIE/dTz7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak8QGJsHs9EmkdWUa+n/T10DMerEzz0S9oBc+BnLZfCnmnBIoPZlOmhQ4RnVTfgMGuhubzfUJhoU5fHK5PxJkxEBybl+cmBCkP8zDCcLNo8swZsc5qJCSKUdn6BZIiRdtXKwWPFAIdbgwWsf4vgmjOok8Dovafysq7tA6gl64qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBGzZJcM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBGzZJcM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so8889776a12.3
        for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 04:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910478; x=1769515278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=QBGzZJcMFazeNJqhcgBMNIlqAiDs9auo7F3JevfSYVfSo8O17+6tn092shOyPJ6jDo
         X7jl+SaIG8jTDU7GLyk8kr/PkaV4h4qOl2RYWMuftWJ8utZqhPvbTfWRJu9cXVCBZHvl
         fX6zZXHuUeHrum7C1FDMzkb6BiM42vLzGsDqtFw5wIdf/3o0KWfLF55YZlh7cJtkSNYX
         a49P9BmudsF863wMHZ18FVQ23564MmN6o26QB72Q+xCaTwYeva0Yxyw3NrCUgth0cr6l
         qWTap8WX4vp2vJlScClpD9PK1Gjzfu9gR4ghUA3L7XD/FhcuC5IsBujA50qlWDhS5piZ
         r+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910478; x=1769515278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=liOgayx+FT7nKc0JUVZjNqxxrJbnvtBkT3UBL/QqdxZqNYmDqBftBcms1W1pfoWjBQ
         nnN0add1h4wBU6wlhYKkp/FSCg9l0ZbBnvQbWFhdudjEU6Ieb7eeezJDzcXOHODOdBFq
         R2CCNAZR+z9EuVCfi63GIqzoymKIgTgCaZ7H37P0Weov24gWNEJ0HtW4SGqVGvLAftxe
         C4r7ub73LbMtHem5xuk6nJ4jt0l6KGB6Ndq0h5aQszTNxm69zKroJM2wLV8I02qvy/+l
         PHu4axkuGtlAS1eiVUuROb47phDs3oP2g7GI8QsyXrzN6qgmPT08vvnUaeGqiSv7jrGU
         EcZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHZk3VSQ3cDJY6irzVnWBoG/ein1T3dHeL6oTGhtMhf3F67TsPy74p8sPVHkkoXbVXiWk1nt2SupeE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9skGYVZscDygtGWca4fW6cxPSb9osw6lzTpq1RDiS52lctgzT
	/0JokWdqbpwA5xHrYE38FbV6roEiKHU8+r1MTgMNHQ1M7mGbTqWbkBWEPO0x+g==
X-Gm-Gg: AY/fxX6JLQEX7f2+BHVjxIjlxmjKEUeOYnzfitHHQjb7/0Wlm46lmOzhqSb7t+iqZHK
	/gakxTafJrnO6KDSUqcaRchRYQKlD9cv8X058nV0xjizNRJHGiUcGmEG6uyYQvTlzm0YpNsRL25
	uGRtB0/sk5Fm1VDHWvwn4XsQbx2ofTEzPadI1Ky+Shz0pBW19bnWODL96Bt32+esQnMAV11htGZ
	CChXHkbDgHu5N2k6lBxNh3JG2fBzQ6WuG78V9X/OrdLG0j2nZmNJvrVWCIHGD/nnN0YRy2BJ3Th
	POk5YsVTN5tQr1Jk9xbXqFJK9iYYTiGMnju58HEI3pvonvab4q2LcpnkcSbSjLDFFsqrpLzRmNS
	vedDqKeG0w+svli7KvCzI/w3ZAuPoNVtIvsaVgN5NRi/4S0SeqCPbshaO+0S7fP5REM2JzNzS7P
	4vHxWJMEQyyoGbgJGMyXLfd1/x4bXQkZCbikvljaMjBLS+BfoUwSw3
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr16216419f8f.1.1768903412929;
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569997f41sm27420500f8f.38.2026.01.20.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Date: Tue, 20 Jan 2026 10:03:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, "David S . Miller"
 <davem@davemloft.net>, "Andreas Larsson" <andreas@gaisler.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260120100331.1f57aa99@pumpkin>
In-Reply-To: <7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
	<20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
	<f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
	<7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 22:39:53 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 22:12, H. Peter Anvin wrote:
> > On 2026-01-19 07:39, Thomas Wei=C3=9Fschuh wrote: =20
> >>>
> >>> Do we actually support any compilers which *don't* define __SIZEOF_LO=
NG__? =20
> >>=20
> >> When building the kernel not. I used this pattern because it is used
> >> further up in the file. There it makes sense as it is actually a users=
pace
> >> header which needs to support all kinds of compilers.
> >> But this new check is gated behind __KERNEL__ anyways...
> >> For the next revision I will move it into the regular kernel-internal
> >> bitsperlong.h. That will be less confusing and still handle the vDSO b=
uild,
> >> due to the way our header hierarchy works.
> >>  =20
> >
> > The point is that we can simply do:
> >
> > #define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)
> >
> > ... and it will always be consistent. =20
>=20
> We have discussed this before, but decided it was too early to
> assume that userspace compilers are recent enough for that.
> According to godbolt.org, gcc-4.1 lacks __SIZEOF_LONG__ while
> gcc-4.4 has it, as do all versions of clang. Not sure what other
> compilers one may encounter using Linux kernel headers.

For instance MSVC doesn't define __SIZEOF_LONG__ or __x86_64__.
Unlikely to be used, but...

So you can use __SIZEOF_LONG__ if it is defined, if not hunt for
something else (possible just fixed in the installed headers).
But in the latter case (at least) a compile-time check that the
value is correct makes sense.
And that can be done portably - probable with a negative array size.

	David

>=20
>      Arnd
>=20

