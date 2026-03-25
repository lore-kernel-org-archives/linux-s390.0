Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BC3F8E1A
	for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450989; cv=pass; b=sp+XbQh9HtNbZhJFQEGh3LMPfto7r6ROGH9u6xqqlUZniwSt1Bh2O5CkdR/vTmLyqlnSCip/nE/fHKIJP4rtMK4OYRU7wKbkyZ2FY+FU4tBpM0kwbyV4zN+fanAxg0tyKeriJHZxFL/AsyrrgE7/eMoZVMq7YG86zjo2jKFc10o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450989; c=relaxed/simple;
	bh=EqNRQCc2ugxrOPUp7Ovatotqy8vCfTRyWxRiEnNz9TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KN/NQLZVqrZvrriBzvCiUEyO28okdptJMC1sWSYnxeK2Zzai7CaR0DzDEvoYkq121RxhtM8OjvN2xOMQPloMTMSBuBR00LwgpgfTFvg0ej1QlLEOsZb1HF8Mc3QMKMrr/OE3fXFlGFHIHWSVVGso61r0joEE/GcjiN7Zf4f5NxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdGCvNuF; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdGCvNuF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so82035ad.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 08:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774450987; cv=none;
        d=google.com; s=arc-20240605;
        b=MjFIpl2Dgdv5x9V3LYl9dKYZaqOTODEQoDRilLjwaoJHKmlCns2tBFuwuGpQE34ZPF
         e6TXi1QrQw3bDtbB0ZGPFZ9g3ZsjzZtnd3VDMFoGe3fkQH9TYUuzYK55lFf/WGMEkgfz
         +ey+9jmVBNM16JgfjMF0DgkcZLgtGQrSm6QebjfoQMWUzNzA4OwnXSWxMDl02fbINNbE
         GFXgI9hVk0Zb1v/X1mtoHh2j+CHRfgODQMg1fGV31imdVlhtPP14du/mA324Ck/ULkmX
         nIDd/F0WFBBau8a6nFM1lFBILkBOj2EablSNTn6rL1RO+T5+qIApcnjqUpPQqUSiQIOP
         sYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        fh=r70j9X/SfkKlS4jLm9v5wGu6DlO9ouaw2dzoxwvRPNY=;
        b=LIi946n8TX6UQBBS5/QaFUx/aMexyXktUj0TNk6M5+UegcWYnWYBhO9pNtHHobcUgd
         L+3io00NFmmAP3TmxZBZ2XffxXafIZ+W7QMU72wBA0UmKZEn9+a95K0cS/fLVhNgPiAq
         to79k+Sal+cmfHBSS/Qs7v4HO7hwZJNGuuEOgsb2iDWW1Np73QXbH6Y1XN6DHcsJJeUR
         +xZMa6Xpm+yFNbFLDemdxq05PRCqfOwekIKbo/DU7Op17jSDgOLm8VN3LYB4/hsYib83
         kLHGGkkpo9maXTPDeGhOQlLk12vb0iTYbXL8rtPrZvbqKoqAp+v+5AnJM3SSujeFG1Cn
         leFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774450987; x=1775055787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        b=GdGCvNuFaEclE6A/6ZgbqASG+szqSjxdQ2sXOAhposeaQIly1jQF3fvRI3mVnyzj2H
         Z0EmqVG3QpaoQ1cOspRl0bAiw+kpL8Sfan1FXSeBn1CxCsftNKqXTTkQj4t9AJBKelZQ
         pGDtF0eEHh16n+J3hPb3Ru5k3sd3VnXlzcFbkf++LzCV42J2wRVBUyRLWl/whkc1ukVC
         AS7l4a0x+6dPoPOUcR42jruxkDUTZ2+CXS77T2u335Kfhv/ffyB10zBCCvg3EMV9f18Q
         JUyWSoAOO2nzAoiM4kQmOHxAjVQKyecPtN/1UbJMsppNphN6EWeV9pR2CAXzQVNtsSti
         N2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450987; x=1775055787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        b=Ptg1FpLmuyLCndkLHmHo9c2iVB6l2TIyfYzzhzbNYM7Gas+jG+zBMktwyQ7NM9CtFr
         cx33VDDLoeyaDUr1HAOtcxN6jrTIfIUo4SEZr9wdJ2KNTup63tt0fpIoutHePl43p56M
         kHjPMlceooHmUa2LUvn7RNvD/EdHvSBTIMFavQIM/zyo/Ao+r7LFsVKP+/KxjGIYLtMg
         hY97YGAnrQdKNVquC0PEuGWn2j+dspFEW8oVlbvkNi3WCskjcpCCDcf5neH9WXi5qZyS
         FfNbQ6bsGyjjRGAu105V2B2MgIR934pj7nwsFplnv3K1LdaeRIFeBgmN7iKtj8kE6Ky7
         YgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ETrP5vBoVSdaVMCT3uU0PRwnLUZ1FlM/jbPbldGc5iH3QDLxd4A67OnOuhZvtouDF64TqhuNLx1g@vger.kernel.org
X-Gm-Message-State: AOJu0YxccqyrIXK1c852QH664GRzMy7Pdevlv5Qj+fiICl8AvpZKcI5d
	te0DdzYdK2yrnfjHLTFKQeuDc7ey/nCtGHnlRQR10B1LV999/+VOvefdsPMbiI96GSsJaXZzvl4
	ussqlVyPQHj7zabTmnccAL80+UYP2XxmWg3PeB6y7HLP+ED+zRSPtmUu4
X-Gm-Gg: ATEYQzy+Qwdja2BqqSKZpLjcTGEc10ZuRWwGCSwIWk8O+YwJDC95hZaMxwy6PbaDmCO
	kW81q31Y4eKQm/ElPX0rzoClI6mZEr5iOC7HYBHS4WPLvuwuX84L6VUQMBTbiOXUXcRXG1umOkd
	qTHEPc71bXioUxNq5SHWHFiShxKD2T4hDO7KaOprRE2f1UiaCFkTUamNHeUTf5OB43EAVVg2qKx
	Tfr+4Mq5i10WlnDCOR5jCYnM0Qnm6pJ6/XC+15FzouHWIJ3yd9abSYnuJp1TfGiFMz6LAU825s5
	Kt1JEKKzKktzLsxOxw01YzQxT5daFIS8giLAkQ==
X-Received: by 2002:a17:902:ef4d:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2b0b2a7f9eamr246935ad.21.1774450985756; Wed, 25 Mar 2026
 08:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com> <20260325120627.1841175-2-tmricht@linux.ibm.com>
In-Reply-To: <20260325120627.1841175-2-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:02:53 -0700
X-Gm-Features: AaiRm50lZIlNjnCB5rKHqTebxoxD2qMsZ2sUdhqBdRfwcHc3PS-44RLQmndEO10
Message-ID: <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf config: Rename symbol_conf::disable_add2line_warn
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Rename member symbol_conf::disable_add2line_warn to
> symbol_conf::addr2line_disable_warn to make it consistent with other
> addr2line_xxx constants.
> No functional change.
>
> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implement=
ations")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-diff.c     |  4 ++--
>  tools/perf/util/addr2line.c   | 12 ++++++------
>  tools/perf/util/block-info.c  |  2 +-
>  tools/perf/util/libbfd.c      |  2 +-
>  tools/perf/util/symbol_conf.h |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 59bf1f72d12e..8a93e56f4a7e 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1353,7 +1353,7 @@ static int cycles_printf(struct hist_entry *he, str=
uct hist_entry *pair,
>         /*
>          * Avoid printing the warning "addr2line_init failed for ..."
>          */
> -       symbol_conf.disable_add2line_warn =3D true;
> +       symbol_conf.addr2line_disable_warn =3D true;
>
>         bi =3D block_he->block_info;
>
> @@ -1987,7 +1987,7 @@ int cmd_diff(int argc, const char **argv)
>
>         if (compute =3D=3D COMPUTE_STREAM) {
>                 symbol_conf.show_branchflag_count =3D true;
> -               symbol_conf.disable_add2line_warn =3D true;
> +               symbol_conf.addr2line_disable_warn =3D true;
>                 callchain_param.mode =3D CHAIN_FLAT;
>                 callchain_param.key =3D CCKEY_SRCLINE;
>                 callchain_param.branch_callstack =3D 1;
> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index 31c0391fffa3..e9f084db0802 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
> @@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(str=
uct child_process *a2l, con
>                         lines =3D 3;
>                         pr_debug3("Detected binutils addr2line style\n");
>                 } else {
> -                       if (!symbol_conf.disable_add2line_warn) {
> +                       if (!symbol_conf.addr2line_disable_warn) {
>                                 char *output =3D NULL;
>                                 size_t output_len;
>
> @@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         }
>
>         if (a2l =3D=3D NULL) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: addr2line_subprocess_init fail=
ed\n", __func__, dso_name);
>                 goto out;
>         }
> @@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         len =3D snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
>         written =3D len > 0 ? write(a2l->in, buf, len) : -1;
>         if (written !=3D len) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: could not send request\n", __f=
unc__, dso_name);
>                 goto out;
>         }
> @@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr,=
 /*first=3D*/true,
>                                       &record_function, &record_filename,=
 &record_line_nr)) {
>         case -1:
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: could not read first record\n"=
, __func__, dso_name);
>                 goto out;
>         case 0:
> @@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>                                               /*addr=3D*/1, /*first=3D*/t=
rue,
>                                               NULL, NULL, NULL)) {
>                 case -1:
> -                       if (!symbol_conf.disable_add2line_warn)
> +                       if (!symbol_conf.addr2line_disable_warn)
>                                 pr_warning("%s %s: could not read sentine=
l record\n",
>                                            __func__, dso_name);
>                         break;
> @@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>                         /* The sentinel as expected. */
>                         break;
>                 default:
> -                       if (!symbol_conf.disable_add2line_warn)
> +                       if (!symbol_conf.addr2line_disable_warn)
>                                 pr_warning("%s %s: unexpected record inst=
ead of sentinel",
>                                            __func__, dso_name);
>                         break;
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 649392bee7ed..8d3a9a661f26 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *fmt=
, struct perf_hpp *hpp,
>         char buf[128];
>         char *start_line, *end_line;
>
> -       symbol_conf.disable_add2line_warn =3D true;
> +       symbol_conf.addr2line_disable_warn =3D true;
>
>         start_line =3D map__srcline(he->ms.map, bi->sym->start + bi->star=
t,
>                                   he->ms.sym);
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 63ea3fb53e77..c1c12308cc12 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
>         }
>
>         if (a2l =3D=3D NULL) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("addr2line_init failed for %s\n", dso_=
name);
>                 return 0;
>         }
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 71bb17372a6c..ff229942fbb1 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -51,7 +51,7 @@ struct symbol_conf {
>                         report_block,
>                         report_individual_block,
>                         inline_name,
> -                       disable_add2line_warn,
> +                       addr2line_disable_warn,
>                         no_buildid_mmap2,
>                         guest_code,
>                         lazy_load_kernel_maps,
> --
> 2.53.0
>
