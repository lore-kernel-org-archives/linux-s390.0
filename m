Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857EC230BD2
	for <linux-s390@vger.kernel.org>; Wed,  2 Apr 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596525; cv=none; b=txJrBpepBiu8iKgTEfjr1lZ5nU8C/plJo5eKT0qCG0SkLWPSerAt5/5lALGegtMcUGEFdwDDkr3SZM2UtHu4mdb83tHQa4Bf5ThLmYEMcs7Nq6swMna+udjdW5N3iAlp0oJGiPG+N6VFxGhIbDmS0x2NsCvP2jtAtkPB+Bu8frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596525; c=relaxed/simple;
	bh=hFmt9tVTbnzz6IMTCrEPKn6NiL3yOalLnxXBtm1hJ0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aIrPribPWzmvz5uxmcbHind3wTjl/dprIJUwUkiR4wl/QiaNyvt5tx74JxzBkd6BHnQgH/KHK+uRsrTBZ2/zhA2aLbdDSoKivPKQdivGG+d/j6EqwwYU5E+B94DwA8uxEIQRYer99LqfeFCDREik6U/hJoztlMa59qDP8vqaS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BV3YxtRH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BV3YxtRH"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-525da75d902so2857959e0c.3
        for <linux-s390@vger.kernel.org>; Wed, 02 Apr 2025 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743596521; x=1744201321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qD/PMOyx9XK9R1d/xQ4M0XKWGpm4ZEHxb/f9TzxVDzc=;
        b=BV3YxtRHwmumFk4OibmAdJCeTgwWG3pKwGnOwegbztZp6nmrtL67W4+P0p4hClb/WF
         SdtFnXuDSP7VJG6GtRfAHHpGzvC0KAxw5hODZ8mVXBb8vlIIWbGrL+9JUQ8/AcpMNarm
         4vVxjyIB0j2LlB8LLhCgORbnSnff/f4pKepG/58wL9pnPQgIcYH04ay/GgR3DegiBrbO
         IHPq/PpVKqQnM4SAUA9bWK43EdWcRWj2ZTNy3uCM9MEcS9CEdHoHZVICBBsa9Zgfl9qv
         INpQoNalbSjITd8GgEpUHu83+uyPm8HVq4ZcKeXrzZumbYVXSlzC24Ak3keH/HcADeQj
         yqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743596521; x=1744201321;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qD/PMOyx9XK9R1d/xQ4M0XKWGpm4ZEHxb/f9TzxVDzc=;
        b=Yuc8Q3BvHV+YS+on1P/pPqgW5QzkraElwggTqVhABeQzvgTECmybY0eQuvFAi5Byjg
         gcSoH080Z8Abef1pRZp5aio6INYFTHU/yLY/RhfsZB+gHJzkHNrQP7ioS+7En3hjc+b8
         BRSxrxSYb3KWrMfOJT/Q/fr7GE4tL5zAClLOwhSlmiynOD3sopTShMLWwcNd5qg+09ZY
         OMfLKXew51bkCYHrq6n/NxkNgfpC+eGxca4V+WnR4B/fzObTnFCVg6iMjRpF3QqLOev8
         oJ4mEW6HGxu6rToCltgydr1LB1vTAAQFxgbH8Nv9Wv2DNl4DOGPzx05AEHcmQgqwW7wV
         bO6A==
X-Forwarded-Encrypted: i=1; AJvYcCVdZPK8aYN+e+4K8+gGAzPuY6UJ/MOCyqDUMo/PVXQ8xHocalmKjwXGEelUxOnyLtEO/1xx5iqpMDu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1AC+ARjNBfPKhxM17Kiovr1XMnU9SuWcOGiCzhz0mje59I6Pi
	uYCBvvjDBnKTJ2Bn4+ZTTw6boSVcG5GHVxGVyFzxaAt2joHKZKe9YgOtyp5ZSBke+ozxMK+2Oqy
	EhOR/+FUWW5qymgoukfrE47aAAfUyJmbzipOW1Q==
X-Gm-Gg: ASbGncuf8pZjyZOfDjRlsZJLMBv/sVnz9KzTXf61lhILXTvwYIBGgSenPr9BylKmB5R
	oi9OKQqyoHYc8wUX0woaVxP/jBknVNPKf9haFhN7OHG53XWojoP8CSL/SjalLclhf4Y1uY/BvS1
	X68LyJjmFyx/mPtHB2d4aACAnY8UCS/sSceJq7PC8LgEsJQGTZaxyx9c2fN2w=
X-Google-Smtp-Source: AGHT+IGZd1b5fqfa6pHXvxexGDlAKss+FYCovowlkAi3Xj1GtUKyZmc4loNHv1qXkrx3HBYz8r1MbDuMAFYoP6L8Qfw=
X-Received: by 2002:a05:6122:1ad0:b0:525:9440:243c with SMTP id
 71dfb90a1353d-5274cfb95a2mr1043348e0c.11.1743596521224; Wed, 02 Apr 2025
 05:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 2 Apr 2025 17:51:48 +0530
X-Gm-Features: AQ5f1JqYWbXD84vj9qiHXH7fpaSiEYXFSjnm4-yFz-CnOCSphgOZJOvkdDjcXGE
Message-ID: <CA+G9fYuQHeGicnEx1d=XBC0p1LCsndi5q0p86V7pCZ02d8Fv_w@mail.gmail.com>
Subject: clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
To: clang-built-linux <llvm@lists.linux.dev>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, samba-technical@lists.samba.org, 
	linux-cifs@vger.kernel.org
Cc: Steve French <sfrench@samba.org>, bharathsm@microsoft.com, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm, powerpc, s390 defconfig builds failed with
toolchain clang-nightly on the mainline master branch.

First seen on the v6.14-12245-g91e5bfe317d8
 Good: v6.14-11270-g08733088b566
 Bad: v6.14-12245-g91e5bfe317d8

Regressions found on arm:
  - build/clang-nightly-nhk8815_defconfig

Regressions found on powerpc:
  - build/clang-nightly-lkftconfig-lto-full
  - build/clang-nightly-ppc64e_defconfig
  - build/clang-nightly-lkftconfig-lto-thing
  - build/clang-nightly-defconfig
  - build/clang-nightly-lkftconfig-hardening

Regressions found on s390:
  - build/clang-nightly-lkftconfig-lto-thing
  - build/clang-nightly-lkftconfig-lto-full
  - build/clang-nightly-defconfig
  - build/clang-nightly-lkftconfig-hardening


Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: arm powerpc s390 modpost "wcslen" fs smb client
cifs.ko undefined

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log

ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!

## Source
* Kernel version: 6.14.0
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
* Git sha: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
* Git describe: v6.14-12245-g91e5bfe317d8
* Project details:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-12245-g91e5bfe317d8/
* Arcitures: arm, powerpc, s390
* Toolchains: clang-nightly

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-12245-g91e5bfe317d8/testrun/27856145/suite/build/test/clang-nightly-nhk8815_defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-12245-g91e5bfe317d8/testrun/27856145/suite/build/test/clang-nightly-nhk8815_defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.14-12245-g91e5bfe317d8/testrun/27856145/suite/build/test/clang-nightly-nhk8815_defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2v9EdO7KHQCCZBICM0MvpaTUbLm/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2v9EdO7KHQCCZBICM0MvpaTUbLm/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain
clang-nightly --kconfig nhk8815_defconfig LLVM=1 LLVM_IAS=1
 - tuxmake --runtime podman --target-arch powerpc --toolchain
clang-nightly --kconfig defconfig LLVM=1 LLVM_IAS=0
LD=powerpc64le-linux-gnu-ld
 - tuxmake --runtime podman --target-arch s390 --toolchain
clang-nightly --kconfig defconfig LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
