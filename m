Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6B2798F4;
	Tue, 27 May 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357231; cv=none; b=ctmteNe0DOI2JJUC93BaE9Hd8utcXNq5u+pUu4SUpizJ0N6Qnw74mIsMkjzWg5uI3J5cpq/kktl5eUeOi1w8PUsSieg1fUkYV0rNZpZu2S7Ius8YN5C/15+dBcHGDeSA7rlspfuPoKSdJX696TJdkFgcw7aJ6q/p5Gsmy4aQ44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357231; c=relaxed/simple;
	bh=GIndecsrTpe+jS3rqHUhRgNa3S4TIKoHXC28ZWtBcVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbDUUmLzd5kIwDedvTLFptUwYtZZSplB+hTwifeAMpwW7sFxbWOro2x+46HQLoPkxAaUlHv+O6Ixy6sB7JPU0HYuYiVsULLGgAKXT5Y3SAcFJxmrWgo3c3YSkEr1X7ZOuEWzR6YnpvS/3a1KKmDahR8IEjDfQmtl862zKYcJD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8OGx5ct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8OGx5ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB177C4CEF1;
	Tue, 27 May 2025 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748357229;
	bh=GIndecsrTpe+jS3rqHUhRgNa3S4TIKoHXC28ZWtBcVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8OGx5ct8McCtjqPoXoq3Nua3k70oTHGZOBMwaIhkM9Vs4/ZzDST+hAZR9vhr4RNi
	 3id5BCEH5n9kRYcGUT72F5gXlTsR7KOkCx9LoOIfDzroUy/PpxxlAJgflQ9MQ1kYuK
	 9//F3rhcKpr6fNE0Ni8P6VYdE5yp6+w6tJvW/nwc=
Date: Tue, 27 May 2025 16:46:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-s390@vger.kernel.org, devel@driverdev.osuosl.org,
	lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: stable-rc/queue/6.14: S390: devres.h:111:16: error: implicit
 declaration of function 'IOMEM_ERR_PTR'
 [-Werror=implicit-function-declaration]
Message-ID: <2025052753-enticing-exceeding-a8ce@gregkh>
References: <CA+G9fYtSrmuXzvYbCrmT_4RHggpaYi__Qwr2SB2Y0=X3mB=byw@mail.gmail.com>
 <cdf339b3-f3a4-4ed3-9d40-8125b50c0991@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf339b3-f3a4-4ed3-9d40-8125b50c0991@app.fastmail.com>

On Mon, May 26, 2025 at 04:59:54PM +0200, Arnd Bergmann wrote:
> On Mon, May 26, 2025, at 16:49, Naresh Kamboju wrote:
> > Regressions on S390 tinyconfig builds failing with gcc-13, gcc-8 and
> > clang-20 and clang-nightly tool chains on the stable-rc/queue/6.14.
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Yes
> >
> > Build regression: S390 tinyconfig devres.h 'devm_ioremap_resource'
> > implicit declaration of function 'IOMEM_ERR_PTR'
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >
> > Build log:
> > ---------
> > In file included from include/linux/device.h:31,
> >                  from include/linux/node.h:18,
> >                  from include/linux/cpu.h:17,
> >                  from arch/s390/kernel/traps.c:28:
> > include/linux/device/devres.h: In function 'devm_ioremap_resource':
> > include/linux/device/devres.h:111:16: error: implicit declaration of
> > function 'IOMEM_ERR_PTR' [-Werror=implicit-function-declaration]
> >   111 |         return IOMEM_ERR_PTR(-EINVAL);
> >       |                ^~~~~~~~~~~~~
> 
> The backport of 
> a21cad931276 ("driver core: Split devres APIs to device/devres.h")
> also needs a backport of
> 18311a766c58 ("err.h: move IOMEM_ERR_PTR() to err.h")

Now queued up, thanks.

greg k-h
