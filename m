Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7084272E72
	for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030363; cv=none; b=EfcnjAIW5Bonk1WznoEdqHbrSNkst9WFShxfdVE8gDbwdOOny8ZGTvQ0aTMA+Ji9JmD7zSEy41w0MXzdA3O1O9NHueGd8jWXObOXf1S7CtlACIEIilkUM4juCJMLpGZ+AcdxjoaZW5Pq8pla0kz+RgSpwjoNdZF4ff5ZiQZqimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030363; c=relaxed/simple;
	bh=UpOZTzA2Cg0xuj9L9Snqlj1LAarwNb659Ui+cQ6KOhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jntexqw0U+wuNteHImDB83Pcfv0PQIqVQt2sFD2xk9GT1SwELCMMqts5oIzxyYCCSPGYNzBUXv7XVOcENsYszc/YocnC9UtN1nupMj+Us3bvdmYinpmfokOg7H4ogsaCdzueY7REmWHYsM3yjef8gcX1MhICmWUDHpBRAY8abUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso2256254137.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 00:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030360; x=1761635160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhPGZdM+an4DNurRNIbu5m1jJ3B3iI2V4DQkHllaTd4=;
        b=BnEO4DTBzlxQO19+Xo8bitmrtCYTYOjDj2oe/jUpzJ5YOiNwR9SFv6fX6TdHw8S/d6
         0yd6RVQMW4VfP3OAMl4hMs/y6Sk2QKoQ6pvMqrRMc/aFVPT22V3rPNa1mO2r+ydIWoez
         dI2oDSxle8vXIDN8G0NLM2NRt5sx5eJLcz8zjmo/CVWDdFViECU2PFkHxG6jbPHWcFfl
         Kkx4XMv3iXi+teTsF6Nf9iTX1UNc9o/2QAg79HjqERknXlloFm/CHZ89Gpu63hvvriGz
         jsZ2eBBTrM6/gkQ1yCt8LOhHX6HfPat9Z3/D7WkN7Zr6NLQ4sX/qUhYV1Z77dASEqMKS
         eT3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsZBWU/Ho1353zWaPQAsdtqKV3N/QoamSs3bZXP4TjcW0PVgue2I4g3/KIq6r0b7Jxlc7Bo85TJY3p@vger.kernel.org
X-Gm-Message-State: AOJu0YycuFATWltrp4bT7PTiVtTzS8NsfzUpuzEaS2T33UUcY50HtbLb
	TBwY4pTxwJhQ6DmbDDKIti/UvyDOKRYOPpjAgs1aAiSvVCIy2YJnksebP5p8V9nm
X-Gm-Gg: ASbGncs2KeIrrpImhZs0mZW1/lmnOcERedjWX+9H0QSiGUddQQ71d9TC+lS5/UK804o
	Fc92/AwgXPEt+nM3C4OFPnAN0T6T2gaqAnaM373n+MK5uUnrVJvSr6rJc3Y9JwUHXBoOO0Rft49
	BE0/WGzgtn1884T/7FfPN4pZnToSNKSkfkddUQOJkLVFgQqYCCv8Ee+3lG78pzX+IYolXSyYfum
	mwitXj8nejG+Gh69wUfScAcZNJJMV/jqFwO3G3G2X+1kbY3pFc6wlXDg5pfaujF7kXnC9nvxJQD
	Ngrt62jbZItA+BP+vUcho0wrIe670bWJRQKoXsSRO8YNt8H+EdJHTsqox4Wbbz8a7VRqposUtxR
	LsnneNYBT3gECoxIIxYpENN/5LWL8H1pHnMnvIwIm0vhYSQ2fAicbVSaZQn989x27TrJ1d3npbS
	7LCuTf/XaB1vYPx0O5gs3hLk3QmChNsV5tc9pV4A+9VuOfnic4
X-Google-Smtp-Source: AGHT+IEY5xcfIV/0cGhJwJWKElSFla4T5f2NCJJWXPyxZrzsKcysAleQWlAZtnhNN32qiBOcD1A4yw==
X-Received: by 2002:a05:6102:290a:b0:5d5:f4f8:1ef5 with SMTP id ada2fe7eead31-5d7dd6dcb1bmr4243274137.35.1761030360365;
        Tue, 21 Oct 2025 00:06:00 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556620a6677sm3078461e0c.15.2025.10.21.00.05.59
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:05:59 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e352f6c277so1247093241.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 00:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsfSNgQrZ0dOCOldF06hefqkOvmU8Wc8gCkE87HsUfuFQkGXXEtExD1+dTYhtntjIgpNB7CV+tSF6I@vger.kernel.org
X-Received: by 2002:a05:6102:548c:b0:52a:1ff2:da15 with SMTP id
 ada2fe7eead31-5d7dd5a6916mr4190451137.15.1761030358892; Tue, 21 Oct 2025
 00:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com> <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
In-Reply-To: <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:05:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
X-Gm-Features: AS18NWCwSLaTZzUZHHjPu2aHB1yMxhOD9WxIuBCDLK0u4mfaGukRaya3oKLFi-A
Message-ID: <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Doug Anderson <dianders@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Andrew Chant <achant@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

CC s390

On Mon, 20 Oct 2025 at 18:04, Doug Anderson <dianders@chromium.org> wrote:
> On Mon, Oct 20, 2025 at 8:42=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org> wro=
te:
> > > Printing the command line to the kernel log buffer is one of the very
> > > rare cases where:
> > > * There's a legitimate reason to print a (potentially) very long
> > > string to the kernel buffer.
> >
> > arch/s390/Kconfig:
> >
> >     config COMMAND_LINE_SIZE
> >             int "Maximum size of kernel command line"
> >             default 4096
> >             range 896 1048576
> >
> > Yummy...
>
> Wow, what are they expecting to stuff in there? An encoded initramfs
> or something? I kinda feel like the 1MB number isn't something anyone
> expects but is a number picked to effectively be "unlimited".

Dunno, commit 622021cd6c560ce7 ("s390: make command line configurable")
lacks the "why" part.

> Do you have a suggestion of what my code should do if it sees such a
> long cmdline? At small numbers (4K, 8K, maybe even 32K) printing the
> wrapped cmdline is nice. Above that, maybe it should just print
> something like "<cmdline truncated>" or something?

I don't know, I never saw truncated kernel command lines myself.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
