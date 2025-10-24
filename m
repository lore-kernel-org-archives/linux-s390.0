Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CB32A3C6
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321815; cv=none; b=BqTAJrBROSk3MLm9zvK9vgj7+vg7cGp9fBLDDJU61lsFGfY4PrOppSdrXDOUJTwEBaAoLNxElZRllu91hJKVyyCgz+buap4kvga+UxRlstxsjSttiVsSmEIdY8VDwq7XrzXggrinHgTSQmUtSHIFu8ZV/Cneblw1vlBUccC80qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321815; c=relaxed/simple;
	bh=MZveBwN8pITgiKu2IvyyZYnSYExm65gAyhHVYf2v+Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8fMX02+vrXHwe6oQbxtmdiqL1b4BqQzhHmTZMh3e0+kxUevGqj6UXcBPxLk9vrESjzQUVkogCZj5JGcTzTnq7ozoYEZihA7PFcWldnrivINHhryYUO6NYh8UUsJFmiTw7BrWZO/Qbv7SK3ncKOuL3wJJmIdkYueS9XUV3n28Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kKeNt5ER; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKeNt5ER"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782e93932ffso1869175b3a.3
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761321813; x=1761926613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opD0p0FG32wb49KtDa/XK4x3J2J0EHXdG+v2/vEH5Fw=;
        b=kKeNt5ERajzXfIfOltk2zn/dJPVj+4jq+HoUMlCDR+Kgkeyq0A2g4PJqaTxX+QLKrx
         /wS2uBjLFBSvQO6otrBn0hAjxUri5x4L64viB4x2pFRxfOFiLiDn3hBCWNjMqWi5udg2
         s/dwbEYBVLQN5GAaYkbtnVUrq7nALZrDPc9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321813; x=1761926613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opD0p0FG32wb49KtDa/XK4x3J2J0EHXdG+v2/vEH5Fw=;
        b=nxshFzXOoPefYbOIaG0m5xMPYd+I2nr8VzPPek8RQKbHDOe9qbRnrBr9/thY8FXbts
         j33R+kTjqaZqFppJJhDzhZ7xTRK+QRfRqmx+wiCYRHPuaLEL2n3b2gIR4cWLGWUHFtZU
         m3k6+/AEt6l7DEAg6IesGq2fD5uNvbCAKMX/QXYJuVxyW6MhAcM8C2ees1CPAp88t+7Z
         n3m5PaFIyxa2DHfDJTvawgpwmMiz3HtrNDmVG8F1NQe7TxZtmKe8luf/iYa1xrTfbkXn
         6LKREkPKIbj6U6Q7SN+3VB7mvKmN6DRY7eF2WCpuBsDhnFGtBzpZG/mH2U82RvPcWAjY
         2c4w==
X-Forwarded-Encrypted: i=1; AJvYcCXXUh2LW8iEOc7EdVeez7SQaFVhXixyZyl0Nl3BEPqASWCLjMGk4/UCrjjkD93LNay2jQ5lXOhD7fNc@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnXUbPmCFVdevfWpomD8tciCwOOKyF4R8aSFauO07koLnq0Ht
	hIGuPThzmJ1/A6+VBJLfL7hGFzLgrjTH0CP22BQaNER6fFDIA8zqHtn/RglX5LEL8xCzp6D6m/z
	Yo/I=
X-Gm-Gg: ASbGncvLIS78BbYcN1Lq9RyKG1qugLU6sMgkgXJbT2iK14I8CrlXI5lj/hgSSbQdQ0M
	s9aO4O6uU2gMxaDLJG+CyQqG6SYOksBxhqXHJlJ+CwSTmRqF1bhZn1hBF/X20jPOgMyTv6t5S+u
	3EzMyqbjc28QlI1+LmnKUQcZ63N4v+hDrsHT+2h0YcQ/XLa0hHnYuTWOJggJcBntwTkjW/jjk66
	CGLYYuYVZgPMen8j6CnnXoQYpoK7gHvVh5+DDzpo1odD6kL2Y7BT72xyrUSU56/0Cdkhofil/B7
	L0DWJ6JGm3pAFHBY9Vq+8mAXCMT8sqZhtGNrN0ITTLzLnYnwIZcF08asqDFwG7dFcT5VAkf315J
	tormcfiU1xKCn8afVA7ljZ1aE9p5+aN23H9AnJi2xIL2JJtBaedRjowBeP802DMPJnqnsWpZjFD
	qyaM78G5uKMVxtVY2A/mz+73D1caJZn9H/bpm3OG2DJ3M=
X-Google-Smtp-Source: AGHT+IEjLr37lILW2MZakAsVIPx4n+z/zZTRjCWlGOFAjwvpKmz1uuuztSB14GQ+itY+dhO4vK9AOQ==
X-Received: by 2002:a05:6a00:1916:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7a220a083f7mr33758894b3a.5.1761321812612;
        Fri, 24 Oct 2025 09:03:32 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc49a2sm6339320b3a.73.2025.10.24.09.03.30
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:03:30 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290aaff555eso22386815ad.2
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 09:03:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZmjQZHw+1II/YdEt3Itpyj9/b9zA7u8Dl8wNRbkZ6f2oEzofCSKMGsEnftrtbVnJ7Z1ziDBAltLIf@vger.kernel.org
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id
 d9443c01a7336-290c9d31109mr364082495ad.16.1761321809382; Fri, 24 Oct 2025
 09:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
In-Reply-To: <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Oct 2025 09:03:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uo4YAh8zGeU+tsxHEapsPyjAr9AyBEaAgiL3mUnN41=w@mail.gmail.com>
X-Gm-Features: AS18NWBMCp5d_6B9UUkRIRbhw0cZobNwXLRN_85Hn_tEol9iOKdQ3SjYiCqWIMo
Message-ID: <CAD=FV=Uo4YAh8zGeU+tsxHEapsPyjAr9AyBEaAgiL3mUnN41=w@mail.gmail.com>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing to logs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Chant <achant@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 24, 2025 at 12:51=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> > +config CMDLINE_LOG_WRAP_IDEAL_LEN
> > +       int "Length to try to wrap the cmdline when logged at boot"
> > +       default 1021
> > +       range -1 1021
>
> Apparently COMMAND_LINE_SIZE is still smaller than 1021 on several
> architectures (even in asm-generic: 512).  Unfortunately only s390
> still controls it through a config option, so you cannot have a
> "depends on COMMAND_LINE_SIZE > 1021" here...
>
> > +       help
> > +         At boot time, the kernel command line is logged to the consol=
e.
> > +         The log message will start with the prefix "Kernel command li=
ne: ".
> > +         The log message will attempt to be wrapped (split into multip=
le log
> > +         messages) at spaces based on CMDLINE_LOG_WRAP_IDEAL_LEN chara=
cters.
> > +         If wrapping happens, each log message will start with the pre=
fix and
> > +         all but the last message will end with " \". Messages may exc=
eed the
> > +         ideal length if a place to wrap isn't found before the specif=
ied
> > +         number of characters.
> > +
> > +         A value of -1 disables wrapping, though be warned that the ma=
ximum
>
> Or zero, right?
> So perhaps just use range 0 1021.

Sure, we can use 0 as the sentinel value. I was thinking -1 would be a
more obvious "wrapping is totally disabled" value but I don't feel
strongly about it. I'll change to 0 in the next patch.


> > +         length of a log message (1021 characters) may cause the cmdli=
ne to
> > +         be truncated.
> > +
> >  config INITRAMFS_PRESERVE_MTIME
> >         bool "Preserve cpio archive mtimes in initramfs"
> >         depends on BLK_DEV_INITRD
>
> > --- a/init/main.c
> > +++ b/init/main.c
>
> > +static void print_kernel_cmdline(const char *cmdline)
> > +{
> > +       size_t len;
> > +
> > +       /* Config option of -1 disables wrapping */
> > +       if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN < 0) {
>
> As does zero, right?

As the code is written right now, 0 does not disable wrapping. The
code treats everything less than 23 characters (the length of "Kernel
command line: " plus " \") to mean "wrap everything at the first
space". Yes, it's a little weird to do it this way, but it was either
that or add yet-another KConfig setting to disable wrapping and then
set the minimum to something higher. In v1/v2 I had the minimum set to
40 specifically to avoid the confusing case. There was previous
discussion about this in v2 [1].

...but yes, we can choose to make 0 be the special sentinel to disable
wrapping. I'll assume that's what you want and I'll change it in the
next version.


> You can add a check for "COMMAND_LINE_SIZE <=3D 1021" here,  so the
> compiler will eliminate the splitting code when it is not needed.

As the Kconfig is described and as the code is written, someone could
still choose wrapping even if COMMAND_LINE_SIZE <=3D 1021. Someone
could, for instance, choose to wrap these lines at 100 or 200
characters to make the log message look cleaner in their terminal/text
editor. ...but you're right that I can write this to be more optimal
for folks with shorter command lines who haven't touched the config.
I'll change the "if" test to this:

if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN =3D=3D 0 ||
    IDEAL_CMDLINE_LEN >=3D COMMAND_LINE_SIZE - 1) {
  pr_noitce(...);
  return;
}

That changes the sentinel to 0 (as I think you requested) and should
allow the compiler to optimize things out.

Making sure I got my math correct... Let me know if you see something wrong=
.

KERNEL_CMDLINE_PREFIX_LEN is 21

Assuming the CONFIG value isn't tiny, IDEAL_CMDLINE_LEN is the CONFIG
value minus 21.

So let's assume COMMAND_LINE_SIZE is 256. That means we can have at
most a cmdline length 255 to handle the '\0' termination.

So if the CONFIG value is (255 + 21) =3D 276 or more then we should hit
the "if" test and early-out because we can't wrap. If the CONFIG value
is 275 or less then we should proceed to wrapping.

We want ((276 - 21) >=3D (256 - 1)) to be true. It is.

We want ((275 - 21) >=3D (256 - 1)) to be false. It is.


I'll wait a few days and send a v4. I'll fold in Andrew's "__init"
patch as well.


[1] http://lore.kernel.org/r/CAD=3DFV=3DWFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=3DXT=
boFXK+RSspA@mail.gmail.com


-Doug
