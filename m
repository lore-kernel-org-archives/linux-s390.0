Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914513DD52C
	for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451037; cv=pass; b=WZbVc9OaYir0TGC5i9j8Wuv5Uu8h7jF4xxFWJSUQz/Apjk9Lt0yz7vjCfbydii72XfgRuw1ztiM4qXJJCRDJlJYStCglviNWopDQ7ak2kc5syARSh2dIQLbENdLVhCuzeEwJXXPZHqQdrcHNLz9r++4zav4jsLb9sB18jdS9iLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451037; c=relaxed/simple;
	bh=qm0d3kjQW6aV5Cy2RHmHl8ULGvSuNMloC3mjkRM2Ggw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NegOLrbF3cnoWjVyVrZp7Lcys49pe9y1k02vt74GnXsiOiQMasWLWSOz0oM6pitmMBBDyVfn9MRAvvmuDwM0apTstciIZdGK+37Gqgfaic6mVa6sSrBrF5Sqh2BEsClTHdCtYUDQn0ACfACqt3Z9Oj87HTrnxU+TJFArjf5ElG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PquHJ8hv; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PquHJ8hv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052562254so102095ad.0
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 08:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451035; cv=none;
        d=google.com; s=arc-20240605;
        b=PbOZ2n3AwSKJrsxEXHumDp4jK6gVOpxg44uI47zb1ACcMGJoWj5Y5+8OxAiLvZQRHv
         g7hJdnDQfXipIvzmwVD3eTfQRUqY/vq1vfROVSXIIuecfYuqhoPREDBXMLQxIgQ9s/ni
         J31z2J2oa38gHeuMyco0oMKWEIknyKls2rXjy9ySlNxv5J/0OXspTVjN0doSOeJAo0NB
         tF8qEEnhaqnXagLQ6KNUJosbXdAPRb5suj4f+H3W8GJowzZQ0rQPlPAGudwz9xnfANBJ
         D9BxuswGLslgZvvCG4RBeya8KUfo9oNgt3X5W1Y9a2ZHlhEtFpHsMf6dgtKY/4aEfkYW
         HwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        fh=WzHFYGnNJE/G0+TN72G/sb8bN6UjBxlKj+lENM3Dzrc=;
        b=TdyfLO42gYmhyyx9XcWtl3hRXRPg3f9kjBTDD35Z3y5R1kLxHdhOuZNRujlX/UHsU4
         vFXat84JD5ZDCIgn9hWZwojHcqEGAuZInNCfxUDN7bfEj3SC3A9NZY2aQ8vPc7+dqoVM
         U+M07++Rs3cCgvUj6HkInxnfpfCChlLC7VD559xO9vQCE+EQB/Wbw5Grc5YW6PXngyc7
         hvYdu0QBO9WTS3upX3BCyEkLbBO2vrlgOYCIdwqaXv7t5ovCUf1/cIsRdGhkaHRetRUn
         QqoWdhJFuuWO6fkBUs75Rr3AuR+MT1fSswchvLjjPsmTtm0SopBOIwNNcP/ZYCec+mdK
         vHjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451035; x=1775055835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        b=PquHJ8hvvdwSWl2FiF6B5ycrJOH0wnAKwfUHN8Rr4VGfpQwroNuLsEKNVoqfgfmmeT
         U/di0+PfvZvcsy1Fx9utQIJJcv2MpLhihXvJRP9WXvLHQrqjoWwuMqir4sKSZuAgXoMd
         vbP/XNsYrk4FfijBzkcSNJXVp9Ecuc40bwFcseFZMkNYM41UDn9xWiIVwIAimvMb7z1N
         8/bIgoUOX1bwV9ZSoS1oaGIMQD5AO4y668LYcrsSJVBlqsgJU4qclCkamjg/A6oxxkvr
         nNInbEgONMLSxbRg4b8FrLcvzbWhXpnG6SmoX3DDviIsRDzLdkphAMHn1WwqUliykPuQ
         ZBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451035; x=1775055835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfgBqYyqmJOVRzGjk6Fl6eNS+jqrf2i2gCxPGM4REos=;
        b=DXyWCMsF2nUM7v7kygCkVFEhw8AgPH6Xfhe4uNwIrYFbx2BWuPEx42+gPR9s6JpKAR
         7E8EfSBgXwM1jIA1yvy44VTbhgAlUzX0yJtEVxNoeOPlS9UWUcKwaZ0eh+1lQG66UYNB
         L8LX4c4q+cJ+5WWp1QXAMguGrCME1O3Fqpke6ZBduCWYwd1N7V956KahYWr4Ybv2fJbW
         UhzVAUq2QsnhH7Etf2O2qr7tzQLnd7XqrYpbZ2r35n+8T9fgtBBEtnRSezJBQbDi231q
         BT3OACNCKkc/xdf9jdIjeNal9TYkXWAJOEl7JfmI1X1c9YT8t2A5qmUlHWrT2DyRnV7V
         dcUw==
X-Forwarded-Encrypted: i=1; AJvYcCVqlue5m5QNBO88nKLSfyBfh0+49aw7s6TO9vUJXmuy/SfAXGcQNSWLcQMe7usbvf7Yp2fa7EssKUfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Gu/Yy1Akvop67hbmC7bJ2AZ/Lid2l0dj7099E5FLoZAITQr4
	kEy3SoA5YdyKD50taugaZ5h7E54vtdVKBT5Vv1WXAS20vUmA7APaayyDAkaH3s3pGnz/dtTJWTZ
	8jZOuqO0yKbsyRvWhKAUN7j2TXGXnuMoXSWQ+36yb
X-Gm-Gg: ATEYQzzcjHExYOs3ObXnEK/k/sVi95Kku+n9pKxgZglBaqr3VbhGT5Uu4+D7eGTldQe
	WDkmr1cQxnXFDsQpHuay9vgQQhoXHZL+4XbjDW7OxL1kvThXRLL9TJpeFgxi1Aq683mKex++88C
	bYQZGNXh+O3qJ8i9neJI51CBED/mpHUhU1/i/8aHxjIa/Bj/VWJbEKVqnLHEfooEcLwrAMWFl7j
	/gQuUGOeCaPFYNz2ah2HrG5s/zFnS7vSIcvqMEnJ5hMyXlZexlC26X6sy8zXKti5E6Az6u6J1Ow
	kkXmokAc0sMfUY/yZpuvXCF3LXstsxOOLomdoA==
X-Received: by 2002:a17:902:d4d1:b0:2b0:4d40:ce18 with SMTP id
 d9443c01a7336-2b0b1d4459fmr2878515ad.14.1774451034374; Wed, 25 Mar 2026
 08:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com> <20260325120627.1841175-3-tmricht@linux.ibm.com>
In-Reply-To: <20260325120627.1841175-3-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:03:42 -0700
X-Gm-Features: AaiRm528F_wWEBXtl0FfNSdUfpS1Bi_tLi3HEsUxHneMwV_eVuVnmeFilDaCSjg
Message-ID: <CAP-5=fV_iaQYRkgOw4rQTLmXbEtrRT3TAFOFdPznF_9BOHGNpQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf config: Make symbol_conf::addr2line_disable_warn configurable
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Make symbol_conf::addr2line_disable_warn configurable by reading
> the perfconfig file. Use section core and addr2line-disable-warn =3D
> value.
>
> Example:
>  # perf config -l
>  core.addr2line-timeout=3D500
>  core.addr2line-disable-warn=3D1
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/config.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 0452fbc6c085..31541e03aab7 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, =
const char *value)
>         if (!strcmp(var, "core.addr2line-timeout"))
>                 addr2line_timeout_ms =3D strtoul(value, NULL, 10);
>
> +       if (!strcmp(var, "core.addr2line-disable-warn"))
> +               symbol_conf.addr2line_disable_warn =3D strtoul(value, NUL=
L, 10);
> +
>         /* Add other config variables here. */
>         return 0;
>  }
> --
> 2.53.0
>
