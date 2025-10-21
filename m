Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A23451D7
	for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062876; cv=none; b=IOY3vQdyBrWjSBSOgxnqpWoz+mAVCUjjlPxnZ0cl1lWRPbfPdShvEyZVLgNr42g4hjwpLDTbdHR2nOSOwnPfr9D2AIfRG2tAdOmuHgrhg1l6VsbTr6AAhoRMpn2gGZF4AtQhFCVq1m2ZCheIhG7U5XUhBdVFp0iWn/Gfl6gvgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062876; c=relaxed/simple;
	bh=bKpdUjAbZudmEXfwWsQOnsj8GT9aOq+yPry9bLfFxUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsH6Wr1da3zhMf9aInE9MzGF0cSzIn8fjCzOeqeioHycHil90Vm8ZWqR6dR0i+hSmluSpcA3wfn1E5MepMXDklV8xyId2bfxzivo8d9gKIxsCyuBSsebQr/pnQK5hXHQ2/KSRxp1CHO2wWGq/1JFZ6akXADst6Bde2ke5CWbDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LEPW3U1q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEPW3U1q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so76440845ad.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761062873; x=1761667673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90eEaPtbwxy3p3pxWrxnRzTG0xmlwztyiMfCrjZT8xs=;
        b=LEPW3U1qQKWg4uZp+vJM/z1LdnS7L+ju81BmYdPuPWUrmvlXn4+VXueeY2wcJ82WCU
         Zt5fb+7YJBoDfW3NoV4f/DL5CT3vWpkcl1jT+sF4UI42StSg9O58/pZm4UJfoAuBncX7
         dWqgCMbr4jqhBSUTC/dIhi7QUpYtemg1+7tsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062873; x=1761667673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90eEaPtbwxy3p3pxWrxnRzTG0xmlwztyiMfCrjZT8xs=;
        b=hy+SyznUcecExPqFzIrSHIqs4ac9OJq/p+PmJdEQ7uas8s8+MX9d9y5plvuvGqtx1a
         mh8gNUaJGXpUplHgBxA+64Psg/Y+ucbBe9rfEd4T6L0GZjgHF7jnFlw8BswFEawJjyhI
         I1otcF1Y0euAmlN15mmqCuCcKIWWKwbkLO4e3wdpf+oJm1s9kmAODeEI+MDbuCJtk560
         rAGSyf+13xG3ggIF/rvZY8hD3Xxy2drLJPH7K+7lw82jjGewvjBbava4Bfy55JAtl8G9
         /3f35/Hp1SR5lIly0orDcr5+CpjpwUj4MtjQ00QgSevawwCPP7DVlh7zlUfmpstwN8P1
         mDiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsoi+4qkZcHWxp7irltWK5bNAj6PaVPiJSQBMTUYuL4zkIpIjr6YYtkuPHLcCX5VUoKL3BVctCZ+jZ@vger.kernel.org
X-Gm-Message-State: AOJu0YynMzAwNyJv6j6d8zp6wYubIWAVmyRGtJ/qT0HB1qdqS4prWFWQ
	rNJke7pzfMa8JuAU6yYY7fYlU4tdB83OUgKxEzz0e1RyPtfOvUliM3t2t0l9mf/0OmfjQJfU32S
	ThDk=
X-Gm-Gg: ASbGncuf5o/+mWtq3T3kGKIzyLuYV5EoxgG8oGmpuhj6CAbIihMDbEqUE6zywXOVafx
	PqU66fJjAJqLcV00GdkVvjss0Sd7jYJuK0gUljkOsZ4kUpLp8CxTa/XIjnnuZjXZ6JxAwW5e4LP
	VY93A5mzgn7Wuw9xmykJL1DmyRA1iUvzG6KQgPorSTiWBCLrJF5ZF0C53kRxAAhW0PTDmC3BoSJ
	eaB1ENChHDPVFM1BGJ0Vn+NTko4y58dIyRaFhtQuOHf7Z7HZKYEFRb/hNQYjrQnJU93dK1rqiaK
	A7+6CCBBtqI7N/rUuQ5s/P5BOnE0nw7okWMlIR7ofOmhd3kXSN52RL49Sa7biueuPOicXucEhPZ
	JHh2ZoGVmghXHiFyH/0FyVvslhmxmSbxlVZbixepq6hb8lHgECi/go1/HcnVOXTrcnkpByu0BxN
	78OwnVf8bOr6/a0VrrfcA1HYQ2w8jae2PeX/qV7J/9A+M=
X-Google-Smtp-Source: AGHT+IF+NpVrjVW1tzsrzrEIOSBz0mFMNvYBp6QdM3cGBKqFCO2lvh+sH/EReu2nn0NTKc5Wp6mLlQ==
X-Received: by 2002:a17:903:1a4c:b0:27e:f201:ec90 with SMTP id d9443c01a7336-290c9ce63b3mr210587995ad.25.1761062873447;
        Tue, 21 Oct 2025 09:07:53 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d585bsm112465485ad.64.2025.10.21.09.07.52
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:07:53 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27eec33b737so86912985ad.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 09:07:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmm5KPuXOtKdHNIb1jAdT8eQFdDZtdR2TXZ7KAeB4p8Tq4CWSh8ro19v5583nXbP2k8FMBfLdzfIVx@vger.kernel.org
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id
 d9443c01a7336-290cb46bf6emr190882455ad.51.1761062871921; Tue, 21 Oct 2025
 09:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
 <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
 <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com> <20251021131633.26700Dd6-hca@linux.ibm.com>
In-Reply-To: <20251021131633.26700Dd6-hca@linux.ibm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Oct 2025 09:07:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XD19==ed=OPWSvrz-KNQSphHUPwCOqX2-Zi-1o8XE49g@mail.gmail.com>
X-Gm-Features: AS18NWByrjhJ32HQ8xty6HQCqWcjFJthoH_GcJNHfXtjtrqxtZ3YbUmJqh8GKAY
Message-ID: <CAD=FV=XD19==ed=OPWSvrz-KNQSphHUPwCOqX2-Zi-1o8XE49g@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
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

Hi,

On Tue, Oct 21, 2025 at 6:16=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Tue, Oct 21, 2025 at 09:05:48AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 20 Oct 2025 at 18:04, Doug Anderson <dianders@chromium.org> wro=
te:
> > > On Mon, Oct 20, 2025 at 8:42=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org>=
 wrote:
> > > > > Printing the command line to the kernel log buffer is one of the =
very
> > > > > rare cases where:
> > > > > * There's a legitimate reason to print a (potentially) very long
> > > > > string to the kernel buffer.
> > > >
> > > > arch/s390/Kconfig:
> > > >
> > > >     config COMMAND_LINE_SIZE
> > > >             int "Maximum size of kernel command line"
> > > >             default 4096
> > > >             range 896 1048576
> > > >
> > > > Yummy...
> > >
> > > Wow, what are they expecting to stuff in there? An encoded initramfs
> > > or something? I kinda feel like the 1MB number isn't something anyone
> > > expects but is a number picked to effectively be "unlimited".
> >
> > Dunno, commit 622021cd6c560ce7 ("s390: make command line configurable")
> > lacks the "why" part.
>
> That was just a follow-on patch of commit 5ecb2da660ab ("s390: support co=
mmand
> lines longer than 896 bytes") which solved the real problem with a too sh=
ort
> maximum command line size back then. In order to never have to deal with =
this
> sort of problem again it was made configurable.
>
> But I doubt that anybody will change the default ever.

OK, so my theory that 1MB cmdline is not normal / realistic / expected
sounds correct. Essentially it's just saying "we didn't want to pick a
limit". We could add a bound to what's printed if we want (4K? 16K?),
but it's maybe not critical since we wouldn't expect crazy long
cmdlines anyway.

So I guess the question is whether any of my arguments convinced
Andrew that my current wrapping logic is OK. If not, hopefully he can
clarify if either of my theories of what he meant by "chunking" were
correct and then I can send a v2. ;-)

Of course, given that the max cmdline for most architectures is
something like 2K/4K, it also might not be too horrible to just
increase the printk limit? I was assuming that would be too
controversial...

-Doug



-Doug
