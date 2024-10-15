Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1705148FE1
	for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982426; cv=none; b=GZPLx23xP39jCdSWdz1apxAa5+6rEZsideCrmei6r/CoqQFJX62vaCCX8JyuJn5LASlW4L/vAUbi4QRwLWlqZg4hM/QLoXIbksMY2A4QLL7alE/P5d2/Lm6Ql81E6r2j+nHVZRYdN0iGzUOQmWi+KWX5z4gT9jMhnJ4vu3Ikwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982426; c=relaxed/simple;
	bh=mGonrEb1BPUx4D9j4VoLPoRRMOa9lPSnwGc8RZ4M4wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYMgkisetVPEoTTAw3PfGNX056qeijb++2o3ZZryCP3maEqyKKjbfYEDKURgC1OMS3JyK3YnM89YK7kAoWOZdMHyvEUYUYoViQ88dUn55pig/8UbaEQA5VWYrWT0xdsIrgR8uIZE0oKiw7x7pJueWMVw14iBI7DtWoeH7fASMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4HXCAQ7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4HXCAQ7"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad3so848680e0c.0
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728982424; x=1729587224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxR65U6vScytg2kv+c/PJeOMb0nLoNUa0TL3Lk+ySjQ=;
        b=M4HXCAQ7PrDoVp1CYTk8Gfra/EnxIy2z+WTzoyR8DTMH/h2RjD2hAJr2bbd0VXasNy
         iCGYAEa4iERwfQ7ZUExRwyiIYwpT4qWkzW2oxNR5cmyh12t3YJeLKbHvPkQwupkc96ap
         VvPYgB6ae71H1UXJaYJXOQn40Lv9t4X/wZydRjceURiAw27m9MLFE9khlnS2g4DKvbpz
         wnITuPNQbjrSpV0q7X/Q19AkfwkiSWy0bF83nAD4n6Jkf7cVDvmRQTjagKg2eXpbnVn/
         o0Cl+GfuvuIsiARKLA3wQdMRMW2xRPl6DnnBRPth3s0X+jUXhcGgKlUoI41+pZD4saFV
         /55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982424; x=1729587224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxR65U6vScytg2kv+c/PJeOMb0nLoNUa0TL3Lk+ySjQ=;
        b=tzboy6Eh/kqNkMyql/4qFwBXJtZChMek80rWmVo176vJ607rtwgBzxdRLh1pHN7Wir
         ncdmy/koFRBUXOXGv2C5y4uUt5xtFLpF5YiuiKusOliN5T9hRxWRCpBZFe+YmW0F/f5A
         2h/wvf6xVj04wAtPb1gtib5z9RzPYY2XcvV1KHHHiUWeQar0d3/AxQGxWuPJ204iJB9I
         1At08h5T/comDOl2FJXBpmz0Frr2oq6952LgUIjUEpL4DG+AFMNhlDecABpDz3JaOoyX
         ePmqWHuDdNDFc8+77tNmPBGBCzEHXGhdrlvp+MB06V3ry8YoJfeZveZaBbOb9hiDcmAv
         Z0CA==
X-Forwarded-Encrypted: i=1; AJvYcCUIG9z5LPM6MHGsszaEkVO803676xK3s+IxQQBhoU0X9aa5XWo8MJinWkoGQzfdUoqtSAFC1d1dTV6B@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/6ZP7OUoZQP/0pGp7+fi4L0/bvm0p5ppz4WJgpEDw5vQzdC2
	x+t4PIs7RMt/0at0g8dMXyAqULP1+/0bLGQPFYyQwWnlSfK2UA/++f/6ZXllDJZp9A9Ee3ZbsAa
	BCGoSC9h+w/KSxLBz2KP9yauuwIrYutVaOKCmXw==
X-Google-Smtp-Source: AGHT+IHYT/lHJ/KmvqL7SaqGdoczqsfadmaNNg8dY7DEGsvtTmxYpiRRMNBoaPAsZOUeM9hrJ0Cis2z02a5DwvTJsUI=
X-Received: by 2002:a05:6122:209f:b0:50d:35d9:ad5a with SMTP id
 71dfb90a1353d-50d35d9b726mr6394442e0c.5.1728982423743; Tue, 15 Oct 2024
 01:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141217.941104064@linuxfoundation.org>
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 14:23:32 +0530
Message-ID: <CA+G9fYuaZVQL_h1BYX4LajoMgUzZxJUH5ipdyO_4k36F62Z5DA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The S390 build broke on the stable-rc linux-6.1.y branch due to
following build warnings / errors.

First seen on v6.1.112-799-gc060104c065d
  GOOD: v6.1.112
  BAD: v6.1.112-799-gc060104c065d

List of regressions,
* s390, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection pointing to,
  73e9443b9ea8d5a1b9b87c4988acc3daae363832
  s390/traps: Handle early warnings gracefully
    [ Upstream commit 3c4d0ae0671827f4b536cc2d26f8b9c54584ccc5 ]


Build log:
-------
arch/s390/kernel/early.c: In function '__do_early_pgm_check':
arch/s390/kernel/early.c:154:30: error: implicit declaration of
function 'get_lowcore'; did you mean 'S390_lowcore'?
[-Werror=implicit-function-declaration]
  154 |         struct lowcore *lc = get_lowcore();
      |                              ^~~~~~~~~~~
      |                              S390_lowcore
arch/s390/kernel/early.c:154:30: warning: initialization of 'struct
lowcore *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors


Build log link:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.112-799-gc060104c065d/testrun/25432580/suite/build/test/gcc-13-defconfig/log

metadata:
----
  git describe: v6.1.112-799-gc060104c065d
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: c060104c065dc2884e301155e32dd955e6bb45b5
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/
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
