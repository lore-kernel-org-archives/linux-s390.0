Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04334292B59;
	Fri, 18 Jul 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825953; cv=none; b=XaVZv7zVc6/0AxL0yAf1KvI1auv/h+vuRuFZ3/W9+VpH9dcTv5h7/3rgY2oJEXvs4sqVVGcjoZ/MT5R+Z8k7fk5DBIi8tmq8qeBMpqgW/lf/sZtgQq+hckDmIsHhcwaRDmdSl0+FEUq+5VxJpXMxXkVVgApq5Hphd30sqxU1D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825953; c=relaxed/simple;
	bh=ICkx4RQog4OKxJFuHNw5QWQDaxZatIGPBHQ0QRAHuic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqPkJfy4+ruPVKpuwEwnnmxkI0paNwGsbFAjiYy4m9oP5gFHFI3M6WCtsJkWcYKVtLA01nFmD/2PoKkEhPbuOE00ZDqujnSBSX1T3XSZ2HnjOlx/mm+f0wJ7py3SGdRDJGRgZacA6xWWAyknsyl5lAM/19yQYnCHVnAOG1W1w4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE+bP5TA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE+bP5TA"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b561a861fso15390401fa.0;
        Fri, 18 Jul 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752825950; x=1753430750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE5OlSABnLgWhYl6SAq4PjOG8cGD+M3libfM2kaqTAg=;
        b=eE+bP5TAXl70TuY2rfrjLFLBvt7iDd11k8gthOKQhH9B5u/3SWrOyM1ntbxXfpxn+1
         hnjLpthDGGHBrrSGv9TbiP8du3C15V6+54h301jdpEk1rWrXhuV2PaEeRYsItpZPhD+x
         vb/wsNxOTiAedbwQxTi/fBmm62qUuRnT+ueHRt63cyCz9/P4GNNU20uSnshYnLzFsPA5
         kkE0SZFHVYxgecq19bogFnU0jLFfHMbwF1LLwTfVP8TLobBSvdpyXmn0Gc4zZ09RqpkA
         3NNBRGHCo8ExYOWXabk3S/8App5x9V2BcAWwzPvp5t81igGBtpWrTAAGaIlf9frjbpxs
         x1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825950; x=1753430750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE5OlSABnLgWhYl6SAq4PjOG8cGD+M3libfM2kaqTAg=;
        b=ACJt6ilr+wUXFl3VoA603SkvkiMUjTWiDx/3RENvKsuJ6gRxGClTiWTSQFV8rjYOaK
         ur201h8NT/KqEKod3jnOE+ts5VPbD7TSQy2YcjwJVIiQye1rDxeGTF78oNSD/VJUZVKl
         ZUS6IKwB/9CoX3h+jJ+0qe4ATmPcLCBXjkIhRV+mXOnbWQLIy/+6/OdCQ4l1mPlHB1aN
         91sEwN1LzklscLm9KnPcVdPTXLd4O6QFrsSUn8cKTU0ulD3k3mH4PQw5CBaUq8G3AeQj
         Bnb2WSv2kGfitqdzFa+1j+ER1L7Xai/9bjKHSTV+6UBise0IX4xjwUnHg3UhfzH57UgC
         Q8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVJsddYAkb+SksEulBeERAyYDLH7M/PqSR0R0ZcazYZmayddyjk0qdz9PS803MFryod4BwhV/Cbb17JY6E=@vger.kernel.org, AJvYcCXPdgimOP+qRZd4q52WWaTGbRq/gb04BSfslBLMclWfcf14iMf+d+jaGfXBof+O9oWCK3rcYjfoh060Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdltMdHw5Nx2cVy6REe/l0P1zMwG0j952GcJGN2VMShK02Cs7t
	l4hnCZkBYElAWbvBg5p8/EVX0qWhedMC6bfu4nRCSlzqAi0/nqWZb/oQd3riGE9gjbFAfhs4be4
	WUWmKgeDCTdnrHfF5o7TkBEHamf639jM=
X-Gm-Gg: ASbGncsg+NXpTneiebpVuEY336cz+uqf9rOZJBgx4p3O5RdvUhRlhQMZWDrukIR4G06
	Pc89+btR1sVnoo1xfzmhnpY4/J1HeAf1Uiq+A9XJrnlT4QRqG78xf6sSHzz/Rul5XpNQFiCANSU
	IPJLcLjGpR+8axrdf9X4UtHDilCjr0vvsXLMFOdIIxAJSavtJ/0aGTEj4v27uH6bqWxpUG4YJfN
	Xxe92E=
X-Google-Smtp-Source: AGHT+IHyLMKDBrDr7Srvy/Ikd0HaWMaoK7ylFo11Rc1uD9JBuJ8oBsq1gin5zNroA8IEeJqMbuI/vDPTs3/MNmSKtdw=
X-Received: by 2002:a2e:80d4:0:b0:32b:755e:6cd7 with SMTP id
 38308e7fff4ca-3308e56e179mr28488571fa.32.1752825949700; Fri, 18 Jul 2025
 01:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-2-snovitoll@gmail.com>
 <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
In-Reply-To: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 18 Jul 2025 13:05:32 +0500
X-Gm-Features: Ac12FXz9YqNA1eFVik-g2DCaFm9kQISkxpcsj01QS2Zo6EkvjPY09aiUDIQMxqs
Message-ID: <CACzwLxgyd9yd3ah=LK93Bn7SwAy7H1Hhi=ncFzZYUs+6YGEqvg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 3:10=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.=
com> wrote:
>
> > Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> > to defer KASAN initialization until shadow memory is properly set up.
> >
> > Some architectures (like PowerPC with radix MMU) need to set up their
> > shadow memory mappings before KASAN can be safely enabled, while others
> > (like s390, x86, arm) can enable KASAN much earlier or even from the
> > beginning.
> >
> > This option allows us to:
> > 1. Use static keys only where needed (avoiding overhead)
> > 2. Use compile-time constants for arch that don't need runtime checks
> > 3. Maintain optimal performance for both scenarios
> >
> > Architectures that need deferred KASAN should select this option.
> > Architectures that can enable KASAN early will get compile-time
> > optimizations instead of runtime checks.
>
> Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> during -rc6, especially given the lack of formal review and ack tags.
>
> But but but, that's what the mm-new branch is for.  I guess I'll add it
> to get some additional exposure, but whether I'll advance it into
> mm-unstable/linux-next for this cycle is unclear.
>
> What do you (and others) think?

Thanks for the positive feedback!
Adding it to mm-new for additional exposure would be great.
Given the complexity of this cross-architecture change,
I think of taking the conservative approach of:
1. mm-new branch for exposure and review collection
2. Advancing to mm-unstable/linux-next only after we get proper acks from
    KASAN maintainers/reviewers, at least.

The series has been thoroughly tested by me - compiled all affected arch an=
d
ran QEMU on arm64, x86 with KUnits.

+ Forgot to add in CC Johannes Berg, Peter Zijlstra who commented in v1.
https://lore.kernel.org/all/20250625095224.118679-1-snovitoll@gmail.com/
