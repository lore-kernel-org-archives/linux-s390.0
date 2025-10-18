Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3E2F361C
	for <linux-s390@vger.kernel.org>; Sat, 18 Oct 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784166; cv=none; b=XAViStAr00DowN335qs+SwgxFjVCIm2LmyYwTHVRbHnAt3FeipkUs4zrT567qELxWY6AWltpO320lIttl3u4CV9ajpjxczgr9Z7ol1K+wGnw/94spOYFVE/GE+sskIhG64emMDnQoKB3xAVy+oHozRo+IhYq0Ta4vArE+zdFsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784166; c=relaxed/simple;
	bh=eujZEm26QNomQ0uZsPlsJhjB6dXoxCoQV/63rJ+xGzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US/6VD8MpbcvIhQ+hh+DPlAf7Iws213Tnz2Pck2rduoMvMDsAIwNBkj9Ou3YTrPTfWdlRKNPsFZxdDmqiqfr2PmsO/QrqNZLFUkN9rFk9o+3MQCXyFYCVe+4/rZkoyKl0w+J/OFM132Kt0WJVIqbOs6v8Rnx/fGBP4sMM3bBYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeTFPecj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeTFPecj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55517e74e3so2946894a12.2
        for <linux-s390@vger.kernel.org>; Sat, 18 Oct 2025 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760784163; x=1761388963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKtCJR7APuqaYl6bh3Ms7NkEOrtscFZrf4VBLleXnTg=;
        b=GeTFPecjlx/di6r08ytrMbzemmrjXaCZ03OFRAlWUTSPrS9foXp3N/iY70c7MZwg+v
         wSlPcnsQyUtlnjjDwKmupJpRmwZ8D0pIrV2/y/UWHYbnKum8YWo8/j4jPJVNhSQ9f4wE
         /5cywRxR7C4tmxfK6OrBtwR/XYg3XXjqzknUqCCc+03kDK8V933C0m6wvAmJwZGgDTa4
         P/knCM2WLsegD4uZvKuBpjNHIZYwkS7HKZtFadPPp5uSY5LG+nvGKDWLliDRm5yt6pT7
         /dBZT0tTEabP51SxntHGwIVZvdeuAqWvEDOFlleahgc9i/dyjeIVULEKhgdai8bfFFtf
         NLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760784163; x=1761388963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKtCJR7APuqaYl6bh3Ms7NkEOrtscFZrf4VBLleXnTg=;
        b=UNbe0KFjkBpoZ6qs3kR8BXEMccJJzpQuUeK/djqytBxeNcKCRs20CZWNuFfTUcU24n
         CERFatJopqVZzKYA7F82IJyfDhq2ynXUF6qsRG2f8fAkylG6WUwtTey8t4Wclw9kRoRL
         w6BIxgl3UInkdRKBH+/yeVUVvmMT+OfcixO3HqfEQYjXiJq5UDru7q4dY9aItobZcRl+
         6DitmK4UPQaDnRf4MaACS2sPLfXY1dF6KhbpC0hCWl8tajcVdGOW587XdikB4gx6Jsgi
         PHy8VsBBbPRq7TtVHAFPLUkpwinNFHK1JC3tya6EMasK7BnMSQA3DljVXhhay5L0dDYZ
         7CQw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6ky0teyjto4nYea18eZwzvEb7Tote8oRXQsdG1loM6Y2Scrha3FxyfEOTypwP90Y43HsWr0LbVOi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrpeeb+UDJ/7VyglqkdS2y9NA1GArwBvNXwwyraARK75Rgq3kw
	b5e1nlt49ZqENJS0SCGDGL2GFDavcef5InRd6upUdtqVPh0lS2w6svGuMu0ehgJSfAC3bOcRRU3
	L14E6RJEW6xDzQaPnbYfobRT+cd9A+hF9ruqGyywMRw==
X-Gm-Gg: ASbGncvfwH1edxfgcS5DKn3Y6R9ibgllEBaIP8uoS4F2bcyJKKIAA8YOmJZTipoTlln
	Roa5NtLHvESlDOpURHz3w15bMjP3U3+KUeAdfgiV9Dbu/COveoqfzHE+jDGNqoKo97VZqgZP2vf
	FeylQB1Hm98RPQ3voI98ePrjSSOQQgq93kDSwcmlW16/6tnPr5RDdbLWRKAaIFXgGT/zRpGWh2j
	b2vVwsj9PTrDOqthYdhYMERT203eDcDVf4SOQIAC7dmLuFnMSa8z6yaYPoTnGvDX7LZgWpqCmSU
	sJ71fcQLMo6fHSNX8PEHtOKid7qopjEw0Vr2YZxXVRmD1D5i9aeNOrQCBhc=
X-Google-Smtp-Source: AGHT+IG4l8FY9Rly63iVwkF4ND9jy7VhkbE+KZiG23qYJct2RnQ0jxSB1oZo571w+5Hbj98wxOCUhpezndZy+8OOhOc=
X-Received: by 2002:a17:903:2309:b0:262:9c4:5470 with SMTP id
 d9443c01a7336-290caf85241mr87472235ad.28.1760784163263; Sat, 18 Oct 2025
 03:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145134.710337454@linuxfoundation.org>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 18 Oct 2025 16:12:31 +0530
X-Gm-Features: AS18NWC1tQ1llFX7LULrRrpUFjdOIk2jZcXVw-IyC4sFHqzmRTWSi7dadzfwsO0
Message-ID: <CA+G9fYvQMwxB2LHpZPkQ7nUDkVw6LbMnpRif=tq_A0K69aiGVA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, linux-s390@vger.kernel.org, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The S390 builds failed on stable-rc 6.6.113-rc1 with gcc-14, gcc-8
and clang-21 due to following build warnings / errors.

This reported regressions also found on
  - 5.15.195-rc1
  - 6.1.157-rc1

### Build error:
drivers/s390/cio/device.c: In function 'purge_fn':
drivers/s390/cio/device.c:1325:23: error: passing argument 1 of
'spin_lock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1325 |         spin_lock_irq(&sch->lock);
      |                       ^~~~~~~~~~
      |                       |
      |                       spinlock_t ** {aka struct spinlock **}
In file included from drivers/s390/cio/device.c:16:
include/linux/spinlock.h:374:55: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  374 | static __always_inline void spin_lock_irq(spinlock_t *lock)
      |                                           ~~~~~~~~~~~~^~~~
drivers/s390/cio/device.c:1348:25: error: passing argument 1 of
'spin_unlock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1348 |         spin_unlock_irq(&sch->lock);
      |                         ^~~~~~~~~~
      |                         |
      |                         spinlock_t ** {aka struct spinlock **}
include/linux/spinlock.h:399:57: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  399 | static __always_inline void spin_unlock_irq(spinlock_t *lock)
      |                                             ~~~~~~~~~~~~^~~~
make[6]: *** [scripts/Makefile.build:243: drivers/s390/cio/device.o] Error 1

### Suspecting patches
Suspecting commit,

  s390/cio: Update purge function to unregister the unused subchannels
  [ Upstream commit 9daa5a8795865f9a3c93d8d1066785b07ded6073 ]

Build regressions: 6.6.113-rc1: s390/cio/device.c:1325:23: error:
passing argument 1 of 'spin_lock_irq' from incompatible pointer type

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.6.y/v6.6.112-202-gef9fd03595ef/log-parser-build-kernel/gcc-compiler-_drivers_s_cio_device_c_error_passing_argument_of_spin_lock_irq_from_incompatible_pointer_type/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/config

### Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig


## Build
* kernel: 6.6.113-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ef9fd03595ef20d45159b484886170cccb77e879
* git describe: v6.6.112-202-gef9fd03595ef
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.112-202-gef9fd03595ef

## Test Regressions (compared to v6.6.111-197-g07c1c4215e92)
* s390, build
  - clang-21-allnoconfig
  - clang-21-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-tinyconfig
  - gcc-14-allnoconfig
  - gcc-14-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-tinyconfig

## Metric Regressions (compared to v6.6.111-197-g07c1c4215e92)

## Test Fixes (compared to v6.6.111-197-g07c1c4215e92)

## Metric Fixes (compared to v6.6.111-197-g07c1c4215e92)

## Test result summary
total: 120291, pass: 100081, fail: 4386, skip: 15390, xfail: 434

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 0 passed, 14 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
