Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B621D3D2
	for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301501; cv=none; b=lQdExKwexKuukw+nY+WOY0hwzWbzsCeESLMD7azyOBNJWPOE9erHB0/j6WkqQDHzpQetmYSbdG3iQ2fNdZPVvU2lWh1FGoeDFCArPd5rZkQhi0s5pfpIbpIguPpq8iVGGqRe23qMTQgjj7Wzd21ClTSG9jHMbGJH4jUP3MuLvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301501; c=relaxed/simple;
	bh=3SSJe22EI0/zwdN3+ptsJEa9SF2HCC8v9PBFh6uZZj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaYcGb+qiIw5UQMh7wW4uB+zq7SrBFhX+dS2UsrWof5l4/PtcJbE7sSXPy79FYzEcXUQxWc8UzHBHebmpW89N5C9EExUfwlQ3tro73L4iWIvfzqtGivypehfWyPvBRi8CAhnasZ74MTja/GlYA7lbZoU4ZZLgdYIz0qeJmeQy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QqvQG6o; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QqvQG6o"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df371e1d29so1825ab.0
        for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301498; x=1751906298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqFV3vdLcpqk0WIu5m/78ZKQUMwnbH0yFrWHYwtacwc=;
        b=4QqvQG6oz6GmA806y9A8338eG8GtOIJRkEteF5+t/tfJOYz+qamcglr1r70pD62q5i
         f0ZR8hGPB1BzP1gj0ofaBSpR5DCrEcG3xXgIVwrUZXN6OfzJEh8pM64pWsrH9kfqzckD
         CKbKgq/EmCBeUVWX05WCDnlSDGCWNbKHjLOA68IhvKf2VfleqsCcDuAUJ6taEEg+JQ3u
         NgHd4GxQslbAIRULD3nrrUv3YUsDizBgbSb/weTlKzy4iHtYReBzVAckBQWqOeaO0ZWu
         fMdeJQy47oxqXTf9yRZ3AcUH1nnzvxK+LMtF9k0gpTbk0F7btSRoYhuupn3EPWE3ZkML
         gxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301498; x=1751906298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqFV3vdLcpqk0WIu5m/78ZKQUMwnbH0yFrWHYwtacwc=;
        b=QAof/Oak6ln+vMEBpA0+HYQw/EP7/OTongtpW/F/8qw0PAbrpHP+jWuNIUAUpfgLUC
         3bON2ZsG5szfkEInjb8LcCOYW4qx42CjzqztbWiSajCaoYsqaGn/atHz45wt/6mYTC+Q
         ZI3GwXctZxhws9QFlm6s3V+ZqUaEGEfsoLJI4/xUFSjaG+gWW5iIWhVqvTZU97reWSgt
         ouvJ8QOnRVwX8ViyyP8s/y4bgsrhX9l3mH24vYBLcl1hXCUZQWXUeM/UT3FTL6veu09d
         jK5Iiu+qhYgGTqmd9fD4N5OvUe4PFwXVPXdtZb6oOxBSzmxNi0wHb6u3Si+NGH8LQpo+
         e5MA==
X-Forwarded-Encrypted: i=1; AJvYcCVmcg14+9j7Vz+Fmd+/7LmLSPr/JvlcL/odsuPNVRsckoSXdOAnNKyG+gOHeaBmsOqn8zLJIBnt3OV6@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0IUlonHakCsJ7C7mbPXFYY0RapBCHn8b4WjtNkFbyMqacrnL
	d8XuO/u1wKSnZV7gSla9zF8nO8G7OyqI+gPALoVkcp8qTvooZMH+ltmCMuSrE36kughYpP1DKGN
	87eo9J/C0sbH4de4fy7LfRvTzJIJZjZRCCdKOvaJC
X-Gm-Gg: ASbGncvlUG1wyricIHTN9zgcaAk/SCK3LuYWvd7hyL53XoSJag7hTvW1SoEY2x82J9I
	5MGxBSAkMrwtXNHxbg4r87B8fR9vFUbCKpEknzcx7fToe0rX3v7eW7oHvOjN8RotagwmyHu2dOx
	S4xDtBgJIuutxfJSPEdfDGgQ9ohYBkOo5dNOc5SO0+0bLyyPG/oGBmsQdYhSP3WUQctxrNTWA=
X-Google-Smtp-Source: AGHT+IEV4ws06I3PBKCP3xfx6fJYQY/7epzwWRJpF5/I1Oop+DfcLvxUlkyWMCvWvFPEidAUpvsHHwmLeU2IN8EN8pY=
X-Received: by 2002:a05:6e02:2281:b0:3df:16a1:6874 with SMTP id
 e9e14a558f8ab-3df56d202d8mr6648955ab.29.1751301497806; Mon, 30 Jun 2025
 09:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630091613.3061664-1-tmricht@linux.ibm.com>
 <CAP-5=fWGiitgromQRTxEsU3cY99gFAU6WPLnmiS7-Q8vQNGbYw@mail.gmail.com> <aGK2xQNQOd1WoDVk@google.com>
In-Reply-To: <aGK2xQNQOd1WoDVk@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 09:38:06 -0700
X-Gm-Features: Ac12FXyb9pIGay8KgAhrAvwHn4i8z7MPif2V10yaHDvHwigTzIW6u1Pg_N--RW0
Message-ID: <CAP-5=fWb=7qnAcE8i5Kv8yTnmdFOzX2jPvR88bmzqRtGhSbDzQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: perf header test fails on s390
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 9:09=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jun 30, 2025 at 08:42:01AM -0700, Ian Rogers wrote:
> > On Mon, Jun 30, 2025 at 2:16=E2=80=AFAM Thomas Richter <tmricht@linux.i=
bm.com> wrote:
> > >
> > > commit 2d584688643fa ("perf test: Add header shell test")
> > > introduced a new test case for perf header. It fails on s390
> > > because call graph option -g is not supported on s390.
> > > Also the option --call-graph dwarf is only supported for
> > > the event cpu-clock.
> > >
> > > Remove this option and the test succeeds.
> > >
> > > Output after:
> > >  # ./perf test 76
> > >  76: perf header tests                           : Ok
> > >
> > > Fixes: 2d584688643fa ("perf test: Add header shell test")
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > > Cc: Ian Rogers <irogers@google.com>
> >
> > Thanks Thomas! Given the s390 restriction to require dwarf, should we
> > switch the default "-g" meaning on s390 to mean use dwarf? James Clark
> > proposed this previously. It doesn't affect the change here so:
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Unrelated but I found this test is failing on my machine.
>
>   $ ./perf test -v header
>   --- start ---
>   test child forked, pid 42799
>   Test perf header file
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.182 MB /tmp/__perf_test_header.perf=
.data.vvFUf (4114 samples) ]
>   Test perf header file [Done]
>   Test perf header pipe
>   Failed to find expect hostname in output
>   Failed to find expect os release in output
>   Failed to find expect arch in output
>   Failed to find expect cpuid in output
>   Failed to find expect nrcpus in output
>   Failed to find expect event in output
>   Failed to find expect cmdline in output
>   Failed to find expect perf version in output
>   Failed to find expect sibling (cores|dies|threads) in output
>   Failed to find expect sibling threads in output
>   Failed to find expect total memory in output
>   Test perf header pipe [Done]
>   ---- end(-1) ----
>    83: perf header tests                                               : =
FAILED!
>
> The pipe mode doesn't have the headers.
>
>   $ ./perf record -o- -g -- ./perf test -w noploop | ./perf report -i- -I=
 --header-only
>   # =3D=3D=3D=3D=3D=3D=3D=3D
>   # captured on    : Mon Jun 30 09:02:09 2025
>   # header version : 1
>   # data offset    : 0
>   # data size      : 0
>   # feat offset    : 0
>   # =3D=3D=3D=3D=3D=3D=3D=3D
>   #

Strange, permissions? I see:

```
$ /tmp/perf/perf record -o- -g -- /tmp/perf/perf test -w noploop |
/tmp/perf/perf report -i- -I --header-only
# =3D=3D=3D=3D=3D=3D=3D=3D
# captured on    : Mon Jun 30 09:35:21 2025
# header version : 1
# data offset    : 0
# data size      : 0
# feat offset    : 0
# =3D=3D=3D=3D=3D=3D=3D=3D
#
# hostname : ...
# os release : ...
# perf version : 6.16.rc3.g8f2bc25ec32d
# arch : x86_64
etc.
```

Thanks,
Ian
