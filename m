Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66162E1730
	for <linux-s390@vger.kernel.org>; Tue, 16 Dec 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873859; cv=none; b=qPWcNoDXIehwDyYHiZm8cz9kt+jhExOKaSmJgxLbZp8+nwrvFUJJDVxnum8KL5TL1S3e6oFHuei5P5dxoFTt61UbOrAcElKZtP81UXPmpUkWf6hIHxhYf3KgvICX8nfEfvApWNk31iZb5csP6Eohe1KmUeqnJhq75bxu0K0gbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873859; c=relaxed/simple;
	bh=rdAB3rTsM2kPBbfJpGSxoybGGY6bsi0WVH/CDiWPH48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad4tDTytkp/B04djTKgaRA3oV6pNQKzKjaiHzqR/IcJ33kbJk0x7Iq7OAdEv+S4g6AZmSc3Z8nJOjFBk4Kokf6hEvBh5w5qqu5NRJ3gNI3d1rxGaiFRKMiY212ggvX0iMsyrKcMVUgga+FqzBqaBQKC1OO5EltkNg6Fbm5R7ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R46judFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R46judFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63466C2BCB5
	for <linux-s390@vger.kernel.org>; Tue, 16 Dec 2025 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765873858;
	bh=rdAB3rTsM2kPBbfJpGSxoybGGY6bsi0WVH/CDiWPH48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R46judFncVma2UFkYNjNbr5TdEW5KwY37YfDgTTMBud2rQmcJUAnmBnMrDf1is8DC
	 YT+TBjs7FKekCEF8JOh9ldb5XizTh/Tj/w9kwNdx5zUs1WdQZ+BExOLO79AssVyF51
	 ZPBMNIh0rsAt9wmBuHIn/81Yuk4D+z//KNCdxmOw7rd/oEoENSJCBpvEKa68Nh7FJJ
	 1ZZYbmAt/IClCuefumIVBl6tRsiIZBXzWi1PyJJwNttKROJkSk3+9BLLgDLBbJVa7O
	 hMPoh+ejhyJzBuvUcsz2E2Tt89BPr8TmCttIy5UOPOFiSPkyKk3DQX5T61SCdhvi6F
	 s2EPkv/G0k1Fg==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c718c5481so1976284a91.3
        for <linux-s390@vger.kernel.org>; Tue, 16 Dec 2025 00:30:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF0o51mLmLYjJVGmEeUcN4KH9bhohwd0e8WRRH6Uafz5dTqoUGJVAsEvkMrNeYg/CSxYLrphj52+Qc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8t8X4+LJdAZnmoaVQEyeZsPn3PytyN2wANkMU20Ka/Yl54t/
	7LO5nyjE3WvXBf913POInulw3+x/+Gwbaqvb/uWWuoeAsPZrt01Vw/Ss6hzQmnxdoVrfaWQj/Sw
	a1SWhL0WQkuMHAluTsrFI3kEznb5OoIE=
X-Google-Smtp-Source: AGHT+IEZiIoxZ4ahkNk0/4l0GnF/w4QftZY+MiBqqc58ZUWKxJID5qTsh8sHraWFLh9as/x1Z9qBIWeJzeWk9xWW63w=
X-Received: by 2002:a17:90b:35c8:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-34abd6cc48fmr9458424a91.5.1765873857654; Tue, 16 Dec 2025
 00:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163520.1144179-1-ryan.roberts@arm.com>
 <20251215163520.1144179-4-ryan.roberts@arm.com> <202512160024.B688A8D0@keescook>
In-Reply-To: <202512160024.B688A8D0@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Dec 2025 09:30:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHaqfEqDpvC-iC1fUn+JpTj=oqfM2sh+sbaC8_PBVHBUQ@mail.gmail.com>
X-Gm-Features: AQt7F2qEPqn2Fyl42wG6ot8Vul4tzgiSNEtR5kH_hcxqBXNDjzmNBXOTKIXUk1o
Message-ID: <CAMj1kXHaqfEqDpvC-iC1fUn+JpTj=oqfM2sh+sbaC8_PBVHBUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] randomize_kstack: Unify random source across arches
To: Kees Cook <kees@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 09:27, Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Dec 15, 2025 at 04:35:17PM +0000, Ryan Roberts wrote:
> > [...]
> > @@ -45,9 +46,22 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> >  #define KSTACK_OFFSET_MAX(x) ((x) & 0b1111111100)
> >  #endif
> >
> > +DECLARE_PER_CPU(struct rnd_state, kstack_rnd_state);
> > +
> > +static __always_inline u32 get_kstack_offset(void)
> > +{
> > +     struct rnd_state *state;
> > +     u32 rnd;
> > +
> > +     state = &get_cpu_var(kstack_rnd_state);
> > +     rnd = prandom_u32_state(state);
> > +     put_cpu_var(kstack_rnd_state);
> > +
> > +     return rnd;
> > +}
> > [...]
> > -static inline void random_kstack_task_init(struct task_struct *tsk)
> > +static int random_kstack_init(void)
> >  {
> > -     tsk->kstack_offset = 0;
> > +     prandom_seed_full_state(&kstack_rnd_state);
> > +     return 0;
> >  }
> > +
> > +late_initcall(random_kstack_init);
>
> Doesn't this need to be run for every CPU? (And how does hotplug work
> for such things?) And doesn't it need a get_cpu_var?
>


 prandom_seed_full_state() takes a 'struct rnd_state __percpu
*pcpu_state', and performs the initialization for all possible CPUs.
