Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F336A02B
	for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012079; cv=pass; b=NK9Sq8rtWMD6+z/jmAeV3TMYhSb+sEEQ88NM6NzOHEr65+x/TV/CTjtv/Q/c1P16NiV+CK4BMyFQPUlIE3oAw04ktWcw54t1Pbi39FW2BYgrSo0e9YyQpv+08BaP/12OdVmXIDarCVcEcnLzhY1mdAAyPnkEWE61qrqzcl2HMYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012079; c=relaxed/simple;
	bh=he6k1QrRKlKP5zMoRbbMTSbEndL4HL80WArN9x0v9pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGomBt8js0D2lbpn+a5Kxuj2ONGLaN6CRRF2PsObeDgNqoL0nhGXElknaDv7cRqoGWuJ2yPGh2kT9j94qbD8bsahkRFFMvYjjI6L6GBspYzJ5NhUn9r9R/AiIewV53uPggm046ZMxxdYAuWG7qW/2I90tASo+ZCtEFQ7FDuvo4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRntH0cm; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRntH0cm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a76b39587aso102415ad.0
        for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 08:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012074; cv=none;
        d=google.com; s=arc-20240605;
        b=cy1ZkhMkgpTIDdMAO/bIP2hBW/WDmx7kvJ1QWgRzI8naGx38Vc8ggiKh7JLiXjnFdu
         q7WaCMkimeurmnle4VctH8w+mEVfc8e9wORvafBoUyETNXFlP4S0qaOvEucs0bK6pEaL
         NuXRSpvUkUv4GYJrKM+Jhp6ibg4KQYJjmqvRDES2KL9kCXdx1pFSWObErgWHWxXXy/i9
         lf7AkVWWUu7yPW8eHL5KATMgrk2Q/3wGgBkxyFVpdWbhy4dTCgbeAyV2Wvgnyz1Z5g1o
         mRXWZe7IUAYmpEaWxkA3YPCyFst3hRBizQTsdxoj753ETf9zkdC8q/YefdR7bi0gtiwO
         TjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        fh=Uhq5uIrYFtNt8wlUDUqIr0NyHZ+047W0Mtd/Sd3L3GI=;
        b=dJSy8mSVc+73y30adwtRMM8eaHFlniOJmbcrLsQ/8bgibLPTu8LHfv2mBu+tf+70IW
         P+t74IzF+7Nl7uFOHavTZFZO3mBmQqllM8bKLnIOe9tGS0JJZHWQ1e7f+AXwS/haY5jL
         JYiYx1cye07Q8a5+PX/WDmmW7c7AhhLHzPEGuc/9Lw9eVV3vXQLW3H0BoPWzqOQTZojw
         bmUFYzJJSVLyilLG+wQX16m/Q2noFL74aa4BpWsiejiD1cc51f4xxzFZzi6GHll7k6tG
         OFLzFzkRKs6MZXzbgoBNBteZjByhtIGBYZJTQP1BrfUohBbpCdgJGLrcgntch8ySczQJ
         8g7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012074; x=1769616874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        b=pRntH0cmjndtLj+rYi60YHjDBG29sSppKmY/bKPfC7WO0kbD3tQKL4uc6muujMelkK
         OD6RXY3XQH+GP6aziepgrDG96Hz7rkS69E/67NhRP40HWLiiFglOwHxM+NzCz/jVZScX
         3ffBqoD4X9vzM5gi+RoxYwVjLxusDDukCgCLFAJOlD0nSAMBFnqlRppmDALemAMZEWPH
         /AGEsIPDOS0CiqJy4sviX/zxBuHJfr1VvTYkcSC/Ffazud5HspBbhDcalsXV/X8njaeI
         HgN6G+DOXGHXT8ynisJ8XIb6eeg3tLNn1r/Ycc1LtMcUbAKL7zn38whAS0XFjwMCuKDE
         y6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012074; x=1769616874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        b=RI8Yn9KMYK4ak2MgOCdJpDgZZROKB9+LL4ToP4oKo+bJ83K15R3ExQVrC+LkFOoIs8
         PASiWbUuDOvLMn7gnGm/O8D76V8Ka7dquEehFMTylvkVZUqI4YCys9Z6R25y2Bgv3B1H
         jD2rqvwhW6ErMYdkdEltrewMNR9DrkAM2xZeh5GKD4G2mYKdC6UV9T57dfwpc4QLl2r+
         ureHlnSW78nG0PcM4n6c8/fx2JZviuk5/8FJ8B+CCNBHuZkCbVlRCe/HFJKNSTyiMPtf
         QqoFPq5UMGQempApniG/HthmRdZvaHDqowAbLmABNkAgoE2o31s071uyVsgi4BPfqbTM
         GQbw==
X-Forwarded-Encrypted: i=1; AJvYcCUi3dhnKQjtCrYTnBDiihBfq7Yeb+Vv/tGJre+8wf3Zow5N/EqSBitTCH4SkghBzSDVtdFxdMCLXeBp@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvSgnNjhDAbci4SWKNszju+5v4xaQPv4LIwXky5aCnRNR4a1c
	dU+rTPlAmAvkWJUkUBZfJlVrPuybLJMi5Fb///fqFXHObId9bRLv7I5RfY+RA7OOiYe26XzvuZ3
	MeOYoJJdbJ4JgIhIUx2GSckAwms+MB79JDpsP9m73
X-Gm-Gg: AZuq6aK35Y3JpBc60ewk+fxJl29yXoJopwRDi3WBRBvzBETaDDaiFiVZ2coO4tgrKrn
	UzGi+lS1Gz2DSKH/vRWtBPEWB1LZ6EirqduL+z57D6gLcDHlWf3vEBr7kKMx2kkH2rTWVuZ+pLv
	fSbJcY6176YPGZ0B8bt1aol2Gth+tQ/4SdtnnYN2kbePZuqtVDyj65hEsfJsGN94FaGKJ83ieNH
	ZFxX2kwWAXSvz0qCUTUGiqNVYf7EBuoe+jRPx0+Wbl6qyr/D6ySQ5IVbDnXVb8HbK919gQ5/Gjx
	D7QFTSW/d3T03/4wCJrjwcvJEQ==
X-Received: by 2002:a17:903:245:b0:2a7:7f07:340e with SMTP id
 d9443c01a7336-2a79a3b948cmr3243715ad.4.1769012074058; Wed, 21 Jan 2026
 08:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121082402.2311962-1-tmricht@linux.ibm.com> <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
In-Reply-To: <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 08:14:22 -0800
X-Gm-Features: AZwV_Qjrczmou1z4XeWYuSuAhLwzJxk3rivR5zSTPtKkcNs9xW0clGNshOXeuYE
Message-ID: <CAP-5=fWjzR0WqD7RyDE66ChUQnt4_qwauEPiDsrhtL02u_zo4A@mail.gmail.com>
Subject: Re: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd
 names fails
To: Thomas Richter <tmricht@linux.ibm.com>, "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 8:12=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jan 21, 2026 at 12:24=E2=80=AFAM Thomas Richter <tmricht@linux.ib=
m.com> wrote:
> >
> > V1 --> V2: Add linux next repository
> >            s/needed/unneeded/ in commit message
> >
> > The perf test case 'libsubcmd help tests', subtest
> > 'Exclude disjoint subcmd names' fails all the time.
> >
> > Root case is a special case of sorted input which the exclude_cmds()
> > in libsubcmd can not handle. Assume the following inputs:
> > cmds =3D { X, Y, Z } and excludes =3D { A, B }.
> >
> > This leads to
> >  ci  cj  ei   cmds-name  excludes
> >  ----------|--------------------
> >  0   0   0 |     X         A       :    cmp > 0, ei++
> >  0   0   1 |     X         B       :    cmp > 0, ei++
> >
> > At this point, the loop is terminated due to ei =3D=3D excludes->cnt.
> > The for-loop now checks for trailing names which had to be deleted.
> > But the first entry points to a name: cmds->names[0].name =3D=3D "X"
> > and this is a valid entry.
> >
> > This is the case when all commands listed in excludes are less than
> > all commands listed in cmds.
> > Only check for existing names when cmds list was changed, that is ci !=
=3D cj.
> >
> > Also remove an unneeded if (cmp > 0).
> >
> > -
> > Output before:
> >  # ./perf test -F 68
> >  68.1: Load subcmd names                           : Ok
> >  68.2: Uniquify subcmd names                       : Ok
> >  68.3: Exclude duplicate subcmd names              : Ok
> >  perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL=
' \
> >         failed.
> >  Aborted                    ./perf test -F 68
> >
> > Output after:
> >  # ./perf test -F 68
> >  68.1: Load subcmd names                           : Ok
> >  68.2: Uniquify subcmd names                       : Ok
> >  68.3: Exclude duplicate subcmd names              : Ok
> >  68.4: Exclude disjoint subcmd names               : Ok
> >
> > Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cm=
d()")
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Thanks Thomas!
>
> I tried to apply this on a perf-tools-next tree but it fails. Looking
> into the git logs I see on linux-next:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/l=
og/tools/lib/subcmd/help.c
> the last patch is:
> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empt=
y
> In perf-tools-next:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/log/tools/lib/subcmd/help.c?h=3Dtmp.perf-tools-next
> I see:
> 8 days libsubcmd: Fix null intersection case in exclude_cmds()
> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empt=
y
>
> The test I wrote was to give coverage for  Sri Jayaramappa's fix:
> https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com
>
> I wonder if we've put the test into linux-next but not Sri's fix, well
> that's what it looks like to me.
>
> Now that we have both your fix and Sri's fix, and they differ :-) I'm
> wondering how to resolve the differences.

Sorry, resending as I got Sri's email address wrong.
Ian

> Thanks,
> Ian
>
> > ---
> >  tools/lib/subcmd/help.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> > index ddaeb4eb3e24..1ce5fe507687 100644
> > --- a/tools/lib/subcmd/help.c
> > +++ b/tools/lib/subcmd/help.c
> > @@ -93,19 +93,19 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
> >                         zfree(&cmds->names[ci]);
> >                         ci++;
> >                         ei++;
> > -               } else if (cmp > 0) {
> > +               } else {
> >                         ei++;
> >                 }
> >         }
> > -       if (ci !=3D cj) {
> > +       if (ci !=3D cj) {         /* Verify cmds list only if it change=
d */
> >                 while (ci < cmds->cnt) {
> >                         cmds->names[cj++] =3D cmds->names[ci];
> >                         cmds->names[ci++] =3D NULL;
> >                 }
> > +               for (ci =3D cj; ci < cmds->cnt; ci++)
> > +                       assert(!cmds->names[ci]);
> > +               cmds->cnt =3D cj;
> >         }
> > -       for (ci =3D cj; ci < cmds->cnt; ci++)
> > -               assert(cmds->names[ci] =3D=3D NULL);
> > -       cmds->cnt =3D cj;
> >  }
> >
> >  static void get_term_dimensions(struct winsize *ws)
> > --
> > 2.52.0
> >
