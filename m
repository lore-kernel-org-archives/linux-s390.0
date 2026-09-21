Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0674CE691
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007906; cv=pass; b=tGwbJP5cwfHMDd1PSZMmmhTiTdCFttp01cKrFJGhZdE3U/YWAVQqfkhzF/aHgMr4CAKBm4IFGd79pb6rF1roe6ppHdZ5PeYRKspIq38EmWNxG5Rtv6kSisjoTy/1G8K+cKYm6dUBdlKBazI4QjbnsccyAvphdZJdR2l7awH3wIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007906; c=relaxed/simple;
	bh=tQzdD12zrT7V7gvs7VjAz44916mnPRGWzcIJa1GNvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHDJbti35KFa6G37RoP7CKl9meLxWImVYZSdlTqFP2kkTte/iaTOqjDs+7QLvZD5DrPseFFunUhB6dC1m0ioqWJuxxQBDtT7IK1ze4YI2As5iF4cSMAArz8fRBLn2tb9oXHfyULOcHevd18tv6QbhVG5117FY4pEmlQYK/qolCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzXQzUD9; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzXQzUD9"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e50968489so2929500d50.0
        for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 09:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007903; cv=none;
        d=google.com; s=arc-20260327;
        b=lYdp7GKgirRZzWJm3KOXEtOnbjOX41k+mMNJcbxa5uMiAHTP7X4lanA/swetVxOUJ9
         /INcTfRgEb/P55keAojoJjU7v4nzoSh3feMfwm8env5AAV2S10LlopP6vx3yETL/zM42
         VCwAsheW0h3JN9hSosruBiUCxpyJYXq7ep9yWTYSsOliXs/+vx0E7dlNO4+voiUH31fO
         RDsxU9BjETND2LKTopTNl5LDf2B5fqWo+yaPl98Sz58slJw91ZMMzLwEP1EErKJqrqFX
         7PuNVPSg57OIJAWpJYQSGhreknPiG83twI0RKmvPAhnz2TGv8+z/rEMLQqP9yl0Kc73g
         lsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        fh=MoxRB1g5EVQCTta2yROqI9xaUKpAIu0AAFvG1OIdV9Y=;
        b=kQR94qQZ7b6xkhQ0owPunRsaVzU3UwytylIGMu26JtDYpvPd+T5TJKbCzoTrzs+pLf
         rA2NDq7lyFrZbZam3MpYZ7iw5cWiKvaHZjXR8MWqenGzr2jWT9SNRS2Pq2TwWUM/N4Hf
         Reoz1ic+TNdD4VX9+Y6dANd8jGbrmNiWWFg1CxE/ZbQ3rROw0V4/dLvi70xBeY4T2zSZ
         IP9oLxlRCx6yX0uJLO3lsD00ZbA5aCSaq8VmoLpcrwBF4Lp0j2GC5anp37ANhWEhDmi8
         YupC8nzgKo4jG41XTnR19GBCUK9PUYIyvlnaYcBojthhqf5ZLDWD28XZVeOSHp3eOg8Z
         +qmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790007903; x=1790612703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=dzXQzUD9aQp+/l7NVQZpQWmwtie/4d36Ok64i7dmRhWmPyDvJsinw+jEZWspg54Eoe
         BQ4FHr0VznKmfLdR2p1CggwWijyS20mf15xLId08dKkZ+w6HHBd4Qa6zZmvB1shN35DU
         R/hVdgclw6I1loxNb0g1ZrgDfOs/3F5I2YrWHb/YucecdPS5Q9fReo016uHWJXBop0DQ
         pA8cBhxobYaoibgg3sUr2rQSWIuDVBZezSygK63JpmuYto+f9B/eTlsL+beRfzKRtHSl
         uB99Oo6S3bL2+CSEse+FN4TJJk7s/C0P6DPCyxQmLuIfxpg6g1Ud+mIihsHy+h1p3iF5
         rVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007903; x=1790612703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=Eesdi7n1hAxdEg6bHGKuOVyzWFY0yqudCqssgQDM7uUHPH7wco51VODSPUytfC/+vC
         sVDNhcSdcGfN5zkV25NJol2KyV1pGBOMDErh6kxgnTg6FznUfgBbbDxW6GupDg0EvK4Q
         rusvqStSE/xKHXlO75tZGHcjQKR2gLKY0ArgntRMCcEXokJlomDKOPRWI/ShUI0SBGrE
         yzgqoZ/xlErfkB674EP4KNtmnIJMd/cRaeUK7K2ufGMCOHR7kZELcwvwkka4MzyysOys
         ri6vLlgXOscj2bJgW7iGzPrIVagArLLtE6+rTlcNyDLRVQtDdpI7qRzE3cU/pyRSU9PA
         sJ6w==
X-Forwarded-Encrypted: i=1; AKwUvBw8fuC/iNoWZ7A8BKxRoK8YkzAs47Sdm4omb3BPuY7DHZPQLNtGIBVm1v0BQ1HCL8NJDol0HfIP92f0@vger.kernel.org
X-Gm-Message-State: AFuF++mV4SeeJx2EmLhG90OATRqWWPMC6dfDErUtXl3tZ7w5NSNGztuZ
	/MsAPzOV4jABFNMd2o9zstwK2HyN479OSZK+GkJOkQAnyY9LAu75kRIqZOCYPvdjgj2Wtm38JP2
	SICsUCO80Tv9u5n+WzddBdb1K88dD39s=
X-Gm-Gg: AYBFou1lz4IlmxAGj40qmFpBilaigRwsR/e/YdxClA6tzYe7HAWiHZq+HbJMK85YMoa
	KpSsVjfVLIGYaWADoBjPzF/A/T0P571uWpyI/U7/1rLw670dYRUcCDa9QKxiOvsAD7JPTeqw+nC
	hQqGgE05ZQv9bdSacctfnysc4PzjzCpsWWAvCJOPS5PU3DN1XqZDF/sxzIg6mEXvRPEL678Mdf0
	TjCyDj1Zsk6aSxhyA9gm+vqZzQJkbEkCSc7yULD92NzE/5+b2O63jJ19PP7f8D3OPfj9Dnvf4Kw
	UqnNvelBUmcYdoYaR+ik9LCO8sbWQ/kmc6Pu+FTWaSqrenLmjmrIVYLCkIDIut/p74MO//589lp
	1txJ4MnQNQ2gJeyc/JoeafQNBqIGDBTWuW39wQwoomcFWDZ9reVhaTIfzo3jv74r98JAimGzr3J
	Zub3Pa4SCChHHBhxVhxmdRScg=
X-Received: by 2002:a05:690e:c4e:b0:672:be40:5eaf with SMTP id
 956f58d0204a3-672be40629dmr713487d50.54.1790007902724; Mon, 21 Sep 2026
 09:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904195132.141068-1-sidchintamaneni@gmail.com> <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
In-Reply-To: <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 21 Sep 2026 09:24:51 -0700
X-Gm-Features: AcwNN1VSvI94aKmDMDlc9C_7_9UyySkBSsqPddt2OeIwAs5C5fHNExBLC9Hitxg
Message-ID: <CAE5sdEgLFFcsQ8rpraQ4L-EvppqxUn+=ZdHFgker2Wd--EGL6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<SNIP>

> I think we can keep this fix local to x86. Would be less churn in the end=
.
>
> The problem is that x86 switches the BPF frame pointer from RBP to R9 for
> private stacks, but the trampoline still uses RBP. arm64 and powerpc64 ke=
ep
> using X25 and R31 respectively for both stack modes, so their trampolines
> already use the right frame pointer.
>
> Instead of changing the generic fixup, can we resolve the pointer in the =
x86 JIT
> when emitting the call to arch_bpf_timed_may_goto()? We already know whet=
her
> priv_frame_ptr is set there. R10 contains the offset passed through BPF_R=
EG_AX,
> so we can emit:
>
> /* Private stack */
> leaq (%r9, %r10), %r10
>
> /* Normal stack */
> leaq (%rbp, %r10), %r10
>
> Then remove the LEA from the x86 trampoline, as patch 2 already does.
>

make sense! I thought that the remaining arch's have a similar private
stacks approach to x86. I'll give it a try and re-spin the patch.

> This gives bpf_check_timed_may_goto() the same address used by the genera=
ted
> loads and stores: the BPF frame pointer plus the counter=E2=80=99s stack =
offset. For
> normal stacks, we just move the existing calculation into the JIT. For pr=
ivate
> stacks, we use R9 instead of RBP, which fixes the mismatch.
>
> The existing save/restore of R9 around the call should stay. We also leav=
e RBP
> alone, since it is still needed for the native frame chain and unwinding.
>
> I haven=E2=80=99t tested this approach, so it still needs checking with b=
oth normal and
> private stacks.
>
> pw-bot: cr
>
> > Siddharth Chintamaneni (7):
> >   bpf: Fix timed may_goto stack pointer for private stacks
> >   bpf, x86: Use resolved pointer for timed may_goto
> >   bpf, arm64: Use resolved pointer for timed may_goto
> >   bpf, powerpc64: Use resolved pointer for timed may_goto
> >   bpf, riscv: Use resolved pointer for timed may_goto
> >   bpf, s390: Use resolved pointer for timed may_goto
> >   selftests/bpf: Test timed may_goto with private stacks
> >
> >  arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
> >  arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
> >  arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
> >  arch/s390/net/bpf_jit_comp.c                  |  6 ++--
> >  arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
> >  arch/x86/net/bpf_timed_may_goto.S             |  6 ----
> >  kernel/bpf/fixups.c                           | 19 ++++++------
> >  .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
> >  .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
> >  .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
> >  10 files changed, 75 insertions(+), 63 deletions(-)
> >
> >
> > base-commit: d761934c9483ecde93fe99d8705282f716dfee50
>
