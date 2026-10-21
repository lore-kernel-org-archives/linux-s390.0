Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607159;
	b=oSTS1XCZ+intcd1yf9IS5xQot6YJhKwq8YMHrqZ8OD4WNh1eahUuGW4GJwoXhUtrkWcM
	 VaIKbcY+WqOOdoMUPeMTfYWuqXbwRaeeKb17yfNvsOBcBHyBwNfOFZ/xizOntHayekSM3
	 3vDI+y9AkYMi4zahZcKX3c3CXtmUdjSn6WQlMKuKZGE9rESO0b3h6emLDdzBZMNGBQkfy
	 1durJjlwKI/gK6nRafiiEVaaTO1sePQXPT9Lg7VeHFiJoxrnVpn+UgE/bP/eV9l37Oi9z
	 cta085zLK1LyMijjK6IftgP9WO7UGpYtjwb1E+/ulfouSLQY2UCHY/h3mugC/qX1HdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607159;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=N6fyMcM49GdqoHU2qB+Q6cBcQk7A6DXHp1dBvrO4qF0=;
	b=mo6b/ARu1iy7b/dYpk3IinOL8jeckKICTqgRGHRlcZiJAlufIOJgKIto5RewAJDPoZ1l
	 aEIjOqS9G8UXMzjdtIkGi7ZjJug/GbndyfwVrK6EJxZw9qpomc6rJEZm/EKRhLKIO8A4O
	 qhDbFlLWWmgtylEoSxalYU9G1JSiKP+CyAlEFTJZTWQ7bIEvMjxcCkC4LBLg39GCDhbtN
	 0ATN60OP0aTmfvJ+gx31rn16uPNhh3k5MK6Y55D/pJt6J1cu2TGGXjLPBOgE7YUEYAdjD
	 2W7Qu1mBGD64CoFSGuO1+9sRHbyV6Kl38zg1n2kernWpCkN/jMJIeUQgfJxRifHaiwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihiH1ybm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F677606A319;
	Wed, 21 Oct 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihiH1ybm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0321E1F000C1;
	Wed, 21 Oct 2026 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792607158;
	bh=N6fyMcM49GdqoHU2qB+Q6cBcQk7A6DXHp1dBvrO4qF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ihiH1ybmTSVBwKPmKrZOVjhPA8IxWboEITg9XVGZecdf39z0zwd+kW0RkSt6RUYay
	 5+55tR5nH50mpZf/RRkioiM6+WKRv/1eAC2WsFGBjx8d/9eBwNHU2Tx2/ynXeyniob
	 A5QXNrapO1WjVXCvT8hX0c4mpxN+O+vPU8ElzdxQVrQftKVs7Rj4jx+1DpaxfeVhLz
	 nyF8JHngJcvhyWoWkim/TEhLAOJWGvV6su3uSt1U7H2w2aO850qDwT9m7UdKeOkTuJ
	 EKHxsziWIY6C176n+2wgNy3EQ06myw7y7AW7uet/U7aSRk9XJgH5TQ2ObCcS3LmRYm
	 mtwvaJ77mLnlw==
Date: Wed, 21 Oct 2026 11:25:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Julian Braha <julianbraha@gmail.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Move testing of '-mfentry' back to Makefile
 from Kconfig
Message-ID: <20261021182554.GA2594500@ax162>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
 <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
 <F643B506-5031-4BEA-8279-199E7E181721@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F643B506-5031-4BEA-8279-199E7E181721@kernel.org>

On Wed, Oct 21, 2026 at 07:44:16AM -0700, Kees Cook wrote:
> 
> 
> On October 20, 2026 2:52:18 PM PDT, Nathan Chancellor <nathan@kernel.org> wrote:
> >Unlike cc-option in Kbuild, cc-option in Kconfig does not test options
> >with either bit ('-m32' / '-m64') or endianness ('-mbig-endian' /
> >'-mlittle-endian') flags because which flag to use may depend on the
> >result of the configuration stage.
> 
> Oooh, yeah... Do we have any silent failures due to this in other places? On x86 I worry we'll see similar problems. Stack protector arg checking comes to mind. I will go see if I can find anything...

I am not sure. I did not look that far, mainly because I thought it
might be hard to audit what is expected vs. unexpected but I guess it
would be easy enough to just dump the result of cc-probe from
scripts/Kconfig.include into a file then look at the tested flag.

On immediate glance across the tree, the s390 Kconfig checks might be
problematic with s390-linux-gcc like '-mfentry' was. Arnd, could the
target for s390 be flipped for the kernel.org GCC toolchains to
s390x-linux-gcc so that '-m64' was the default but the toolchain could
still generate compat code, which seems way more standard for distros?
FWIW, compat support is being killed in the toolchains too, so it feels
like it is worth making this switch even more:

  https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=5886bb453a6a010fc218d90c18febf94a1be30d1
  https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=748bc6a7febf874d84657f538c9d9e3b8153c6e7

The kCFI checks could become problematic if one of the 32/64 or
bi-endian architectures gained asymmetric support in the toolchain but
it was not the target triple that scripts/Makefile.clang uses, but that
feels somewhat unlikely.

Everything else probably does not matter much in practice just due to
lack of use (think 32-bit RISC-V probes when using clang since it has a
64-bit target triple). It does make me a little worried though.

-- 
Cheers,
Nathan
