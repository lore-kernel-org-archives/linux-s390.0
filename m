Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADE18E749
	for <linux-s390@vger.kernel.org>; Fri,  9 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213080; cv=none; b=BLg7cGCeMvaBf8V+5JdVL+vvWPaMsT+6a7cltPg3BLUJKmgD3KyUffrSKhroomOPMnF79ZUy7Nu3ifDDDAnxAHknuD1fT0/n3z6IYyRd3Xjfz2KLuT08FZQmKQCQ4XRd4qcoLEmH4gsTadBayV2kIupGXdl0hHSITeyOWX4YQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213080; c=relaxed/simple;
	bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biZXhzTwu0ylIH59jl9ui1cWfR4gk9danNKdKUKMMM3i9M0f0Jj7yPRi/9ohFMoEAVr7HuL7AM2/RY6L0CcMOT5v/DS6mmR12e9J5+1lPKpWMAISmAvXZPguF5rTU2mCPsGebf6rbsTRHn5NUzhKsKrsjqUBS3Epn66344ehF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTxp6Je9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTxp6Je9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so12145a12.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Aug 2024 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723213076; x=1723817876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=WTxp6Je999t+kn1Ow5M76Wtg9iLz+QJ6kALtH0vxLcMSRf0V0m33+9C7v3/mBWBZoD
         a8lKpuTztTJKt41fGLLCaVsSBDoXoKh1+Ni1T+wzhNpkfx2jNqihCqeX0hA8QMSbnXiO
         cpZKQ3iOeMriPjTODa+QgPBvkJGbk92agqgPKBwf/d6QuwYPlLyZGD1LHG+Cxfv1ocMY
         iM3Q+ow9T6UiG1tt0IOOd2adJVCEZgCEWSxiB7cmeaQZG/aeviCpoqnXhr2KyPl+2poU
         EE6MwjDmHSL2v7Z7vsS0ZLgSksztC5fu5VQ54j5fd0Or7yvrLE/xXlIufcbz29BVxm15
         9cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213076; x=1723817876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=D4ydtj25ZAufmENJh+FETUYIj2Fx7yTVKzBe8JRXoD80khUfhRZGRkTNP5S8U2y9/r
         oYgx8YLhhLwATolI5qW04kt7mvpE2ej0US7/26DMQK2KYQn/od8XlYT/vsNqwj25MEWN
         O+B/Am0DDpNNhjNENu1RoJhjnA36gr0lWDO1H+qOhDjzfstZasJe0KnL+cPhDyfV9Twc
         x0wJ/8fzlScQDo1ZZKEpJAb5YDViO2iHuZGmSYUzop7ulvYSpdWvY3LZKoJEXyyrdv4F
         QSzVn2Tb2P47B0NAysVnLO2m+JCrDuCsTspExRX6Greea8U1fv1kW0PT+t8MP+71mVTZ
         368Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmyoZK9XYT4jwcwEp6i507SBqd2iMS8bpQ61O2lTOJR5ZDmM7wK9e0ezJNx7W5B/ro+et3KFWJqnxdyn6M/Pdgyr7QEklQPMdS2g==
X-Gm-Message-State: AOJu0Yx9rmxwVPTFWyO5Gmjgm8XwUCmIpqAkkBvvdgl4MjJ8ZsuRZl15
	Bcz++YeK3y6pAmCqTHaz1l4865/GdcAkg20+dgxNEgIYpRaL2K9JJci2n/wBmeWXovRBnUgpbxe
	c7VknuF1B8Pa+1+4uFagzZK+7PQuxbbYO5Ht6
X-Google-Smtp-Source: AGHT+IG4FJuMRgOPLrNVllaBIrEDQBkPDDIpRd/2JU+QjaXaE3XDW4T5ngFYVh/mKQgDCJH+Vn9glx33KtIoCA3ICtA=
X-Received: by 2002:a05:6402:26c3:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbbc4d3f2bmr168346a12.2.1723213074852; Fri, 09 Aug 2024
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
 <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com> <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
In-Reply-To: <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 16:17:16 +0200
Message-ID: <CAG48ez2vzhYcgt2dtZLx0j6eK92xEHwjFfowg57fAuhQ-0_zCg@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:00=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Tue, Jul 30, 2024 at 11:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> > On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> > > Refactor the list of constant variables into a macro.
> > > This should make it easier to add more constants in the future.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I'm not sure whose tree this has to go through - I guess Arnd's?
> >
> > This is for 6.12, right?
>
> Yeah.
>
> > I can take it through the asm-generic
> > tree if that helps, but someone else should review it first.
> >
> > If you have any other patches that would depend on this patch,
> > you can also take it through the other tree and add
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > for cross-architecture bits.
>
> Thanks!
>
> I was thinking of maybe trying to write a patch based on it that'd
> have to go through the MM tree (for using this in kfence), though I'm
> not sure whether I'll actually do that yet. So your suggestion makes
> sense, maybe hold off on putting this in a tree for now...

I don't think I'll get around to doing anything on top of this patch
for the next few months at least, please take it through your tree.
