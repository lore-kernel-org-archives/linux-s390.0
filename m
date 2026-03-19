Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D6374183
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930484; cv=pass; b=D4GPJthKSXbqeRRtUZE08VXwIoGRh0A32GOdiQh6DSynw349gTG3HjIYUzeza5m/iVg0nuSGFzoy5ucuEp376rIvqMa5ydWw8o2dvJ2ozP5L8mM2fRcJzPB98A6ANOxY3OxYC4h/M0iXCHEq9r1/6QvaNQdsflFEdItT1RQYoAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930484; c=relaxed/simple;
	bh=x6wZk7AvpBRTPYt5th9R3ycT2p5XdAgtnR98fAb1EOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXna/wBdy4eBxFf1JLy4UFyJtgEtLV6abAxXicPEixGUZBavhqcd6R9jMhNXFvoB5uW9sxYrdAQGpcI2avEbuQyPooz/cWHZtu9MRz69+ICzSzGUCCPWCO2dirVkTof2I0JKhg1u1ZdeyvGaUABCdvkZTuFSDc1wEITD8RgB4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcCKrhoY; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcCKrhoY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b97b30fa5e5so160173866b.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773930479; cv=none;
        d=google.com; s=arc-20240605;
        b=c6lBMIj+RWeaWPEjZcok96DS7TShn3Vp32QFyeBraaOW7f7+MWoc71PRh5VtCm5FPc
         IhELneuttsNccJvimyOMGFmGEfTsJU9c4+vfNt+q+eAX6DV695t3DtVtjXrwdlsWWoQb
         Q1A3+tbsYLaFKjiXyRbpjhRkT6xbfnbxGTuVNwm5uKv5KflCiEfCLwlyw+GEjpg4Nj7Y
         oVm4pk4oBGD2ey1jCX1DscJk34bme7GZ4qvDSXtgwAfz8brRqizuHmy0vXKtNZ1Pkuoc
         IEAlCpDVDmq/ICh7UMFwpE2AsU+ZNxFENIZUs9cRV+NYphlQNRzcG4iZQ1JdVuRcweRt
         AxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        fh=CNBAfnu5CIZZ2Ev6vKjjW4I7TYrbt6eo2Z1gEoj2tb4=;
        b=R5f5S9R16B6SgzEh1bL6dikNOd14EXdVDxPBvTV8qXhMDP7nr3f1cWKeuhgRfmyTNx
         fDGj7PUERsAnOysC5sC1j8wDZJFtm6eBVyKr9bHQfDH7u2we/G+43yLr+qfDt1onbSji
         WlLDGy+CrSCoXcYNZLipqGbbJYhUAob+vTBrH5UmR8jjBYjyl9FfHzzb9P1K2QHtPe4i
         boGKhZYphHgWBeq+StsdkqBrKljB28tBd3KPSO2rJr6x4LAIuuvur0Yw1cB9VGx4kWKz
         7fE9/Xst/vZBNdjiEU1m7DFbKXXN/Jxa4OsnejhiGSDN6fQYNLKzGvHXUGU3SdlWdFt+
         anlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930479; x=1774535279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=kcCKrhoYX+8CZszcDQbuZD6T4DnxTVx1KFlZ0Jph2pEsT7DV9Mnj1YT1bYrXCuAa+S
         hpDAfQ1xXxUjFpI++GUXCzaWS1y6BSStTwjGD+OnOBciNoZ7Xp1VqamSGoaSAqSZ1u5R
         945g+zKdeorBhg1AKG/Bb90H6R2LtDirpwrPvj5Oh9WzuAiCQSN2EnknkZHTKsbab/zB
         fnD79VSfUGwENxCYTTrjL7dnOT3K9jltAF8JDxfu2vpVHutMN4ta0fP0qdP80PoqOA/o
         HPeL/1Ukubwi4cdQoCwu31uFJ5Bte1R3lZPg/JzllRmeny1zCPKEmeQumCaUrIAZcRJw
         +4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930479; x=1774535279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=ibUphMx/WuJD/ozmzSApgdP+JbLFKdjfyrTqCs9gOGAoFNenUlAMuacBipc7560ykU
         x9va3vK2u73bEM+ovORhftiowT5ngYYbZG4rn2tqkip3KURXZrWIk5zh/vBatkwsofOP
         hnDkRhmribW6zgtn3nFyldDxfbAmozZnAACEMFQ2RsM6bbKS1zP9Z2CtJKid6WYyqOg7
         1Ryh79Kxbinkpum1dxyuVdpyjVjik8je0GTKhgUu6ooRBhh9rUCLy0YdmUFLMDEqjyTM
         ZcpBzQ+VL1n6Z00pDV0T/xmbW38VYzs5NGfw+6kDDccALWy5tUdhs3qryNh6k/vyl3ew
         Je3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDxB7bo98kVrwjRYPgwgf9jNSCz9A8Jjtv07BpHNlWijKhFTNykPEx2FKhnu6aDj4tyhV4uwMc02/I@vger.kernel.org
X-Gm-Message-State: AOJu0YxXosUYkXY5KDIPhhQMBre8ilA8zrWAH4JIJGesCtiXtw55gP8Z
	Nj5j89LJ4reJ2IhEbfRYW/2k0S88JgDuMXqLQ+Zn05qfG9gbY0DC80nRQw762wnGpBXkoceBTyw
	L4o3NNFHL3ZDBvpPelftkW4bCn0R1ooE=
X-Gm-Gg: ATEYQzyaTk5vFLo+7MM7CrGtFE/k/tKKxieomVIhNONphJzct/vshsXdEL/mG6/pwHu
	K0mIU3TMDaT6Otm4qiDzrJ9Xgg1yoHx8i0/ImCVSMYZfLUtspYIYnFpEah6YMRQOyMpwXk6Drdx
	oTM1vVFFbyiwckItcleEb0vQNGTfpdEeo75mIMoxEW58Hz5Ll2Kj52nbJ60u1eN08udrPuEwYdx
	MdNLcg30s3PLOgj9/fwnfKCSPVFrCQKSmVZp/OFuUc/z+Si3p65er1PG0fcl9vDU1uhbshcmZ2B
	85GOeau5iw==
X-Received: by 2002:a17:906:ee83:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b97f4ab7799mr545864466b.41.1773930478856; Thu, 19 Mar 2026
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 19 Mar 2026 09:27:47 -0500
X-Gm-Features: AaiRm52wQD6uRKulnt1Y_ioaRFL-b1bqEKDLHZMA0LYwV13CAWHAV79Bf5laR-o
Message-ID: <CAFTtA3O74BTJz8d87CJFQpa8Sub_ouKyyAB8cTXUxd=BnUzS7Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 000000000000..fb4233445276
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/ua=
pi/asm/auxvec.h
> index 95050ebe9ad0..0a725f2aa2e7 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -33,8 +33,6 @@
>  #define AT_L3_CACHESIZE                46
>  #define AT_L3_CACHEGEOMETRY    47
>
> -/* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH    10
>  #define AT_MINSIGSTKSZ         51
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
