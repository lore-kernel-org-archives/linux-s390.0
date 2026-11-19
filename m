Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117665;
	b=D9mCZVxCpRpNpaVPVDUorHxgVExOQqX+rh6MHHUQvl6+eeH0bPuwiudM//Wa2oy2QsTg
	 ReQ5zrNVll7rX6r18kgzLDIiKxzMeCvO87UUrPppmrNDw7FdXLkZ7Ujkrg/z05LhCm5FQ
	 +u+XeAmcdvssijW7n+ssPxRyXXpNmHgNzuc6LDsN58Wt0EEDx+NLCMPETeolZVvq14jYF
	 OzUxrql5vB28NE/+GKDr7cF28LmHujfukL3/5P90/PQ4a4XaLWSljl4m3Ecm+MrNrJL4C
	 8dMzYer0InzSPdASepv+cJfi6uJzp23z37R2YralHJT8iA5jzKeWx0daO/QHOoYrM0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117665;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gkSFi0IrVXipnhVUQwel4oCB1yg9JYW3fJo9NO9I6DQ=;
	b=OBBfEQw4NqdhiJia/4ofrmJFlwMQsjYkmjJwQt+ioWrO943V5p+UpoQAsKSo9u2SeXhm
	 98iTK0tXa0Wrw/mnOFQ74ctp/f6rK7u4n7dm60XWAGu1Xd7DkYigkcFKS4J1TFA+ptzP+
	 lQkDtP97BpxOvNQalDcFwpRN2Z3B4W1vIdzCkSrXAyTJQJviz/OID8PhkutvUs0h7YKKf
	 OfKb3nVo580eBh1RZrlOWUziH+z4jYPwUdGFsfta15VQs+GnG22K9zPu6OGqEtQwVjj5a
	 HMuG1L8NIlTs1+fgtVfTrv2ZDI5R9+91A+QFmhEdoA0+j4et5IK7DkR3t09C1sBp1qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY6D0SbD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C4606A325;
	Thu, 19 Nov 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY6D0SbD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C70E1F000C4;
	Thu, 19 Nov 2026 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117664;
	bh=gkSFi0IrVXipnhVUQwel4oCB1yg9JYW3fJo9NO9I6DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oY6D0SbDkYs/CqSGwekvQEsLKnBqh8n1TzAkBFWyz0orrqaxlMeBKCke9QpzkZyVV
	 //GpPI2sOx6KeIqa6sLvPxmEWVRUAaBoiBV3Jsy+PXoetBY2VI1AxPUgrYL4WMoxez
	 fEpnO+UbiUlTN/SzQtg8YZlnoJStFY0duJ2L6NO4Kxx34N3O/sP71kDe5vWpbXqe6Q
	 HiRAOj063c0wLkVoNSHdYJFT6uCVicl4XP7VWJOjJQzEiICLg7MPTCWpsOV+9Jh7ox
	 Zaa/uSqzoROYubg3sVxX7aZ+N/dtvB1h07IFMX9flo92eV6xnsCNRxfEjGGhZTxgWR
	 //LwXeRFcTfQg==
Date: Thu, 19 Nov 2026 12:47:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <n.schier@fritz.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
Message-ID: <20261119194738.GC875856@ax162>
References: <179424040477.1704532.18231793404479518924.b4-ty@b4>
 <av8Uv7EV3sLqUBfr@derry.ads.avm.de>
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
In-Reply-To: <av8Uv7EV3sLqUBfr@derry.ads.avm.de>

On Thu, Nov 19, 2026 at 04:24:47PM +0100, Nicolas Schier wrote:
> On Mon, Nov 09, 2026 at 05:07:05PM +0100, Nicolas Schier wrote:
> > Applied to kbuild/linux.git (kbuild-next-unstable), thanks!
> > 
> > [2/2] devicetable-offsets: Get struct cpu_feature from a device-id header
> >       https://git.kernel.org/kbuild/c/50ccc340
> 
> I applied this fix on kbuild-next-unstable (and rebased today [1]), two
> commits after "Move struct cpu_feature to <linux/cpufeature.h>" [2],
> which is being "fixed" by this patch.
> 
> If we keep it this way, a bisect may hit the issue; folding does not
> look correct to me as that would mix-up related but different things.

Yeah, good catch.

> So my questions:
> 
>  * Shall we keep it the way it is to keep the original patch order
>    (bisect might fail on the two commits before this patch)?
> 
>  * Or shall the patch be moved before Uwe's (removing the 'Fixes' tag,
>    and rewriting the commit msg)?
> 
> I am in favor of the latter.  Are there any objections?
> 
> 
> [1]: https://git.kernel.org/kbuild/c/f1dc66c38b7eb4b2fb946a2fd6929250ecd2d85a
> [2]: https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.1792144769.git.u.kleine-koenig@baylibre.com

If history is already being rewritten, I believe it is always good to
fix potential bisection issues like this. Rewriting the commit message
(and maybe some of the diff?) and placing it in an order such that the
build cannot break sounds great to me (but others are free to disagree).

-- 
Cheers,
Nathan
