Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273836C0C8
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459437; cv=pass; b=VVhlQiR7uL+XgLZhxo49U8AnPBiwOcd/XJGD7T59ryn3cO/MrqRNYvycjtqioTc0mzfFPlzNBZVui+Cp+ycRTmnjNnweIo0rqcIzqd7DUnVT9i8J2fAjPFLqlkoylv2e6smzyXHyNkv6BGVGbXy4haGjLYyS4zDOtcrYqnTFvOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459437; c=relaxed/simple;
	bh=uvE5b/EiDpNgiR0Kg/L+ZSuEvfLCiq/r/YNySx3RI8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYpyNcJCqDanaPsbCFiOipZJN1bx+pH+kUXJPa4DVQMaNh1S/p+sveU397/W2YI76ezEWZwlzUv8aoumGhYkVchpLLPIB2grQ8qqr/az57Wi9XP2GRypZe1T51SlLXRgihSnB5THe37O4AKK0TA4BktP/Oo/Ofn1rU3oHwHxwUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glfB8ogb; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glfB8ogb"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e843c64b8so340751cf.1
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 11:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788459435; cv=none;
        d=google.com; s=arc-20260327;
        b=jo9dmatyysddW7ZQD+3JwxJsFkvnWBYu861SNNMcfUlsxrm5eqYNjarWXQG0XVIOvw
         CTgbBvVmovhoklz3ufkk2m8xNHylmDgUG1N3kU4EVg3KAQFCq/VLVPhekTanA57JUnw9
         ZJmVr7HII3F0+X0Y0aG5UOFZQ5EdElwedR+7rKeq3kRjmpGpWWxTXVdTrK8v8JUqG7zC
         oRdZcl7aUTd/K2rqXSyl2UJt+dQhz53z/3i9Zw+v5830Vywv/gdXBYDsxn/WWO/hZxqI
         9Q5LMpNozCm25MAU8qGaokMcDOmfynPbWv/AD26xHG5LtcCN0enf6Vo/yk5oTg8b1XLJ
         +xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        fh=WX5UrzyUpzeQbytFkYpEkVzn+jMeg+eRp5aPPwLJ+Ic=;
        b=CeDw6ohHTbmMvjOtp8I71M7V0C/Fo74cdHHNmsTUXFO0q+nnYfbUIlNnfTsLG1yPi9
         RqHE2ZS/j40hYyc1cequ7p74Gk6FzpvH35i3ghFwRMSnETnGEEVCRDZiyEUJWwkCfaaw
         exT6SGy8xAVHbX/WoI+cYbfA13CDB6AIEmAJTgGbjtB8/UFqnYlwb1QGTTStdSVaHXD8
         ChIpfUcEUxedIwxI73sP2KrdF9ncQBTbhsz/H5qcJNjObHqAhbcJiva1PY11oXzeiZct
         P8Vnc9Y+Zs4Icrc9ZULp950hWJ5hfeE+ODyAJ+OpvhaWbF1ThS92rzRdiBzJn4MKDFJj
         rAOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788459435; x=1789064235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        b=glfB8ogbiW1UrHVbhgTdWbl9g9W8SsJkTDLlIYtNd+PHpONFgsxqjg3QM9pLw5fQ1E
         cnAh5pjiwnHczQYIqu17zcG17LEGdwvdc79aoYHYzP9pqjCwO97co8JpY5Ri29WQycSr
         +sKnnXjHT10V/cF0xC3ROJwlN7gwC4XVFnVGtoa5j0NBFUKURTazcMWX0Y8CLs+wRurO
         5FJ2kC0bfaHRK29KcH89652PWKUqDB4nYAwrRtm7oHota79QAe7lD+TYv32muzDpzLoU
         TAhBXQqShVtyjQr7AUVdi2g+1Thd2OjmTmEHmr4awBOiQMJhvY/6ixfIWoquRZU28jRC
         LTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459435; x=1789064235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        b=cEF2Xp8GyJULnhgPw5o4HMNamF1UzALd05chttoXu9b3onhaBH/4QH/LNF6RF5ToTx
         mzz1MorCzxWRvlI64qyz1wn6buG9QDGJUVenzZ7BMKc/0paOqxC7c7vZIca3nMMvZsR5
         K8xPGVeVDrS01eRn8RBiadYnBVXHtW57y3YHmu27+uIT1f5myR2h8YzSiquuKoXBpfzK
         keuC+/rlA1SM/isOpQ+UycEUDI/Cbt+mVBkW7r9MaIvDp/WAmxYJ2DfWfn9DFjEprXqP
         ORA1B3LMNzeNEXq9Bbt03DXcQPMwkA3SJhlau2A7mZlzcxrsDdIjTjZB6TBQ7X9BBKjE
         kXYg==
X-Forwarded-Encrypted: i=1; AKwUvByrtmSW7cLBxLSHOado/esiXBi5wXTBiUJYh2neJ4JwBOGpQ0yRI8nt47zRBubIdpvweZBICJnepgOy@vger.kernel.org
X-Gm-Message-State: AFuF++nZSD4oWOyUyIBcDG+dEbvM1PRmpy1zJ2eWK3yns3V9m2vGFgVf
	CwMRFeQQ4YBH9iKLZk1oiG3LYx4raFXaoeLj6POoEOtRRmug8n35vnN2FqWfg16EH/U/lPmGcOz
	3Lm/8cCsFrDgMt65Y/pFQpb2ECpd1y/2QSu1v0CrU
X-Gm-Gg: AYBFou1vNJWINW2NsV0dnxRgk4ZyCXutkoQwtr3jPr94xl1HTnc3pXOwO7u/BVmuOFQ
	0D6+/kIfexAZRHOhdm5F8tGpEalJAHMMZoqkNt9zaoEgyRrKE0wTnqc1c4o7xqeBhaSPdjS/Umz
	w5Sz0YS7Fl3wDdWrzV/BRE1Egg5xZmkFqlY6aeQH6XdppqXZyZ/77KLwM3Qm+lTUAtShaq05xxo
	Q6FBZnKRQWeaMrvsPE9ZcTNu2uamEn1RlEvCKYM6K1Ze3Qj2O6t5CZgHKhPMC1XxKSZS1FMu0x+
	XZE39PlTdzZJgrRZC/1r0EiP/Rzel7PNkpAy/28edp2/Hoe+AKnhgdY+GFy5yOYIBV81TEMwp4A
	=
X-Received: by 2002:ac8:5992:0:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-53055567dccmr83931cf.9.1788459433648; Thu, 03 Sep 2026 11:17:13
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903073554.1300334-1-tmricht@linux.ibm.com>
In-Reply-To: <20260903073554.1300334-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 11:17:01 -0700
X-Gm-Features: AcwNN1Wj7onVlAWq82ttAz6rRWHfVF4Ef3_xa9bxcnd8LJ60UxXFqlzVG2puzko
Message-ID: <CAP-5=fUtW=EfB5SOt8iCSsyt4pg_2NhoWvTr=Qf5vEKU5CwZRA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: perf stat tests fails on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:36=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The test case 'perf stat tests' fails on s390 z/VM machines. The
> root cause is the unsupported CPU measurement facility on z/VM.
> Therefore the events cycles and instructions do not exist and
> are unsupported. This cause the subtest
>   Hide zero events stat test
> to fail.
>
> Output before:
>  # perf test 116
>  116: perf stat tests  : FAILED!
>
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 0
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 1
>  List of failed tests:
>   116: perf stat tests
>  #
>
> Output after:
>  # ./perf test 116
>  116: perf stat tests  : Ok
>
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 1
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 0
>  #
>
> Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppres=
s zero-count events")
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 298ce454b45a..1f5d4cc05807 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
>    # Check that --metric-only works with --hide-zero-events
>    if ! perf stat --hide-zero-events --metric-only -e instructions,cycles=
 true > "${stat_output}" 2>&1
>    then
> +    if grep -sq 'No supported events found' "${stat_output}"
> +    then
> +      echo "Hide zero events stat test [Skipped - events not supported]"
> +      return
> +    fi
>      echo "Hide zero events stat test [Failed - metric-only command faile=
d]"
>      err=3D1
>      return
> --
> 2.55.0
>
