Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCC1AD418
	for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975914; cv=none; b=hmHIK+MCDkXWDEWcFTShHfKEJHOxD5FMq6Ra0wn93OHCJfDBolLYWB77KPdk3X5wKUyILHUqtzmLTibdtnh3ucYtbY1iWJ0gu6J5Mt9US5VayIGv1KsaJFogBwjlJB/fTvMZ22BXp+Lnoi9HYoKM88YAgkBmtB9R0Zf5fEwbP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975914; c=relaxed/simple;
	bh=oBC+1HsUohKVIcQAJ+6MB0/ZUctHQtUBhtp+e9sDpvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUB2Kk2uRBagPC2rjoJbj7utAhL3YTjcaWIskMnA9mnE9Bn8h8aUoU8YDB5cDzE6sBcDRnbirWtllO+aq3T24+L6qJ6agjUuzgW2XhePa4wGp2vkKAR0ob4LRI2ipUVDR29PvKv1833ided9zjFVurMmqRA5vj3zU9R34DGpjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=De/8AHEo; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="De/8AHEo"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fd059e49dso1246238241.1
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728975912; x=1729580712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9S+Y8EgTI4RaVYlHU0odSMHwKx4OEouTcUJBn6Fq/ys=;
        b=De/8AHEoxrhEvoqQ5QVIUlCI/nVQT2OSVwYEDAYujNDp9lwspw6jh17I4ZGERnCrFv
         idb8BLsJLf6ecujqqMgXKm8vlaR5YQRiMpUv2y6tiN2SaCWU/0flVg34ctjG8P59JJiT
         pDPF6M5lCFuD5yRyiiWyYQU0AQOdiPmO2EkseHackRqyCA8z2ZZHxuC+Va+FSBaukwUO
         I6jpqLQ5112xLNGQzJcIs3scOdK+6f3jY+25b3V2cbg81JOEw+62UmXsgAbhIgzkeZLV
         V5FS0Hszhe3C9hj+y45N5KYtBD10LUFtWCIBfihpp+nDa9iR1Xl7xGM4Gd1KaOqQh2aY
         mikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975912; x=1729580712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S+Y8EgTI4RaVYlHU0odSMHwKx4OEouTcUJBn6Fq/ys=;
        b=ESGpRlMeMkeMpmGLQRZH5xgZZpET1ndTYogDp9nbh2jSYulaV8p5KNK8xlS+lyvxmL
         u0oZugV1zeseKVyJ5m7owI0+g/Tk5IHBK6p6jMhB3M5F4O77f2atdzTcjVvp/zM/Tkpe
         jCnt2ioK/uxdNzUxke2kXI2r40Tock0vLGXiwn4rprq3T1Vnw5WpcJH6q6q+FP/4U0Au
         OBYjZBkEB/yOo9j1x47/YZAfbSDFMiiAxtZXuRwTeqwnTYLFa7gOymdrcQkN1vbO8jd3
         qZB2TJWjxkoBNM9VjJW3Pj8QMsUmE5ByqPZjoylynB/ipaBl0LQohItOEPRJtnVgDqmw
         35Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVHIztrcw+sOlE9uSo6yckhNe3Qh6k7aPlvQdrlH9shfIc1VLuBveLczLnECnrOjOxthf9kPfuy4yon@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhTlL9LpjldCIr71XVDwwFyJ9oYLj1jryJhyZQYLJAWb4Higg
	OqWgVWpJGcARsCXqNSO7kxedtmkYe1nBJI1ifurvAwYdypxp97CTTTztmlpmnPcCPjqLY00h5yl
	xPRVs556h9mOMwUjVgZ7JvnTls5rVSiXq4+SfNw==
X-Google-Smtp-Source: AGHT+IHEcqC0X9UrZgnNhMSIO+RyEt/FWn39JNphrOjRmt8okVO8tsYm73/rsHZiD48SNgda7GloKr6sPzvke21V0Ok=
X-Received: by 2002:a05:6102:2ad2:b0:4a3:b2d0:ac50 with SMTP id
 ada2fe7eead31-4a475f4c6damr5693483137.11.1728975911768; Tue, 15 Oct 2024
 00:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141044.974962104@linuxfoundation.org>
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 12:35:00 +0530
Message-ID: <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 19:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.4 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 build broke on the stable-rc linux-6.11.y branch due to
following build warnings / errors.

First seen on v6.11.3-215-ga491a66f8da4
  GOOD: v6.11.3
  BAD: v6.11.3-215-ga491a66f8da4

List of regressions,
* s390, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Build log:
-------
  arch/s390/include/asm/cpu_mf.h: Assembler messages:
  arch/s390/include/asm/cpu_mf.h:165: Error: Unrecognized opcode: `lpp'
  make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/startup.o] Error 1

  arch/s390/include/asm/atomic_ops.h: Assembler messages:
  arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
  arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
  make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/vmem.o] Error 1

  arch/s390/include/asm/bitops.h: Assembler messages:
  arch/s390/include/asm/bitops.h:308: Error: Unrecognized opcode: `flogr'
  make[3]: *** [scripts/Makefile.build:244:
arch/s390/boot/pgm_check_info.o] Error 1

  arch/s390/include/asm/timex.h: Assembler messages:
  arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
  arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
  make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/kaslr.o] Error 1
  make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.
  make[2]: *** [arch/s390/Makefile:137: bzImage] Error 2

Build log:
---------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11.3-215-ga491a66f8da4/testrun/25429522/suite/build/test/gcc-13-defconfig/log

metadata:
----
  git describe: v6.11.3-215-ga491a66f8da4
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: a491a66f8da4fbfc06aedae9a8b0586d11a51fa9
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/
  toolchain: clang-19 and gcc-13
  config: defconfig
  arch: S390

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org
