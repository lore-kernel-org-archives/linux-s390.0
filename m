Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED71F4C8E;
	Mon,  6 Oct 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759794080; cv=none; b=nak7HojVp4EqIt8JNW3cqNv5dDWtOHgrZxCAcee+pFyBBrsWK21IHua7C80iyxZHkuDb5adDEOdt7y7559Rww+lK1vJPoCxKOAF0IgXG7K2+tgzg01NSPQAnIgX7YnXUXiy2bwqJHOnfeyn/3AizNS7miE68Io2LG8Byv1clK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759794080; c=relaxed/simple;
	bh=xszjC2Dxqd5ZiPhUJHIBSXkqN7La1yNTuBc0F2qfY5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdhQJiVkz2TYfXGScGflVENA/TcRb5nNd1kyxcgizx42tWJsuzgpnrcRPpZ79L+UdJgZxSbZ73t9kVMtr4ZkoblYay9/vrnaoAEyRYJPLaGLY8mLKuCF2jmHkAGdXCHPdsfC2o16Zak8mhLFwEGP0kK7hvYtKDS74oDvlqV7WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evCYhaTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evCYhaTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F044C4CEF5;
	Mon,  6 Oct 2025 23:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759794079;
	bh=xszjC2Dxqd5ZiPhUJHIBSXkqN7La1yNTuBc0F2qfY5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evCYhaTmsCpATfjUPXTRjPLyu0Idj16dEyfRZOXEe890RC7QrsTj0j2k504YOrXGF
	 OEXXZrEIU8A0mKsjKV7XLuhKtzHJ7LIafj2mLORRLgOoPzXMvRllFlsfd0gLGNkWIq
	 dafEgkJ8lNoE+o8ss89tAWOJxatw8UNuguSRbDsqb13GI5m0Kp52PGKcwvlFDfyA8i
	 H46MhhTVcqfFuWIS+THJrgqKAAOkUXyG8YI8BF0ZfQFoMbrCK1yoiUBJbw+QLMfSG0
	 WQ9OxT1iDk2LW2fbwlEJ/PXMn8wpoeZCQciLSW2+/RcR5Xw8PivWNsj6RxgWJ0RQdY
	 P+6eKFrlYbFRw==
Date: Mon, 6 Oct 2025 16:41:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Alexey Gladkov <legion@kernel.org>, linux-s390@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required
 but not present - no symbols
Message-ID: <20251006234114.GA659425@ax162>
References: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
 <20251006174740.13659A33-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006174740.13659A33-hca@linux.ibm.com>

Hi Heiko,

On Mon, Oct 06, 2025 at 07:47:40PM +0200, Heiko Carstens wrote:
> [full quote below, adding Alexey and Nathan]
> 
> On Mon, Oct 06, 2025 at 04:55:56PM +0530, Naresh Kamboju wrote:
> > The S390 defconfig builds failed on the Linux next-20251002 tag build due
> > to following build warnings / errors with gcc-8 toolchain.
> > 
> > * S390, build
> >   - gcc-8-defconfig
> > 
> > First seen on next-20251002
> > Good: next-20250929
> > Bad: next-20251002..next-20251003
> > 
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> > 
> > Test regression: next-20251002: S390: gcc-8-defconfig: symbol
> > `.modinfo' required but not present - no symbols
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > ### Build error log
> > s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
> > `.got.plt' not in segment
> > s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
> > `.got.plt' not in segment
> > s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
> > `.got.plt' not in segment
> > s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
> > `.got.plt' not in segment
> > s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section
> > `.got.plt' not in segment
> > s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
> > s390x-linux-gnu-objcopy:stM7JmYX: no symbols
> > make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1
> > 
> > 
> > ## Source
> > * Kernel version: 6.17.0
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
> > * Architectures: S390
> > * Toolchains: gcc-8
> > * Kconfigs: defconfig
> > 
> > ## Build
> > * Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/build.log
> > * Build details:
> > https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
> > * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHdDpSLSMJfU4MFvRyEUQuDn/config
> > 
> > 
> > ## Steps to reproduce
> >   tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
> > --kconfig defconfig --kconfig-add CONFIG_DEBUG_INFO_BTF=n
> 
> Isn't the above exactly what is supposed to be addressed with commit
> 8d18ef04f940 ("s390: vmlinux.lds.S: Reorder sections")? Or did something
> change with the commit? Didn't check, and might look into this tomorrow,
> but adding Alexey and Nathan already now :)

I did not change anything with that change before applying it so I would
have expected this issue to be avoided...

I can reproduce this issue with the tuxmake command above on
next-20251006 but I am not able to reproduce it with korg-gcc-8, so I
wonder if this is something toolchain specific? I will have a further
look tomorrow but if you or Alexey beat me to it, feel free to share
follow up findings.

Cheers,
Nathan
