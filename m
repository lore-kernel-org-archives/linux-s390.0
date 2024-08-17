Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B480034
	for <linux-s390@vger.kernel.org>; Sat, 17 Aug 2024 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874273; cv=none; b=WGxkBnveA1DO3x3HdCnyAm4CCunf2XH+drnoe6F0+gV/Wq5TYrzJ5YOKPR65HDgq/KvVB0lBwVqc05e9CL9S6CaCnGDqHGllTDCXdhLkXsHhHHyX9VWS3rlNQJR4EmAVBHI9XPJPGom8scOroZiiT4t2+ycTf2iYA45VMO9rUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874273; c=relaxed/simple;
	bh=L6/kkT9rKApXwS91JQDNsORr/X1GI+rDEPlBF/B/ELo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJKRo/dlQxuhB5hjk3DXTBZ7v5b7WgcncctfhuSllg8Q+odQHk+RTWUrH55O5RGF+vTo0pWqNYR8MhbygINO7/3nCNkrtC3Vc2LztjmmGUzan74HmuXD1eAK6y3oEQyu2lnBReTWzYGYMDENNEeBCtGvJG01IHbpPQ2nSFsw9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4z6jW7M; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4z6jW7M"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so14449156d6.0
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2024 22:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723874270; x=1724479070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu4Nl0GB1iED2MWCr04OB+Jfo3hv8Ww3jPrNd67fLNQ=;
        b=t4z6jW7MH7C28QL1V0WVtNUd8SyMRUyOUX84B9Wdm2fy08D96z0lKIfrRLKHp7ee/e
         Hb6oq1KFxtBgcsUBW1LDtI4qsHN4oF3NJavL0llYWi4pW3rXVNv8HJae04Vq4Wg7L/Gh
         90EXMxDlrJuvkbDbw3blGgPbo5HFNNIdgBAL4nzxQwLnv9+x/VZqrh/HNHeoCFUdvjCN
         W6yPTXsmpJTvFUA2wCx7JC/FOqRncFuc5N94ELsgapv48BPdkK3KceQ/aeXRnCdmFmVf
         ZUejq9LqpkHc7e7QDjrYwH4CYFyQ/+ejbgxXR/dBqKedTfjXAdQcMiT6CrvrANOS7m9s
         vvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723874270; x=1724479070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu4Nl0GB1iED2MWCr04OB+Jfo3hv8Ww3jPrNd67fLNQ=;
        b=CPOuVFDG+mkcBixmOHt613zu/Lua3o0O4dKq69WUC8+aTkL4EfwkAzSxP/J042WTdw
         Kl9LjOHapLVCr36nIZw3Dt1PlTIHYbKHVoCZxsJ8XBy2NJ/yd1j1TrpZgn2t6GACVonM
         DoYSjWvEL8YXuMazjQX6/w5ErUWDvoebGIHs9oVA7UA0Tg2GlggcIOJuXDUv6zYbqVs3
         laOWZqtiiFa6DIsen5HdXjjS6FSouJ0B2pBBR9/o9Zy0T3M+eSwY9TtawcPJOuf1Pb1B
         HrN8J9C4FL2nMi74N9lNvl12C/niZHeJ43Z7KxM0SFrxIl2jW9Bk97glw9S9+nOPH8T9
         LJjg==
X-Forwarded-Encrypted: i=1; AJvYcCUsVZZkwHSiNZnmsaKWvlihFEhzV33py3yuo88YAgUuLtNRrE20dY4r/+/qrJ0zUxk9cJRPqMjbvxggkV9PT76f7VjrqTmxma249Q==
X-Gm-Message-State: AOJu0YyUpu3y/KbQcWFhQMmt3HKRq5m/n5dEuNA0nKgraZQ3J6pF1eF9
	3mJKdMgdG9/im40H8mzg+6qrAC39UIlyY+b9OfKTSaiaUFJIk82Ihs4eeHTiXbYECHfIeuV5pct
	zoLeA2YwKpMWIdnmS2Wxy3fei+xytK1Mzf883uA==
X-Google-Smtp-Source: AGHT+IE+sUu9pWEuBlQvuPiIymkPTnth27ELlW5XvrnyJPCs70aN5KVC2LtEGJ+bMm2rNvH1MKufn+f3an7JwP3laYM=
X-Received: by 2002:a05:6214:1c48:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6bf6dd61a57mr140443316d6.8.1723874270359; Fri, 16 Aug 2024
 22:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816101509.001640500@linuxfoundation.org>
In-Reply-To: <20240816101509.001640500@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 07:57:39 +0200
Message-ID: <CADYN=9+gT_me8D_+KtWqmS9_vZg7=dTat90dPCNSieSjq9sFXg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/350] 5.10.224-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 12:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 10:14:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc2.gz
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

The bisect points to 0fbb54ce4bff ("KVM: s390: pv: avoid stalls when
making pages secure")
as the problematic commit [ Upstream commit
f0a1a0615a6ff6d38af2c65a522698fb4bb85df6 ].

Build log:
--------
/builds/linux/arch/s390/kernel/uv.c: In function 'make_page_secure':
/builds/linux/arch/s390/kernel/uv.c:240:19: error: 'UVC_CC_OK'
undeclared (first use in this function)
  240 |         if (cc == UVC_CC_OK)
      |                   ^~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c:240:19: note: each undeclared
identifier is reported only once for each function it appears in
/builds/linux/arch/s390/kernel/uv.c:242:24: error: 'UVC_CC_BUSY'
undeclared (first use in this function); did you mean 'SIGP_CC_BUSY'?
  242 |         else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
      |                        ^~~~~~~~~~~
      |                        SIGP_CC_BUSY
/builds/linux/arch/s390/kernel/uv.c:242:45: error: 'UVC_CC_PARTIAL'
undeclared (first use in this function)
  242 |         else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
      |                                             ^~~~~~~~~~~~~~
/builds/linux/arch/s390/kernel/uv.c: In function 'should_export_before_import':
/builds/linux/arch/s390/kernel/uv.c:270:40: error: 'mm_context_t' has
no member named 'protected_count'
  270 |         return atomic_read(&mm->context.protected_count) > 1;
      |                                        ^
/builds/linux/arch/s390/kernel/uv.c:271:1: error: control reaches end
of non-void function [-Werror=return-type]
  271 | }
      | ^
cc1: some warnings being treated as errors
make[3]: *** [/builds/linux/scripts/Makefile.build:286:
arch/s390/kernel/uv.o] Error 1


Build log link:
--------
[1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-351-g470450f8c61c/testrun/24890569/suite/build/test/gcc-12-defconfig/log

metadata:
--------
* kernel: 5.10.224-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 470450f8c61c0d2248174891cb188c5378eb5d22
* git describe: v5.10.223-351-g470450f8c61c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.223-351-g470450f8c61c
* arch: s390
* toolchain: gcc-12, clang
* config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2kjlITR0fntaWX0F0o4bJ62HPb6/config
* download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2kjlITR0fntaWX0F0o4bJ62HPb6/

--
Linaro LKFT
https://lkft.linaro.org
