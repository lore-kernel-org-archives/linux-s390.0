Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1A1C68AA
	for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980496; cv=none; b=qZW7sL3BQLDKrW+24952gd4n07/cpqOeDSyqzcwke8obukqO0k0xEArzTBUUX87NdFnQWYofmYAgdMk5x2jOPXCMSlU80PVCNwgFUTnjjy3kjgEHYV9k51+gY1I9QESnAj5fThPBdvnsdbg8P2I20oEfEUyu0MgRfpLzfy8ixqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980496; c=relaxed/simple;
	bh=zD3HmgW+TlfcyOvp2QLRv/48BOBk+PPPEeanN3RBWTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuxVcVwDTuA8OZ6cnX5PQgz6M18hMsXMTu1SLpCzMp2ld3jh7bji9hSTHlnDKGO/8SjFlkUsdB4sJPD+7cRLy4R8JEHaXNmrhmUaOrV8vsZknBXJq1N3QgApyz8kMYvVt5+YIqmXXgKSIsgyudFLL2NFRIVYzc2vjb6zgDRCDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJxQl/vG; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJxQl/vG"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fbee98881so921177241.2
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728980493; x=1729585293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lW8e1d56O5rgpMPsi4Gluv5d8nw+f0Vj8iqFfuuPxRg=;
        b=cJxQl/vGpmKCoYKFErbas4jm6IAU2jvM2UrCApMSZcOM0lNU8P5ABW5E6rXEurnSGC
         ATyi8msajb33+8h/hVgq+Zg2/ptVOMgPNLu/7p1HNAmiWQXpG08j1jUpObu/lMWqYTXt
         GLTbsZazjAndN/8fpPLt1ESL7k93Uh+MzpV5HnOxZOqSifqYhuLb1rD2c3OhyAR121Ai
         Zf7FA18zWWXOxiboOg/sV18lll4SE9/xcEXcNT7srWp+DPBlT+l763jCdVwK2owl3EPy
         dUTQtlc4dtTMXRtlV0Nx/3U+mxN/5ZR0T5ty9ruWsLkxchMOe/9I0UassSRe8hEpvX7B
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980493; x=1729585293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW8e1d56O5rgpMPsi4Gluv5d8nw+f0Vj8iqFfuuPxRg=;
        b=vYZeopToTouW1RhhSN9GFwymOuUewWbI5Sa6uoa8SSPbxX8aHl8MGfMc78/qa1rDyI
         gyf5VAjoKNOd7HcTg7HTEo4FLtnlApUSKLGIF3oPlN3hkYW53OvswQjsC5Ijt+gKmBtD
         1GzH0+Qqci+kUGctJHXSdr+z+BeU0I8eoBFQGJ1TmuBgrIq33c0Cj2v5XWZwhFVpbDfC
         6y/96J/ONWiBTP6z7WB5dcv1uxl0y4onv4m1k/I1ZTrKiCek3d9MaWuwAUaiYE5oGZhN
         0X4PauK/GbS/fZ8cbkvgArrYCQ1j6tdNdbLbsnWS/L4zl3MZo3LrIxpQWNDorpugus1V
         P8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWqVjKNxekoqUQb65R6vTe4kzomkTgBXoMn40mKDKDXhs87P/Qa50e6yeOKIg4bxvRe87jo5/Mqz1Jp@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5OzG13UUzuPk8lg0wXIWznUckhSkDBM/tZ78dSJNc23Dn4ED
	mmCoIRJvBvHWP7o1RgMqN84eiiGvjPkJuBnloOSdGKxFLhPClUxtGt39c5w0S3BSUJzka9cM9wU
	ousn0TPEo3SGYFb5CBaNqsyMNvqv7H5j8lD7Gzg==
X-Google-Smtp-Source: AGHT+IFUIwYSu6KbEUAyth9XxFqC5nZrcsAdb62v1PqnR10rTpKu/1c9tc94aN8gqcFnCnBkFhMxBIdlbJj9h25BLbM=
X-Received: by 2002:a05:6102:cd4:b0:493:eebc:d77d with SMTP id
 ada2fe7eead31-4a4659ca79dmr8656632137.15.1728980492921; Tue, 15 Oct 2024
 01:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141042.954319779@linuxfoundation.org>
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 13:51:21 +0530
Message-ID: <CA+G9fYs-BXW2J-n1R7VO2j-qqpP=3nzYC4a2C7=-fnLTW8OR8w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 build broke on the stable-rc linux-6.6.y branch due to
following build warnings / errors.

First seen on v6.6.56-214-g8a7bf87a1018
  GOOD: v6.6.56
  BAD: v6.6.56-214-g8a7bf87a1018

Bisection points to,
  d38c79a1f30ba78448cc58d5dee31c636e16112d
  s390/traps: Handle early warnings gracefully
    [ Upstream commit 3c4d0ae0671827f4b536cc2d26f8b9c54584ccc5 ]

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

Build log:
-------
arch/s390/kernel/early.c: In function '__do_early_pgm_check':
arch/s390/kernel/early.c:177:30: error: implicit declaration of
function 'get_lowcore'; did you mean 'S390_lowcore'?
[-Werror=implicit-function-declaration]
  177 |         struct lowcore *lc = get_lowcore();
      |                              ^~~~~~~~~~~
      |                              S390_lowcore
arch/s390/kernel/early.c:177:30: warning: initialization of 'struct
lowcore *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:243: arch/s390/kernel/early.o] Error 1


Build log link:
---------
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.56-214-g8a7bf87a1018/testrun/25432877/suite/build/test/gcc-13-defconfig/log

metadata:
----
  git describe: v6.6.56-214-g8a7bf87a1018
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 8a7bf87a1018a21d9dbbc5a794cb9a4fb3243aa0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/
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
