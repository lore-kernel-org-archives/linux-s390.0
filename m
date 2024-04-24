Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164D158219
	for <linux-s390@vger.kernel.org>; Wed, 24 Apr 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945439; cv=none; b=j/g8tJfxk8sgQwOvPiDmfVXzsC2nijQmGOhyt0rT356yBwWKQTS0Lcz26EyFPak6jMUFPKJCecLA8sicXXBlGh/7JyxI3D7PI8MltAaOqi5I+Vt33krRyRxQX+uFPAd2SDsWLR4BvuyUgpyO3MZAGvFMknVPSmzdI/khCp4xWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945439; c=relaxed/simple;
	bh=Or64OaneAWMEOpHLPP9hFWsP86VsJI1ybI9wBjzPf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df7sNI8JIpB8vP0kgPEwCM7ZC56HO+lbC54OTDaN5wgO9YAUyobBT7JWN7eVpa7Z5h/bmbkZlUtRoYSVk06ksfhYV/otsh9TGNM7oY7RCSZwmgdvqxmZcnIDWYRUj9Sqxcl8RQ4cKHxeySbZUGg2yItRolpWkQ/p7LSwYIHPBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkiiVk0k; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkiiVk0k"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ed6cf3e7f8so1051469241.2
        for <linux-s390@vger.kernel.org>; Wed, 24 Apr 2024 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713945435; x=1714550235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=gkiiVk0kU3cUlosxTNSomjqMd128jrplNoxCvP8jShbz72PusgBj608q6ETjgQVw7L
         tn5LUPczwDJLRRHMqstLwapWJRAmRJaRd1UNx6lGxiy6WBlSP/B8t5MuYyBvkDzrxKfx
         EdFvGSfxhiQcn30QtKHX4vQ45Ap+eLXum9L1/e9Nnt4poQY2YebEZ+IcRNdwyjK8gWt1
         d71+fOg0tBxIoeTrREXkzQvix2NYWWXaVXsxPm6j1PTvGoVDqBtgMWy7tQkdOSGM6PSv
         a3wcJsHKXk9HrdWn5Y7A8l+jONJ8wvzqBxNqJqAcXkhe3CQ/Bhd/dAguCxRB75gGx1YP
         SD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945435; x=1714550235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=lh8Jy1Otd42BhKIIexE/4zApMbhLeUAYPowA+DpPOqWSodSC7VJwV/xYPwCagglzmA
         mQQrHU/52brLs33M7TuhFJzGx+HVuWmyGLN3CV04oCNbr53ouAsjqgtFvNN0Re1a2jxK
         uxSjY5mC3l8SaSlq2GPYlbD+LDKWk5mfnhUIh03pV/6XJZB0rDUlflARG6Lj17nZTawR
         lH0c1cperr0XrO4Tdys8/2A9rAggf3gQxuic9DtV/LN8RKHAsghFsx1OCZ8tX4abTGAv
         khYHADQlAcszbt1aby0QwqiyhlkU28H9bSsL8DdJAIXb+airPyvto784AzTi761LeTp1
         wm5A==
X-Forwarded-Encrypted: i=1; AJvYcCUfhLkGZeCdK4aMsOlmxxamtW6sTJVm/+DQ41EhmmQsgaXkCKg+SdIzQ+C3sSUu2UXS4a06qniaubiuigUVEEQ3LET9+/VeEDRhHA==
X-Gm-Message-State: AOJu0YwSuE2oFT+wg8r0vITVTntc5sA6iZiViWsDZCBgXGq1bXoDyU5n
	uCny4ctuZrErchGiZ7X+EmiFrYbvURGJtcRP5W8wxsq0GYEvFHmmbprGnqQKrcS5RMGl5sM5Y0N
	MRhZJbfzzpUuFodLbQ0CkjGcefSA8wqM27+dc4w==
X-Google-Smtp-Source: AGHT+IFUwN08g7BSlDM6prRxw/urZVDh3+vum7FMACj7zISxNt8w6l0rqBWyuUBUbfTG9y+9p1LtvpT3K2vwBvNOvOI=
X-Received: by 2002:a05:6122:c89:b0:4da:9a90:a6f2 with SMTP id
 ba9-20020a0561220c8900b004da9a90a6f2mr1806626vkb.10.1713945434922; Wed, 24
 Apr 2024 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213844.122920086@linuxfoundation.org>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Apr 2024 13:27:03 +0530
Message-ID: <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org, oberpar@linux.ibm.com, 
	Alexandra Winter <wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 03:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 defconfig build failed with gcc-12 and clang-17 on the Linux
stable-rc linux.5.15.y branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---
drivers/s390/cio/qdio_main.c: In function 'qdio_int_handler':
drivers/s390/cio/qdio_main.c:761:52: error: incompatible type for
argument 2 of 'ccw_device_start'
  761 |                 rc = ccw_device_start(cdev, irq_ptr->ccw,
intparm, 0, 0);
      |                                             ~~~~~~~^~~~~
      |                                                    |
      |                                                    struct ccw1
In file included from arch/s390/include/asm/qdio.h:13,
                 from drivers/s390/cio/qdio_main.c:18:
arch/s390/include/asm/ccwdev.h:172:50: note: expected 'struct ccw1 *'
but argument is of type 'struct ccw1'
  172 | extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
      |                                                  ^~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/qdio_main.o] Error 1


Suspected commit:
--------
s390/qdio: handle deferred cc1
  [ Upstream commit 607638faf2ff1cede37458111496e7cc6c977f6f ]

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.156-72-g70f39a25a6b8/testrun/23638097/suite/build/test/gcc-12-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFs1EvyrjLKUD3D6ODW0Agksv/

--
Linaro LKFT
https://lkft.linaro.org
