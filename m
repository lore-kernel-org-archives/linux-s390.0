Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86131A7E2
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108368; cv=pass; b=kBoCX4RT7aI4q52RZ9m9IdV4rB3wnHlWpCp6hBOCM1VGHMCTlroFTD2P9DypY1XL6iLTxwwMK3YqujHvCa4s75gdODs4kQBaKcn+6KbXusS1++LU/C0jKVU6R63OcMxO4qXGSC4KOHqY9zSxac0ugKMn5n9spAQ6Qy6dQVPT1pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108368; c=relaxed/simple;
	bh=tEcBow2gdBp+/voVp/g9x+g9NV2I+Be2aTB/lbhkaHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUYe6uO4kRO0XYNT90Bw0oE4Ckepj3AvTpMpo2vVVdXNFvXZx3gtegl2rtJIZvE8oNcAezRijd5NypYjPeoUpgPy63ZmoGpXMVvJoxYuKOevv2nbkBrb0Uy22dtMEGWLKGww8r3Z/YJn2rYokuo0g3sv4OALGCJwP4Ds7AhI+tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hL2pYXdr; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hL2pYXdr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so111745ad.0
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 09:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781108366; cv=none;
        d=google.com; s=arc-20240605;
        b=ACLrzRhEg9+ZpTqu/3odHkdr2IoW4WwHj3ceqea/Rint0Iz601GBJ/VEUHHIkb3Ylx
         +s3vUPr5tdQsnwTRCdrOnaFzrAwKC5hi0AsQo3QnpRa6IRNlYa+moiFyjlGQ1dyexV6f
         1WZrxxsijxs04W4g1PpSmcltFxEUamL54JjGdpFG2h2xjLZ58iTrlAtXSXVSe5hed7AK
         hPu2UNQthv/ZU72Z2iQYB+TfWDaO5R4JH7aHAIHLWuZeMldJPire6ZbRvZjTVTAbCjEz
         6aOm9PaCpauJCk+vvB0GnCWjBCRPm33lKNvUbPwYV2KskX+e0G9UhWgaTxhTRCcs3fEY
         0+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        fh=YesW50SZoSeKHSw9I/HzIclXxXFfJN5+Lxk4C1yiI3c=;
        b=WOmsyfsZuTI3MhOFZMYrp7i7cxGXdtd2SQY1VMxqaR/dp9NZsTeUQpW77xI/xdDhxg
         lHJVqtB4hbGOuXBR19fQ0qCtqTCOaOvRCdjYwyTRQX8trzZhtGGAZcgj0qSU1k7YX6Lj
         j+VIA98I/I1BEPRaf/ivpMIaA0WRUaBiXxiEy19G2mCCBBDACZl9q7s4OBNFOzDVg0gy
         TuKhVavfUi77fIBNqfJ0DPe4BEmTyAcpZIiiL3sAsoSxbwSo859/IZreayHhJDgB3vfY
         XHmiZMyu6tXC3paim9rReF09L78Idgt2dBKa/hEWYPL+OnLxpzcscJoqMz3e66onR4Se
         laLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108366; x=1781713166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        b=hL2pYXdr4CwfLvTKLanwttjQywdcSG7O/Bm/S0nWjezyo/Ts6qjPR8SpufhVM/BHtf
         426VJB2T2c74DaE43o3Be4qS/SKUuVNrCA3ybUzH8DQ0Bl6WIPudOtfmJy/s7917O0VP
         gY7IL5e1UqKI+m/57hlg8LED4EugLzNFbgpRTv6bqX7YAlr3yIb68xGjs7Rda7AIeDYE
         pqq1pxkkgE7zyaH3A/YmZunylYJfgQIqMyNkonklrmtA7szN37jzdTN9sG5/hWHw5wNK
         ZbGaEx8MasU5cfl/VunIbccgAaZwk/YfOW6UDUeljotoLOmKsuIghsQxfqzmKxqxropL
         +/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108366; x=1781713166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        b=eB6N6DcBt0HEvz/2Je0SEIXYRJ6Bnw8E2nt6yx38EOCGwcDRf5jPRzNBEPiUrE7PJQ
         qbsHxFAn74iP2HUDdNcLk3zhrldANcl4UqzavNiZF6+VS7MJbF32Whiw7cx0VP1OU9xQ
         9cCSQcWfb4EEDTVtrf/PWhD9aMBSQK21xVP8eycytIxF3zaAGRhWnU0heVG+Ngm7rgZo
         segWxLp3rQ5WTuBBNGFgmS1pWuyeENrprmvmV+JbMZi5Tj/N9nIlu5gHFlV6m4klu/pb
         sCWCuCcruUZRwEPqu8V+iwxvIb3AljTMxQuGWzNrBznVtJELA3SqC8tLR1vtYgnIeAtp
         tqmg==
X-Forwarded-Encrypted: i=1; AFNElJ9pp1jqucCQNplmOfdqtUx6yLQ5DrSSYbiB4myLZtRIBioM91Vaya2yYRqXPvG1JBpSby9B02XjO0PR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62pr8+ppT2P77TdAK4EKQw1Fhb58PPeQsrlsgqf49POpwwOGu
	xqChtBz4UMMbEL6p+ddRb7gpuUfBOSy8MDqtLXEqRsdcxg8oo1/3GEyRGcKT/1yDeCFaa/lSqne
	0PlEybJpq73gNoRChj053u8FKWjF17XURLtMjk41C
X-Gm-Gg: Acq92OFG1nZ2Bd3NPUoDrEbOwhYkYRsS5wWkLGug/obZN/vwQfOlV7l0870TDq32hqK
	fcJRBCZEl7BqNfohVtlR7IF9yud2kX7mKbIYHxmmPAbTwo/2jH3WJNtlnlyv2YSeW+Cv25PDZfb
	F4chzRW98tvJMtlmmv0UK69G9WF47ILeZ4DxLmvZ6mI7yIv2Fvi5lDJ1MVR9Yl4C3OzcaaBHMkN
	Xl75EVAdNFuBEvde28ohO4PUJrbCBwn7i39eqqVp/6Mo6Vezf6ebk0LxWJ8a8YFABPB0Dg5o7La
	NIkuhtqtEePshxDtclI9axZly4uJG5PeGHeOe3mRNEcY+2gUAh5pZdPZ24M=
X-Received: by 2002:a17:903:3c25:b0:2c1:ee6e:4e4a with SMTP id
 d9443c01a7336-2c2d942700amr238395ad.27.1781108365793; Wed, 10 Jun 2026
 09:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610112451.1553054-1-jremus@linux.ibm.com> <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
In-Reply-To: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 09:19:14 -0700
X-Gm-Features: AVVi8CeML9xOHpqDi-kOipKhEhSw8qM5oNh-G4lar_licy0sI8HoLNL-mbAU5DU
Message-ID: <CAP-5=fUowmCCdfAOoPimduZ53GTfRPp1qPLMUfXU6R80=x88Eg@mail.gmail.com>
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
To: James Clark <james.clark@linaro.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 10/06/2026 12:24 pm, Jens Remus wrote:
> > On s390 the Python extension build fails as follows when using a linker
> > that is configured to treat text relocations (TEXTREL) in shared
> > libraries as error by default:
> >
> >    GEN     python/perf.cpython-314-s390x-linux-gnu.so
> > /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> >
> > This occurrs because util/llvm-c-helpers.o is erroneously built from
> > util/llvm-c-helpers.cpp without compiler option -fPIC but linked into
> > the shared library (via libperf-util.a(perf-util-in.o)).
> >
> > On s390, object files must be compiled as position-indepedent code (PIC=
)
> > in order to be linked into shared libraries.  Commit a9a3f1d18a6c ("per=
f
> > s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
> > for s390, which is used in C compiles.  Add -fPIC to CXXFLAGS for s390
> > as well, so that it is also used in C++ compiles.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Great! Perhaps we should add a fixes tag for backports. Perhaps:

Fixes: a9a3f1d18a6c ("perf s390: Always build with -fPIC")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >
> > Notes (jremus):
> >      This patch applies on top of the perf-tools-next tree:
> >
> >        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt.git  master
> >
> >      Note that this resolves the issue discussed in thread "[PATCH 1/1]=
 perf
> >      build: Fix Python extension build with GCC 16 hardening":
> >      https://lore.kernel.org/all/ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2=
-a85c-945b6f05615c.ibm.com/T/
> >
> >   tools/perf/Makefile.config | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 333ddd0e4bd8..33f90968c8a9 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -109,6 +109,7 @@ endif
> >
> >   ifeq ($(ARCH),s390)
> >     CFLAGS +=3D -fPIC
> > +  CXXFLAGS +=3D -fPIC
> >   endif
> >
> >   ifeq ($(ARCH),mips)
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
