Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA33CC9F1
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334031; cv=pass; b=n50VYJQEUEuCOQ6Zg4KnT/H+wfTpKUVCOVh3COb/Z1FeXBjT2p9bMyjbbSBnma0MyCxeCnZcHIzI2EnIMzfqUx5WEHdCZUIQNpJFpTzEw2xLiTwEiLmXfcO99R4XLYGR4EibVAsoVPUBKPILzCoHZyS3MHqJjjJA/sN5H406wIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334031; c=relaxed/simple;
	bh=cXTmgm1Drti0GUkzUJ7MyMtyMPH9GQxRekSaqMSm/Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMbluhU39wTcK+ecEWu7VKYkqeJ2o9WZXVCk4BIIX+N48TIssoHYDIb56PlQJguVrTek+qsYA7+h433KbrxOJk8KNgGT8IRktT4qU84RZslDoalmRwyZPT+wV6U82AzLKHQcm5uEt+8IerF/aUBgCr2RKNs2D2y1i+bj33OZ1Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gur9tzFh; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gur9tzFh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae49120e97so2245ad.0
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 09:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334026; cv=none;
        d=google.com; s=arc-20240605;
        b=XAMOLGxjnxs6TKccypO+sla1IZYZFf7LevDiywZg00pCA0JLF9V2RXbK5MLba7mcAl
         R3mMyNjOKR6swYGWwq99OCX3tuynJR9s+sneXXdy+CmXu2QaeaD4g2p1AWIku8kW4AXE
         O/5O96TWvwozYa9UlRUp2uGVJHm5sxoXR71Z1cQxDjvzXjQi4mMxyki+YtGBekb2+EUc
         W26Vmwu7U4IatTDAmBC5Rfizu5ANQWswdCjC9SxlGKgyuu7NAy7hBvviPqhoMDXu6dhf
         3PXts3qwLH+cRVIjilzq8eqm3f3lULz92l8tDurimvhKcO+NlKxyKo6slM0I4RpEEhfO
         Owig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M/LAJ5ikmrz1JbjWnTLog38iLe4UPx3i0FMVXAHUZkc=;
        fh=ZH7q/qQeb0OXA81RtoH7G/v1EBKc+V3UH8ljGYOhujQ=;
        b=IJ4kwUEJ77bQHjKYgQkHudz9NG4xHJGoQI+vipukrmh3nMT7Uje6WRlGgcPBLOP06b
         3DYBlRlY3MZJSEX88j/D4LvGkMGJ7//gdf9saHwqMD8GkPc4rdtK7FbExxQuZIzrVeKe
         WHAgSG2cmxXgHT+BsXn3kxaqO1WA0OXkS7JRE7xxRyJM4iGwi/Q0EZjHv1uDrgVCcrRb
         33Zlk8xQeSOCkka0Xs86QE68G+K1zgVd/eRfmB1K5QfEJHiVklYtQ1ku0XcQIwqan5ck
         INrs4U467wH5FNlAMmTkICQPxsj3SC5foPKUZ8diDpcKgOIv3ZUTI5xI1ayKgyfwT5MN
         qTdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773334026; x=1773938826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/LAJ5ikmrz1JbjWnTLog38iLe4UPx3i0FMVXAHUZkc=;
        b=Gur9tzFhZpS6VDtrb8LtktNfDwATAWmyQ3EJSHdqGDRtaGJXwAAlPcR6eNETfbq6NV
         xCV8pEd1EMzjh5F5bsKpn8q97Rf+qbURonEPzuy3PhQMszrj/SaYlIzi+vyNGbro2PHX
         5IadNs9XuIOnblTc3PKGZ4yl+c5x1d2UFKzb6UoxSiavUCfWB7ntt5l31nwB0999lBq+
         h2g9sdLQMvvzGVWbopKt9K9OUX92pxrR80C3rvHHBCk1bBFKDfQqKXaeL7ZlDO/tIdH8
         5tMZWsMCnZJgd4p7kbxEflklfkd08ujS+bmQ3hmpeXlmBGBaoH/tnYevYQekMhPrK1d4
         omTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334026; x=1773938826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/LAJ5ikmrz1JbjWnTLog38iLe4UPx3i0FMVXAHUZkc=;
        b=iYL6o9b/3y/38CbWCWrn0UEqKyDH7hSZag6/wTcjKRk5QYqrRXGjSiy/yLEgmgEg/d
         jwN4+xOOcNQcUXYkw+9wjPJV5bxe/0Fd9WxmIky178l8PYwtYZYDTnf1xnTzOHX3RN9K
         nde889P39RCAKuWYY0wDaMYFJDkntOP3HdwHBNE5e5d8qdaJVP3zZDit999coVBaciHM
         /E2HjswHyOxIr9jpHNv+08l5bqsmXhyPdmRL2PUhRZI2hmx1uuk1E906RHxi28o8Evy5
         XaDAH52i0R9bBDwiLf4R3NV3DItSTepPMXhbohv/zGFUhcsIQ1UKGqASYKIdLjahZYiY
         atJg==
X-Forwarded-Encrypted: i=1; AJvYcCXzEmt/rwueZv5nLL7fMp8mVOML6LAKCdyhLMNccFo+JIGVQPHLa1leBK9BBIz2MGQ8TNt/bEbv2eZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kXGy9QaTtF74V8aiId7lNj9RHxJNyKGb6yNWlWUCXFD4ihcQ
	E4Z9ZmrYSkYdTYvyLiSa9c/B5kd997CmJ0i1j41drOysxJ5t460v0ZCIdyPsVNxebF0Sl0r2wH9
	XYIlbvwpFKoUdSi8CA8crSISd/UBXbNCXhwCnk4PUgSLWn0AGaRWM+k0y/O8KnQ==
X-Gm-Gg: ATEYQzyAcFgGEe+vkb34ZZjYvbEHMi3ZL1kVRoxd/aBkDDpXmgVEMeZ0akUjP0diyb1
	T9xSqABAQFfGgKPGAUKggbwgIGaBN9Y95Ca/wNC8bEPeBS4idHr7vqVG9Cu1OsnT4lj9iIIIpsS
	Ljsja6OAxoY6dNOCn0vQVEouTiIjGvrTI1ZzM/fpCmlTkONTOro+FnAXMah/QCE927CrZOEG2S4
	0twdmFqTL0ralRacH+E4uhFaLUGJeqTWngWpcWF/y38BD7zI0mu6h82AKimeT+M2vkaf/IdcOnW
	HII9R0RXt//W5PIr8Sh0j+Tu1ojyhumZswb+
X-Received: by 2002:a17:902:82c7:b0:2ae:bf32:20e8 with SMTP id
 d9443c01a7336-2aebf32253emr1496865ad.18.1773334025973; Thu, 12 Mar 2026
 09:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com> <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
 <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 09:46:54 -0700
X-Gm-Features: AaiRm51C2uIqTJySAiWPTDsdUdqmta4jbLnrfAAIoy3AWkg2rjqIo4zpC3T2iLg
Message-ID: <CAP-5=fWeicz7iFMM8vw32OCQXkBcCeWS4qA7k-iNJ6r7izpBbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:54=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 12, 2026 at 5:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > On 3/12/26 07:16, Ian Rogers wrote:
> > > Frame pointer callchains are not supported on s390. Ignore the option
> > > and print a warning.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2: Only disable user callchains as AI is telling me native "kernel"
> > >     callchains are supported on s390.
> > > ---
> > >  tools/perf/util/evsel.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index bd14d9bbc91f..fa21b48cba86 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct e=
vsel *evsel, struct record_opts *o
> > >               attr->exclude_callchain_user =3D 1;
> > >       }
> > >
> > > +     if (EM_HOST =3D=3D EM_S390 && (evsel->core.attr.sample_type & P=
ERF_SAMPLE_CALLCHAIN) &&
> > > +         !evsel->core.attr.exclude_callchain_user) {
> > > +             pr_warning("Excluding user callchains that are not supp=
orted on s390. Try '--call-graph dwarf'\n");
> > > +             evsel->core.attr.exclude_callchain_user =3D 1;
> > > +     }
> > > +
> > >       if (param->defer && !attr->exclude_callchain_user)
> > >               attr->defer_callchain =3D 1;
> > >  }
> >
> > Ian, thanks very much.
> > Your patch set helps a lot. However there is a small nit (which is mand=
atory). Please add these lines
> >
> >   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_CALLCHAIN;
> >   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_REGS_USER;
> >   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_STACK_USER;
>
> So these lines are dropping callchain from the sample_type which means
> the kernel stack won't be sampled. AI was telling me this worked, but
> I'm guess it was wrong. I think rather than this it is just cleaner
> never to set the bits in the perf_event_attr, more like what v1 of the
> patch did:
> https://lore.kernel.org/lkml/20260312031928.1494864-3-irogers@google.com/
>
> > to the new if(EM_HOST =3D=3D ...) above.
> > The s390 CPU Measurement sampling device driver does not check on the a=
ttr.core.exclude_callchain_user
> > member, but on the sample_type bit mask. It returns -EOPNOTSUPP when th=
is bit PERF_SAMPLE_CALLCHAIN
> > is set. This solves the invocation with command line flag -g as in
> >  # ./perf record -v -e cycles  -g  -- perf test -w noploop
> >  ...
> >  perf record: Captured and wrote 0.183 MB perf.data ]
>
> Right because the callchain was removed from all the samples. We can't
> fix old kernels (other than by using fix tags); is there a possibility
> of adding the exclude_callchain_user to the s390 perf driver for the
> sake of kernel callchains? It seems better than providing no
> callchain.
>
> > Also I discovered that the fallback when using --call-graph dwarf comma=
nd line flag still fails:
> >  # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noplo=
op
> >  ...
> >  Warning:
> >  Trying to fall back to excluding guest samples
> >  Error:
> >  Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be remove=
d.
> >  cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. T=
ry 'perf stat'
> >  Error:
> >  Failure to open any events for recording.
> >
> > The reason is in __evsel__config_callchain() which calls evsel__set_sam=
ple_bit(evsel, CALLCHAIN)
> > and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type.=
 It also sets the
> > member attr->exclude_callchain_user =3D 1 and sets bits REGS_USER and _=
STACK_USER.
> > All three bits are not supported by s390.
>
> I'm confused by this and your previous testing that showed the
> `--call-graph dwarf` worked. You need the sampled registers for dwarf
> unwinding to provide initial register values for the unwinder.
>
> > I have modified your 2nd patch and appended it.
> >
> > I find all these bits in sample_type and the attr.exclude_XXX stuff ver=
y confusing. If there
> > is a more consistant way of checking these feature, please let me know.

I forgot to mention, yeah the exclude thing is maddening. It takes
about 100 lines to convert the command line modifiers to those in the
perf_event_attr, there's a priority to them, and so on:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/parse-events.c#n1759
Fwiw, I was thinking for patch 1 of holding onto the parsed modifiers
so that we could reset the excludes based on them when switching to
the software event.

> Ok, let me check it out.

So looking at the cpum_cf driver it fails events for having sampling enable=
d:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/s390/kernel/perf_cpum_cf.c#n859
```
if (is_sampling_event(event)) /* No sampling support */
```
and the cpum_sf driver fails for any kind of callchain:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/s390/kernel/perf_cpum_sf.c#n839
```
static bool is_callchain_event(struct perf_event *event)
{
u64 sample_type =3D event->attr.sample_type;

return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
     PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
}

static int cpumsf_pmu_event_init(struct perf_event *event)
{
int err;

/* No support for taken branch sampling */
/* No support for callchain, stacks and registers */
if (has_branch_stack(event) || is_callchain_event(event))
return -EOPNOTSUPP;
```
Perhaps there is an oversight in the cpum_cf driver wrt branch stacks
(LBR on x86). The PERF_SAMPLE_CALLCHAIN bit is set for perf call-graph
options currently:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/evsel.c#n1024

I think cpum_sf is the PMU we care about for the default cycles event?
Since callchains of any flavor don't work with cpum_sf we can do a few
things:
1) Disable the callchain and allow hardware sampling to continue,
2) Switch to a software event like cpu-clock,
3) Fail for the callchain option with this PMU, which is currently
happening anyway.

I dislike option 3 because it requires special s390 logic for many
tests, and we lose testing coverage of hardware events. Option 1 is a
smaller patch, an early return in __evsel__config_callchain if on
s390. Option 2 feels most like what the user would want given they
asked for a callchain. We could change evlist__new_default to take a
"with callchain" boolean and on s390 that could switch the event to a
software one. Only two non-test callers use evlist__new__default
(record and top), so it isn't a huge change.

Wdyt Thomas, option 1 or 2?

Thanks,
Ian

> > Thanks again for looking into this.
>
> Thanks,
> Ian
>
> > --
> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germ=
any
> > --
> > IBM Deutschland Research & Development GmbH
> >
> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >
> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >
> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht St=
uttgart, HRB 243294
