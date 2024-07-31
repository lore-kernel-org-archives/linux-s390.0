Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349F1A4B47
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418662; cv=none; b=I6J4kqJ2AGPmLDooivt5KpuojwqgwmGzfrJ87s3HtrtXEzs7BNN5h+aFYcNgslfVVRRL166b4k3pVuKaaYSJ3fN2XL0IsdLki3fknqnz3vcst0BJCQtREnTXp21wLgbLLwpohNv5aqy7zHUwJGw6qZy6Zj9N4R3khegvsKuhGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418662; c=relaxed/simple;
	bh=3PqYnVZVjS8Nchubqr5TZb9ZbM9gnu42tzIZibGM38k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQfVF/Oaa8ExwqmbIdHP8jkhDePX94xnzkzVv06Swv7EMzmDcGktbD9bvxv1bc17vBgPz1tgSG9pcYx0InsttL2so76tsy/wDFQBKjR6Xt8NtBfRUmpouunvXEe8bKpo1myUhRmTFVYxh2I69hq40opnhyywOREChsi5ZhhOtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zL+OcRKB; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zL+OcRKB"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4929992a5e2so901831137.2
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722418659; x=1723023459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUB2XfCmuTVubROS/hczkI5vuM+eVf8X/sAgSSkYLs0=;
        b=zL+OcRKBsCiyclo0+DZyLAm4X0o55M4cplNreqSoGDOPCt+E3sW8WCAH5QGD87v2Cc
         xyfbKwOhG2GaPgFxrIyUACzSpueEGGXlrMujL9MnEm4+GubW2HkXjjT//JN8YrJKjAI2
         H+4lcKIhwoX/mEFFadDknOKPbRzm2flPZaBV+3BIoBP2fVuyK/6OsmzufJj5XJYCUdJS
         X0/7IA6DNJQOADrnlpxOGD/SMjhKhBQE/ppZSXexPOIMpq68oFPT2iod5QWfPOtmFyba
         vc0eReBqbcNQXEe5smxc70+8DzX5mJ0gy/plwRmM16WeKHwLAwd4sRWiI0Nbeg9uvsOj
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722418659; x=1723023459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUB2XfCmuTVubROS/hczkI5vuM+eVf8X/sAgSSkYLs0=;
        b=S20FMkfY0b7r5QX0kgCOYb7t5gSVtVVU1SIzOPyF3j1Cwc+ZGWkn7WjptnHot0ZrTg
         WSBjB4eAsWSelRiQDzrRqxuPUOJRkS2ppC1gV4r98czaPTfAHjJ/oDuHR4CXWf/FFYgs
         rda4D2bkqQJCHG6ubRhBx+Hx+tYP1JtOUxLOfU6L4K0Szd5Fg1WKA7hgUFQ0nD10ykcE
         9hYktCUcIyzR6wyn3b4ddtuSQwh/XRAfy7g6vRAvRDCoCbblAiZrKyNRRv/yF//NgTJE
         bCjqAHVsBDvjs6tWuA4DU8dm2qMBAxHqEzrWhom+GN3ZOFjsdaaIFErYnij6Vhq2gi4R
         f1tA==
X-Forwarded-Encrypted: i=1; AJvYcCV6W6Uyf8F9wYvXHglLAv25+KAflQafu7OvMAwr+Zmw6dvaEchZw9SCJI1qu+jLEKNbTdGCEdRQ2HYM42VcDrBXAl+k4pdolFcqOA==
X-Gm-Message-State: AOJu0YwEcGMtwx0ytBy24M5X36fjW/P/SEfofdqR4TZpyRYFYon4UaMa
	RFcK7U7t017p2CTBKY+nxHDTCJFbSlHbnmO6BgmJDVTUZUU2aOb/qRSUktFo2gQbm+mIvdbMcUE
	lGW82Ue/0gyRVO2lVmgqc9rfE+LzyDMis0PLV4g==
X-Google-Smtp-Source: AGHT+IFwnHFkgq2DRdLx+mwGenItfQdCUaBvRiNx3dWS7SZyP0MZEu7BMjqAOHN1DQFd77LTqPl7sD/Jd5/SE6O03hI=
X-Received: by 2002:a05:6102:548b:b0:493:bbd7:3ec0 with SMTP id
 ada2fe7eead31-493fad0d470mr11329869137.23.1722418659376; Wed, 31 Jul 2024
 02:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731073151.415444841@linuxfoundation.org>
In-Reply-To: <20240731073151.415444841@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 31 Jul 2024 15:07:28 +0530
Message-ID: <CA+G9fYsGYtFhoSZbv_s=3TCSYis-pSPDJ3LJwxbtv1_9+Q61JQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/441] 6.1.103-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 13:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 441 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 07:30:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


On the 6.1.103-rc2 (and 6.1.103-rc1 ) s390 builds failed with gcc and
clang due to
following warnings / errors.

* s390, build
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d

Build log:
--------
arch/s390/kernel/perf_cpum_cf.c: In function 'cfdiag_diffctr':
arch/s390/kernel/perf_cpum_cf.c:226:22: error: implicit declaration of
function 'cpum_cf_read_setsize'; did you mean 'cpum_cf_ctrset_size'?
[-Werror=implicit-function-declaration]
  226 |                 if (!cpum_cf_read_setsize(i))
      |                      ^~~~~~~~~~~~~~~~~~~~
      |                      cpum_cf_ctrset_size
cc1: some warnings being treated as errors

commit log:
--------
  s390/cpum_cf: Fix endless loop in CF_DIAG event stop
  [ Upstream commit e6ce1f12d777f6ee22b20e10ae6a771e7e6f44f5 ]


Metadata:
--------
  build_name: gcc-13-defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0Kna66eRxxtDjqsue5mHG0j8L/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0Kna66eRxxtDjqsue5mHG0j8L/
  git_describe: v6.1.102-442-g5ad01ec1b787
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 5ad01ec1b7877a0e30c018e28e3909f96dbcef8d
  git_short_log: 5ad01ec1b787 ("Linux 6.1.103-rc2")
  compiler{'name': 's390x-linux-gnu-gcc', 'version': '13',
'version_full': 's390x-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0'}

--
Linaro LKFT
https://lkft.linaro.org
