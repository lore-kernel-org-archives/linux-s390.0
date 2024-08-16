Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A813B290
	for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798372; cv=none; b=mMdvd5XYEIEsfb7Z5nhQUj+T6hCuNdaSqLzKjEIAvUiI+pgKkWictA6GSJgpwKYC2ukSJK164x7w06khJ3Z0/vUcmHm4lHGZcDVNpHG/ubCHcsXsAl1VxcjTTehLD9pYt2hl39uPsbeHHXNRh+SogYo/syy8/UR+Cx7lGp058yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798372; c=relaxed/simple;
	bh=b5VjYZomUq4QLo7azRFOK7rbYbpMDyOD2BeliqnLSEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S85ThbMzyjvGXLbeE7BzptDs2xnSW/xC0sOljlMTwuzfOir2+Irt0KX05YQIrARaqcFKyhRbPJBR9IAKTn4EQXUWMe9lHPaFoR6TeAAW+vOufpVSGIuktVSUrQp6V3mmR0HQ4CECsKYuJXMkCfAWIpEQ02KnTvTrbORVkQuhx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xWCC/X2T; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWCC/X2T"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so203314166b.3
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2024 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798368; x=1724403168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e65/T9qUroc+GcaiwE/lqgYH/wsQj1WvG1P77AhxpUg=;
        b=xWCC/X2TpwmjIGipfFEpDxv5y1El9y+qODbwZVJ64dgOSQgeeS5Z7VvVZomsvtWBdU
         T5YylnDciDMHHKv7GRxtmMll06j9S5I5JbTTuB0emU6XJiFuTJctr2fZ16L/iL+XIsqJ
         +rp9oivjrOg8Zpk8U+W3Dol529jMZuIPiy2p3g8bMBz5l3iGA1mZGEYJ05REljLz+DpY
         jMit/aBrJHbypMlyS1hu+mmX0tnGVH+NYYBSVhu/z5jczL095mVQ0t32HBeREzEFhGf4
         q9BUeXFg4jjeV2itzdCjQ86kTc9FwYrTpntSovLSblwcaNl8F7KtT7VWqDFT04wGnErh
         GT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798368; x=1724403168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e65/T9qUroc+GcaiwE/lqgYH/wsQj1WvG1P77AhxpUg=;
        b=WquIndhWOqn/ikrbCxxVLrj7GKOKMcw/yXhfPq4hx1JLuhct7GyDuMBjX075SdYhmf
         mJAws6sraYVejecOAXGnnHzngTZt2mlPCVS9FJVWy09qOBzVtp6y+uXxskQ+eZpnx2K6
         QFSfvwOya1D0+2SKIeZVm8jBnCAOKjGNPM/ETBF2pWraQZwpYxoqPePOi7HlS48Dz1Es
         akp9cJGCivpDXuGObZaCDcypSFDGfHgvBn2q153mLLIqzHXJf4Z/n9zpoTSIZZ+sA7LH
         6UNdkVISPSBPxnA/Edx/CGXiWGbQQBI91usV5CsSLXD7XYoMO3XOdB8uRL4LsWGZ5XVf
         OVaw==
X-Forwarded-Encrypted: i=1; AJvYcCXPMjnhBlx2epArxeENeE8x99NbeLv3ciSgIFg8Lb31NxmTdQ2cRZfLS+DiPjuoK3kLRdcrNyVUxMT+EcwsW7U3BPR2vHzenkbfVg==
X-Gm-Message-State: AOJu0YxCJbVujOnpyLO7f9/RlGVaQhHdioQJ6R4M2ZqcJBnTfeLaPlYR
	J/DAcfjdy4A73zFVtH2FkRfvDPE+ARlwH+znykxP7XDdJu5K8rrAvacwQM+Pe1B3esd65VVt5yF
	2+25ftwq8TiCvU+GvolqnMN135zQQPIzhUg7pCw==
X-Google-Smtp-Source: AGHT+IEiGLOupo2idMEIYgeBEEhwpy74x2AZzsa9raRzuh+5+yX/DVQkWeGNuYisVyq0HUy+LQnKGZPFddeuMn+7bKg=
X-Received: by 2002:a17:907:e25e:b0:a7a:a892:8e0b with SMTP id
 a640c23a62f3a-a8392930f95mr145350566b.19.1723798367668; Fri, 16 Aug 2024
 01:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131941.255804951@linuxfoundation.org>
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:52:35 +0200
Message-ID: <CADYN=9LRUpKMbBebjkcy3qo3O_1UFevA=x90SGZQ7ja5FXHG3w@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/484] 5.15.165-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 484 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.165-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following S390 build failed on stable-rc 5.15.y with gcc-12 and clang due
to following warnings and errors [1].

s390:
  build:
    * gcc-8-defconfig-fe40093d
    * gcc-12-defconfig
    * clang-18-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Bisect point to 85cf9455e504 ("KVM: s390: pv: avoid stalls when making
pages secure")
as the problematic commit [ Upstream commit
f0a1a0615a6ff6d38af2c65a522698fb4bb85df6 ].

Build log:
------
arch/s390/kernel/uv.c: In function 'expected_folio_refs':
arch/s390/kernel/uv.c:184:15: error: implicit declaration of function
'folio_mapcount'; did you mean 'total_mapcount'?
[-Werror=implicit-function-declaration]
  184 |         res = folio_mapcount(folio);
      |               ^~~~~~~~~~~~~~
      |               total_mapcount
arch/s390/kernel/uv.c:185:13: error: implicit declaration of function
'folio_test_swapcache' [-Werror=implicit-function-declaration]
  185 |         if (folio_test_swapcache(folio)) {
      |             ^~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/uv.c:187:20: error: implicit declaration of function
'folio_mapping'; did you mean 'no_idmapping'?
[-Werror=implicit-function-declaration]
  187 |         } else if (folio_mapping(folio)) {
      |                    ^~~~~~~~~~~~~
      |                    no_idmapping
arch/s390/kernel/uv.c:189:26: error: invalid use of undefined type
'struct folio'
  189 |                 if (folio->private)
      |                          ^~


Build log link:
-------
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-485-g0a33b8afe07a/testrun/24869919/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.15.165-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 0a33b8afe07a366222228559e4dd1de564dbdf13
* git describe: v5.15.164-485-g0a33b8afe07a
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.164-485-g0a33b8afe07a
* arch: s390
* toolchain: gcc-12 and clang-18
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2khLvf8Vv5pS66ldvXrSWZd6CHa/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2khLvf8Vv5pS66ldvXrSWZd6CHa/

--
Linaro LKFT
https://lkft.linaro.org
