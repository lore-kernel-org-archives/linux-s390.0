Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92813AD3F
	for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798561; cv=none; b=LbGLRpVZlc8C6i3n7ACkJBgLeAXVd2WQIo6vs/aCa/oBSnsgy0xdiY8knAFjwJ21sjnwfqOokSh6RBufz6HWhC7ywrsHzbMPwi5+dCmvnaDgEm6hSoagRVIGe8gPoM45sj00wkP7wRGKlrBKHttYTtWAAUMEVcL5/HyfdrzmniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798561; c=relaxed/simple;
	bh=mjQpM8uJCD7eyFye+z53uA0Js+MvGo4jYaTp2h//ROg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npoJNzdkXc/quSO3Hgc+5o5c6LlK88TRpSwBeyPlZd2MdbNLcLcoCmrdpwfnWDk04syQjGgWOle7rTgby5gsmLabCHO1wPxghvfA7N68pxsV/4qWEYSyfD2No6F7BfCaY0QDqhpHfoiW0LgTBuu2mTCGVmqObIRXfGPe8Zf0fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyf/vjh+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyf/vjh+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so2269092a12.2
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2024 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798558; x=1724403358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WoJE6qKRAZwDfoJxwthtCXkhettrA6+z4VsWqqQmsO4=;
        b=vyf/vjh+wMxo42EurQnEE05rD/GWvW0yDykBL8zh8GfH1bdjHA6XnK0U67NT7P+jJ0
         jv6zf6ON4DD95L8UnSWh29LyYqU+0Yiav2VFsw+ZQUianJJHr4h7nVq9NUvwXoe7Zvpm
         aKEaXJkWk/WjiV5U9MeP/brYaVnmeqYuUz7Uc2i2prsytmiEA949UGHDRHbz/AZTKABM
         TuyqiwOUcOBEZiJNuglaIGCoPhyvGmu1Q0VVQX/pLtKi8lW6CjD+j6TfR0hCNOMBpnfN
         YREkNgTyocvtWUXbKAx5Ww9DGm21oYihD2Eh2bCM403/GObSYvt+bLu6kiwrmfNhqFPx
         rY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798558; x=1724403358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoJE6qKRAZwDfoJxwthtCXkhettrA6+z4VsWqqQmsO4=;
        b=IthXdAdz2wtpvNCUWn0nr/i2I24ixelmwi64qyI4N8ff54u2FgBSr3F4DohL/nVczv
         vxiA7WA5Zc+bgnjM1B9v9FgpZmE2o8WIRjb1QzFBE8HfA/72MhUfYQVOjMU6JHB8KHf+
         ss2YhhH3Y5k8sVcVB6V7mduGeqFkRedlUmewO7+MA7WieHmdtZrbkmr5klI+7XaAJ+gg
         0MzwEPyJuK7Hwq/Jr18WqZjuDXVJrcQ2LQZ/aWLW/rg67yC+IipUHUb0EqoTTBGk1zGM
         MRP63n5QOAmypjr6wbfuRtu4D4zAzGU4jDsMcEFDv5I46wmjW3ftyPXw5TBdLV6h0v4s
         PVaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7W6bnLxU9qEpe0jQ3CoNrydSaLWjV1c1kf9f6XRTLIBIknhiyMldbHwflbSV0GFoDTxu96tV8fo8PjqdUR5x6yCz9fgtK4PuRQQ==
X-Gm-Message-State: AOJu0YwV4a7vX9Kf/2zmn2IsuPcOh4FNSc2NhJ/MJT6T7SNTi6Ld3FkX
	Ko043qoooGNdoXIEuwaOYULhm35vRaLfQ8mfsO4wrhTD2sBLWvkXFfMJbmrqBC8F2UAn762py8+
	FLkuxbOII3jPJavaDezQXJaYb1NWPVEaEAFhqeA==
X-Google-Smtp-Source: AGHT+IFrl9O2aVZpsRSlg68IlGM1qKW5ruuvScEIT4Tazv0d8eLt4WP3OnNdG9x3zIM9/rrZHqWKBiXe2s8ieqbnOAs=
X-Received: by 2002:a17:906:730a:b0:a6f:1036:98cf with SMTP id
 a640c23a62f3a-a8392a0393amr169160366b.54.1723798558229; Fri, 16 Aug 2024
 01:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131919.196120297@linuxfoundation.org>
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:55:46 +0200
Message-ID: <CADYN=9+=+af8c=_GWSsFHoL7qX0=gFA69g_8mmJiJ43=p-2kzA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/352] 5.10.224-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following S390 build failed on stable-rc 5.10.y with gcc-12 and clang due
to following warnings and errors [1].

s390:
  build:
    * gcc-8-defconfig-fe40093d
    * gcc-12-defconfig
    * clang-18-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Bisect point to 0fbb54ce4bff ("KVM: s390: pv: avoid stalls when making
pages secure")
as the problematic commit [ Upstream commit
f0a1a0615a6ff6d38af2c65a522698fb4bb85df6 ].

Build log:
------
/builds/linux/arch/s390/kernel/uv.c:205:15: error: implicit
declaration of function 'folio_mapcount'; did you mean
'total_mapcount'? [-Werror=implicit-function-declaration]
  205 |         res = folio_mapcount(folio);
      |               ^~~~~~~~~~~~~~
      |               total_mapcount
/builds/linux/arch/s390/kernel/uv.c:206:13: error: implicit
declaration of function 'folio_test_swapcache'
[-Werror=implicit-function-declaration]
  206 |         if (folio_test_swapcache(folio)) {
      |             ^~~~~~~~~~~~~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c:208:20: error: implicit
declaration of function 'folio_mapping'
[-Werror=implicit-function-declaration]
  208 |         } else if (folio_mapping(folio)) {
      |                    ^~~~~~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c:210:26: error: invalid use of
undefined type 'struct folio'
  210 |                 if (folio->private)
      |                          ^~


Build log link:
-------
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-353-g4dac9055c10c/testrun/24874277/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.10.224-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 4dac9055c10c8973c91824a692ed00f3f650e5f0
* git describe: v5.10.223-353-g4dac9055c10c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-353-g4dac9055c10c
* arch: s390
* toolchain: gcc-12 and clang-18
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2khPV1GrHYOypPzmwQE6yACrEg5/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2khPV1GrHYOypPzmwQE6yACrEg5/

--
Linaro LKFT
https://lkft.linaro.org
