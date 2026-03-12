Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1923909BE
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330897; cv=pass; b=MOKnVne8mnvxGmCtIyeqZM/JhHLXUhVaydAU1Cpk9wX3Zhl8HdDs0CCWH2QyrCUAUlHCCjGh7iuz0HaM/IDG95sd50LHZ6H/oa0fcPDR0DDx1plCcgjtPfq3fSgBYNblsMa6KpIVVAVhIOz0lCg6GtFgo3AjUNq+wZChx54yaPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330897; c=relaxed/simple;
	bh=ZS+/ItMjmQy14ENZqWve/PidZqa0ImY+HlFy6RCiPB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XV9RjJylIPCrLDNKRR2irrgLNd8GjxBVzQ0Niqe03PVeIUF72v2WWe1rl6uQ8lYomwNfm7vfskUEVc5BbJCsKc1mCYdhjfg/TtpmakOX9wAsedAHs+ahLW6BIYxwBCvn4OcJRZLRkrxnHR+8y2PyoM+6cqc1/ndgMGW48faters=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY5Yaoes; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY5Yaoes"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae49120e97so98765ad.0
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 08:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330895; cv=none;
        d=google.com; s=arc-20240605;
        b=WBfoAipt8mF3iEgxG+FKMZegT/1C5HaGXp+YsiXElzUW/osQse/0/FPA3PQfRqniSN
         IZnJ1CI8RdaLhKuXbJag7gubIShR39ma66AHSS/6kNspOe/Qcmpr7MAlHhAm5+4GhVcp
         CdQKE41JVb5JLnpdCifW2zmOmxXWseVZkMZnW+isoYMlhZ3zeP5emTGLupSoqnb8rjcf
         vTVM6m9G/KWbZ8Lcm3k0NgViKYlfS/d0HN/Snv0nfCgQm1HiI5HI8mdutPDQ3oq6TxqW
         3P2AQjBUXxDB/VFAS6Np0rsvh9NrsB7DsD6yTyxQeRBnh9hE6RsOc9RvF1+eeWaQ7O/C
         N4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        fh=0+Fi323n62owMtNz4eZhk4uyEAx0zBceiRqAod/yn1Q=;
        b=DKvzCee6YsYfX/s3l+NGUB0IB4cTa46cdnZVkIiYsGsFiURxfg9bRgln2cqNdEoreQ
         TLwKmL6BV4spyCVxGNf0+vQSTxfUvMsfSnPvDKZVaSzLf3LhGHy0vmd+QnTGwjEIEsQ4
         o9TDNxRPk1/un8uORUwAvsi3f9UAGzY/EHzyfmSkjNGl/sAgGjT3xYIAvSRUj7hwtLvU
         iWMY+31nqTxl/4ij3U7JH2Fs3Y7Wv+CAlXXIz/gt/V25ynRHi05+wAB6XVup/y8x9TMr
         5qaBvEjxYyxiiyLzWRqvvYxRAoz0+8QhQkEdbpdAZCmnUz3tph+uzox2l5Nf4ddleQTI
         CIyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773330895; x=1773935695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        b=UY5YaoesNhP8sgvAkKYeEyR+97Apbz1rEQU5vAf+Oh6ngu8q1ojSJB/CXOhl2nYJRB
         IIT7hcEqsDkPOBhdWr1fcAPlG7HRBRiRSaS8LjOSajLkSFaVTvTta6YNs+foy6VFm7we
         cc5lPX+8nXVmqUI7JPNLCm51eQ1PI7ineVYRoc//XCUwPaLytfBDQognu9COQSLXbgKz
         9m+0aV3myWVFpS7hiYHdoxgkLC3/aoj84VqeLbIxu0mfJACB9WJqZ161i5goZ8kFf4E4
         6UoZ3pUm5uCOJT0T44k6VF15JuCahmnmxu9vSt0D6A6D7/lEqjlcaiWprIUC0LuDn7en
         e6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330895; x=1773935695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        b=vmJN0+JhcxEFoUx/a7SkXVDPsjuZrS0AXLjFDg7CgsThMz+pRfjC87iRGwjLr8W2Oq
         Q/5Mefre9MCgcyhbSjV8jTRkwpB01hf6ItcCcuWBLguM472Irkmn3T9NWEh0VEYYGXDN
         xT2CImeNTd9Crl+yWW7BoZsOFBxZ5rK03/8yO1Tz1O6REXsSmau3Mgp52oRE/McHenxc
         Q2z2DkxGiLUi123I9yKKGfWbeaULD2nCZn0L4feIg1WT6p/+sEsO7ozuAXdgox6UZBPo
         T1JAcmYq2JjQktkrmDEjGQCwc/5ol7GcLlHy1q7X7LMwp7dwavgl9dB0YhGFHcp6XJEb
         Mokw==
X-Forwarded-Encrypted: i=1; AJvYcCVy+7061sc8bSwaHi12sRvLnSvdonEfCFwSnY0RH8YRdxs9aIH0lJFdvBX+MFt07fbAU2s3aqigkV9n@vger.kernel.org
X-Gm-Message-State: AOJu0YzuC8egxVqJOcoWE/qJl3Aui9yR5h9409AUa4EtkpfI9XuzDB3H
	rOHklK7ezP6TGTg7Na4xoNehDmMnQx/71He9nt9OnT7vJOun10qZwDtyf0RX+gAzP6eJZLasFsl
	ZaJdKqfieUY6N2P1nPUTIh1/WuYL+n7Af7WpjOVKj
X-Gm-Gg: ATEYQzyeG2Kl0j8Z0h5zT3n6cmYDa+D96VXgPMzwdia/8uSxXLa8WBm4fpLup4Gn+NM
	a7n6cau8InO4P5vjMC04xeK094cbtQdZwzlU+lfoJjXcWfo0S4f0wDYXdunl+lzVPMOeCxXuoUd
	hpt+wiGDrHjvDnwT2vh6IRJ1P7zMi3oVtDa2+CN2bQsTR6Pg8lnBtdK/6UeI3NvHaFAKh34Pbfl
	Bivlahkg+UBF32hyufWQOIM1JGKm9FzHknlxzC9x6N2GDbHyh1x/9ZSYbaUKC8xKpq5ycMj6Fyj
	3hDDqpBxjjQrpe7vPYibaxjcvYfaXKunSV4V
X-Received: by 2002:a17:902:bf08:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2aec566cbf7mr758665ad.22.1773330894106; Thu, 12 Mar 2026
 08:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com> <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
In-Reply-To: <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 08:54:43 -0700
X-Gm-Features: AaiRm52XnLLGRVsSOtUv5kOWGcQRyED6TdG_wWyxIGXeGQjR4wuDdkjk1jeva2M
Message-ID: <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 5:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/12/26 07:16, Ian Rogers wrote:
> > Frame pointer callchains are not supported on s390. Ignore the option
> > and print a warning.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Only disable user callchains as AI is telling me native "kernel"
> >     callchains are supported on s390.
> > ---
> >  tools/perf/util/evsel.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index bd14d9bbc91f..fa21b48cba86 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evs=
el *evsel, struct record_opts *o
> >               attr->exclude_callchain_user =3D 1;
> >       }
> >
> > +     if (EM_HOST =3D=3D EM_S390 && (evsel->core.attr.sample_type & PER=
F_SAMPLE_CALLCHAIN) &&
> > +         !evsel->core.attr.exclude_callchain_user) {
> > +             pr_warning("Excluding user callchains that are not suppor=
ted on s390. Try '--call-graph dwarf'\n");
> > +             evsel->core.attr.exclude_callchain_user =3D 1;
> > +     }
> > +
> >       if (param->defer && !attr->exclude_callchain_user)
> >               attr->defer_callchain =3D 1;
> >  }
>
> Ian, thanks very much.
> Your patch set helps a lot. However there is a small nit (which is mandat=
ory). Please add these lines
>
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_CALLCHAIN;
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_REGS_USER;
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_STACK_USER;

So these lines are dropping callchain from the sample_type which means
the kernel stack won't be sampled. AI was telling me this worked, but
I'm guess it was wrong. I think rather than this it is just cleaner
never to set the bits in the perf_event_attr, more like what v1 of the
patch did:
https://lore.kernel.org/lkml/20260312031928.1494864-3-irogers@google.com/

> to the new if(EM_HOST =3D=3D ...) above.
> The s390 CPU Measurement sampling device driver does not check on the att=
r.core.exclude_callchain_user
> member, but on the sample_type bit mask. It returns -EOPNOTSUPP when this=
 bit PERF_SAMPLE_CALLCHAIN
> is set. This solves the invocation with command line flag -g as in
>  # ./perf record -v -e cycles  -g  -- perf test -w noploop
>  ...
>  perf record: Captured and wrote 0.183 MB perf.data ]

Right because the callchain was removed from all the samples. We can't
fix old kernels (other than by using fix tags); is there a possibility
of adding the exclude_callchain_user to the s390 perf driver for the
sake of kernel callchains? It seems better than providing no
callchain.

> Also I discovered that the fallback when using --call-graph dwarf command=
 line flag still fails:
>  # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noploop
>  ...
>  Warning:
>  Trying to fall back to excluding guest samples
>  Error:
>  Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be removed.
>  cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. Try=
 'perf stat'
>  Error:
>  Failure to open any events for recording.
>
> The reason is in __evsel__config_callchain() which calls evsel__set_sampl=
e_bit(evsel, CALLCHAIN)
> and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type. I=
t also sets the
> member attr->exclude_callchain_user =3D 1 and sets bits REGS_USER and _ST=
ACK_USER.
> All three bits are not supported by s390.

I'm confused by this and your previous testing that showed the
`--call-graph dwarf` worked. You need the sampled registers for dwarf
unwinding to provide initial register values for the unwinder.

> I have modified your 2nd patch and appended it.
>
> I find all these bits in sample_type and the attr.exclude_XXX stuff very =
confusing. If there
> is a more consistant way of checking these feature, please let me know.

Ok, let me check it out.

> Thanks again for looking into this.

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
