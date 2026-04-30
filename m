Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE017A30A
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569903; cv=pass; b=RWqc1A05Z+jilcNfAC1wAgMFvD+EcpydKyKG9N2GVdxcxRLe+ZqDEbP/IAFhGeT6UBETUhUI0Ww+E2uQn0L0bcPao8Lsi/TOfgRtSSJpww6fsLdXqS34CvwSy6EcsYSCwNBk9Cd3slfoi3qThrGlB/tT63Y12qhoAd7sdxsFK5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569903; c=relaxed/simple;
	bh=FwNKP0InoyCJCoAMkcfGwHqTxXaBtlR3JdJR34J2GW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI3pI61XNP3KOyzVpX3XS8phPln+HYewGWzYzdD+RY2tW7d6IXxIbuejl2elqxuiu2Xax3OG5I3DQAHZDun6/Q3XdM3Wa6KsYZ+CKjzbvbiYzQs/ECpjZLLIpF1phLrRzpRZTa72iL+c2cCJ0A95Ptz1FFcrmShO/LC4m8kjPTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpBeAA4d; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpBeAA4d"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so28951cf.1
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 10:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777569901; cv=none;
        d=google.com; s=arc-20240605;
        b=ZyhfxeRIxL/2RPpFaWvu1Lk9i+4OaPqXsk51BDhV318Hk825b20L+r3p+o2b22wEY4
         DxQxctK5h4GW7u23jgAp5mvHS20YrCqxeHrYF4jZuJkkG9qvIv0L78lbhWxArZxR1vgW
         hJtV3R2C8qLiFpAGFuKAGja3dfzibu3M8obRTq7rs72ilAMHJ7CpPVU/rlrNdAS1za2x
         hKTIbd1RYH8MQSnOICkNxkTHIODSB6vaaZtFvExJk978NnE8WShVPdhtk8TJwbbOWzGB
         lU6LL52AFzZV4Rh/x2zHLPza/+nfpUyctgeqTVkDErcgC6zx3J89elzyceuQ8krF696b
         Zl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=McFX5gNqOvKZ8pnwMW5W5DukXmHwj3b1/6EBkR+5oQk=;
        fh=E6CJKHYDCeC0chB6zaZ/rKbc2UJ7/r7unYC/she6/rQ=;
        b=GaDzfy3orPdPJrIthp80nRF1qEm4vNcM/mibQnmlMmtRmsWzJr3cFvs4woNm4rrVyV
         7P2RyaKfp1nf63miSdGRuyzyCi8VxXt533Y3q+Ldu8aXgdavxDbM1rTbYxXAzRFnIwAK
         jDgink9nYvlYAeNrRQPUd7TEiAH+dIkR1ooPDtF3yMiwFqt3gJh1fvrh9mU5dX0KhrQ1
         ZLKlU8BN5tpjn+XjDqdSLKM/GAp8JEu4t3cKDypa0VoynijX+0BGygOmOa82l5DTncqY
         80GgbPm3yKGh+Y+zWFNYLqC5UoGpH8jJLlmZpWs5Oc3FGw/Wmlb1Co0FRXxz3pb4ouIE
         OzIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777569901; x=1778174701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McFX5gNqOvKZ8pnwMW5W5DukXmHwj3b1/6EBkR+5oQk=;
        b=DpBeAA4dBh/uiVjjh0Z9xpT9BLvAa3Xkn2Jqo4c1pNkhjWkRA7N9K/V5cAThrKa8PG
         jTZojG8Erb8/yyzG6UYW9dRW2XJ/K5N/sS0CpDewnl86Qu/aD2jtclClRxqWbAa34THc
         XRXlZPlvtZr/ij5yJgJ1IdI5z21sBrqISQWedjC2Xjo5bBCG6R7YkB8JDfN1yWNgA+lH
         3+2GYvCobk8329USUlcK/Zidk8xD3Ak0pF2aTcwkYJ572Wa/Z8SwurzRTDTKzafY0dwn
         NKLg6MsezsjeqBcp5drwMovlihPjYjk+SC4eMZOZJl3jafzrTZJLxZfVnTW5D/3fNMvw
         I6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569901; x=1778174701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=McFX5gNqOvKZ8pnwMW5W5DukXmHwj3b1/6EBkR+5oQk=;
        b=BLoOQ8x3cESJ4Oj9Qm8MFPy3Wpwnd2FCF/mHDbUEBONbNBzy80SWtQo4gWV3kSocHv
         rLX5uPOzOjKHUPwXupTSz7OvOTyK9k4g+Vr0ImAaUO6QRcx1P/Qzxl6Cd+7+MKOvtap6
         yaVS30Zm+3kYPysWuIAV1HlrjNxMV3IXMTOr+xAsfJ7ZPrq68WmX9qEc/M+oEAjtPaE0
         lr9l0BKZKS3XwPTDi8XU4M04uT1aduIg0hNrzEfPgRx2n6NKiL7JLnNB2nENNMZMsZSB
         XVDwj04DddCrjGu7HkFXHwbKJJEERoQ/e32Ju56bgCwUFM177TAKRzMw+9xW/fvJwU+L
         3pTA==
X-Forwarded-Encrypted: i=1; AFNElJ9hz30agHoRbFhN8PVaEn39QDGN0kFIFJKwsU0ZWBlgZWrS0A6LkKu3fMhSxkzUvVpIx7R/qyjJwyLm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiz9QMZuhpSezHjWTB9BlQDCm2ANnK/rk2jZG2AU5nKbbNhGbD
	yc3dt+pvv9rnUhJwou7Qg0fVwc9yJdNTwKszlJonPVmjD1s4NZmAmKvs/9Vg37FOloUvhZAqWHl
	0joj0C8WVsRcHawFV04EBjGx2PIWJj/wpoHPJkNhQ
X-Gm-Gg: AeBDiesNRnvDWJw2fX9N5oZFn4E+hZoVeLhsrJ5POO2j36/rYuRRboKSL6iPzhfQPhu
	x4n/jnoRmBqnRqwozvZpzced7trJnS+hoSDJMuECrq9bKURp2Evg9u7UnG5Lw1lwvKgzpgD1l88
	pzzniuz6EtEEUTdQOmKZ1qouWYYZzOKAiIi1aBmUlASCXjkBwZS5Q8VxxD3VEXtvbdLGeGrjHdI
	hLe6st2Mytujx0MFwUx/W4MrgkclwGOCxT1IvCe5zi8d5x17DihTceWPxZdJ/WUbQNUrrbZutGJ
	+jaYFVd2KIiGVKz3M0mWA8MR9f8AsaATl2QfGhNeqIFUF2nWIuuc71igSQk=
X-Received: by 2002:a05:622a:8d03:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-5103d2bae05mr306371cf.16.1777569900870; Thu, 30 Apr 2026
 10:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429211359.3829683-1-minchan@kernel.org> <20260430074305.9d3389ed71af040acfe222de@linux-foundation.org>
 <afN2GBAjBSGlTgvA@tiehlicka> <20260430093423.3118ff0f295a9719cdadd91a@linux-foundation.org>
In-Reply-To: <20260430093423.3118ff0f295a9719cdadd91a@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 30 Apr 2026 10:24:49 -0700
X-Gm-Features: AVHnY4KtYPqXaxorbLC2XxEQGKcXLI2PBWMWnecC4yRS76p9u238IBXgkQazEmU
Message-ID: <CAJuCfpEwn-q6j3UFnB+OZAWm2CRo0uCyjXJSNiZpQDFgE7vZgA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, hca@linux.ibm.com, 
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:34=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 30 Apr 2026 17:32:40 +0200 Michal Hocko <mhocko@suse.com> wrote:
>
> > On Thu 30-04-26 07:43:05, Andrew Morton wrote:
> > > On Wed, 29 Apr 2026 14:13:59 -0700 Minchan Kim <minchan@kernel.org> w=
rote:
> > >
> > > > Currently, process_mrelease() requires userspace to send a SIGKILL =
signal
> > > > prior to invocation. This separation introduces a scheduling race w=
indow
> > > > where the victim task may receive the signal and enter the exit pat=
h
> > > > before the reaper can invoke process_mrelease().
> > >
> > > Does process_mrelease() have a manpage?  My googling was a fail.
> >
> > It does. Very well hidden in 884a7e5964e06
>
>
> Well, that didn't appear to make it into the manpages project and it
> doesn't describe the expected usage: need to kill the process first.
> But I guess all the needed info is in
> tools/testing/selftests/mm/mrelease_test.c.
>
> https://lwn.net/Articles/864184/ is useful.

I'll try to carve out some time to post a proper manpage for it.
Thanks for pointing this out!
