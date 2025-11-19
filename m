Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E7302741
	for <linux-s390@vger.kernel.org>; Wed, 19 Nov 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572012; cv=none; b=reHlQOYyK8wuzNWbyu+v+damgo6uPJDXprxXVstf5tYEqAlg4iU0sP2UW8zmQF0iJ3zm/A9d29fgajd6hl08+/FpZiX45xSctY/jy3B4zvHYDZKxGOeyjUAhmbwX1hr6VKj0BDVn19ZPaxNjJTTL34+5QzZDIK7mBrQyg/f2AyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572012; c=relaxed/simple;
	bh=ox/9vhvkrZ2YFHQ5ruc0dQSAeJdssTHSZ31fjIu4Xcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/1l9qLhWH7o9+H+s2FmWKfh4XyzElM/CvLiXX10pxUVdxUpYAAnXxLeBBKpOhKrGVa393CkAPqqSEIf78pYTMaTYtBRzRwVQiHkB3ghf3B5bsPcXJd8heQ2Gr0BK2sOM/GiuD8PAkshScqC2HiLRW6Spfhjxsi84HNcYQ0RwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHSrG6vj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHSrG6vj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29852dafa7dso226595ad.1
        for <linux-s390@vger.kernel.org>; Wed, 19 Nov 2025 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763572010; x=1764176810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb4agBV1NIebVk5UoYPPgBtf64ZcfvgpzIo5DZxYRek=;
        b=FHSrG6vjUXOKueDytJnxSVMPhz3GMOGCO7Wm670aXwEGNFNwiOb9tUwEaAc/AmQV+8
         VnH1e1JM31MEwg96mwTYD9rTjq26H5hIT2EqZQjVVEBWJ9fPpshp/DKleKunwGuccsfC
         PlBacXUYt1Uu0FtynNBSlxMkjYhqSVZld6n1opqfMw4yaRGcC1S/+j5A9E02htU6ngdk
         CFAfmzYxw4tWsG3W5b8qxoe90ZtxuVdtjYQODlpy47w1bMCFMcy3aKr0yXiAR4k1WXuJ
         lCCC3FUfvxTXFjffMrRrr6ZOIItrKl65lLW64V3bDU/eA2UE0zzIiyCP45GN9C+2F3GZ
         c4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572010; x=1764176810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb4agBV1NIebVk5UoYPPgBtf64ZcfvgpzIo5DZxYRek=;
        b=wLLXIc8wDtdLMi8W0m/sZWixymkPm/1glnS+FHqCFftLPlp1UeZtTlpYpWLWvEGf3n
         LPz25VF4qeyXxGfOP7QTZLtSEncvv00IfJ4omyD4QGsmLbqku3r2NEX2PUxcnhgRCz3t
         MUaRG2vsBifZhtkIAbsNTFIa5I92uD4/skfQxSwu6EMa3Cz16ZPD6JZDk2DkdFJ5Z4cN
         PO/oMkMh4lH8bQ9lYyaWB4bOk/ADSj4BZ0GJJ8WgVWqHQhruyg7JjN168RFV/MTuJGcy
         8aCh9cD/P1G1Iu4q23ph22l2w87TsO4UB6Cls18qN6kydqfTtJH2oJG6xaL9f6oBFbvb
         Yijg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1OpWNtXgsXBRAUwhNhRebSmdQ4k3e+zKi0seEkJuJti9GQoD0VctIKOfpTAbjHY4xd4/rJETdAxG@vger.kernel.org
X-Gm-Message-State: AOJu0YybXXJM6RG4unSz6AP55IHv7BzzmmjBGWqp/QyhMvnWTX1ADpkW
	4hblLQf/zzu2WON5c3jOBz1hWeB7uvpq+MkWJPXw6Vz9wy9sH1rQA+fB7bUhUWD2Bjmxe5ajZ0U
	KJECbdiYsYvqMUFDJNUNOiFsrYDtyIXWWkpjNdiDN
X-Gm-Gg: ASbGncuxFj8ZtS2AIp20Co+HHKS6VDWFFLeTvF1Vf4ptttBf3KdyVB5fldGFkdGL/n6
	vN+w6w0a8GZimQb52nT9aDr2AthzOPrimkQ1t4gF/vQaiEo10El/tdiyBDUNRbVK210KC8n29+0
	ivKlJ3utuWnD+FcMbORSpM9cx7TZutyX43H6M1TKrdbjBeIlBOvtt8wSwdPnoSFXPHDcdb8xIBB
	aJ2xX7FGJMrQ7IX4Z24Wr9Aum2L6ftaA5AaRpYilhkV297ADbjTEADlaVQ4M+bnwd/CMbgYtjCI
	mJKvhkQVoIJFP/69XXuXQWSkdA==
X-Google-Smtp-Source: AGHT+IFtsjqgpzNXFDzfsquynuqMPN2tHdkQJCkKFdwf9l2tBGEYNOmEfbFv3qdaAf1E21kK8/Sptigpdb0cYU38x/I=
X-Received: by 2002:a17:902:c412:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-29a05fa3a9emr3609065ad.5.1763572009638; Wed, 19 Nov 2025
 09:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119104751.51960-1-tmricht@linux.ibm.com>
In-Reply-To: <20251119104751.51960-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 09:06:38 -0800
X-Gm-Features: AWmQ_bnlTtiRRA4EUoZBXiBiTyKKT0KOdZndooc_2VtWxVEHzc1PetaKx5nqjrU
Message-ID: <CAP-5=fUcNNcuFEyreGa0dpqfJzZtkDdp4yJXgZR0+LN_Mj5RaQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf tests: Handle s390 metrics in perf all
 metrics test
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:48=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> This test case fails on s390 because some counters metrics
> are not available and the metric defined on them fail.
> Add s390x specific list of metrics to be skipped.
>
> Add an extra line to display which metric has been skipped.
> It is shown with the verbose option turned on.
>
> Also return "Ok" instead of "Skipped" when no errors
> have been detected, but some metric have been skipped.
> The seems more logical otherwise "Skipped" means all
> metric tests have been skipped instead of just a few.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas, I believe the intent with these metrics is they don't
fail but report unsupported for their counters. There's been some
discussion here:
https://lore.kernel.org/lkml/aRi9xnwdLh3Dir9f@google.com/
with Namhyung and James pointing out the issue on AMD and ARM, and me
being confused we Intel isn't failing similarly for events like itlb
accesses that Intel doesn't support. I'll try to find time to dig into
the issue.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/test=
s/shell/stat_all_metrics.sh
> index a7edf01b3943..b86b36a49228 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -7,6 +7,10 @@ ParanoidAndNotRoot()
>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
>  }
>
> +# Ignore metric which are not supported on s390x
> +[ "$(uname -m)" =3D "s390x" ] && ignore=3D"|branch_miss_rate|l1d_miss_ra=
te|llc_miss_rate|\
> +               dtlb_miss_rate|itlb_miss_rate|l1i_miss_rate|l1_prefetch_m=
iss_rate"
> +
>  test_prog=3D"sleep 0.01"
>  system_wide_flag=3D"-a"
>  if ParanoidAndNotRoot 0
> @@ -27,9 +31,10 @@ for m in $(perf list --raw-dump metrics); do
>    fi
>    if [[ "$result" =3D~ "Cannot resolve IDs for" || "$result" =3D~ "No su=
pported events found" ]]
>    then
> -    if [[ "$m" =3D=3D @(l1_prefetch_miss_rate|stalled_cycles_per_instruc=
tion) ]]
> +    if [[ "$m" =3D=3D @(l1_prefetch_miss_rate|stalled_cycles_per_instruc=
tion$ignore) ]]
>      then
>        # Default metrics that may use unsupported events.
> +      echo "Skipped metric $m"
>        continue
>      fi
>      echo "Metric contains missing events"
> @@ -106,4 +111,5 @@ for m in $(perf list --raw-dump metrics); do
>    err=3D1
>  done
>
> +[ "$err" -eq 2 ] && err=3D0
>  exit "$err"
> --
> 2.51.1
>
