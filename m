Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096C2EBBBC
	for <linux-s390@vger.kernel.org>; Thu,  8 Jan 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895443; cv=pass; b=EN+SQlTZGy7EratFZVKJ2b823zYFgNLxJcEOC06QMsdp7aQQ1HSI7VY+T2CXY8qNo0H6tJQ7k9eW5IzEUIn3U6rZTzovZMgjdmQSBIyWUCCbW6eUVa22tF7UtHHR5veEsvHPxGAo+6Pjr3lUpAIKaDGY6nyQjwBLtGhx/P24cFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895443; c=relaxed/simple;
	bh=VZ2DjiQsZGuUb/ZcBUBBrG+r3ZRoipQdQv++S/T0Ikc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAjVYhelrId7sRhcOacd92mbOr2PL5kneXNUwXOwE6KuZB8sSkOP3Mz7fgZNGFCg6EBmN4baccMUh5kz968q9HlKFWJecixGtTDmCv8gT5WOB7NCRH13u3kPPH2mmHi/8pxArssaPsTTCeudR9ziK3MRfSqRV938PHiM2uM77OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofKH3H+Z; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofKH3H+Z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d06cfa93so5385ad.1
        for <linux-s390@vger.kernel.org>; Thu, 08 Jan 2026 10:04:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767895442; cv=none;
        d=google.com; s=arc-20240605;
        b=ZS4uvOgJs2Ja4nHoPiXTxfOdeemn370r6neQ6RchwjPQLgOtMaZnYsFkP0eVFKjwK5
         1tk7zH6veOSZVmQJDQk/SRe96ITU1MERSKhMv5ngofWsfkEeOjtFOZWnldqK0/v2aEij
         az2pfR4NuzJL53EX2cXvmRze9N3WIkIHkGoVKRm1IzXX8CfthpM0Nm9fF4o1MFuRHB4j
         VT455JMcRyfFttQ1ZSEJ3rDIsGlSnLwTdk/OvUBDkeoqmvTBglTuROMpi1OGdfowdMQW
         9P3lEGgN/n8RGLTumV9mBm3XLgpZhnDwxD7tbc6KqbNSsjhXmrckbJLdqztsFH7tysTW
         ytyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        fh=PLN7egwR+6i6eFWwmc4kz8bzonXf5cHEBVPx04Cw5IM=;
        b=jm2rAoUBP+zBKzXQB1jcZWbnYGlO0Hqq8COtoy99lWSXoW2/urvsGYCBEdeB+BcWFP
         PyX0LS32KH+Z6GBVH243N7WTYxAIh39rkaGaL6nFo3JI4TKMW+FSSycp/GDYBzEh4Khh
         G+Hkephu8j2dAekGmFaSP9kZ6MblQf8HbN/YpA1SKU0dvujQW5Wr4dXYLpJFzGNubN2q
         vUOvE8afX+E2TbXmLQG7GTwbBqL5wqcq0T715FFJH4OdXNNE4N96rIpV364McFpIzSSb
         LF8Y61NfOOScoJNVO6RxhNrFLopA8b0odZU5pn8Xp+uu5lS9f7jzV+ZVVi0pmnT+ya3u
         C02w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767895442; x=1768500242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        b=ofKH3H+ZNMX/WA+j2xtFRltaemwK25CTpLOyBQ5aENt1+WF+KCSx80yb47hKL3Yjdx
         oXnwgKC0koz7gAgOS49RHB4Y0JD3ziZPevRRTN+TZKE+FmPgd+WBlkFb0DZbcGrKdt14
         6dLQICDyY8W/8NHMaJhFtrtk/s8JwD0PRrMYykh9plm93jQiYPGbxeuG49eyI9vlSDG8
         lxe3jl0iBQ6auNT//YV7ePXkaeBwPh3CgXgjaN0j0pkHuc8yqo1pjFRJDCvkbBTBwe7l
         B+E1h3vD8xqb4QlamORvff6AWclAQCeqb8ItN6byWiF7Vb3gjsMxXEr8NlSTojCF0QF2
         7YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895442; x=1768500242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        b=b7Dz036pQ5ZhG7gQTBfwe6N3soL0chb7SVyClsFv/oIiETSUh6xNYlRccBkY+AwAi1
         LslXUtYJdo+D0cYHHV+UXoUFvzfjEOz2tei7K+Gn8PxuW06wY+fUt6NqISHB77yC9hqj
         PM0RJRo5kUK0+jr6Scl1QPGt70VKPu/x7ANsTtXSQA08z4mh5s16kRn0AXV11/nAXi78
         RTJTq05r+BLSPBk4gvUhACJSDXKNsXO/AvP5DXI6GSnyVGh/dgnY8X1W3AsM7QaxkIuM
         26a5bR+T0r7LpXV7xvImUGuhFjuKzmgqlwQkVz8dYHysg6sPT0wvV2k9v8SfuOLYhh+J
         eA1g==
X-Forwarded-Encrypted: i=1; AJvYcCVLyGbGrHrVLortc5kEVJKn2N03ZSawQ0x1IXmFY4RPpZVGI+k2BTM2sagKA/qd8FJt+Bf2+9aQEcGN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nEyEBkHYKCQIjXgoDP1JBx22faTLniAB4sG5yRv9e9OCTxT/
	ewzovfyMIelb0zuLUNlvV/puZy4CEhjYMAg4FohOId9PWbFrXfP/HYDKm6DKFEvj7dZuaLlgaIo
	iZx1Lbal4RjiUHgzhytgVpAZwSYpLa7/fpDM24Z9mDzr0COjTj2CFZhqM
X-Gm-Gg: AY/fxX6JnfWhCy9VEYZOVa/jORQhHNZCQgwcOpSi0dwPH+LY/AUKukcr8MFls1TO4zX
	+JkTaVfbULQDAt4pqeq4AAUc+9yO+Tx0J7TzEk38d92uiSWpuj3Ju2TfN+O2ADsHTT6QAK0D0kj
	gqNsUoyUh+AC0pJdKN+GAGO0cb3lY5kxRg+XntbkgvXDW/TfWJmZmZTaKWWmVqtzdmzbNEkupyI
	ieHFSTI8et0/Y7dB7O6VWT8GT+HG1Zs8FnjLtj7XBTCMuy3a98eJMX8E7/I4qKdGL6zTWq8zqkA
	q5XtuXjtamtRsJE2nkwtpxextJ8xGGsHItA=
X-Received: by 2002:a17:903:1666:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-2a409b56f30mr175475ad.15.1767895441406; Thu, 08 Jan 2026
 10:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107133216.2070400-1-tmricht@linux.ibm.com> <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
In-Reply-To: <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 10:03:49 -0800
X-Gm-Features: AQt7F2oJUhjubWBuwt_7LuW7SItCz3ByEUNTTrbbNopPlLHSpC1d6luidvPPvUM
Message-ID: <CAP-5=fUrqq5fH9DRtXM0KvYhG5LWzWMf0E4r+62=kAQgbzDHAA@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Fix test perf stat tests for virtualized machines
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:30=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 07/01/2026 1:32 pm, Thomas Richter wrote:
> > V1 --> V2: Add correct Fixes: tag, suggested by James Clark
> >
> > On s390 perf test 'perf stat tests', subtest test_hybrid fails
> > for z/VM systems.
> > The root cause is this statement:
> >
> >    $(perf stat -a -- sleep 0.1 2>&1 |\
> >                    grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)
> >
> > The perf stat output on a s390 z/VM system is
> >
> >   # perf stat -a -- sleep 0.1 2>&1
> >   Performance counter stats for 'system wide':
> >
> >         56      context-switches  #     46.3 cs/sec  cs_per_second
> >   1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
> >         12      cpu-migrations    #      9.9 migrations/sec ...
> >         81      page-faults       #     66.9 faults/sec ...
> >
> >         0.100891009 seconds time elapsed
> >
> > The grep command does not match any single line and exits with error
> > code 1. As the bash script is executed with set -e, it aborts with the
> > first error code being non-zero.
> >
> > Fix this and use wc -l to count matching lines instead of grep ... -c.
> >
> > Output before:
> >   # perf test 102
> >   102: perf stat tests                      : FAILED!
> >   #
> > Output after:
> >   # perf test 102
> >   102: perf stat tests                      : Ok
> >   #
> >
> > Fixes: bb6e7cb11d97c ("perf tools: Add fallback for exclude_guest")
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >   tools/perf/tests/shell/stat.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 0b2f0f88ca16..792a0b79f6b8 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -233,7 +233,7 @@ test_hybrid() {
> >     fi
> >
> >     # Run default Perf stat
> > -  cycles_events=3D$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cyc=
les/[uH]*|  cpu-cycles[:uH]*  " -c)
> > +  cycles_events=3D$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cyc=
les/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
> >
> >     # The expectation is that default output will have a cycles events =
on each
> >     # hybrid PMU. In situations with no cycles PMU events, like virtual=
ized, this
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
