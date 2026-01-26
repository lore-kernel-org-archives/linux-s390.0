Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABA33BBD3
	for <linux-s390@vger.kernel.org>; Mon, 26 Jan 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449387; cv=pass; b=hMB/hT4IcOq/WzDRDu2WV8qp1jgcTTW7s5n6jnFtybpUKNm6FuEksE5tlqoKoMwTBK4oxSMcVXo4jo0xpKzGZrW+OpPaExxo/kg0ynCFg8BOTcfi5pkbBh4ClwQEIFStMSHr4eeDeVzNgkXKsHXLaSbDOC5Il9qY9Q5ozSmBlb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449387; c=relaxed/simple;
	bh=g7YzmZlLzxLm1WxnED0D7dK8pgHNCsq9mTJ/fFxN1c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THCOIsJRWthjN9ZQJndV3xnrKfyOzvAn3Ibfy8MSMpBkx9SsEK8ReCaUVAOjb2mYXu46ZoNGus44eeapM/IVf9YLg/5tjskXCxkXUJ0PzXiXftVooQRsoMgSFog1ZHlA/pFqZuglAJ5jgVEXDx4F/ny/Sdp5206nFuZyOxKY0qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B51EwUA6; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B51EwUA6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a35ae38bdfso125ad.1
        for <linux-s390@vger.kernel.org>; Mon, 26 Jan 2026 09:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769449386; cv=none;
        d=google.com; s=arc-20240605;
        b=QCpu3Y/0LBMe8qK0FctH1b6gJhcVCbuf94U2lRNTOK1jCVdkvCnqlL3yhxBCbpsECK
         QkAXuvovrBSTOIc7g56MInZvpkX0cwtqLhRQoCOrt78ZrjEOTFy23vznW+QGFSjAnQwx
         wD7lGT+u/o9hgz2cfiP/6AqTtguyleNC1jjl9T1A8igk9aMxbxg07B2o0nq6CvwHcGlW
         HHAGuhrdsOXVydLsPvali6ziQGUoNPNBomwu5LwfxYP09Wx+R7r0/0J2A3Wp7wgPYFaR
         oCVp2y/eOrXbbqHMAnmCrsUSwL6kFhBj234f0AF5WqRZtiZle+zlsEyYAg9Uc4dAzMD4
         YmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        fh=eTMcoEbR/DRWykqP9xqJfAOh8Iz25iBPHXPftkEABcg=;
        b=d8yF7nIsHLHru6IWMe0X52BSQKn0sqey23iS3lJScc8AW1E8ns2TACf6KhpOtm1/hH
         /TDzZ3U3ET2KtAG5JkmQamYIbIZDE+LKlUeqgbC/3jg0U69rbYFf8Z5gvrj5oct4GE/S
         HtrMosxQiCu4uODOTj+G+6dGX0X4dw2JiHrEcd3xZI1//TQ6tV50rbRvYssJoHtWlXd0
         EpmflAn2OtuR317BL5uGQERicZyhE1EM+Alvw8GTzMS9VPqTO3poo5lmUHwm+7oNpKz+
         RaX0NVBMoKPfP93F4CAHuPfLtrqZUrpVa2RHz4HUV3tVhw93wNkJKDi3yq0yU1OWfBLd
         MRRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769449386; x=1770054186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        b=B51EwUA6Vmu4RIEZ7hQonAMTKUfBc07lmiAOUa91ij8q4It9iuOQwLmu+bY+xRfWB9
         DOnBLcrL163/DTPPzAQMHRVCVBxdOaaTQGLohr6qnmFT8JXEnZ9TlWbcslhUpzKYRvqy
         88DviBcjigF614jR1jpuIV+OoUn/g9aBQfJjeXZCZ8o5DrGl6UC4T6VXw4nnJd/ly+iU
         rTT+mU5vAvg+uH/aDtGnNg41DIl6+/nFHsC0Zaqwl4QyX/0uDhtQLPsdnG0O4A8kbuMm
         o59g13JGaeUhy2hP8wAEmZaoCacMk8MaxPRH/Y6xGo41EDcsnAmf/oEIPww7N501kMeK
         ZWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449386; x=1770054186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        b=mPy1OFUSH3ye41wpCWKNnSCuj60GyXgGc8oO4U6LFHZ+huWZaeWhsYmm1/wnW28tQP
         02udVnqmLqL50CTlueEmY8L4j58r+zwt4/tqYtYPJUozkEl0DGeRfltKG2iPi9vsl2XM
         X23vEmlvk3YUY8I5efSte7uBgTtsBPEWG2iGLZ4LTs1z+UGlKcGoHtnwPRmSpHMmZOcy
         9dqbKwk9TTE/9p1BR8OGDBU0YzYkWV8VcaOCr6FbS4T/kXP09UuqOFD8hi+G1AUD+Lr3
         Uww0835YYWjzFwvr8UTEq4H4c90BYACK98EFdiHRYyGeb8yb1c3v+DKnMF1WvMEDPyDy
         jqng==
X-Forwarded-Encrypted: i=1; AJvYcCUzuwk2P4hm3f69t+P1F0H79VG8P9I96I4bzeTC+IixMgB0gLQ/f4OskF2kbT04CqprtqwV5Equ4LsH@vger.kernel.org
X-Gm-Message-State: AOJu0YyRidtrRtXd0oJASThA8YJeYqiQjUYh/7UMTcfh8pMKaqEx4tSy
	nSQ3MK1b9r45k/gFMT7tXh0IOawu6xn5aijpoQjmglAEsljb6qdlZx8WH1dalgsLmqYtnuFQ44S
	cmwp71fcF57UVa7Xl869HBV956g5zlaazpiV6TZ/h
X-Gm-Gg: AZuq6aLbI407SqRBZm5V/8f+Y9v657MXpOjRFFDX1dDsSTJktqdmjsVS53/iXS/PRem
	k3bRpcNmzfxWrQcvPoT4v76lKd6GtvJ3VE81LGgSrjYUXR9qw4nGI+K0GcqqF2aamfQqP7FJEiY
	fHs8ywNb6Em821lu6UW51AoMWsTE/tlUvoLY742OFUfEmcpRMnert24JOyCSGtGFNUc5CYxue2S
	kM1vIgBemb3o3L/mjruxRrx6Z1yX+QPiZg+BuTIsYPpLT4nC+fP6Gf4NVJLRodMDV6YqGe+FlpX
	VPH0P0ix7bgiCAwGWoXcZTzugA==
X-Received: by 2002:a17:903:249:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2a844e940f6mr1999015ad.15.1769449385360; Mon, 26 Jan 2026
 09:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126101823.2090077-1-tmricht@linux.ibm.com>
In-Reply-To: <20260126101823.2090077-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:42:54 -0800
X-Gm-Features: AZwV_QhnBtYvUOa0-W3O55v68ICGZGXde2Tro63ayWgS4vBkaOy5iMUVh04ueaw
Message-ID: <CAP-5=fXPGXJMDPQc4XxrEWW_HgJTbrbL6g1xfTBn14jDiW0Yxw@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf test: Fix test perf evlist for z/VM s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:18=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf test case 'perf evlist tests' fails on z/VM machines on s390.
>
> The failure is causes by event cycles. This event is not available
> on virtualized machines like z/VM on s390.
> Change to software event cpu-clock to fix this.
>
>     Output before:
>       # ./perf test 78
>       79: perf evlist tests              : FAILED!
>       #
>
>     Output after:
>       # ./perf test 78
>       79: perf evlist tests              : Ok
>       #
>
> Fixes: b04d2b919912 ("perf test: Fix test case perf evlist tests for s390=
x")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 5632be391710..8a22f4171c07 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -21,13 +21,13 @@ trap trap_cleanup EXIT TERM INT
>
>  test_evlist_simple() {
>         echo "Simple evlist test"
> -       if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
> +       if ! perf record -e cpu-clock -o "${perfdata}" true 2> /dev/null
>         then
>                 echo "Simple evlist [Failed record]"
>                 err=3D1
>                 return
>         fi
> -       if ! perf evlist -i "${perfdata}" | grep -q "cycles"
> +       if ! perf evlist -i "${perfdata}" | grep -q "cpu-clock"
>         then
>                 echo "Simple evlist [Failed to list event]"
>                 err=3D1
> --
> 2.52.0
>
