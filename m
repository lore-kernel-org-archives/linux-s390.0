Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22F364938
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814601; cv=pass; b=liRTmYxA1X/vaLn76xPhXIg+UzDofuKlnBJLR6PXF3ZjIa7y2R524HxRpjAhYbvetKKRtQT6rhYo7mi04F+H0HRCi8vDbP8HsZlN5La3O4+ZCvynuwtLu+hoqWTAa6JlAtptkPrmC4XKFjcn3sFBzJGo0BUAnmsjaxAG+0ofQgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814601; c=relaxed/simple;
	bh=LyvuvQqufknbMfPTy2o7n/T+OqohBBDpzWX+jX0Ni6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYQlt6B3tQVCTEjGziBmH/WelTxG+Mj0Qv8LvyHY4DlYahr1r3ewkKY90ZNpKBbInuzNBn5AQlXXvM5SygxS95BqgW7UGVcItheTphgprs44P8ViblKujQyPUVwNz+LVkIwHdA6zavj0YP9DXseDz4Zc4ImDK2pYoBa3bP6+Mk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czA+VIq9; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czA+VIq9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97a06d7629so541523966b.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 23:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773814598; cv=none;
        d=google.com; s=arc-20240605;
        b=XNK9df/U6SmbBoJxsNXGUzAp3gpImkamacCEBG3lfim59noayKexZHTfCm37FUlKMi
         xUZT7+qvIJ/zEU1s3pLZbb+wpR1LqCOxPi58zSZmHrjAUd9EoHb1US5uN7HN0Zv7/xkV
         /mGc6P2iSM52ausN6mZFcijBKZL35p77/XNLjuf1/dkPz7yD1/uAQ70BMTzEFoP7Pl08
         n+cEDuj7S447c/qHzYFMbctJ1OplBxFk1oT2o3J4fx0AhOetF2GIhkRaBGY7NbGchzki
         2i4RBjvjmP/DekbLBG20bmjR8+LyyKywtimlXiK1S4TQA6jKZr8Wi14cMrtT9K90kBJP
         rfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        fh=WUYv2oP8E7OvSfVrGaISLzmqi7fnz7+cm9pFl2MGUhc=;
        b=Acb6b+RnjH5L8FAx14sq5jVkPB8EbF2iquKtPVaS/ZVw67RbH9uFM7pOMBJXrGhdlj
         Ub5egCvs1J7OmLD/bYHhVL6MTUGzhX19vCmaZs4JzCxJPi81/v0KrB+07PIEm5UKCpCr
         iE18gWmolnhd4MkwR6KnALi43KfdVcDMufGTvIjEiA/k+kPSujZiLee3BVktVLdAivVA
         KmNid3Yuz+VGNtLOGFmIHjsqiH4vIFnX9Hgl4VW3b7cvC8CK9BW9Oe3b5YJ/RFKORurB
         K3kyaKA4Ra0xxCBIRWxz+eEaOgTX4wfkoGWqzqsX+SmWgvAucEjMikQezLoljDXx/jsa
         hHjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814598; x=1774419398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=czA+VIq9QGWQxIWviOuOrte+AkszdW/h15AxwnnBl8PgQdCUSJeFt/rkA58JF8bw1z
         MYdnPYGFr5y46Y9Ze6hH0uQbYgBxWhk4ISCFrpb1oCRqUKW8TesUGp2nfyk/tjdH6ZzI
         DwOCFfQmjthVedmcIE7z/9904oV0s5pfRk6WMlT+ADyKZllzFK45VHyMvAMFKoo37U/j
         J1nqKAueMk09QeZKqRnb2BbN9+d1iclFRFK4eWers79RzlXUT6c5NL6yIGsvvdDwBLkL
         mIaXTaJyIolZxl+55rCZtIapNWvPnqXYQeH5Kjuv+rgtZgAO2r5C3jf4lHbFErXbdAiD
         Zyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814598; x=1774419398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=PwVF8pN+7DLeINf2eY3ns8vrvnqcaPrbKiHYzO6kgBTkNSly5qPulPw+/XCUvV3r9Y
         gNStrV+QNu4srgCjVB2wDQaS8NioEGzHYlGWK0HRbVTNKn9SKL/h/yO8hec4Exq2TGK/
         LqjbQawosF/IdN2Qbi5luaQbSKArgchXWw/t0XJAz8tNwOVRBbf0YcxVJcCZYYXihB4P
         0icTGF4y/DhUOK4pBL6cvPOky8fvqLSadWUb7RhuBRsK2O1WltMWb/9A4ki11PUMCmRC
         XMzB5HmYs8dYlifkZlGHItQC2ILitSlcMk/XQ81ZLWTHC5CorjtMCRU4HM2bQL+2scL7
         T/XA==
X-Forwarded-Encrypted: i=1; AJvYcCUfBeCyVIJDm3geod+8vYSFUjRVVPpzWyFe+spTDe8dgwVQCEmXE4oPRrI0bC8GEIa2igU16CloVyex@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TjuOE/Td/RVpTUPmvSur+4H3a6wvYdBTMB8/sm792IAoFeNd
	RTYG+IYujdBqMyyzST/jAn5hpczY5/hSYRg1VaUmtDz+xQk7WsRJOJTvqWm7SyB65tY1TqiQA6T
	YHNaCLMXUB91AZvOvvp57HpHazVIwslU=
X-Gm-Gg: ATEYQzxFbmm9yr4O2M9LCizJcC/V9TnR+VfktJUevoWe0jxN/DlOZLHkl+y9koIEKyW
	7MY32qKRAElXbCAb5/XgwNrBE0+o/J3U9TXYm9QPSAC24wWj9kRswccf2f+L7nrZ/Lo/hYO9JnY
	7WbFc6F3j6vGvQQC4JYkR7T4HizF+XhkY+O5sjOnLuc5yNnbqXQ+/G1BaVajoTWgn4NRcPooMGa
	U4FC7sIFCDdfwM7+sMZ08SSPruUOZD+okB5k/dQyZ8zf7Yycy6VUYe8/BoESo+l6QuJN2bxHLKO
	86XIutzpXYFfDpt3P0k3CwfZF/YaTdHa1pYLfvh0odh1FoLyiLY=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b97f4801ab5mr133040366b.15.1773814597747; Tue, 17 Mar 2026
 23:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Mar 2026 07:16:26 +0100
X-Gm-Features: AaiRm51Xx89jeaivgNYAhMk2LxpIu3kD6j5N4SuQDZ84WCnP1EAzJIW2dMNKGiE
Message-ID: <CA+=Fv5RLtUPp9BhXfFEUk3roE3Gah0iUamDEZ-MXCNM_xKm3PA@mail.gmail.com>
Subject: Re: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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

On Mon, Mar 2, 2026 at 1:32=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/alpha/include/asm/auxvec.h      | 7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Build-tested on alpha, no issues here.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
