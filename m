Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9728F4;
	Wed,  4 Dec 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337124; cv=none; b=IJtnyjsGem24k3h4yghxpV/R8BoVdB8O1CQITSu/HsZpaJqNaRJeaEsZYLsdCLXBObJgGVU6Z+dyJ9v7FacIfxvc0rmTy62pZiX9fQCgb7nrrHun5OHeiiITd5cJh6rC6ZGi/hu6DtjnVIMjP/EUCph8vjb8TIR2UeBFdsveat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337124; c=relaxed/simple;
	bh=+4Kt8FQgX1dXK3ytxSuKT6GwIzThB5cSGjNPnJtIIl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo80se1xtN1cA4qWI2B0jdcvpJ26zu8oX/s1yY+G1ixLiY478v9kJWMoHCDeeAWgD5JsrkLxFGhjsKay/n/QU6fdAcD00QybpbuqBSvpiwLE+gbhQwlLj+K6TEOUnAEChLF2xIkXPS5JoMDJEEPWYzm9gq5a/p+WmIn2SKZyUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUO+PTki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUO+PTki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21332C4CECD;
	Wed,  4 Dec 2024 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733337124;
	bh=+4Kt8FQgX1dXK3ytxSuKT6GwIzThB5cSGjNPnJtIIl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUO+PTkifvg77tFPDqbocLqM6dde9ocUoP4m2IB3JQLJtlAZU+s2xxdOivSy9ruGW
	 E7gSkIWcMxzAbL+FcC2L/5hZVB6/SpCfcJJxo7Vqm8zGhKzrgQvh19blEGfic7huPq
	 sj3GcqlXZYb+fhkQNCH/KbQWYRj/j/2aMBNMam8FP+WYetLCPshfWGc4EulIiLaZoi
	 A5ohewiy3XzIF2m8stkhUIr15z/sy9m4rj64Qo8VrQu41bhSbFiW4tuvznog1UPuam
	 kS8qE7kX9mHbS3OLMF3CoEMXW1yQREzjXkcdZUY8NRXLRAnL70L3GHpzpKjH4QNmqm
	 uJsXHybtpxiXA==
Date: Wed, 4 Dec 2024 08:32:03 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low
 limit 1 greater than high limit active
Message-ID: <Z1CgIzluYZzNVpuK@slm.duckdns.org>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
 <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
 <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>
 <c795c090-430a-45a6-88b2-94033d50dea2@stanley.mountain>
 <Z1CUIT8zAqWOnot-@slm.duckdns.org>
 <be025b385bb94e0c92cd02ab57dc984b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be025b385bb94e0c92cd02ab57dc984b@AcuMS.aculab.com>

Hello,

On Wed, Dec 04, 2024 at 06:26:16PM +0000, David Laight wrote:
> > This is a good catch. It's impressive that this can be caught at compile
> > time. The upper limit can become zero but the lower limit should win as
> > that's there to protect against divide by zero, so I think the right thinig
> > to do is replacing clamp() with max(min()). Is someone interested in writing
> > up the patch and sending it Jens' way?
> 
> Perhaps if written as:
> 	inuse = min(inuse, active) ?: 1;
> it might stop someone changing it back.

And maybe some comments too. When I was writing that clamp(), the case of
min and max crossing each other didn't even cross my mind and I was dumbly
thinking just "oh, this protects the value on both fronts", so yeah, there's
some chance of someone (including myself) converting it back to clamp().

Thanks.

-- 
tejun
