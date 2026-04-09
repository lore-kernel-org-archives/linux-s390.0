Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5E36A022
	for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2026 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702664; cv=pass; b=Y7pAQzVbJAgDByC2BdxOCXRl/h2xzjejkPUXGRYcfgec0bKGE6WMaqWCHb/IiGkMUdt+tmR5qyCX27fvJKcTYf9XWxi7ecMvRYOClUM+Poh3y3TTOUX99R3Qfvr3Ad3ahYCFhA2hp7cM4RgcqQ9NxkvDlD8oPEYAB41DSqmOASI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702664; c=relaxed/simple;
	bh=1Du6tFZ9igGBv4DCcY8bAzPfTgYS+0w//bxO90ypQnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8PNqVn3lwnxNcmlkGh/TmYuPfaq06x7PkVhURDpmJEm7fDOqnzJpmKuGeSb4KoF4kXUfpXyJyvLQqPP6wMrcwr3yCMsQHX7biS3rawEymoY2/qJNV8n45jyrvm3bTGxgaWdkv0WayMIjhuC3afZgOb6GiN00kN9ibUG2sseSLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTBRAXD; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTBRAXD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb38e86cf2so31315585a.1
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2026 19:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775702662; cv=none;
        d=google.com; s=arc-20240605;
        b=fyeGpXHO7EWE1bxZlXlrJ5FAYqR7IV1PdrUJMdbO4GNWcjXke25JZ+4vt4rO/E7LT1
         XEjOPOZCvJEl8aJ72A/FFlnmkDA6VZNoYCIe553/4toaj+Xz6DhK8D/nPiRmpEQMwhZK
         h+YYw+KvGG9xdHEJ9ry4Q2tR6rpo/ACE3CfM7hU2Y6GirNSnhVMjCrWTb2Kw6D1WnODA
         3jM5YGaxn5afNXa7Lz04ZCsuCZQPQNiUdAHSXMYJQcQ5084u1DkRbq7XVb6eLwnhXyAT
         10ftoAR54bPG6+ZZTZBbOdWgarxDw2xZxAftSzv0SjB0afDfgdyUJeJ3nwSZJbPad+05
         fsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        fh=FbKt08x6aX+Np1mSw8cnHmrVzyNQ+N1lyRErnB4c7YU=;
        b=DeLj8gbsqTRuUt4EVE7UtMJskIAJ/HcxjdkBAj8fWEDMVAok0yro43Xxs1Z9WufhFJ
         YaRYJWiZjxASnWOzJr07lNbXhiFCE4vVMDSLll+T8VHMG2qWXEc8J6m62LXYlsQfTHYG
         /j+AXiGDBgbrHeyWXqLm+mYQb8rCPJeOFlcBNXVnz2ZiV7X6VTswI95UlIHujinhVkvh
         NGP1Rz33hvHhgQENLiKbEyec3Yj0Gt6mesKVBLzXfZ9lbs/3B9afeICseecRiqVwVbJl
         lpdBNB0WhGo3li0DzchQD7fK2o3s7TGFxhzt1gNBf2306dF1hBIIAjgrJtrL1Knh0xy9
         iJfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775702662; x=1776307462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        b=TyTBRAXDd4rH9yqvVuH+prVyKuAAqmAz4Ah1vhXuu1x20LUXD26dUjNYJdoWacoOUz
         2gn1pRfH2SOOz6fGOULRrkPrA87bgDSCnUXCxp70wgNGo2jEz5yJR2vJXUnl+231WJdx
         VGTiOq+0ZiqdWFrgjxxiQk1iKliVc26E2CCaBrwbSO/fsRG/VHrOs0PL5XafQabwKmn1
         Z2AdsGD9UahXpc5emsh2xQ72hpLUxk4ZySnS1MCsx7ruzKyqRh70QIS+KCRK4m3zzJjE
         dLpcj988S9t0YcUOyhRZ+itQJ2rg3U4KJEYuN9cuiKaZSh5wlvju5P9G5Ck/1sZvDarR
         uEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775702662; x=1776307462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        b=Kgdm+WRxXzcEx13m6GyI0otFmEvU68iniTjvOA/OFNGVgOrKDK8as4POMhdZAVM1WU
         L1G+J2/1zTiNEzqA7fkRfvkQbmPl21BbIyXKRSkh+Zl02jjaIXS7IGlB1UC1sd+npqbC
         nGgCkQWDrGywyNWp+4Di6KRzyLVeWPI0L/aPwIeABcWSrZhbgXjmLcuIP5Wt9VRkl1nK
         Yi7+7nsCElO0ho6Qu15fb9ewDUszBsmiNlDsrXowVbly3vphwFfIsvEWcwpTtM1A6p74
         55/aK5NwDXY4d2LCOFbdXpaqOkUnxpX5HVPtGOHIkjo+5PeTQzmAY0gU0wBHgD86+rhp
         MAwg==
X-Forwarded-Encrypted: i=1; AJvYcCXGeAoKI6/rcZp9whjN9nbZ3/oFC//6U+IXKC4s25jHd57S2iCb0n+MxxtgMYJbqxLFNWSf0PJtAZno@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uCkX614tobnzBp4XlUQMYGlL7y/deH+X0lQHZ/wUlwK47FDL
	t00qiNx1bbx/Sc9DneGKM8RxQc49U2UkbMcgxY6WDgNY/CzIMMoXvPHrZ3+vTtAu0ngqwh93yWn
	OJEncxGR6sjR70BS6EDhzKYU0XiWmBfI=
X-Gm-Gg: AeBDiesNWz6ldSkpY7+1q90095Vliifl8k9kUjT8rLt5CX1v5rrBbv7y0CpfnuBJpWe
	ge4mY7+O1Q+LEnaat8NgRiHqZ9GtTh+N8H+mXFsWSk/21LSZnZs+kn6c1ktnwlVnqJrXqA3K4Xq
	R/Nx6Zl2dCPj48xSRjodiRYLOCHSrfT0h+3LxjGXPv+zBf3Lrg9dUvDgtnPV5kGImk5v+7mR6k0
	vMj/31PUU6Ud2jlZq19m9KHF/K2RaLLtWbL4HzRLcoWP8Say9eXjcGIPGBTo9ILSP/fCr1u8LS2
	9/3ZCQ==
X-Received: by 2002:a05:620a:2988:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-8d41e62f4a9mr3265255385a.57.1775702662334; Wed, 08 Apr 2026
 19:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408113143.1645091-1-tmricht@linux.ibm.com> <adcPeB5qc0M0K8Fw@google.com>
In-Reply-To: <adcPeB5qc0M0K8Fw@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 8 Apr 2026 19:44:10 -0700
X-Gm-Features: AQROBzDXtGknASP2wkzXWBfVH29fVRefhJPjjbxejEFqBfetRAxuoF_jRkjYAVo
Message-ID: <CAH0uvoiyqcR6+kqw2=6N7n8wCH1PA3P687vzSrQGVOeD0MDb9g@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Run test 126 exclusive
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung and Thomas,

On Wed, Apr 8, 2026 at 7:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 08, 2026 at 01:31:43PM +0200, Thomas Richter wrote:
> > V1 --> V2 Fixed commit message
> >
> > Running both tests cases 126 128 together causes the first test case
> > 126 to fail:
> >  # for i in $(seq 3); do ./perf test 126 128; done
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  #
>
> The test numbers can be different on other platforms, let's use the test
> names like below.
>
> >
> > Test case 126 fails because test case 128 runs concurrently as can
> > be observed using a ps -ef | grep perf output list on a different
> > window. Both do a perf trace command concurrently.
> > Make test case 'perf trace BTF general tests' exclusive.
> >
> > Output after:
> >  # for i in $(seq 3); do ./perf test 'perf trace BTF general tests' \
> >       'perf trace record and replay'; done
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  #
>
> I believe I have a fix for this problem but it's blocked by a BPF
> verifier issue.  I need to find time to work on it again..
>
> https://lore.kernel.org/linux-perf-users/20250814071754.193265-1-namhyung=
@kernel.org/
>
> Until then, I think it's ok to have this.

Agreed.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Howard Chu <howardchu95@gmail.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/t=
ests/shell/trace_btf_general.sh
> > index ef2da806be6b..7a94a5743924 100755
> > --- a/tools/perf/tests/shell/trace_btf_general.sh
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -1,5 +1,5 @@
> >  #!/bin/bash
> > -# perf trace BTF general tests
> > +# perf trace BTF general tests (exclusive)
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  err=3D0
> > --
> > 2.53.0
> >
