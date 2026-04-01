Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60839B951
	for <linux-s390@vger.kernel.org>; Wed,  1 Apr 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060485; cv=pass; b=WnChGiKDNoK8H4ECJViyVoD4zJURuO4gUOS2+DWCszRD0LJlIGKKwrcrILgXjsxPFj8jzsdqOalH/Le6Wipwo6g9DmKkbE5CgRnDleeswZBxFrp30X04o56GojYaAcHZI0ELqKep2OnzCG/MKCoe4dNnV9iOZyAdgswGqoMCOC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060485; c=relaxed/simple;
	bh=kjka6yapCfD4HbjmN7gRU//AkLrg1C0JenYZqph86Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3PEssL/jHGhOzo1G/6/k5Q5xCjPCg48CuIeWhW4RzYIwd4/3vx6rRmuVEC6UjBwiHtgUU4dhCTqlOjbe9jW6hwbv2u4mH75MOvL0V4y8Vg8pNWMtRC03yNFgeg+UUrWlIvthJtcl5VzuhCLt43RStbduAcrLG2ylagpOX3tBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAKWHmG4; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAKWHmG4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b243198058so202725ad.1
        for <linux-s390@vger.kernel.org>; Wed, 01 Apr 2026 09:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060483; cv=none;
        d=google.com; s=arc-20240605;
        b=fonxhCT6wdx45Hb0/LzwaCvs5dM19AbbgPhPfZhsQrbFncK0Evosfi4/GwYLCCntna
         aib4LhDLG5+zweY03eqe/og5tJ+mVtelbHp5mxbjK2s0gYl0/tnwhoAze28CvEfRQz7O
         XgrJcZCF7DEYoi1LPhgEWNWG9EEks55bY1GBKnEcA4WrblGJxPLYEFJoUGrUe4ZH2shf
         VSddNSfP+m+jlZshL4yezPxWLbYUjlgcSq+bvBCt/TFPJr2ir1NdnasIxlb/JzpfclIS
         JHOd0poKNHB/NqIclETJ/843eUsPSam4TlwupHJi0jzjv/GKSbokR4FaFbtpCymE17qA
         l3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        fh=o6f7zdHO7QXqzqHGAxN4WcauEqYVgmF/Bg3ytQQ9R2M=;
        b=a3jAimN8GxguEvgbeTa9nHqetbhRaBoN6vJYYcNrkhSoc7jhBkcgxzZpj6YOQ+BfSA
         TgRUdgMsVjVt9jH5hNzwzXAfVDtPk63ht871ARiN3E4GCo0SzYlgF+pB3QOrh9kxoZVg
         94iCQs7FmX20ohLfBuWer66eqq/RjchUTQcpuDSaFLOx/hfmI1bw2msDeZuEbVfwEFkJ
         z5ikOgUo/4u0i0YdpyyBvUp7dvfk/gVFC3EHB0iwVjaernrCCyyo5KREoqhF50MhvYoC
         v2UNP0Og5c2UXuNZb/C+XGWam0wiBm06b2sS3LFxSdmpT4Y/V3jcnd670GCxzW9/anAy
         pXkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060483; x=1775665283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        b=dAKWHmG4XLSBxEac0RdiJspMLnC51y9/3wQj/dyYAcYCIei5BXXKqk0ERLiT2otB7T
         7iPrukCbdbL1zxXy7w4+nQ8zKibnWnG45oCL52IwCW+4aM/hkQWFr1/zTeIropSGUdrg
         CxjYypPqZdQ/FUgvTqN7jS2qcMJQ0Uia8aY0XBlPcBD5ZbD7432EBtodgzinXxAmt1Zk
         dWDTC0pUZXnEZuBfGctchhJQzr87ZA2Ch2ixs64sNJPOVZkchaStZS1lR7pi+5UWiWGm
         Mv92yydnOc2roe9AsNxvM4FwcI+NRT5b3LV5CqErdbGJZJ4GI+5PBXUDU/+XI1p/wZoF
         nJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060483; x=1775665283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        b=M08nDFeO75/YsewwzMX/XMWzURKT2bUOJLfijrFbqvwJla3rIYqWozgNJNQ5RAD3jR
         6lFIarGGwLuaUQhbMHjvtvQA5Ff2Nx/zA4cJIwzpHiEJhx1gRQQjQHefwNldOtPSt0Zr
         5V9l8VBTMi69iiXyAFF/APa2UE45awvexZpeFolqIQuEsvCMfcXzwHvQaEQZSVJccX2n
         mwFsfhCdv57CvCZpFeVBQ2lQObQNuqTQINvc1oRUSwgjsZntcD5k+ZE/3CfGYmKGamnq
         whoa58v/sHMZY1WVC9NK9jJGg6kmBG16Iww9DFjtovocgqj5u3XR4gYW77X5WL/k6/R9
         MH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZVN4t0lgUDjATMUX8E9kJBeXLogRi8wQIx28Cz+EzHnkmZoJA4SXOQg23+zx1tZv1uYR/dJsDbwd@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyVDrXCNmBvtgPZt7IH3f2KQG4Fc39DIAWnWXWBFuG6U1jpld
	2YhtNRMyXdnSuyQdy0RrNZlH3pnUcwGG1qrHor7cpQ85xMNGYpeNe4uRhJvtcIxjZK3C8RWnVNI
	Qi/tT7tMLAem8fGmuxpzUz7Qam7ThmAzs+q12RNl5
X-Gm-Gg: ATEYQzyBTYwJtlgCs+wkpAn9EFc5625Ijf3zHQJfmjvH45hoEyGMYUax9N3y7pmUpun
	E43fnj9+grHzPCqlclm0uJFlCxcEuaz9+qFX81sLWKhkFMrRKx6iytQFsqGHW5AkkLWJd5Itdbd
	JQX2IJkoskaXXjJ9NgOlidq1s/0pPXJ6ZOpc3lMtZpEfdBGS00PjE8hwElyTd8EsScs/tAAjnnI
	TgUAog1cnbKii4ipcYATUPGXw+hHOr6IfVUr38WLHBIo14Ov0ZKXK4bQ5RBqP0xoYqyW5wItnOP
	+/XYGmwmzWVb9ThDlEiLb2zz0lvoDkLk2FEp
X-Received: by 2002:a17:902:c409:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b274d795admr298295ad.9.1775060482802; Wed, 01 Apr 2026
 09:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401122102.30737-1-tmricht@linux.ibm.com>
In-Reply-To: <20260401122102.30737-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:21:11 -0700
X-Gm-Features: AQROBzCCfjfl2yfm_IJE4MRh31I5SUD0IvXQE45wm3CfBrnbzlLRCqeCHdIGvas
Message-ID: <CAP-5=fXpU52Y1H-KgLrpYnTiPvZ59DViYTOuML1a6bETBt8Kag@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Skip perf data type profiling tests for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:21=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Test case 'perf data type profiling tests' fails on s390 with this
> error:
>
>   # ./perf mem record -- ./perf test -w code_with_type
>   failed: no PMU supports the memory events
>   # echo $?
>   255
>   #
>
> because s390 does not support memory events at all. According to the
> man page, perf annotate --code-with-type only works with memory
> instructions only.  As command 'perf mem record ...' is not supported
> on s390, skip this test for s390.
>
> Output before:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : FAILED!
>
> Output after:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : Skip
>
> Fixes: f60a5c22967b8 ("perf tests: Test annotate with data type profiling=
 and rust")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/t=
ests/shell/data_type_profiling.sh
> index fb47b7213b33..eca694600a04 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -15,6 +15,10 @@ err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
>
> +# Check for support of perf mem before trap handler
> +perf mem record -o /dev/null -- true  2>&1 | \
> +               grep -q "failed: no PMU supports the memory events" && ex=
it 2
> +
>  cleanup() {
>    rm -rf "${perfdata}" "${perfout}"
>    rm -rf "${perfdata}".old
> --
> 2.53.0
>
