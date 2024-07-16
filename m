Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C83224
	for <linux-s390@vger.kernel.org>; Tue, 16 Jul 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162888; cv=none; b=lL/GudV/brZADdFpxJeepJig8eS4NxDVfS6BTVFF9G2yY5KgYv630ctkIPbYAGv/YcZtSwEQ7BDgEyIFmNQoFV1jpjWwiIREM4sU5B1K/TgkOPHEMLRk4ePJGdhqBYyCP9qutD7k3VCN3pFFQHf8oRkRuWH6lgbBF3ZxWE6O+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162888; c=relaxed/simple;
	bh=4Ur9xhTL+sC+z2fRn1LeIE7AdwT2fsvHEHXp8cMQVuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJiYiaY4IReOQtTDLKFfCYCRAohxggWnCmTwEq8CHdM5Suwpy6SGkLpRg/hg4RPKAbU6HChZgnDo4ZsUlBZdc/Sf5qR7iLoDtUhwi5qpMeac29MJH3R6/3vM2JqOiv97AFr5+AZYu9Raen7Ao6ofVNuqPqXO1M7gKVb6rRNmvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeEWI9Ey; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeEWI9Ey"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeec60a324so30288071fa.2
        for <linux-s390@vger.kernel.org>; Tue, 16 Jul 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721162885; x=1721767685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c6GNJjXe4aQne+TSaa8LyLS0Eu5HZLIaZpjqqmJNiR4=;
        b=VeEWI9EyciqbuLf9Wa6+20MtEkcqAiPa0hUJdiMZRrfK19fu7kvXwJt26/ApcaKTEd
         3johlFxLkv9XlRej+faKj1CpexjMXPyZyZThJsn475vAOzpLeWRGDSoz0Fp34IC4j4VM
         fyxkDvlmlW2Xz0pHzCRsLPMFjxKwKwIjAKmUnQzq8e864Xx4vO1OMItomdxA9mL87+1I
         irU8Hlhy8NbKe9lud//6DUr9DKYueQ23DzmA13k74Tkog+qOoMcKmKChzqqLYG1WihQK
         ekcxNqYjIn9ubooPSvYwt5+idyhK5cqLcFBbk2Bvi+ePDfNe5rWaGywGCRy7+c8p24xf
         c0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162885; x=1721767685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6GNJjXe4aQne+TSaa8LyLS0Eu5HZLIaZpjqqmJNiR4=;
        b=N7I1NYs8LOBkoT1a4NMACw57OszY47tP08dSZA3dkEVWNVs3mfbiIC5uCP2IOTtO4F
         PX0lxQEfmXcQAOp52Afqg+KoNRfxnk28YpquZlQTwu2xlM0+As9YBL6/plBu+eltIbJ0
         zfJe65bzmeOA2EQoqUMVeHvDel6qwpSYTS46oM5dKOvqZilFkEJNtM8HM2muSsov8y1m
         wJuuxHxjR8lloQHhjdJcfs3Z6bKiRecrlIbGXJFrHm/dEePUUCB5itPJlEHx3l/YY51d
         Iu72PSVk0u16bld8cQREhlGdFnMGSyUu2oAEdnjDf4JGjHRPF3FsNLWrlefaW1Unqn9O
         926Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaS2wdG0daV4nqBRP5Xfhwrx/idcy4MvVo8Qac7SayXO0enax408GXWX1ucs44DiY2kSUN5xeTpqMAxajByX9h4nIB6xXU5azJVA==
X-Gm-Message-State: AOJu0YwY4Eu6k+M92VgqnbYaTKhAAWlQNmuBdy/MDHYEcxvpS2ukIcod
	nZUwppdgKavr/ibVs4DSvDr6+p8FvwW7wWHEzqsrBuzIrKZwv8CpoCm1Ui4vywKqaO0a8KPe6z6
	uwPprqgFYjH4745PxpLjgckoUoav7GruGenpRCA==
X-Google-Smtp-Source: AGHT+IHWB9+UFZMeujAczzwgAyMeRBak9A7BEJ7/zhXCtvVtyq9dOdepGTchh2FUJeUis1miwAnEDhoODIErtZbpgPQ=
X-Received: by 2002:a2e:8205:0:b0:2ea:e74c:40a2 with SMTP id
 38308e7fff4ca-2eef4173e8emr28566101fa.20.1721162884653; Tue, 16 Jul 2024
 13:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152745.988603303@linuxfoundation.org>
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 02:17:51 +0530
Message-ID: <CA+G9fYskex_Z+r0wxv7XDdPVHrk=8jBPWH601mY_Q2mKDj-T=A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/108] 5.10.222-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The 390 builds failed on stable-rc 5.10.222-rc1 review; it has been
reported on 6.6, 6.1, 5.15 and now on 5.10.

Started from this round of stable rc on 5.10.222-rc1

  Good:6db6c4ec363b ("Linux 5.10.221-rc2")
  BAD: 4ec8d630a600 ("Linux 5.10.222-rc1")

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------
linux/arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:255:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  255 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:255:19: error: '__uninitialized'
undeclared (first use in this function)
arch/s390/include/asm/processor.h:255:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:256:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
  256 |         unsigned long addr;
      |         ^~~~~~~~
arch/s390/include/asm/processor.h:258:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  258 |         psw.mask = mask;
      |         ^~~
      |         psw_t

metadata:
---------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrKyHqAZ7eSsKwMSVqDueYpKo/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrKyHqAZ7eSsKwMSVqDueYpKo/
  git_describe: v5.10.221-109-g4ec8d630a600
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 4ec8d630a6005e1aa82671aca9f6716039f5b6e7
  git_short_log: 4ec8d630a600 ("Linux 5.10.222-rc1")
  arch: s390
  toolchain: gcc-12 and clang-18

Steps to reproduce:
----------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org
