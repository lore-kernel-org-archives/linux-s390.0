Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A7426D05
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979950; cv=pass; b=MqFCf5hf4hQHFt0qTcdMk845qSynSmBC3JJdg1N0nDLYRDq1IT7ul3eWfIV7FLroM+pZuuSCh1KShGirLco9uNOOe+0VE5bn2zKWTIXrQurzmK06g2yTUuSwKYqscClFfgV2fgcqPRPj/j921YIubp6HJPrq/1aN//Dk6nnhneQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979950; c=relaxed/simple;
	bh=wJYqa8CNOmRXNHFacU1Cl+9w4sAaAKxCbAa8Jd0yOLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVjWeRRoNj3POBnFv5M0ANH1CwnpdfI1kOpuhYT6h/gZKghtP13T0Xb6QTTWPAMXhA1IDwUQcRPUs0/ck+hBOkS5KGjBm3s/pChFqPAe4MJXLljz8HVqC47AqHQwGXGQ3q6oz7YU0FW/O9sYetJJm8FQuimYGrNzsdgEum+rw1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsR2b9Xr; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsR2b9Xr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0c12be0ecso134725ad.0
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 10:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774979947; cv=none;
        d=google.com; s=arc-20240605;
        b=dGOBs8gtMxprTP/2UO5yIB4gMVq40LIZkDAYEC4v1yq+RI0qOYihLwdHA7hgQVhrtp
         +fbm2FsgLh53aSWM3BBO/FkT+CbQVC02EjB3725ojsqDvs1ynO67PfoTcF9e/Of9JatF
         Zr4ELbvn5tTSMv2Wy/KQwyVYGmCREWLrUuuCIEIJaXnNVlqKqyORHXgw7NNIZGGF1PxO
         e0+2hBhgNKUP8HWB3n0JHZLQnKTDYExs7gkpLD+3hdv/k094vCfBz6+nHZBz+ipWQjPU
         C9Y0imNbPHw8d603h8KzPVp6/B1FHLFu6vp7EFn0+1FrMwDx6SYXtH6+i4bayolzU2lv
         1ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIpgbLDZwM+3B1z1bVKHYcqhZBXlMkODpOifxw3XbSE=;
        fh=sBDV8voT4O51ILo8V+S/PRLsZ1SwwfsFl0ILUhiP4GY=;
        b=WEr3zwgSLpd/Zy2k+KnpefBqgkucKjRdwPpldRkIBRRL82GrjAcm4pJ1C9CWvmM2qO
         B9SzpxU4nymnDHREgWBTMUYeonMsJ+6cPlWfI9k9vL6FSkX+3cAgfOU1p6Foq/9MZjeT
         MvXcMkNbuf+XjO1udzHnLSylMHNoOSPN+s4wU4W4qC1Scy5oQLf0BgdS8P5THKkSpPyO
         /wC+nKojhySguPE7kEoWDAZu479auS478fGDjCH5Pj/xyJI7wtEr4yoO+f0rgCTqj6Ti
         dNGQSoJwXqqNzUb0yN5T48fajDJX2vih7WJJvRn30uMA2EBKAdiQU8V/gYvMsaLtJiDA
         6NWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774979947; x=1775584747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIpgbLDZwM+3B1z1bVKHYcqhZBXlMkODpOifxw3XbSE=;
        b=vsR2b9XrrUGYpL8gWqxplhcYoK4KSyWbbMo7iSf6V/CIkjuHmhguYdVZ8GwQXmjj6G
         VMTv3KxFfxvCRWPA9TLkkBcPyTV8LP0Of5qoZx46z+gD8vafGMdLziNFmy6JGU4//Q49
         RZTCBlhCYJYoodrd96nnQi5Dyc9JIF3iySh/JeGsL1XHv8m00mJeuGbvGosbgfo6TSmB
         1XHbm8bfqvujPkFEV4FYLqvwJ95L7KrcS/LwsdS81kewlv4c7BE3VLD52YLSEDPXf8uw
         yx4MdpSohZmS5aN5bwhcgcIJGXqHgEC3DkeHENX4D41juGlHSVxf51Qplekd6Iuul31M
         LvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979947; x=1775584747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIpgbLDZwM+3B1z1bVKHYcqhZBXlMkODpOifxw3XbSE=;
        b=OPtIRZYYTAV6VL0VuP/2h8MNvHo8zq//lXZk0m/NJ8kVxt/xC7EzH92XNvNtNMJrDZ
         DoMaft3DXdIKDG6x6sJSOXeM9CdWSSdDgb2w/In2istARMLRjCGtQF+k71/uMArJmGlj
         JGyO9kwyVbmq7wTXuBgcamZFppSucMam1Dixm22UHgWX8dIPspxgGZBd62i3dNfNSngm
         Pdc6oe8I1gPgrxIOngqpS67TtA/JT91OlRBWPB3wU4lSQjwCwxtfyPdC+Vsjuaaiul1C
         lgRUSEJJakSMdApTeCjL7qITPq4AjV16decW2JyPg49OC3QXRp3ZgGAiAjaWuXtGbXCj
         3Rxg==
X-Forwarded-Encrypted: i=1; AJvYcCUY7raZBbFbBx/zJHykTdGKknzC45tl+oOhYEc4bqos5O5sWHIKxhP4woN0FxeoyTEmMw8DRVF4nCsR@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMCSA9njiMebE8i9e9QF4G4S+sbmx5nNRkxsq2d5H6egpiBcY
	kORpU0m9IsN++KBItH8zpB+0tFDvpFMQqgQXb02RCfoknspEfSzTWjV1aiooHk8NMe/HknuH11m
	pPtoGIKFKGtZtDRt8iEMSw3GL3VbPV8SJRhAiCwhc
X-Gm-Gg: ATEYQzyChjIq0IDHw7Vm0Rfr0EGJCHL/xJOAL4/2/nZ9T1XS7VBBTYLHDMF6RzPt+2p
	Hgv3yg91VEbc8adf8j1hfh63IC5VJ3DQkKm2nXDVuqEGYi2n0lPZq81ZBqPswZ3wogxxU5CTZYs
	5FEe4sGKJuSMFyY8CPZKagEoAPZnWUKapX3XQ9r3hge4ZSOjxiJFFREc++7Qfp/8mcIJK2GbSob
	Tr0aNEAxettVrOOq2WiYdodRQedzvmYFtJ5AZusNy4MZ7CJVCC/zNdM1Bjx1ZbK4JScRalF2jhE
	/uWi3rNVOoPiY/8OCtpIexgF445sYvLzzP0o4g==
X-Received: by 2002:a17:902:ebc6:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b268f14089mr604485ad.15.1774979946544; Tue, 31 Mar 2026
 10:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com> <20260327060033.2294469-1-irogers@google.com>
 <act2RNT6-3Kx_h5p@google.com>
In-Reply-To: <act2RNT6-3Kx_h5p@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 10:58:55 -0700
X-Gm-Features: AQROBzBv7ZLGEShLdKZs6LMir1nXxpqxTU77_IYBxmII6si7mW_4LE7aZWATA0c
Message-ID: <CAP-5=fX12Kmd26bq4xRjx50WzmuuMszEzuVY=g6y7-hkPd8Wzg@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests task-analyzer: Write test files to tmpdir
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:22=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I'm curious why this patch is in the idle symbol thread.

I'll separate it, I was gathering fixes. Same branch has the BPF
counters test fix in it:
https://lore.kernel.org/lkml/20260325171653.1091337-1-irogers@google.com/

> On Thu, Mar 26, 2026 at 11:00:33PM -0700, Ian Rogers wrote:
> > Writing to the test output files in the current working directory can
> > fail in various contexts such as continual test. Other tests write to
> > a mktemp-ed file, make the "perf script task-analyszer tests" follow
> > this convention too. Currently this isn't possible for the perf.data
> > file due to a lack of perf script support, add a variable for when
> > this support is available.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/test_task_analyzer.sh | 38 +++++++++++---------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/=
tests/shell/test_task_analyzer.sh
> > index e194fcf61df3..b1a6a7e017e4 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -3,6 +3,11 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  tmpdir=3D$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
> > +# TODO: perf script report only supports input from the CWD perf.data =
file, make
> > +# it support input from any file.
> > +perfdata=3D"perf.data"
> > +csv=3D"$tmpdir/csv"
> > +csvsummary=3D"$tmpdir/csvsummary"
> >  err=3D0
> >
> >  # set PERF_EXEC_PATH to find scripts in the source directory
> > @@ -15,11 +20,10 @@ fi
> >  export ASAN_OPTIONS=3Ddetect_leaks=3D0
> >
> >  cleanup() {
> > -  rm -f perf.data
> > -  rm -f perf.data.old
> > -  rm -f csv
> > -  rm -f csvsummary
> > +  rm -f "${perfdata}"
> > +  rm -f "${perfdata}".old
> >    rm -rf "$tmpdir"
> > +
> >    trap - exit term int
> >  }
> >
> > @@ -61,7 +65,7 @@ skip_no_probe_record_support() {
> >
> >  prepare_perf_data() {
> >       # 1s should be sufficient to catch at least some switches
> > -     perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
> > +     perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 =
> /dev/null 2>&1
> >       # check if perf data file got created in above step.
> >       if [ ! -e "perf.data" ]; then
> >               printf "FAIL: perf record failed to create \"perf.data\" =
\n"
>
> Please update this part too.

Done.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > @@ -130,28 +134,28 @@ test_extended_times_summary_ns() {
> >  }
> >
> >  test_csv() {
> > -     perf script report task-analyzer --csv csv > /dev/null
> > -     check_exec_0 "perf script report task-analyzer --csv csv"
> > -     find_str_or_fail "Comm;" csv "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv "${csv}" > /dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv ${csv}"
> > +     find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csv_extended_times() {
> > -     perf script report task-analyzer --csv csv --extended-times > /de=
v/null
> > -     check_exec_0 "perf script report task-analyzer --csv csv --extend=
ed-times"
> > -     find_str_or_fail "Out-Out;" csv "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv "${csv}" --extended-times =
> /dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv ${csv} --ext=
ended-times"
> > +     find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csvsummary() {
> > -     perf script report task-analyzer --csv-summary csvsummary > /dev/=
null
> > -     check_exec_0 "perf script report task-analyzer --csv-summary csvs=
ummary"
> > -     find_str_or_fail "Comm;" csvsummary "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv-summary "${csvsummary}" > =
/dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv-summary ${cs=
vsummary}"
> > +     find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csvsummary_extended() {
> > -     perf script report task-analyzer --csv-summary csvsummary --summa=
ry-extended \
> > +     perf script report task-analyzer --csv-summary "${csvsummary}" --=
summary-extended \
> >       >/dev/null
> > -     check_exec_0 "perf script report task-analyzer --csv-summary csvs=
ummary --summary-extended"
> > -     find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
> > +     check_exec_0 "perf script report task-analyzer --csv-summary ${cs=
vsummary} --summary-extended"
> > +     find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
> >  }
> >
> >  skip_no_probe_record_support
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
