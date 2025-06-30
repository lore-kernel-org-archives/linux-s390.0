Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5D28CF44
	for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298137; cv=none; b=aFAadBMwnN9L8tDAnqol50nYNsOLjnYZ2SlgsOHqN0IjIoXuIIRWdbyRrSyOZzS1e42yc45qMXSUOtAWLrzj995ahooXHlJFl7OHzjz8HxEeyB/+U+liqAHC5reB6Yzav5hrpIoOtq5r0fmo/Xl5zTy4WdyORNmqNjt/OHRgwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298137; c=relaxed/simple;
	bh=4OwvVcEXN+UWNsFrOml/tG+qm85cKbHt02d2ltcoNYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blRl0E7a4HbWbNwW0bBGU3K0UzlRm31qcmU5e8ZPBfJp24rsEVXjX06hewza4rya+v7bkP7scm9Byag3qcjtvEWdluIocgjA4jWkLoIt2mmfRkWQNWOhyv+aBUyvdiDl1aKyCS+gB2mT6AZtqfcu90Z7fR60MqKFyYpglhQg2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9f+3YiX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9f+3YiX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so489995ab.0
        for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751298135; x=1751902935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4GR1A3VoneV+NpZxt5J9kbL5U526gB3aS4wwAL+DY4=;
        b=z9f+3YiXNUR2dTC6Nt7PO2pgvJhxMZeL6pjgzwdN+07izTpZr3cYKnzbpMQEDXShGu
         EWV5Q3AXNsxhwtMLZIAS83qoUvfSeOnyZHni+eIC6NZlfZTYOYJRCFzFb18QiTEh/YCi
         3fsvypAzjupewu7ZPvCEKaBsCSyHdTdTSf6Fb5Pc7iP66moTg9h/sh7/KwWYuYTOmEbR
         L69cpPpbna4PBnZOAjsrwky9cNFvAYmEsbJhoUW5UTrrHTbQHGwvaX4veRHVuX3d+C2F
         caFVu9fDzf0ZZoQMEVLBpAPzsVHJu3pUXmtHHZ/tXez62GnY3PagLHcG03oFD2+KzwAn
         Skfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298135; x=1751902935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4GR1A3VoneV+NpZxt5J9kbL5U526gB3aS4wwAL+DY4=;
        b=VQh8MiNmgrW2qzogsMoa0/0XugUBaGEbkC+/ul/2yZSapMieQXNa1XKyASYY0izpf4
         ww8cYJxHArViMprQxdBVeCqiMgMnAdBYg8LRtvZB6AJEMrXaUp0GdvPfbSImzxxRVgGf
         ggqeJfsI36+6yQA4DRCYlARgA4q71o+XF307mvPkePPYSFhncV64omzjuGk8lS9nJf91
         KYmoP+2vi5LaAltJM9UY50Vb7osRXWJEIP+Ls4jZfwvKdgGr2wzfuQnBzk8oEA+LON00
         sN0fKpHQzbwnA7Hnx8urW47Hu6Qr+Un7ZuLpx4mVADHij82C/P81FVQsNZp9ioTHGmFn
         lg+A==
X-Forwarded-Encrypted: i=1; AJvYcCWT86AcXijP1pFrurQ+/5Mxv24t5sL7b6r/ROqDrQfRN+q+IXnrnOdalTZzIiV6Rg5IdW8dv748PiaV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1LBG63z+RlIKlesEsF2VLdDqn19GLMWIc4jl7GZWVEQ2rK2t
	l5ftX9J6EGMIdvtIavdPcF/zELjspmH6NMpT8OpygFwjjqoYBVnZatsiYZXtRYfMJAq/YwCDTOl
	VMEbw8bsCOTvGHZsebepdZpnah2ls5gBfPEV0T72+
X-Gm-Gg: ASbGncuxJWEcChQFBrKCQol2m+SoCreZ1zPhYFD5E11Ur2YFO9Clpq1yCa/NTTzBz+u
	ozJqNuDRdYD5JltEKA7LEPms9Bl9yC7uBDspYUiJcSLAlnm1DLy8NcezLhBq95Mql30SfXJRoXU
	GAHsZN0+MkoWQfIBrSDdAdiuFxBOMs3kuORiNUAtJU3HRBsgK+j6dx/dtw8i3DK841NzbDbJCkc
	jW090wnFQ==
X-Google-Smtp-Source: AGHT+IHFpDWiLyNLndY1f7Cyt5ObXxyBXFCg52HYgsqNuPCsfO0EOo/myycOnJfLYwJhrCK5SJR/bRMqve/jwdbkZ5U=
X-Received: by 2002:a05:6e02:b49:b0:3dd:f699:b167 with SMTP id
 e9e14a558f8ab-3df56ce74a8mr7082115ab.15.1751298134991; Mon, 30 Jun 2025
 08:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630091613.3061664-1-tmricht@linux.ibm.com>
In-Reply-To: <20250630091613.3061664-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 08:42:01 -0700
X-Gm-Features: Ac12FXxVHD2CMy2yiygOJ78LkGhzZ7nqL-Yfiv0I5XZjPSnN6PvAtkY_EllkwgA
Message-ID: <CAP-5=fWGiitgromQRTxEsU3cY99gFAU6WPLnmiS7-Q8vQNGbYw@mail.gmail.com>
Subject: Re: [PATCH] perf test: perf header test fails on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:16=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit 2d584688643fa ("perf test: Add header shell test")
> introduced a new test case for perf header. It fails on s390
> because call graph option -g is not supported on s390.
> Also the option --call-graph dwarf is only supported for
> the event cpu-clock.
>
> Remove this option and the test succeeds.
>
> Output after:
>  # ./perf test 76
>  76: perf header tests                           : Ok
>
> Fixes: 2d584688643fa ("perf test: Add header shell test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Thomas! Given the s390 restriction to require dwarf, should we
switch the default "-g" meaning on s390 to mean use dwarf? James Clark
proposed this previously. It doesn't affect the change here so:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/header.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/he=
ader.sh
> index 813831cff0bd..412263de6ed7 100755
> --- a/tools/perf/tests/shell/header.sh
> +++ b/tools/perf/tests/shell/header.sh
> @@ -51,7 +51,7 @@ check_header_output() {
>  test_file() {
>    echo "Test perf header file"
>
> -  perf record -o "${perfdata}" -g -- perf test -w noploop
> +  perf record -o "${perfdata}" -- perf test -w noploop
>    perf report --header-only -I -i "${perfdata}" > "${script_output}"
>    check_header_output
>
> @@ -61,7 +61,7 @@ test_file() {
>  test_pipe() {
>    echo "Test perf header pipe"
>
> -  perf record -o - -g -- perf test -w noploop | perf report --header-onl=
y -I -i - > "${script_output}"
> +  perf record -o - -- perf test -w noploop | perf report --header-only -=
I -i - > "${script_output}"
>    check_header_output
>
>    echo "Test perf header pipe [Done]"
> --
> 2.50.0
>
