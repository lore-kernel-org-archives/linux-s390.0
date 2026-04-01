Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A435DA75
	for <linux-s390@vger.kernel.org>; Wed,  1 Apr 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074429; cv=pass; b=tfuROHMnmP3NjAiDFkc5rurYy+JrUkRvO+toPPy/Rz0HVAr0P7WlQsd8MMmTZADZTphFdDDVK28a7PFuRpx9zNwJa9u1mR+PGsurZoxWk8sroS67C/MSDeSso9nJ5a3Uhp1pEb82I62v72pFG7/ixW/rUVDwrtcjVwaO282ep4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074429; c=relaxed/simple;
	bh=Lj+R466yzYuE75ZfH8uQjT5GpOm9hIb8Ad09LLAT+6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeC2ErrcXioWJIJH9zY61Ea5NaYsVCEFEGEjPRdAsQlbHud/CZqSpKwTq2+As9Rm7zcRO3ddfeZ181cedXX4uKb1g5NhiEXywiPB8pf4qmOqz12NGlFvJwAjwnPWbUISwNkFfKiJ4mFK/xfK9C3Ac7b1nnZGvBCnEHi1ypchhKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljaR6rp+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljaR6rp+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2591757fbso30935ad.0
        for <linux-s390@vger.kernel.org>; Wed, 01 Apr 2026 13:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074428; cv=none;
        d=google.com; s=arc-20240605;
        b=dAO+Lh8v20KvBDXWN/Sga/qHGUOjP/DDbcWij5gc1xKb20w4J2tJqjefwCk5QnIvoQ
         B2TSyB7Kyu8aRxQHxHHlJu5WOOILGprPBHTVQ+XqM4VV+jsELDPTfs0gy3TZigkn4qIi
         NxYfmwtxu0pAbGyHMb/UMjMV/mORVpTVZjJHWop+IvwSQyw9t0dOWDL3Qn5CK1Eyg5Fz
         lgLItgXIhEb+Cp/UQzdGvFbGzUhHqUdfbNa69QWVdy8og54TRjfZxh424HazYzZ+0Jp0
         S6Scsx6RKzcy4t2DmXsInxX9dY0go7SKKLwGN2iOTphavED3mUdUjnJoVqYjVw0JqiAL
         H0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        fh=wlL4vnCrFgIpJskGVLmwvR46kIPpUlKftRYdB/R1/wo=;
        b=fjfFoQAhBM6e+hWhyxPDPmNWUkW51QCY1xkqEByozSyeoY6YNQKKRwLyN6GEzMPzuN
         J/JZS/nAajQ+iuEomf9aofrNHa7oNzWUo9xagXGnJO2Os7JIbz+afrMR2g9hmBGnWNPM
         0JPWw7jSs5j27gXGpYn48Ku/W6Y6IjXpKIQ6zkSlwq6q1lVsLscPSSpB+NXm98yse5UA
         +pGHHwdUoLEjKPPvXyaCFoHVlM0jlZzaBZjQyx2K2fMGcKVqexknkmXVJuk39ixKjjhq
         HTGUEFH0PWSOQc4c0ClPuzaqZkyBvGnzIY5StGpbvH8FVQNDgo9VW4pajODjZzjMcSNi
         N4xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074428; x=1775679228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        b=ljaR6rp+zDSMc3S4VfrVCrDpNSU2SQ1Tk4uEYd7VTfLQDfgcDrUBCNrQ6PP+21p4eV
         BkIdKC9oj3m6W2kfmngWRDXLd8g8Rx+HE90unVE9JnJtilpqT+mr8lv2mKYFYD3BYw1R
         vDPNQeND9x9QaZg+xrNyTqC3bCYV8Jc/ixYb3DzijXWXMms9MGqTZX1DqzpEy15/El0W
         0vxbxpsf8O2vmYiAsdO9RwHcZJFLFQj3PXaOSUynGgR3bX459xdeO3J1rZXjAK62s1wI
         /YwcVk7o5DxP8Zcmtkv7EvG0crKmeIA/wRV/ipvlwFS7Wy8BS4fgNconlPCu97DWMsQ6
         5WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074428; x=1775679228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        b=WcN1Yc9+cHCvi0epsYkW+FKSK5uPwPcn3nZ+JNbapGIu7LJNI+Zh2zFAu/CJXE0mFJ
         qB/yQvPiI7jYMRr3wi/917gbgQugTH23lhEFBlwPdPC5dJsXZvCae9yr/dgTM9vF78eB
         euz1Na7n7cNKqgHAHv5+KJgrAmr4qXSWhmgx7VpnV+gkYtv7uf2unILy6EwE+RLkxpD4
         t6Sp3ymP5g1iWFDmWrkRptKmobKdzeFOQ9d65cpJ24KphvVGJdtws0Bi4sSKR81hA+iq
         4o9jjcC8Dmld7iK7SgVE+qOTA6s4ff71Q/AGaggSF+t5+Efj0f+zmkkG88/OHvZuTUMd
         3nBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUq91yjVyikr2S7Y4okQu5TY6dBfIaLo4HO/pTd6O5wSqxP+Cb85r58xM+nVfM+tL2dnPsNU0IULIO@vger.kernel.org
X-Gm-Message-State: AOJu0YxRV4LXdmKU1/k2J+/DqyUCdtJa5cOL+/ROMcqAO+Xmdpp0BX5d
	Shp2+RxcFTpcvqSS+MFRaVvvp1KMBPMiTm8TMELuWt/nn6RYTjWZQEvJ+c+7AvHw9UU/UNpxRCG
	ToL7/130MGbD4vy6gJzlYsB2WKzNHUBIBruYS7Ats
X-Gm-Gg: ATEYQzwv/Zy6pjG224Ztr6vD0PGEloXC1TKOlIqOGVOOzrAz4zi7HYjKfhEtNY8dw+D
	MfbqB7RFlZXC/rXW5d4DKuE75GBQTBcqPeG59kHS4snDJgCsKLRMO3EZdhmxMprDb9dlAB5DpyB
	iyml7k09YT+PDsNvVTtiGQ9i436M22KM0/O9xMTe9ckpaZ44q//yZb3i+0piRr5hWsFXlqUZ9r8
	IqLe7xa4RYq7sRNWBdtK2BauSHHJpApMj1MC/Yp0WrjJLkUKc6/MiOFIpV5xY8cNn0MFK6FnmO6
	rlkHVRHhcd21b0+PyPaGvAlBbgqBwnrjgBK9
X-Received: by 2002:a17:903:1210:b0:2b0:9a61:9d9 with SMTP id
 d9443c01a7336-2b2769ff14bmr387355ad.9.1775074427053; Wed, 01 Apr 2026
 13:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
 <20260325120627.1841175-2-tmricht@linux.ibm.com> <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
In-Reply-To: <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:13:35 -0700
X-Gm-Features: AQROBzAK4Qk9hAJXi7SMmrQptfDmYITsHb3dwfqkPpfw3-Zl_GSuDOExIrDOb70
Message-ID: <CAP-5=fXmTa-s5fTUg+x4hJa4kiJ5bCTVHy7c4L7mBE72Xk+EWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf config: Rename symbol_conf::disable_add2line_warn
To: namhyung@kernel.org, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > Rename member symbol_conf::disable_add2line_warn to
> > symbol_conf::addr2line_disable_warn to make it consistent with other
> > addr2line_xxx constants.
> > No functional change.
> >
> > Fixes: 257046a36750a ("perf srcline: Fallback between addr2line impleme=
ntations")
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Ping. Thanks,
Ian

> Thanks,
> Ian
>
> > ---
> >  tools/perf/builtin-diff.c     |  4 ++--
> >  tools/perf/util/addr2line.c   | 12 ++++++------
> >  tools/perf/util/block-info.c  |  2 +-
> >  tools/perf/util/libbfd.c      |  2 +-
> >  tools/perf/util/symbol_conf.h |  2 +-
> >  5 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 59bf1f72d12e..8a93e56f4a7e 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1353,7 +1353,7 @@ static int cycles_printf(struct hist_entry *he, s=
truct hist_entry *pair,
> >         /*
> >          * Avoid printing the warning "addr2line_init failed for ..."
> >          */
> > -       symbol_conf.disable_add2line_warn =3D true;
> > +       symbol_conf.addr2line_disable_warn =3D true;
> >
> >         bi =3D block_he->block_info;
> >
> > @@ -1987,7 +1987,7 @@ int cmd_diff(int argc, const char **argv)
> >
> >         if (compute =3D=3D COMPUTE_STREAM) {
> >                 symbol_conf.show_branchflag_count =3D true;
> > -               symbol_conf.disable_add2line_warn =3D true;
> > +               symbol_conf.addr2line_disable_warn =3D true;
> >                 callchain_param.mode =3D CHAIN_FLAT;
> >                 callchain_param.key =3D CCKEY_SRCLINE;
> >                 callchain_param.branch_callstack =3D 1;
> > diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> > index 31c0391fffa3..e9f084db0802 100644
> > --- a/tools/perf/util/addr2line.c
> > +++ b/tools/perf/util/addr2line.c
> > @@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(s=
truct child_process *a2l, con
> >                         lines =3D 3;
> >                         pr_debug3("Detected binutils addr2line style\n"=
);
> >                 } else {
> > -                       if (!symbol_conf.disable_add2line_warn) {
> > +                       if (!symbol_conf.addr2line_disable_warn) {
> >                                 char *output =3D NULL;
> >                                 size_t output_len;
> >
> > @@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         }
> >
> >         if (a2l =3D=3D NULL) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: addr2line_subprocess_init fa=
iled\n", __func__, dso_name);
> >                 goto out;
> >         }
> > @@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         len =3D snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
> >         written =3D len > 0 ? write(a2l->in, buf, len) : -1;
> >         if (written !=3D len) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: could not send request\n", _=
_func__, dso_name);
> >                 goto out;
> >         }
> > @@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, add=
r, /*first=3D*/true,
> >                                       &record_function, &record_filenam=
e, &record_line_nr)) {
> >         case -1:
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: could not read first record\=
n", __func__, dso_name);
> >                 goto out;
> >         case 0:
> > @@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >                                               /*addr=3D*/1, /*first=3D*=
/true,
> >                                               NULL, NULL, NULL)) {
> >                 case -1:
> > -                       if (!symbol_conf.disable_add2line_warn)
> > +                       if (!symbol_conf.addr2line_disable_warn)
> >                                 pr_warning("%s %s: could not read senti=
nel record\n",
> >                                            __func__, dso_name);
> >                         break;
> > @@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >                         /* The sentinel as expected. */
> >                         break;
> >                 default:
> > -                       if (!symbol_conf.disable_add2line_warn)
> > +                       if (!symbol_conf.addr2line_disable_warn)
> >                                 pr_warning("%s %s: unexpected record in=
stead of sentinel",
> >                                            __func__, dso_name);
> >                         break;
> > diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.=
c
> > index 649392bee7ed..8d3a9a661f26 100644
> > --- a/tools/perf/util/block-info.c
> > +++ b/tools/perf/util/block-info.c
> > @@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *f=
mt, struct perf_hpp *hpp,
> >         char buf[128];
> >         char *start_line, *end_line;
> >
> > -       symbol_conf.disable_add2line_warn =3D true;
> > +       symbol_conf.addr2line_disable_warn =3D true;
> >
> >         start_line =3D map__srcline(he->ms.map, bi->sym->start + bi->st=
art,
> >                                   he->ms.sym);
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index 63ea3fb53e77..c1c12308cc12 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 add=
r,
> >         }
> >
> >         if (a2l =3D=3D NULL) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("addr2line_init failed for %s\n", ds=
o_name);
> >                 return 0;
> >         }
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 71bb17372a6c..ff229942fbb1 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -51,7 +51,7 @@ struct symbol_conf {
> >                         report_block,
> >                         report_individual_block,
> >                         inline_name,
> > -                       disable_add2line_warn,
> > +                       addr2line_disable_warn,
> >                         no_buildid_mmap2,
> >                         guest_code,
> >                         lazy_load_kernel_maps,
> > --
> > 2.53.0
> >
