Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE07168B8
	for <linux-s390@vger.kernel.org>; Sat,  9 Mar 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950183; cv=none; b=heJhFfEDtonEfolRaDpWIpbr6X8STN1qmUVdtSJWyw+sjibJJ913VfxuVxyp5gG4i0JokPm8XetMzpkiqQ/gHxkffM/vFw+AuPhidUmWKZFsJFCK5bvSMb+EvqnE2+/MubBLMw9GK/8/jA24Kr/aiedoL/hVVfJmykqe7jVk5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950183; c=relaxed/simple;
	bh=fT2eqEK6ZX28H5ccaTmcMsNQ6nqglFnzvb6+pgySt8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJfOmWM05yLtCCRgSMm36zFXYy9RgN/zktbuB42SysMWlMTEQxud6EqEkURZJisbQx6S/Vp/5d8V0U0IbiiKDbcX7MWawvx6AkD5SNHQlrTMmVeXduzEonxcwYXYotrMsRVZgSpSg3nQUpTIl8oQvXPyJZkvs04z6f5+i9R5zVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=162fV91/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="162fV91/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so6859a12.0
        for <linux-s390@vger.kernel.org>; Fri, 08 Mar 2024 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709950180; x=1710554980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iA/O5FAuZIkkJpLARXGwTKQU7mlJK2bNxZqfqbSr2E=;
        b=162fV91/XLOMEVNu91kVDZW9v62EwBIoAJ6EGL0eth1xx+4E3qI4HCMkc9ZHzAiJWr
         uxmyJNPircX+RGcRCM9H0bxjIew2rU/YY0mie6mRepV05xeWiQhgsLRHh/GJi9exhQ3K
         QbsNCRmq4fNrCDQ7dVA5P3TA0M1/B8p/y08qjrU9zelDcIatjzq9TrZQLxPjhVXh7jnj
         r1jouNfrwCJY458HZ9NfSjlhwiee+STd7gGbDwMvcXiGBSwT4IalZus6pj6qzJ/PQJa6
         J26Dea5K2hi4INEP5+YfcmcaxGIZsxkdSnOMzA6zRxVl4+1tCoP9CfDA4S5bhGCSX9KX
         voQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709950180; x=1710554980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iA/O5FAuZIkkJpLARXGwTKQU7mlJK2bNxZqfqbSr2E=;
        b=auvtdJqdja3nOhQ3TXs1nrkd+4UsQ7Rp9EOyGFOQWThL7OZNw0c8tW+GgXZuFyftqf
         iIU4wGDS5ACmbxDjJnUXYHtnnCohYVMpeinAuIxgCKDjbSsJPtAoA9PHQ55g8eKBtdxC
         b/y26AQwkMKaeKCyLUwD28xO467HiLHcDhOd1vfWpRazNO41T69Gtzw+rjeu52imIbPt
         h8tVFZRfngU8QfGmjkUVxMfZ9Qs/a7c08XsDjcPG3cSzSl5e9u3QGISdk465kj+MOyDm
         Zk659ShK35sNkFteI1S+dWqOHZ/pyY1xNfBs56vT3lhlMSQEnEJcsJp99cT1Kb7/Cc3V
         bJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwPQdQ5EG/sKNl2zwgTNO5doMHkc6mZJmF4dJKNQQ/cWpE9jVbtZAskXQyy+JDQZv2WDplRWdqJg4oa7Vf8fbQykdqd/FBJlO7tg==
X-Gm-Message-State: AOJu0YznSySycRtv4XGcFlf82FG2vGloOy8/1NzSPguxPqrlRtKJB+Im
	AWQ9jdzqEBCrmwTUATsDlpSzqCV9OQbvavxzvIMPesSm6OUrdeZG/i5Pmy2ozyLboyQQhXvcuHr
	QNlhkRjMQEey9PUfUF2loKxEBSLDuaGAZjzo=
X-Google-Smtp-Source: AGHT+IH1wfEsl3zKB9H3Vyi4xiJuc8O27VmE0VqduNPgWy5WeVV80OQIL23LnY8tOoMP/pNpbewIu2F/rKRc58j5SR0=
X-Received: by 2002:aa7:cb57:0:b0:568:2a4d:9881 with SMTP id
 w23-20020aa7cb57000000b005682a4d9881mr247846edt.7.1709950180312; Fri, 08 Mar
 2024 18:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308131512.44324-1-adrian.hunter@intel.com> <20240308131512.44324-2-adrian.hunter@intel.com>
In-Reply-To: <20240308131512.44324-2-adrian.hunter@intel.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 8 Mar 2024 18:09:27 -0800
Message-ID: <CANDhNCppmiSEGXErDZ5=gpWFNrS5+Y_vY3e76vhqCwpxKZ+bnw@mail.gmail.com>
Subject: Re: [PATCH 01/19] vdso: Consolidate vdso_calc_delta()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Stephen Boyd <sboyd@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 5:15=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Consolidate vdso_calc_delta(), in preparation for further simplification.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/powerpc/include/asm/vdso/gettimeofday.h | 17 ++---------------
>  arch/s390/include/asm/vdso/gettimeofday.h    |  7 ++-----
>  lib/vdso/gettimeofday.c                      |  4 ++++
>  3 files changed, 8 insertions(+), 20 deletions(-)
>
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -13,7 +13,11 @@
>  static __always_inline
>  u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
>  {
> +#ifdef VDSO_DELTA_NOMASK
> +       return (cycles - last) * mult;
> +#else
>         return ((cycles - last) & mask) * mult;
> +#endif
>  }

Nit: Just for readability, usually we avoid #ifdefs inside of functions.

Instead maybe:
#ifdef VDSO_DELTA_NOMASK
static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
       return (cycles - last) * mult;
 }
#else
static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
      return ((cycles - last) & mask) * mult;
 }
#endif
