Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9B3271F9
	for <linux-s390@vger.kernel.org>; Tue,  9 Dec 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298426; cv=none; b=pLAyFqtI3L5wvNnfx6oqHR2wgAPM1VuQsZvLR9nD/IWHPJttx/roQdsbdHpUPbQRBJLeya3KmTadnaXlhi/t/M8LKJvUb7sWAlzuVqE2iq94EGrVjaXO2PWdoaGTiqn8l053ObaglR99TR88awfNoDKt8mQEwpPnIMhabDfqCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298426; c=relaxed/simple;
	bh=JvFF6+FOKEAOJj9t/hxDHDO1jVTcnLAYiVmuSofMOCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTfCX4U0xKlL767udOo6+uakrD0cUsG5lqq3ZsA7ZMs6oGcoHY4gmWVSSN5r1jN1B83M9LW/g+xrve50HPkM7Yl6hdfw5ClXBhSQT1FfwNnbawHE1bLAGjODXaUdIT1Ra81baDZGQEyLFdFqaBygoYkcSGfNLgfl2zmMGIv45ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYV6hfle; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYV6hfle"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29e7ec26e3dso252865ad.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Dec 2025 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765298424; x=1765903224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIKlOB/KgpJP9kT0dnjJxhFbF65TR4r34o2YIc6jtW4=;
        b=cYV6hfleOG4s2Xj8TORMH/MEzSoM1XY+wzrjv+3M0wqUlgy8BiC6HnQwf3JGxnjeSA
         ODYaJ0bAyPYv49ZXj7AApUYroUjAI6NoAt6oFe6dESqsQWTaqxE0GqJaqQhveDctsMQP
         SQwAf/jWd4BGvSHHPoOffVkBQlHQtlG3T7TR49re+5/hHcPeDxOaH5xV9q9mk8EY9k9H
         jWgRbehXbgbAJMaypGApx2F8+zbeAnJIBFckGskru1s/bsVRIR/1UO4rYZrFaONPhnKX
         kfyZLH8gb6TZzdLDcAQV5PztKSTxahnTvFpboEg7FNdnLSPxfnS/DdS1Nk2i6VYHwiWZ
         JJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765298424; x=1765903224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIKlOB/KgpJP9kT0dnjJxhFbF65TR4r34o2YIc6jtW4=;
        b=p1aHb9bAT49IiA+A0djf0k6j6VXYWUHx35u4slWwDEmtA96zZyvBIsWJ3B84jdgH57
         NIOBEkGLeUDIsAEVSrjvFurB+A40yFJBb/hDoVshGZY/TFCij/Eg98D5KCM1FVOC5GdH
         DKzeNWNwDOZ+J5qlqL7bOivIQbpn7CAmYAXr7EkLB4HKszigZg3iFBSpJvGMfHLqm+TR
         QSRq81mRKmpmwqdYpVd4DqKJfKShlwrr6v5AeICZh372kUPPPtTGACUwhXqoU2HPtya2
         mZMCelcYg8DLqvwInly5iri9dFSwapkYCVVAPRUlfSP1wgVhAEnIs98H+6RmSQyUrHLw
         +ukA==
X-Forwarded-Encrypted: i=1; AJvYcCV+W+yRfEWN0NAhhL6oeDsu2BiWP7CXo7+pS6lxM9HXvr25jPAw+GB6Kj1pIKkdQH6saWWPD/MvKEM+@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdzGkCjd8GSTSLj5kRTXO0xysNrvc34stCiGslMWt5uI0zUiv
	56MTAramXSqvaMuZpFQ7nAQSmz+BSWK0OkmCYM8KNJMTC2WaLaiY94/TkTBd3dKPiRBB2qh/lKt
	Ixm9LSw2q7iSQDdDf8z1wZhN0R+l1igf2vVZwxN7u
X-Gm-Gg: AY/fxX55XAFqgNIKeMYQ7k3zFbfNlayHR0ZkzDnR0DQnaaoXVM8/XeRZV8rbR8PFw7h
	h8KTE/c69JINY1T2UARDRN2B0f9mJ2d8Sx7Fs5F7bq/teFJ/qf6Vw1GZGMo7oi+laohzBYVfQCU
	ULr68V4APabxGOMvNtFfCLH8p6prK5NAr4i5qSo1WmVI79cS1ZjdGz5E2d3F+P3weWIMP/y4qTa
	F+pFkOBOvHXyWbm8drplEuKZktWHhczcrjfFUicoNXu75SFeBRQpsIlPwq7G8UlDB3q/zrLBOJs
	irYDWI1bfJJN6zgQZ+Ugu7Ur
X-Google-Smtp-Source: AGHT+IG+tXtxqxAs5MZsdZ8QQBhYZxwYfw3KSnJRGGNeVnKDA+uhxtLhn7sIFa6Z7B6HlmBTov8Y3nqdUn5WPLykovg=
X-Received: by 2002:a17:903:22c9:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-29e99730116mr3216545ad.9.1765298423750; Tue, 09 Dec 2025
 08:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209105029.142517-1-tmricht@linux.ibm.com>
In-Reply-To: <20251209105029.142517-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 08:40:12 -0800
X-Gm-Features: AQt7F2o2b-TqXVYAJS0WsHVzROtpYWKCgPgSD2vNxwquDaWtEtxWSQOanCjh5Kk
Message-ID: <CAP-5=fVxFEzOwQN610gE9F5XiHYP2wHKD6K5zfBHhFOrxD1fDw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case perf evlist tests for s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:50=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Perf test case 78: perf evlist tests fails on s390. The failure
> is causes by grouping events cycles and instructions because
> sampling does only support event cycles.
> Change the group to -e '{cycles,cycles}' to fix this.
>
> Output before:
>   # ./perf test 78
>   78: perf evlist tests              : FAILED!
>   #
>
> Output after:
>   # ./perf test 78
>   78: perf evlist tests              : Ok
>   #
>
> Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas, I always appreciate your help and fixes! Do you think
we should switch to software events to remedy this issue? Perhaps
cpu-clock and task-clock? I worry about event deduplication possibly
causing issues were it to happen.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 140f099e75c1..80f808b3059d 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -38,13 +38,13 @@ test_evlist_simple() {
>
>  test_evlist_group() {
>         echo "Group evlist test"
> -       if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true=
 2> /dev/null
> +       if ! perf record -e "{cycles,cycles}" -o "${perfdata}" true 2> /d=
ev/null
>         then
>                 echo "Group evlist [Skipped event group recording failed]=
"
>                 return
>         fi
>
> -       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*ins=
tructions.*}"
> +       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*cyc=
les.*}"
>         then
>                 echo "Group evlist [Failed to list event group]"
>                 err=3D1
> --
> 2.52.0
>
