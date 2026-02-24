Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF23A9001
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951640; cv=pass; b=Ck5GV0Qst6fRUbkNzItJuMl4IGE1CJ5ZVJ8Pb2dKrZrKZQLerDbeTGRBqgv1W0M3HI53Jx05Hk/9tFEeX1IHC1Kzwbqom7KqxSUxOlqwWREt5+NzgHZ0EDfmw9buZwW36L/0QoP1drkiIu+3UW2BsGi9/gUTIi/z5g4HDAANhdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951640; c=relaxed/simple;
	bh=QrYSQ14+yzNOLf85m5Fl5ZHd8uaERfS5fL6VVnIfS5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVw2xE/MIklFIaVEoF7C+10iDP30piTf0zscsi9fVr8QUeMraGgsA6tZW5iiJbTv36zmYJjawXMMuTWVU1t437NDKKrVseqknBOg2f4suSVEUzfEp1NdKiwqneDXubUCCdvnWSZTDWSpfPi6dpoUQiSuiYwTy3K9uhBThle/WAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4IxGVLY/; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IxGVLY/"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124a60cc9a1so1297c88.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 08:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951638; cv=none;
        d=google.com; s=arc-20240605;
        b=X/Jt4rbGjJgiP/RC5nWCBmnJUW8iPRzVAL1aXk/S8dSz1MfP3ACYQkFQd/xkljn5km
         TPkZCDaW0JfQ7f5zzvTUhHoQR8eHrxmaCsVdoWLFko9VqY/MhgLHnOWko3W1JV9hvQs3
         AoOxBd5dSo32PXIeJQqTWzdhvDjrMM49Bf2PVLbgbnE0GMrS21fRRaS3nHH5DhZTM0U2
         PIZBpCmS3LRrFXe3+yz5fTwjfoYdfPExr4yUXCk/Wqd9zWzQLVorZWktCeXCefc/r+JZ
         aIF+whzebSLdo/bmLylozW/683PMuwB99U2M7p3/o0wXDM8TuXmRQus/UzzpJD6WPWCM
         bV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EfJnTvsOKAmY1rC0OLaTkfBg+R3Muc0IfHu1bGcmvgM=;
        fh=U229QYFwKyTAH80GrBORxe12hKBq9m4uG3zJiIF7GtY=;
        b=N0phalxaeTsPDuGhrbfRfN/OHaZsjHXOyvX6l6uoZRA9e2s6HeYrSNi5/tZNwaGG2x
         iGk2MtmleMgPY83H+GetGnvUtaybhWTtz3C1opDfWMkiouI3ohTCEVEQ8fZulMlpwoWG
         iYSxksetHO7piXWagZiBwie0OyErhNbqhIZQ72eap/+IkuLWXjLWVgeV3hH+F8dNcarw
         5y1YsCzYZoll/4wn2QhlpkszyZWLUEg8JaA17liStrf+gDWIkmrrZyluTlakcdb9vp42
         ND692oL/3Ups0BzZyOPYBtnwX7en8dF9qnye54uSBSVuqO/5BcfXjxA6Jaby1khkbvkH
         VsXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771951638; x=1772556438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfJnTvsOKAmY1rC0OLaTkfBg+R3Muc0IfHu1bGcmvgM=;
        b=4IxGVLY/UI5uDchY8nPjRcACMXS21lYUBgZItYGD1JAdIw/OXN4SA/ffE0VuKcskQF
         8QGQSne1AeVCXqApoRVZkMetPbBxxNveDy2yiD0OnTQBuXLjLd4Bf4t5lvTLv+Q0uEcf
         O83SBrgiI23Zq5VrrCfsxQWtjkcuxO5BLnDSAU58786uhRW1n9HWXxH683zDyc5Vi5xa
         W4RGZT82ccIAh8cAv2ftS81dkfldE/2MvETNQrsYsjcOUIjg9VvjPXqQI+mbvHajHXLa
         PPBPZb2o0EIFlIQE92CtvmQGA1sICuiiB0TVw8G0sSPDgqtVA72WCTe+5Skn696xS6mA
         VqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951638; x=1772556438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfJnTvsOKAmY1rC0OLaTkfBg+R3Muc0IfHu1bGcmvgM=;
        b=AGkC+MeEhfqSwWeMMpoVQvs0pvKSTv/jFq1Q7Mh7RcGtAw5rusRf/GN8kNY6Q5Yaad
         p2wv++w7p3HqemnFf/fRDCGXm7AtYFrn7ZK8Sbl1wDk0+qaw7vjNNk2wP0065AV1dsKl
         vlxwJdq8rBuljaVoLSTK6eEADUyCGryfJhsNhlNmIVyWpvD7iiNeo/XYJVm9z/QH85Z+
         fpgrER8fCdDi3Tn0IrolYVSbafOzfBFuFYEyuHrbbe96lUHkEvtS79QTexqMftu2n15b
         eFJIlfB6xdXgELZ1dX1+HoP1fcTkmu92lOKLLul3kdBYCYDhlAwFQZg/6Gk6/OMvcMwK
         jaEg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZJ8wykwW44koETs+V7fyHLr/o+EdALAI9hCUyMdw3CfmGs64u8zPQKQEiKimcQXPMhe0Pkr25/4F@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6WSE0nHQk9EL0gWBUP4y28KFu2u9Fnah9XZEfcIhXYQFqCcg
	LC+ZCJVLcYfFILqLXcm4jvzhI27dc1cafqgeIDr2keUgdNdl84FkKs3dtL02T1jDkTBAS024mxk
	I/jTsNUNvpO1x+ujZlwtzjVlE67CTbziEfmGjKJj5
X-Gm-Gg: AZuq6aJ99L/ycAd3ZPZg2MlxAI3VIeC8wT4e9MRYbr+ujHV1h3G2zCk1Vy86eRDvzFV
	Ic2cY3Jt61k6V2Pj7FDBbXTSioIt0BdY5zCV4ZSUce0G2sk1kp4LCBmWzR+tDK4BkGfnf6Wj1nQ
	Vkgz3RIZwT7xW0c4yq7OewoQOiglL5PJ6mFJouTBI+3DFYR5VgI22Ev12bzG1I/wKecvGON6aNJ
	QiQWBc/rK8qIMySdnu1zn6wHmtIESu6GKKo4CbykNRm+XOlznWG2CdrE4VQ9oEtt3NMgksrPrWN
	nrqmjsICMW1Za4qmvdR776603zuxrmQGReZw
X-Received: by 2002:a05:7022:1e0e:b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-12779cb1999mr119009c88.12.1771951637217; Tue, 24 Feb 2026
 08:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217131456.4085419-1-tmricht@linux.ibm.com> <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
In-Reply-To: <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Feb 2026 08:47:03 -0800
X-Gm-Features: AaiRm50asGI7JDUT_Y40QoR3LGh47mug4NCJ1WT5cp7_s4liAF4i-nOtKko-fIE
Message-ID: <CAP-5=fVhpp_uQFWvdT-WXFS5A9n+qUivMvECiwOvG9MpQUcWhA@mail.gmail.com>
Subject: Re: [PATCH v4 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 6:09=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 17/02/2026 1:14 pm, Thomas Richter wrote:
> > v1 -> v2: Add comments from James Clark and Ian Rogers
> > v2 -> v3: Improve switch statement in add_config_term()
> > v3 -> v4: Fix clang warnings
> >
> > The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> > due to a NULL dereference when the backward mmap path isn't enabled.
> >
> > Reproducer:
> >    # ./perf test -F 'Read backward ring buffer'
> >    Segmentation fault (core dumped)
> >    # uname -m
> >    s390x
> >    #
> >
> > Root cause:
> > get_config_terms() stores into evsel_config_term::val.val (u64) while l=
ater
> > code reads boolean fields such as evsel_config_term::val.overwrite.
> > On big-endian the 1-byte boolean is left-aligned, so writing
> > evsel_config_term::val.val =3D 1 is read back as
> > evsel_config_term::val.overwrite =3D 0,
> > leaving backward mmap disabled and a NULL map being used.
> >
> > Store values in the union member that matches the term type, e.g.:
> >    /* for OVERWRITE */
> >    new_term->val.overwrite =3D 1;  /* not new_term->val.val =3D 1 */
> > to fix this. Improve add_config_term() and add two more parameters for
> > string and value. Function add_config_term() now creates a complete nod=
e
> > element of type evsel_config_term and handles all evsel_config_term::va=
l
> > union members.
> >
> > Impact:
> > Enables backward mmap on big-endian and prevents the crash.
> > No change on little-endian.
> >
> > Output after:
> >   # ./perf test -Fv 44
> >   --- start ---
> >   Using CPUID IBM,9175,705,ME1,3.8,002f
> >   mmap size 1052672B
> >   mmap size 8192B
> >   ---- end ----
> >   44: Read backward ring buffer                         : Ok
> >   #
> >
> > Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to=
 remove macros")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/parse-events.c | 82 +++++++++++++++++++++++++++------=
-
> >   1 file changed, 65 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index b9efb296bba5..7b4629625b1e 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *at=
tr,
> >
> >   static struct evsel_config_term *add_config_term(enum evsel_term_type=
 type,
> >                                                struct list_head *head_t=
erms,
> > -                                              bool weak)
> > +                                              bool weak, char *str, u6=
4 val)
> >   {
> >       struct evsel_config_term *t;
> >
> > @@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_config_term=
(enum evsel_term_type type,
> >       INIT_LIST_HEAD(&t->list);
> >       t->type =3D type;
> >       t->weak =3D weak;
> > +
> > +     switch (type) {
> > +     case EVSEL__CONFIG_TERM_PERIOD:
> > +     case EVSEL__CONFIG_TERM_FREQ:
> > +     case EVSEL__CONFIG_TERM_STACK_USER:
> > +     case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> > +     case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> > +     case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> > +     case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> > +     case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> > +             t->val.val =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_TIME:
> > +             t->val.time =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_INHERIT:
> > +             t->val.inherit =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_OVERWRITE:
> > +             t->val.overwrite =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_MAX_STACK:
> > +             t->val.max_stack =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_MAX_EVENTS:
> > +             t->val.max_events =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_PERCORE:
> > +             t->val.percore =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_AUX_OUTPUT:
> > +             t->val.aux_output =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
> > +             t->val.aux_sample_size =3D val;
> > +             break;
> > +     case EVSEL__CONFIG_TERM_CALLGRAPH:
> > +     case EVSEL__CONFIG_TERM_BRANCH:
> > +     case EVSEL__CONFIG_TERM_DRV_CFG:
> > +     case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> > +     case EVSEL__CONFIG_TERM_AUX_ACTION:
> > +             if (str) {
> > +                     t->val.str =3D strdup(str);
> > +                     if (!t->val.str) {
> > +                             zfree(&t);
> > +                             return NULL;
> > +                     }
> > +                     t->free_str =3D true;
> > +             }
> > +             break;
> > +     default:
> > +             t->val.val =3D val;
> > +             break;
> > +     }
> > +
> >       list_add_tail(&t->list, head_terms);
> > -
> >       return t;
> >   }
> >
> > @@ -1142,7 +1196,7 @@ static int get_config_terms(const struct parse_ev=
ents_terms *head_config,
> >               struct evsel_config_term *new_term;
> >               enum evsel_term_type new_type;
> >               bool str_type =3D false;
> > -             u64 val;
> > +             u64 val =3D 0;
> >
> >               switch (term->type_term) {
> >               case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> > @@ -1234,20 +1288,15 @@ static int get_config_terms(const struct parse_=
events_terms *head_config,
> >                       continue;
> >               }
> >
> > -             new_term =3D add_config_term(new_type, head_terms, term->=
weak);
> > +             /*
> > +              * Note: Members evsel_config_term::val and
> > +              * parse_events_term::val are unions and endianness needs
> > +              * to be taken into account when changing such union memb=
ers.
> > +              */
> > +             new_term =3D add_config_term(new_type, head_terms, term->=
weak,
> > +                                        str_type ? term->val.str : NUL=
L, val);
> >               if (!new_term)
> >                       return -ENOMEM;
> > -
> > -             if (str_type) {
> > -                     new_term->val.str =3D strdup(term->val.str);
> > -                     if (!new_term->val.str) {
> > -                             zfree(&new_term);
> > -                             return -ENOMEM;
> > -                     }
> > -                     new_term->free_str =3D true;
> > -             } else {
> > -                     new_term->val.val =3D val;
> > -             }
> >       }
> >       return 0;
> >   }
> > @@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu *pm=
u,
> >       if (bits) {
> >               struct evsel_config_term *new_term;
> >
> > -             new_term =3D add_config_term(new_term_type, head_terms, f=
alse);
> > +             new_term =3D add_config_term(new_term_type, head_terms, f=
alse, NULL, bits);
> >               if (!new_term)
> >                       return -ENOMEM;
> > -             new_term->val.cfg_chg =3D bits;
> >       }
> >
> >       return 0;
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
