Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB4494A08
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729442; cv=pass; b=vBSeOvN3mJWrd7CgtsqW3BVp7OQWucpTItv2+qNMH7q9HOa++mDtkKcQ9hZjdd6WFZX9tFzfK02ZzdSSJFiISjXkFBBsVmOwXZ8Vkb84e2t6aqEfcXJkUkqRrGwhWfF4TmRuo5+SS8tga28Ycvteqe0h329amLE21ZSRgHOxWCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729442; c=relaxed/simple;
	bh=ThdoN2c7xpbfFPU2VKw49l55oAYgxAYpwp70uDUCIEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiGdWmP5egWXhOqnA+ytWbWEn9qE9OaYcK0cpjz85zypHsLejXl5vFbdGM7qQJV/YHYMT464cQWIIlt02DKruCGyjAYJZ+Cn9rbU+CitOth9ru9S+5KWg95xCxNrx1pEAlmBRKD7PJjnZNCWMn+pE1PTzkEs5pASJGgXAXLOY+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKSQkD50; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKSQkD50"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01c79467so370441cf.0
        for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 10:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786729440; cv=none;
        d=google.com; s=arc-20260327;
        b=Kpll/1MHMjbNn+42KFMCyrbP8SHwHi8fQNDxnu/Mkdvh7IJW7GNs2F8pJAbsb40TUb
         M8TkwiAYtQW9rPqSB/lajf7bE1/0f/NOk3dRZeV6mtBWLJPvhW3iJoj5MUso9Ko3EkgZ
         Gdvxar7Sye1GE3izZIplwP4A9LUf+7lNAPWYnEv6ML0aXEGwXPUaxfSsWvkXloV9WXHe
         W7WwD2cV0GNlYhqqXYRHjK8QQOTecoT893iWR63Ti1YeQj2wakNcMnUBgQX0tJcJZC/W
         xJmtnCRCE9cgZZyVD1JEY5R0UOe4RGVL82oHvLBxfxxOYMufT/QaUP+3l6JAjWOzvnGU
         FLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3XIa3oNqh9XbRNaEPeDhKo2IZftbtziRumFePLkBD7A=;
        fh=tF5YpMKcyecg0iur4Sf3ZpsFvKsZ7+KLvoQpsB3U0y8=;
        b=Z1KxvoJNEZeFU5CueQbry8EszM4AgkdFgcvFqkO4nIhsNgHrzwj3KOzBL8ZR8igzS9
         1LEHGCoPgmZInxb5roFG2gNspej7xJ2o09dbdsgicEEyTxdYAnpRrxfPxoa10A8c9W7P
         MCrbuesivFsaVLTTY+R4Y/qWUBsByZgZZrL5Ydn5KY8QtS9gyevDFNSddOXB26CVF+W2
         KpIHiYpiYRvU+jyT6LBDsHLlacoqaVe41SdVDdiBNDQ7JBwoUI0ibY7hzl3WJuypWY/g
         6Fqpso8OutEPshwgCJ9r6SzMdf7HOg2fTxx47NifFTDDnUQuoHx7lJgUAiqF5K2lnmmW
         jNhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786729440; x=1787334240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3XIa3oNqh9XbRNaEPeDhKo2IZftbtziRumFePLkBD7A=;
        b=OKSQkD50LRvbdaf70WWAggEH+UnRsyUKwFGwtmoxC+mMM6JycOqwbReoviTIkx1WkG
         gtUhTfsniqQ7HGjespdSAOpOigIgMtaSC6bahQxweesUt+ZytiOBQFxV/nGUIfv7jL7K
         elCZ5C5I72MYRCV4m86PPsfO/liVuY35bQ7otg+lWG8EH4SAv5qPsnbvPvneON9YUm7p
         7PzfFCGWkYGQZjwb7dTBmJwSwCwV7hEuDm6PudeFpTxvDHTEXkTj64qSPLK9iK1CLvlx
         5nfpEJPTXQ+Kz8viRw367azUaGIFS4wegNWKr0qw5ewIDYC4XOUgrISocgKTUyPwh7CR
         LNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729440; x=1787334240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XIa3oNqh9XbRNaEPeDhKo2IZftbtziRumFePLkBD7A=;
        b=GLo2G69NN6Yax7kMuHnQ5XUP7lWx8N3uhaz3LWwGsVRVLjYddmqLIRTHc5L4InXiyA
         5Jp4jgqScKGJ152qQ/h6dP3k8R3CHn/P6UsDn8pvHbeDibuf0egYXlaq+h/lBiYQeeWc
         g3Z1S+kicOhUYIlNk1iRnxfLnp3OuFrp7MiEm+5/LDlH/V1h+NkzeGJZ1FP9UJyxGK6A
         LxGDEiLaJHAImtm54MScpWV/UvuDcAT3WbOXMrsj6ZagGly69XTY3p8quD1iyNrw2+RJ
         +K0hN1KpanJcKrJtsSXjaX/GWmTpbJfi4ZgHPxm2v4ZGLEiDmo2fJmbmumYhZEeYxBKo
         RVUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq27aI8WsJ1pMK0QKrBTHwVwwSHMfxAOWfkj9DzkRYC4QGw+petbabwf1YZKAtfkrc+IBkEELo7nLl4@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTozoTe9RcEwpJkXsTA6qXBa3qAel6syBcmPQkBGMltHGrU6M
	PwoDEbHWInQsrfIze28KD/RnM3xu8sjqZeO0WcDKZ1hw8pvQBz9bss5f71ynlvYD1rwIyhyXFZo
	ml4AqHU/cL+0b1InZTzROGoOD7FMpErdrb9vsGQFv
X-Gm-Gg: AR+sD12IIbw7iyyTgiN/VisizwE9jCdtgYUBXK1tGwHThlmbAyoVG85dR3Y11ja5Ajm
	siQ9BXuyVzGHb4NUYFnPA1aCLwVfXGIfqiqIfG6VA/GCm8fkdi8+zTVb5AeUCLmhoWMU2wac0Qy
	uF7Fw6+heZ0QXSDJmvqsyEj5qR75fvYZtHZbJhiZWR0t3+2JpM50dW26/RBjVIU1+VAsauPsHt0
	muKigR5YIBZdAiukmNXKjR2T+cN28aRE1LUcBBNBcKdWs9V8tEXoKYXLnkCyQEJHgqxD6F6aOEs
	yaSU395NJbI+EgaG0Dw5xEAmym44jAY69t6tWnDpPMJ87w==
X-Received: by 2002:ac8:5f8b:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52d8631482dmr1548221cf.13.1786729439124; Fri, 14 Aug 2026
 10:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
 <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com> <bfa64536-1c6a-417b-bb28-502ee25586a3@linux.ibm.com>
In-Reply-To: <bfa64536-1c6a-417b-bb28-502ee25586a3@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Aug 2026 10:43:47 -0700
X-Gm-Features: AUfX_myAQHv0Qecj4POBdsMTROB3j5EAzIXj6vRSVzm2q2sQLBtuAj2YR4LRrx0
Message-ID: <CAP-5=fWa9iCadXAh4nU3XHRT7wS4BNbW6i+St-5a3pdVPzUx+Q@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for s390
To: Jens Remus <jremus@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:53=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> w=
rote:
>
> Hi Ian!
>
> On 8/8/2026 6:13 AM, Ian Rogers wrote:
> > On Fri, Aug 7, 2026 at 3:49=E2=80=AFAM Jens Remus <jremus@linux.ibm.com=
> wrote:
> >>
> >> On s390 the kernel uses s390 back chain instead of frame pointers for
> >> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> >> USER_STACKTRACE support").  This is because frame pointers on s390
> >> cannot be used for stack tracing. [1]
> >>
> >> This requires user space to maintain a s390 back chain.  For instance
> >> user space to be built with compiler option '-mbackchain' (instead of
> >> '-fno-omit-frame-pointer' used on other architectures, which should
> >> better not be used on s390 [1]).
> >>
> >> Only few distributions and users built user space with '-mbackchain'.
> >> Therefore '--call-graph fp' may not produce the expected results.
> >>
> >> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> >> added a warning for s390 that wrongly claimed that "Framepointer
> >> unwinding lacks kernel support".  Change the warning to hint at using
> >> '--call-graph dwarf' if user space does not maintain a s390 back chain=
.
> >>
> >> Note that '--call-graph fp' may also be useful for other applications,
> >> such as OpenJDK maintaining a s390 back chain (does not require JVM
> >> option '-XX:+PreserveFramePointer' on s390):
> >>
> >>   $ perf record --call-graph fp ... -- \
> >>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
> >>
> >> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
> >>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
> >>
> >> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> >> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> >> ---
> >>  tools/perf/util/evsel.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index ea9fa04429f0..c4d67d1b35f3 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evs=
el *evsel, const struct record_o
> >>
> >>         if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCH=
AIN_FP) {
> >>                 pr_warning_once(
> >> -                       "Framepointer unwinding lacks kernel support. =
Use '--call-graph dwarf'\n");
> >> +                       "Use '--call-graph dwarf' if user space does n=
ot maintain a s390 back chain "
> >> +                       "(e.g. is not built with '-mbackchain').\n");
> >
> > Thanks Jens. The text was based on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/s390/kernel/perf_cpum_sf.c#n853
> > ```
> > static int cpumsf_pmu_event_init(struct perf_event *event)
> > ...
> >  /* No support for callchain, stacks and registers */
> > if (has_branch_stack(event) || is_callchain_event(event))
> > return -EOPNOTSUPP;
> > ```
>
> According to Thomas, the s390 HW event 'cycles' does not support
> callchains.  This is because on s390 it provides aggregated historical
> data, making it impossible to associate a callchain to the sampled data.
> Your referenced cpumsf_pmu_event_init() code applies specifically to the
> CPU Measurement Sampling Facility (CPUMSF) PMU and therefore correctly
> rejects callchains for those HW events.
>
> On s390, callchains are therefore only supported with SW events.
>
> Since your commit ca76fb67ebdd ("perf evlist: Improve default event for
> s390") callchains on s390 default to (1) the SW event 'cpu-clock' (or
> 'task-clock') and (2) 'dwarf'.  The kernel on s390 also supports 'fp'
> callchains using s390 back chain since commit aa44433ac4ee ("s390: add
> USER_STACKTRACE support").
>
> Therefore the current warning on s390 for 'fp' is misleading.  Given
> that on s390 a user must explicitly select 'fp', and that on other
> architectures there is no warning about the requirement for user space
> to maintain frame pointers (e.g. if they were not built with
> '-fno-omit-frame-pointer' and '-mno-omoit-leaf-frame-pointer') it might
> be preferable to remove the warning altogether.
>
> We could document in the perf man pages that 'fp' on s390 relies on the
> s390 back chain rather than frame pointers.
>
> What do you think?

So firstly, sorry for the misleading message and thanks for trying to
fix it! Also, sorry for the delay in responding and dealing with some
hospital things. Man page documentation sounds good to me, and having
a good warning also sounds good. Since this is for s390 you guys are
much smarter about what to do than I am. Since the function generating
the warning has an evsel, we can get the PMU from the evsel and check
things like:
```
if (evsel->pmu && perf_pmu__is_software(evsel->pmu))
```
By which I mean we can provide different warnings for hardware and
software events. That said, as a hardware event will fail in the
perf_event_open I'm not sure it is a useful distinction.

> > The backchain option is never tested by perf or apparently in the
> > kernel, but this warning is supposed to pre-warn about "not supported"
> > being returned when frame pointer unwinding is requested. Of course,
> > lacking an s390 I've never tested this. I can imagine the warning
> > being overly broad, but my understanding is cpum_sf is the only PMU
> > capable of sampling on s390.
> >
> > Perhaps what is needed is additional text after the "Use '--call-graph
> > dwarf'". The existing initial text at least appears to match the
> > kernel code. I'm not clear how the lack of back chains would be
> > reported as an error code, and this could introduce confusion as we
> > have lots of stack, chain and branch related terms in the perf
> > codebase.
>
> This is analogous to frame pointers on other architectures: the absence
> of a maintained s390 back chain is not reported as an error.  There is
> currently no mean to determine from and ELF binary whether it was built
> to maintain a s390 back chain (i.e. no ELF attribute/flag).

Thanks for the clarification! I think given this I'm happy to add my tag:

Reviewed-by: Ian Rogers <irogers@google.com>

Do you want the maintainers to move forward with this change, or would
you prefer to add something to the man pages, etc. ?

Thanks,
Ian

> >>         }
> >>
> >>         evsel__set_sample_bit(evsel, CALLCHAIN);
> >>
> >> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
> >> --
> >> 2.53.0
> Regards,
> Jens
> --
> Jens Remus
> Linux on Z Development (D3303)
> jremus@de.ibm.com / jremus@linux.ibm.com
>
> IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Gese=
llschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
> IBM Data Privacy Statement: https://www.ibm.com/privacy/
>
