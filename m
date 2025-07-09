Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579C2E5B39
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075748; cv=none; b=rd0nqm4AQ8vH7Grx6E0dG6ULlS9pTZxeNW5BlB50CNxHQxhnDmvXq0Rhm+tueJgChQ6OqMW1nM0MTE15ogIn8aROm8e4QUlM9KGlnwCML6mtfnMCj+lKQskvQ4LA9tHKAnfbakO5EGZnt+p67ym9dMeR1fFwmC2JInmvpIcVajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075748; c=relaxed/simple;
	bh=QovcFoD8Krfi+xLDMqZWIXliDqU55FCONFA7+cA4UIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TobwAXCx2B3/jh0Eqox52hnvzw/3BZyrQj0lquR3ItC14zrZL6qkHoCREJL76vAEfoU9TF2ws6A3ptTSK7GcmdVuKEoMcHGCn3oHI3sJUINAd8Yn6qU2n7y+UPAUQzudXqOZuXEWHAwiik6bHkvaT8ID4PygJLyJsKu2RXdEAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAC/lPvk; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAC/lPvk"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so42705ab.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752075746; x=1752680546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSU5dKke9DWZIUFmbSQUTLS3E3YudP6op3KtOW7lXs8=;
        b=cAC/lPvkR4pN0tQBsZtysBPM1gtAj2bCFYMsLGX0Xr38nae2v6eVoY2AAzk3Wqzrkz
         2ugGy0Z2VsusKuXUJr37DbDcHit/KW5jNlU5LLYuFx3s745XQWuGi+o3T0lFvNpy/CLT
         vuZndPeZQ2Q5IwB+k+QSZmEz7hjkRxfsgpHP22g+2TCnGOY7pkHF01JYFEn0MdpfSdIx
         UOp0ENnehb/BsMwzFQUDEl9YJswbasR4hxnH45kuMs2LxXzDFajrs1wSbx50muHc3vTW
         MTlIgaaTuv8GAPFqiIi89Bqb7T9LplJQUyxS3d6pXAp87t2D6n1xhyxoYrHNVGTzsSLx
         OfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075746; x=1752680546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSU5dKke9DWZIUFmbSQUTLS3E3YudP6op3KtOW7lXs8=;
        b=idHoKjZroY646A1RN/iVOxSrQVK3ZoVF6xqkGcAL5coa14mYjNndEuiq7EGiqpX/wU
         QH/0BKIShmk0MBNw3kiADcMjNHFODmMXADIIhMarhgmFve/RMBdZ8ljcVSeONIcjdqra
         xdVI55HakwN0zbey+ABe/KcelXossZeT46bBwAVB5v+UEzdGxMfq3Tsh+Lf40mTWJznM
         4Kh19hZ+Jf6dBUmQNIHMw59fzhAgVD5HZhKw7rVOy302F+VseOgmg37wyiLHSVBDhPEt
         nQx3zJYvSWdeaUWsC3odp/bbLDcTPVffm59T9Xi0Q7Y0fEkVIOaizpkIdH68ViBYdPpS
         LqRA==
X-Forwarded-Encrypted: i=1; AJvYcCWblxCGwMJ5HklVRQAy45HgJPq165JFHi83+DsW41U0DlQ/s5NYXbwZkIdGb4yc53u4fLpnngHtpkYt@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+ZTmN4jQHcr19NU+PQbYo9WS3BK3MiMPc0WoC6Ll5yESC5nF
	9r4dHbtbtGc2DR8UBsPRSzsIV13GnixUBa40DYNbW//Qe6XwrUzZk17G16b3q93hUSTprdYIsxl
	BKODDOBShXOXmrfRphjsLtP0cX3X7wuOD+KCyOE7w
X-Gm-Gg: ASbGncveWFcFpGR6GIRjRlJk94b2AEhAWDumfip8Ft+rvUDsxYzFp0orev3T9Wn7Zcw
	No8IEqjCfovUhOu6PNGobGEzhGlRoOI2sjWk+PkVT4XQ00Zq1U//npCaxP5rrwro/ZfrUmgp0rs
	G5IXoftbRAt5CpiPxua5dhRufg1pVp50PR46cOh5Dax55+lf8Pxna7W7uh9+8ZDsJOR2yCNnBU
X-Google-Smtp-Source: AGHT+IHQ9PIy+XOkJNK2AeN146I3YHYL5hcrX407J/wgmZ1WsclScTG1u4s0DXxAV86N/BucOJUHKJySsgYRtBjAxHA=
X-Received: by 2002:a05:6e02:2592:b0:3dd:a4b7:c737 with SMTP id
 e9e14a558f8ab-3e167228593mr4070965ab.19.1752075745880; Wed, 09 Jul 2025
 08:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709072452.1595257-1-tmricht@linux.ibm.com>
In-Reply-To: <20250709072452.1595257-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 08:42:14 -0700
X-Gm-Features: Ac12FXyiyh8qm4Co47ZF3XtMQKMC2KU6LdngoTLT_7JWPX0CgPlWYz3wnTXAFQk
Message-ID: <CAP-5=fWTc==g=DAS83Eed_Jg9EgE8QiRgM7Jf3vGhmq=8TTdVg@mail.gmail.com>
Subject: Re: [PATCH] perf list: Remove trailing A in PAI crypto event 4210
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, Ingo Franzki <ifranzki@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:25=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> According to the z16 and z17 Principle of Operation documents
> SA22-7832-13 and SA22-7832-14 the event 4210 is named
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256
> without a trailing 'A'. Adjust the json definition files
> for this event and remove the trailing 'A' character.
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A
>
> Also remove a black ' ' between the dash '-' and the number:
>    xxx-AES- 192 ----> xxx-AES-192
>
> Suggested-by: Ingo Franzki <ifranzki@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z16/pai_crypto.json    | 14 +++++++-------
>  .../pmu-events/arch/s390/cf_z17/pai_crypto.json    |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json b/too=
ls/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> index cf8563d059b9..a82674f62409 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> @@ -753,14 +753,14 @@
>                 "EventCode": "4203",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_TDEA_128",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED TDEA 128",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA- 128 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA-128 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4204",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_TDEA_192",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED TDEA 192",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA- 192 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA-192 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> @@ -788,21 +788,21 @@
>                 "EventCode": "4208",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_128",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 128",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 128 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-128 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4209",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_192",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 192",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 192 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-192 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4210",
> -               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256A",
> -               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256A",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 256A function ending with CC=3D0"
> +               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256",
> +               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256",
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json b/too=
ls/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> index a7176c988b8a..fd2eb536ecc7 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> @@ -800,9 +800,9 @@
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4210",
> -               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256A",
> -               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256A",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256A function ending with CC=3D0"
> +               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256",
> +               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256",
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> --
> 2.49.0
>
>
