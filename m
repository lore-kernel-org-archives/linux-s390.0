Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71021173F
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801638; cv=none; b=n0ZZY0VUcm1Lu+bZXKigHxemLcuRY3OXXpmK0mu71/v/6hMTFcMH+lg2DYF0wIjbvjnJO71i/xHjGqJOPvCYIoTt7syL9VCpRTMtAE99bwabxnmpxWkRVz2gGZrHrWHYy1qO5W/5ubQGTGaghR2SbjZs69vIg9u4ZfwY9ZhY09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801638; c=relaxed/simple;
	bh=6UxNgBbLmEd9k8EtkUtoBRblPssIxgoKWBIO4OHyBlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys9l82n4Zod1sa+kwIpynl9xJg5B/qWRtcj+CwkfwQKen8uCHcSgw9NM6FrSS3QND0a/EIclKI2OTH0FB8gKJZqCkVYz1KftJbqWPyq9rezZOAEhNtCvVRDyqncLeTphQgd/Yimp5yJgmHnbfc7YISYAPUNQGVv6MnilwO8WH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVeF1qwS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVeF1qwS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410c9f17c9eso24715e9.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Feb 2024 21:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707801635; x=1708406435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsA6Vin23ehyR7Ij/sBXeXrDTbKj+YLFziDzOlAwThM=;
        b=MVeF1qwS9Mu2eFkSSW1/CQZo96kHekDmB0UuB0K8zVnlu3iNEi5hrBiRTkBlJy7e9q
         F6ADhSAAInm1SUHDiwM7QbrJ7FjYAPOUcWMqnDOHv9ooFB8euOrw8AbPthAzvoRTCti0
         9OKT5tz37SjrUhvik7gjkJlaGdXYlXLVQaHVc8Jq8zFoPbeb2wtwjtgLH35AdabNNt+3
         uFbo+UQb7bsg8lhfb6GrFCrxAUxm19nv4eIck0VMh/qs5PFE6K179/0R0Hu48WU6eTo8
         AdnBktQlbZOo88cjMWNePMJ4QbNKoj2QxB8Sp6xpRcffsyBLRcWON6eroGtYZQZ2Bku+
         Mfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707801635; x=1708406435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsA6Vin23ehyR7Ij/sBXeXrDTbKj+YLFziDzOlAwThM=;
        b=DB5fXqaRGq/KtJo98ObI0FvmtZkpndBf9pm3SN8TGT5a0wMIIqxSRd905384kgXHF5
         cxUHjbzhdE4d215AQEDx3TpvTxpHFcsVzlMs/xi/5anb+r0pFxKAGQX1F1vFrHJriwAj
         fQBSyhTQ6w5RdfURWQ/lh8S74w62+BFldYgUGpdsWYhSwXUKTcM8PTN3WCozpX9fg8yd
         qabNqRPakdf1DrG3nX9igVjLKrMf0n4cCIUMO1abdrJYFcYorGo9uU3ghoVrxnxFO+1q
         fjobvMfEVz/UhRTCv7PySZ3lTMnPrQvnqYIvPQxL1S7QGjD5iZ88U85YMXefHc3H8cpt
         jCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVF991amIfgQRw55PrgCJuaNgeWIYFQAIhxwV+nDA1j7GhqQcVM+bdS48Rl1UkK2IuhQHhhRoPBStt6Az5fs5IYcWP6Mc6pYjiNQ==
X-Gm-Message-State: AOJu0YxwAlaHDZX9CUoze0QVNE3EkyWu2KDh3T6PvfRXpHWxwIJwcn1z
	wTHQRqn/K+LKfg5FHAw0gDSqsAkaoYx8VJC88zVQiWfGhhZA+bvbVDRgSIO78erKLNby29mfy3l
	uoA34eSm9RSrvHk1GM5G/42VamuFhxrIcrtZM
X-Google-Smtp-Source: AGHT+IHFi6Ul8/IpSL5dH9UF36vlNNuEWfYaVHz0ux89RLv8jLsict9IUa3/bcTp+oAhjprbpCQkEDOI202dHtcpqvw=
X-Received: by 2002:a05:600c:1d92:b0:411:c715:667 with SMTP id
 p18-20020a05600c1d9200b00411c7150667mr1145wms.5.1707801634918; Mon, 12 Feb
 2024 21:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-11-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-11-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:20:21 -0800
Message-ID: <CAFP8O3LhKW4Cg5LQQVmAmFtT4Psap+izrDV+6Bb1zp4yC1WrNg@mail.gmail.com>
Subject: Re: [PATCH 11/11] s390: Link vmlinux with '-z notext'
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> ld.bfd defaults to '-z notext' (although it is customizable with the
> '--enable-textrel-check' configure option) but ld.lld defaults to '-z
> text', which causes issues with building the kernel due to the presence
> of dynamic relocations in sections that are not writable.
>
>   ld.lld: error: relocation R_390_64 cannot be used against local symbol;=
 recompile with -fPIC
>
> Add '-z notext' to avoid these errors, as this is expected, which
> matches other architectures.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This follows arm64/powerpc/loongarch/riscv.
LGTM.

Reviewed-by: Fangrui Song <maskray@google.com>

> ---
>  arch/s390/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 73873e451686..994f9b3d575f 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -15,7 +15,7 @@ KBUILD_CFLAGS_MODULE +=3D -fPIC
>  KBUILD_AFLAGS  +=3D -m64
>  KBUILD_CFLAGS  +=3D -m64
>  KBUILD_CFLAGS  +=3D -fPIE
> -LDFLAGS_vmlinux        :=3D -pie
> +LDFLAGS_vmlinux        :=3D -pie -z notext
>  aflags_dwarf   :=3D -Wa,-gdwarf-2
>  KBUILD_AFLAGS_DECOMPRESSOR :=3D $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  ifndef CONFIG_AS_IS_LLVM
>
> --
> 2.43.0
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
