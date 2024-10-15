Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9318BBAB
	for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978618; cv=none; b=SWVWTJv/oxY7UjOlPDaMSiehb0Dipsr78Xvact2m7/CUo8RJew5jOFRP6X4+vMmQoZ4K1+6UVrWxDYtRHmhZD2dtIYzE1G3Uxn/mSnWuygWDGd4VgwmfiGGepdeOufBFVIbMFEkG8oTSRj1a4sRQE2xgICgAvYfkbraSoGEDHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978618; c=relaxed/simple;
	bh=vOa6EcRUks3vJ+gN4gguaBuawT8MdWJj35kDikZazRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhAecQVpLTJN9/exe1AOk229nASv9tzl24WIRXDlJNe5UDlvXI+TGDmtwLYsU8TIKu2sZmKdbZHhx2Z9/9txWJXhXS5fwX7aERYqpickGghnvyjCQqGNTTf6dF5Jpwp8WQb02grO7exCd8Ih/x9f/6luD6NhaZBw+e+hj3O6+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pq9sqDIu; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pq9sqDIu"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fb86af725so1205726241.0
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728978616; x=1729583416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=pq9sqDIuUiCN6CgXeF98QqUKUiofaqMEh1s8GRRWDBQn1FKcLaYnpBvYsEWGaCehxq
         V0yGJLFFXrIr3MTAQCQUYhjaJyfrjsOA6SqU5kFQKlgJJbA90nxQRZic9loUybr2cNSV
         jm1t3xppD7nyH0a783KUfnEfhv8rmSQtHsk6bELkOthOaF50AAi5hcmNyUB4SDOsWfBe
         s6Hsp1mLL2LzkwtnvJMYRsqFW617kDDsScA5SzRy6Q2tQIcYW5JTytelx19UBLLW10af
         CsabWjARaCKqIrWoq2rq0PCqiiO0ZBBEunmUzAjUfl1hsxBieQCFsWhHCfmwnq5j/s5p
         eT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978616; x=1729583416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=t1ITHhaZiMy4KF7YNzNxqc685KeIk0dZEzfLO8dhxNALf1yzvv0ps1gs2TJ7y730Z0
         gBuJM9qXA5Xpiz84IoMeePgLBYvY57vGmuo5VBYNeDxzhBUZy63HHUr1Xun3QyOY8MKd
         Z233WKi9EvjvKxhNwNDrS3ifFHkBkh15YyBRBMKd+jIaR9lcqo1InzziA7qWSgHXD/lz
         0l7bwzrzZKBENWn5+0tPc6YB8UmRR50H2LDi6Qm7xF2Slif/aOouuNZmjmDIyUB5k9Wd
         kwAaND5Na4DFk8EppQU4PxgD24jJHWJPM64IabVu06eNKZXk5dUlNn6HH3zzMF2wNh55
         BFDg==
X-Forwarded-Encrypted: i=1; AJvYcCU4OYnvBPCjZ1jlYTF47iEbvH5Sbm82/kp3Y1yq1jYjzmg1xeFOY5bE674bZHlPjxIta735OZdVXJey@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQ9lhC3oyRmUkQ3EYeCzLDndM6UpB+93HfaMKX4ViQuSe7UxS
	Oi+kZFSiHfPyjc2WeLoenV9aNoyXr3adek0egjyo2aCKLc1AT7JMxb9bdlK0QlclKGIdPnkAF94
	IdfIwSugZPRJ3RWDeiA7OZU1+Fcs2ureltHEClg==
X-Google-Smtp-Source: AGHT+IHJTQgMwy07yt4Kv3cxeA6jaDdGJW3Q76nXmTxUbWPQyJERX0qrCdD9zyui+kZPBA1VduE7XrCzaRDLLhLgFV0=
X-Received: by 2002:a05:6102:3913:b0:493:bb35:d8f9 with SMTP id
 ada2fe7eead31-4a475f0bc31mr6236860137.5.1728978615788; Tue, 15 Oct 2024
 00:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141044.974962104@linuxfoundation.org> <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
In-Reply-To: <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 13:20:04 +0530
Message-ID: <CA+G9fYvpCw4Dh5BhKjS4bsWix=i=koK6Kw_jU=9zSOFu-UePBg@mail.gmail.com>
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

On Tue, 15 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 14 Oct 2024 at 19:55, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.11.4 release.
> > There are 214 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

[Adding Reported-by: ]

>
> The S390 build broke on the stable-rc linux-6.11.y branch due to
> following build warnings / errors.
>
> First seen on v6.11.3-215-ga491a66f8da4
>   GOOD: v6.11.3
>   BAD: v6.11.3-215-ga491a66f8da4

This S390 build regressions are noticed on stable-rc branches
 - linux-6.11.y
 - linux-6.6.y
 - linux-6.1.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> List of regressions,
> * s390, build
>   - clang-19-allnoconfig
>   - clang-19-defconfig
>   - clang-nightly-allnoconfig
>   - clang-nightly-defconfig
>   - gcc-13-allmodconfig
>   - gcc-13-allnoconfig
>   - gcc-13-defconfig
>   - gcc-13-tinyconfig
>   - gcc-8-allnoconfig
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-tinyconfig
>
> Build log:
> -------
>   arch/s390/include/asm/cpu_mf.h: Assembler messages:
>   arch/s390/include/asm/cpu_mf.h:165: Error: Unrecognized opcode: `lpp'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/startup.o] Error 1
>
>   arch/s390/include/asm/atomic_ops.h: Assembler messages:
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/vmem.o] Error 1
>
>   arch/s390/include/asm/bitops.h: Assembler messages:
>   arch/s390/include/asm/bitops.h:308: Error: Unrecognized opcode: `flogr'
>   make[3]: *** [scripts/Makefile.build:244:
> arch/s390/boot/pgm_check_info.o] Error 1
>
>   arch/s390/include/asm/timex.h: Assembler messages:
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/kaslr.o] Error 1
>   make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.
>   make[2]: *** [arch/s390/Makefile:137: bzImage] Error 2
>
> Build log:
> ---------
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11.3-215-ga491a66f8da4/testrun/25429522/suite/build/test/gcc-13-defconfig/log
>
> metadata:
> ----
>   git describe: v6.11.3-215-ga491a66f8da4
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>   git sha: a491a66f8da4fbfc06aedae9a8b0586d11a51fa9
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/
>   toolchain: clang-19 and gcc-13
>   config: defconfig
>   arch: S390
>
> Steps to reproduce:
> -------
> # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
> --kconfig defconfig
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
