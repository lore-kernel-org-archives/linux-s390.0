Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF7544D63
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181488; cv=pass; b=W88pkqBkjzbU5n9QQ7fupiPAc6AtL4GfHsKAu+pAZprFNSx5W/VUuFptbINajSIrL8Tac4BiTJumOBZZLhZ3sFmfDT72K8lYr7/YZFVmo5CBtcTIXKAB0mEL/NbflzOZ00zPCLLwGFoIqTgIx5nsddgBl5bzv/9QcRJ/ukJNrKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181488; c=relaxed/simple;
	bh=Ki68AWhOtCntsoI0OFIKHyKcKBjhFUq6rGGkI3eKt94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf2Ot8zOxI0ayI+K/TD5oF41Wjx2kZidkaWNFICZUmV6bS8DuBc+pFts/jEDiG8N8gko9mvdVQjU5hykDbhNj3HBshtTeHtVs8bFZNTEOc4i6uciyr6TkSUWWVWNCTHDXmEbFOsCjUQG1wMmifw25WkIBb+PXmghc49Pl1ZnMJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jThPTznR; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jThPTznR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-530e8c6fb80so281391cf.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790181477; cv=none;
        d=google.com; s=arc-20260327;
        b=dDzjEKOfipmnhYgYue9qU7f/I6SuBbfnEvcy46oRv8JNjJRzFbtbNHtwzfibALdLYc
         vx7gjbCwPmX+5WcGqxwwoUPdDoaReVcLR70H5Sdej0zjP649ogD4hfdqlD+QJ+WyT5Rh
         jQWJYID6I56KQRHLiSPmJaZ2kb8jdiyv3e4gXbbwUBSmiDoK7vvjTnBhNM5HIDai5spE
         2OTxQuHqTspYPOIdLHJk5MUqFewgJ4yyTP0fZKSUnQRBKEFWVKsViqVFKAtETBR6YJtA
         kKyVUskTmxbxft0zksE2pv9bGE3F2Ft4+MDmpdQmr4YYKHiOr35HQH6gkOd+sQbbfzpy
         MSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+invQ9QY+xGc1wJGh+eSpEPO8pFIqJwIrCsCZ77yWs=;
        fh=N2eCtHl8ubmjHOaW7BQ5Ionot9xc+5HmzEu3INC7T6k=;
        b=gj5KCb+TDjSSpsaTwCOGIYAq/qlYTUWJJS+uxpucUOIPrw0Ao6btylNH5+V7VSq0nr
         3vEL7BWlb4dPRDJm5mLXFurZQllDTgJHJ/ZYSk12UAPPIbDGIwQQU5nZMALWhlDlbaZ8
         lsv2DRLjWzZJHRWgTuQ5pWaUrLB9YUkD4FLje3hltiAnCCXJmbznoAKYOhrY8JyPtYnU
         VvfgSjtxGoALNHMIwerwD/vJbdSLvCbmpuzgQiF5XI4IrSlL5KurtureDXzaz3CX15QC
         FSl1KAcx3dzU2p5ANk95qSN2XDtmC70A86y0Phc5wA/WEQjsk1T0TDrDydo/dYt6fmMV
         sbIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790181477; x=1790786277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j+invQ9QY+xGc1wJGh+eSpEPO8pFIqJwIrCsCZ77yWs=;
        b=jThPTznR670ycgCbH7qizm1s+5zC15cNHS9nP2YzsFKa99rlkiwHOfs0twMbnFxSNo
         ECKfSxVrJaXI2Tof5xtvy9IySgvjd+BwRvKVzluHdUfORli8b1LmUn2UW1yFp5vMVTrK
         TFD2Coe4xl/zahes46jdA0Fd1QLA8ZjLMui2/amkhJOtTTDhkGvpzTl1Yrz/J4diREqI
         audXPwrPEwiejgxhY2R/ea3RLYWTs5lc8OvOhyDBzavz857Su+uBfPE9ldBMtMyVXKo7
         x7fzP/mHJZbvFz909gDVkJK2I2GWfDNVl/5jIhg8wY0NCvpRGLeiCagqn0nTA0Ut7Pqd
         sqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181477; x=1790786277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+invQ9QY+xGc1wJGh+eSpEPO8pFIqJwIrCsCZ77yWs=;
        b=2p0ckgx+U2RJHxUk2Ie6UR28TR4f6H7DMD0G/pTcO22iu+q1rdsIfr33St+OKl27hP
         q0VXQms3EwOTP3T7sr97ebluSsnQ85IiyEk9tmNgsW/89hz6UyVeVgYfDWgCp+lc98Xa
         jS8ozJZMmqT82dDw9SFA68NX4TyYCdoc8Kr5XXxfxDOOPCAQ/i0Yf/tkpEz7vxFMqgM2
         RTekkSGRVOm9fxSVozETdVF7UDN9MOl0VK3oIzWYcuUKmiVE8aMGxBrdT6G5wluiH0yr
         Ityvp7ssE0wJNYqmEMskGY1rB5ccMPtOPplMZuQzsIVIEuEGyCHYV+jTcLdeiHEgtSrq
         5prQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4/gLlDyJHN2/s2cLRn3E5yGefHguBaig+1oyLEk61GfkOT2WBoQPrXhdB/zPODC+q7vbVJ1qwhGkO@vger.kernel.org
X-Gm-Message-State: AFuF++kWqfGwc/YtybxTuWGXC/B5HIXMVNw4gBR5/uoE5XJikeDopCKP
	kioEGAdgsRIaVSM99WHM3pBxgCkYAbZz3+1xxtFQX8uvpN0barYT9qLoSlX4BVDDRz4qHNlHhdE
	IJ3NUf0OweEV/zTZKPSiM0H2ZcQsPL6qUlw8V0NFGZww60WhL669DWQuX
X-Gm-Gg: AYBFou00SdGfetc2o3nEbqUjI4v8SBCnV//bSkyGUZ7J87wEnRgDADjN5gLXDo15Xvh
	39fAcP5QKHHfADuzkGGYYQ10AHIh8mJxj/oXEklXPFKPm344RL0gnpmBYlb44tJ0X1ir7MwvKri
	SXYNKbYLCc9dbthwo7RpPt+DQDn7AlYimnb8DaWezRiXjoaBFjBzN/3+1oZ16k8soVsfGPwhMrq
	3jJUXboR22o7jkvpIAdqFBaha9Vxxm6D5QXsrNZY2GXWglzm2OBFUXfHelc+TlcnkNo68yF3jmu
	dfWoJXHE0p/Olhgq8oo5gC8qxmSyaclvAOq027FQp4ghZXWzzWadFheMoWnxTbvws8umNwuwlhy
	2AewRNHMCZQ==
X-Received: by 2002:a05:622a:580f:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-532f9c84160mr802371cf.5.1790181476065; Wed, 23 Sep 2026
 09:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144300.1217524-1-jremus@linux.ibm.com>
In-Reply-To: <20260922144300.1217524-1-jremus@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 09:37:43 -0700
X-Gm-Features: AclHuK-tTzR7flHC1FUf-5xqss-YgaqJiwuxrG28Gk18QOopJdckSUgFKtvajV0
Message-ID: <CAP-5=fUM6gb9MY9Sm=QhC+Tc4AFt2=fdLbr4tES++AMQcxryUQ@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Improve callchain warning for s390
To: Jens Remus <jremus@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:43=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> w=
rote:
>
> On s390 the kernel uses s390 back chain instead of frame pointers for
> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> USER_STACKTRACE support").  This is because frame pointers on s390
> cannot be used for stack tracing. [1]
>
> This requires user space to maintain a s390 back chain.  For instance
> user space to be built with compiler option '-mbackchain' (instead of
> '-fno-omit-frame-pointer' used on other architectures, which should
> better not be used on s390 [1]).  Only few distributions and users build
> user space with '-mbackchain'.  Therefore '--call-graph fp' may in
> practice not produce the expected results.
>
> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> changed the default '-g' option to 'dwarf' on s390 and added a warning
> for s390 that wrongly claimed that "Framepointer unwinding lacks kernel
> support".  This warning resulted from a misinterpretation of comments
> in s390 cpumsf_pmu_event_init().
>
> The restriction in cpumsf_pmu_event_init() applies to callchain sampling
> with the s390 CPU Measurement Sampling Facility (CPUMSF) hardware PMU.
> CPUMSF events, such as 'cycles', do not support callchain sampling.
> This is independent of whether perf uses the 'fp' or 'dwarf' call-graph
> mode.  The CPUMSF PMU provides samples collected asynchronously, making
> it impossible to associate a callchain to the historic IPs.  Therefore
> callchains can only be used with software events on s390.
>
> Remove the incorrect warning.  The kernel supports the 'fp' call-graph
> mode on s390 by walking the back chain.  Do not replace it with a
> hint to use 'dwarf' when the resulting callchain is incomplete.  Such a
> suggestion could imply that 'fp' is inherently inferior.  The same
> general limitation exists on other architectures when user space is not
> built with frame pointers (i.e. '-fno-omit-frame-pointers').
>
> Instead, warn on s390 when callchain sampling is requested with an event
> provided by the CPUMCF or CPUMSF hardware PMUs, because that combination
> is not supported.
>
> Update the perf record documentation to state that 'dwarf' is the
> default call-graph mode on s390 and that 'fp' uses back chain instead
> of frame pointers on s390.
>
> Note that '--call-graph fp' may also be useful for other applications,
> such as OpenJDK maintaining a s390 back chain (does not require JVM
> option '-XX:+PreserveFramePointer' on s390):
>
>   $ perf record --call-graph fp ... -- \
>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>
> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>
> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> Notes (jremus):
>     Changes in v3:
>     - Updated warning message.
>     - Rebased on v7.3-rc4.
>
>  tools/perf/Documentation/perf-record.txt | 7 ++++++-
>  tools/perf/util/evsel.c                  | 6 +++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 178f483140ed..dc72606cb25d 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -293,7 +293,7 @@ OPTIONS
>
>  --call-graph::
>         Setup and enable call-graph (stack chain/backtrace) recording,
> -       implies -g.  Default is "fp" (for user space).
> +       implies -g.  Default is "fp" for user space (s390 uses "dwarf").
>
>         The unwinding method used for kernel space is dependent on the
>         unwinder used by the active kernel configuration, i.e
> @@ -329,6 +329,11 @@ OPTIONS
>         enable deferred user callchain which will collect user-space call=
chains
>         when the thread returns to the user space.
>
> +       On s390, the "fp" method uses back chain instead of frame pointer=
s,
> +       which requires user space to maintain a back chain (e.g. compiler
> +       option -mbackchain).  Without a maintained back chain this produc=
es
> +       bogus call graphs.  In that case use "dwarf" instead.
> +
>  -q::
>  --quiet::
>         Don't print any warnings or messages, useful for scripting.
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d..55297b8dab37 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1092,9 +1092,9 @@ static void __evsel__config_callchain(struct evsel =
*evsel, const struct record_o
>         bool function =3D evsel__is_function_event(evsel);
>         struct perf_event_attr *attr =3D &evsel->core.attr;
>
> -       if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
> -               pr_warning_once(
> -                       "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> +       if (EM_HOST =3D=3D EM_S390 && evsel->pmu && !perf_pmu__is_softwar=
e(evsel->pmu)) {
> +               pr_warning_once("Cannot use hardware PMU 'cpum_cf' / 'cpu=
m_sf' event with callchain. "
> +                               "Use a software 'cpu-clock' / 'task-clock=
' event.\n");
>         }
>
>         evsel__set_sample_bit(evsel, CALLCHAIN);
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
> --
> 2.53.0
>
