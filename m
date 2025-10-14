Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323D315D56
	for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450897; cv=none; b=DlSz+6/2JIxqb24WCVPJ67NAflBIIuSwoGmMSbJdcEvEhPUcS9COhK4yBHyc66Y31eR1E8q62oJQHnijSNhTSNrwedCiJ6nchiirY8uPirqsDnBh9+sXfoFhM6OdwRv9EhDnYHDQeCllwFPG46r78euAIJgTVw0R6S9wAEvujro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450897; c=relaxed/simple;
	bh=3Uhj0iN4tv8k0NF8AvRfFrNRJcHVrmJ5n0se5wAQRd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KceU5yWv43QrxzSicCBbTftGo7NiQkCsjPiQSKMLyzZCaTN4mVvwb3BiBx1QgURWaR/gRYuR8zF/M30Oh3toQcJCt8eWg6vpgmCjsbmZoQXr4UQ2xU3P03hYwXLj+xPDZCcEdIFO5CzAyhpOpXQZWv/qaoIHtaSIsyB5SvIhACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cj1p2wz3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cj1p2wz3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-794e300e20dso4127062b3a.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760450894; x=1761055694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9miMHnfOQBt4PukM0PBCS8HCzwLutxaqpSxJB0M7sY=;
        b=Cj1p2wz3oLTNLGdtKyef92IuIPaYQm0gUKNof1f22Ooxtj7VEShNvI8g81nCseyZ+G
         f7Q4GAS9hQhL5jVlDsa8boViaL2Na3dXWBa9VcaJBJ+yrStE+PTMjKSLOtBDIwelJbvY
         kmAYrUcYdb23+3gbu/hVRgpphW/0tpzqqjWkNAO33F5dc6mysjlJ8aXKeRK30NyO63p/
         k79ErM1VkHsh3Y2tyQSzDo6Oj8BhcNWrmLI9ZpQ+QJY8mzL8AIHNQfBweZGmzvRmJcJ2
         YsH3yEwyLyIE4Lq9ektb4alZFWLdFJYEDceJTZWn54nfmwOZXf0acitJA/cYsQvb+P3D
         flSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450894; x=1761055694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9miMHnfOQBt4PukM0PBCS8HCzwLutxaqpSxJB0M7sY=;
        b=i7yrsJJ/yfSw7rNm26ooNxJ7udM5TbK22l725wkzdyis79H5BdrEQ04uaHZNP7DXkY
         Pn+vTuz7Eoe8d9EAYsg26yZqeWBIViHlFGbk/RiyVrP7Rc28ZO2qo4puWYzFbBpJl2Zz
         fKbSvuF/AlZjeN3dmAAmiXwAFtXY800YZ3mp8Yx2e84L20Vdd6vykfSF2edeID2kQuBx
         vM9JX8+WEcD4phMu/mXaSOzs8vws9mriL0v85zaxCev9oXowhEclJA8VihomvU5+vuZP
         T4yiA12uLs3nx7lW/GrBGJg9CKlHW003KlUG7bPQof4z2roAWGTPLO+4VkxG69vgZaoB
         OBKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4KA0gg1abEIUvfOdPymcgNtP+1+m8+vGcLD4DA1tXZSAIuxGVcBkRRGUV+sCt4ogir9AQrdhrQEuz@vger.kernel.org
X-Gm-Message-State: AOJu0YwchFBdX+hTktRqjAgoloypjW/idGCcFDgKvgH78Zua2senOC48
	Wm9FgjN+FPEHZkXPxOgBC/GeC4WdqQlXbjlB7qxqw+ZThDN8zvcc7oK1L+Mx6o6bBYy139QTtCc
	CHeOVWe7N9W9LY2Lx+90RLr+c/ELV+YpGd7kfSCpmVg==
X-Gm-Gg: ASbGncur6MuhdPV6/NcZ0P1iwqxtXQAP5cN0XC84EYU9CMLSZISracX2SwqvM3YBJOH
	n/mhQMm+5sQcf9KV/ocf3L9b5CA2q+KDUQ3csQNUuB5MEg2aoBcIaAgTWrQeB5YA1eha7wo4HZ0
	dzIak6QgIrTUaUCnI6Lbq//QmN1HQbVFgiQ332kubF1BenEAtp68lPf3XdpMy4RFOXRw4aTVCVa
	X+iW4n3dcbZje+MdS2oJbSjoFa6hAfAAzFYRM+myB7aQjtCenCBblyuIeMUb9bjTXBakYY3JNjF
	U2S1XkrHVlywyOVHs72g0dBOzc1Yog==
X-Google-Smtp-Source: AGHT+IEBqme5QBWe13vB1+k/jUkIPGAfUY/crncHZt6R9wHUGuKNxTRr15JC6xfYK89cIfM/DHL7toDVGSsmBXZ8D0g=
X-Received: by 2002:a17:903:1acf:b0:269:b2e5:900d with SMTP id
 d9443c01a7336-29027e5ee48mr300941025ad.5.1760450893675; Tue, 14 Oct 2025
 07:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144326.116493600@linuxfoundation.org> <CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Oct 2025 19:38:01 +0530
X-Gm-Features: AS18NWA2QbZwAP54ku4GMgQeA8c25whyig2-qOvCGzHXJOcx6KjG9nVJKWajSPA
Message-ID: <CA+G9fYuV-J7N0cAy30X+rLCRrER071nMkk9JC6kjDw1U0gEzJg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, linux-s390@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 16:56, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 13 Oct 2025 at 20:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.53 release.
> > There are 262 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The S390 defconfig builds failed on the Linux stable-rc 6.12.53-rc1
> and 6.6.112-rc1 tag build due to following build warnings / errors
> with gcc and clang toolchains.
>
> Also seen on 6.6.112-rc1.
>
> * s390, build
>   - clang-21-defconfig
>   - clang-nightly-defconfig
>   - clang-nightly-lkftconfig-hardening
>   - clang-nightly-lkftconfig-lto-full
>   - clang-nightly-lkftconfig-lto-thing
>   - gcc-14-allmodconfig
>   - gcc-14-defconfig
>   - gcc-14-lkftconfig-hardening
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-lkftconfig-hardening
>   - korg-clang-21-lkftconfig-hardening
>   - korg-clang-21-lkftconfig-lto-full
>   - korg-clang-21-lkftconfig-lto-thing
>
> First seen on 6.12.53-rc1
> Good: v6.12.52
> Bad: 6.12.53-rc1 also seen on 6.6.112-rc1
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regressions: arch/s390/net/bpf_jit_comp.c:1813:49: error:
> 'struct bpf_jit' has no member named 'frame_off'
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> # Build error
> arch/s390/net/bpf_jit_comp.c: In function 'bpf_jit_insn':
> arch/s390/net/bpf_jit_comp.c:1813:49: error: 'struct bpf_jit' has no
> member named 'frame_off'
>  1813 |                         _EMIT6(0xd203f000 | (jit->frame_off +
>       |                                                 ^~
> arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro '_EMIT6'
>   211 |                 *(u32 *) (jit->prg_buf + jit->prg) = (op1);     \
>       |                                                       ^~~
> include/linux/stddef.h:16:33: error: invalid use of undefined type
> 'struct prog_frame'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                 ^~~~~~~~~~~~~~~~~~
> arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro '_EMIT6'
>   211 |                 *(u32 *) (jit->prg_buf + jit->prg) = (op1);     \
>       |                                                       ^~~
> arch/s390/net/bpf_jit_comp.c:1814:46: note: in expansion of macro 'offsetof'
>  1814 |                                              offsetof(struct prog_frame,
>       |                                              ^~~~~~~~
> include/linux/stddef.h:16:33: error: invalid use of undefined type
> 'struct prog_frame'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                 ^~~~~~~~~~~~~~~~~~
> arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro '_EMIT6'
>   212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) = (op2); \
>       |                                                           ^~~
> arch/s390/net/bpf_jit_comp.c:1816:41: note: in expansion of macro 'offsetof'
>  1816 |                                0xf000 | offsetof(struct prog_frame,
>       |                                         ^~~~~~~~
> arch/s390/net/bpf_jit_comp.c: In function '__arch_prepare_bpf_trampoline':
> include/linux/stddef.h:16:33: error: invalid use of undefined type
> 'struct prog_frame'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                 ^~~~~~~~~~~~~~~~~~
> arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro '_EMIT6'
>   212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) = (op2); \
>       |                                                           ^~~
> arch/s390/net/bpf_jit_comp.c:2813:33: note: in expansion of macro 'offsetof'
>  2813 |                        0xf000 | offsetof(struct prog_frame,
> tail_call_cnt));
>       |                                 ^~~~~~~~
> make[5]: *** [scripts/Makefile.build:229: arch/s390/net/bpf_jit_comp.o] Error 1
>
> The git blame is pointing to,
>  $ git blame -L 1813  arch/s390/net/bpf_jit_comp.c
>    162513d7d81487 (Ilya Leoshkevich)    _EMIT6(0xd203f000 | (jit->frame_off +
>
> Commit pointing to,
>    s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
>    [ Upstream commit c861a6b147137d10b5ff88a2c492ba376cd1b8b0 ]

Anders bisected reported regressions and also suggested the missing patches.

Ilya Leoshkevich,
Is it a good idea to backport / cherry pick these two patches on the
6.12 branch ?

b2268d550d20 ("s390/bpf: Centralize frame offset calculations")
e26d523edf2a ("s390/bpf: Describe the frame using a struct instead of
constants")


> ## Build
> * kernel: 6.12.53-rc1
> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * git commit: 7e50c0945b4ab1d4019f9905f6cf5350082c6a84
> * git describe: v6.12.52-263-g7e50c0945b4a
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.52-263-g7e50c0945b4a
>
> ## Test Regressions (compared to v6.12.50-47-gf7ad21173a19)
> * s390, build
>   - clang-21-defconfig
>   - clang-nightly-defconfig
>   - clang-nightly-lkftconfig-hardening
>   - clang-nightly-lkftconfig-lto-full
>   - clang-nightly-lkftconfig-lto-thing
>   - gcc-14-allmodconfig
>   - gcc-14-defconfig
>   - gcc-14-lkftconfig-hardening
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-lkftconfig-hardening
>   - korg-clang-21-lkftconfig-hardening
>   - korg-clang-21-lkftconfig-lto-full
>   - korg-clang-21-lkftconfig-lto-thing

- Naresh
