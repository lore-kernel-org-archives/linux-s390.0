Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206088;
	b=xGtaWCksOFFsBbVO3ahfgxPzBrmugNK9Ju0kA4/LQ9be4OE44tD6CLqTIYJJ3oEswd7M
	 e4v5B+96GRoKxzF581F+fBP3dpR5K+LvnYd6ZHEF0I/YvUeWhNJMrQBj4YDavhFWDLDRY
	 JrdvP4L7fn4DFPRER5QhV+x4gCmqwAkIVx/hupi33QpRe2B7t9J9NktVxhxxNfj65cIRV
	 dI85hgYy3f/QmpJbEZ4j8eOUk02gtft43TAEmagz/YhvlTZABXoopIu6Uw1Rs84XKlCsX
	 gTYnsjy3fZyGVDMy0ZviDrMsDWeLbIcknsQN7D3wXP6jp6dGWeUAI0hIel2N+dR8Acg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=FhubQ0AwqwjKKa4eYGPVP/A6yHZrg9Mpv8xAmXRO44Y=;
	b=Ij2enmmz/2Bz+KPQvvl2SqpaJFotTobrSA98NYBFdEPF8WDyX6+6SUwmNJ3k3v7FtLP7
	 +IEoYXPcdySgdYuKW7uk6vyyelOlP8CxLRfnarfnrrR/sdTUykrfVkKIaMmTgq3ZmVryk
	 GNgmI8G2Il2MjBhGyJQXA4SedsXhOm7ikpiyytUg2LBMJO7ZeDDDDcayhU73FH9XE6Jpg
	 2HrgAa5H2anV1lqVXjSYmsmjOqMCokHRluLkbhSnRmTJoUGdtGMJXoLmrTCP6ogx9OCLd
	 pPEuECYPl1XnUmsehbNFisHf1YKFuzQNI3B9UPtN9DRrJswRfI1hZWfc2LSv5f6vyBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQBjBqzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 447D360A260A;
	Fri, 20 Nov 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQBjBqzG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F21721F000C4;
	Fri, 20 Nov 2026 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206087;
	bh=FhubQ0AwqwjKKa4eYGPVP/A6yHZrg9Mpv8xAmXRO44Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQBjBqzG9wwGKgTzZ5RMcA461vYrebLjyuQVHxrMJIqVm6XCJroPZ2h9EzUP1NEuA
	 u4q+mf95gFoA8IW250eIZU2W0j1/vSAhqkx1C0dlekzJVvN0bdbNNWp28gyMm2VPCW
	 b4iTDPCGGsqOMBqAzbKqPUIQJarXsSX278GxUahwpHF+/sfv3N2I+y5I6aLg9gYzdO
	 +rxuOihQ4f1ULAKCRdfKwCdvz2J8MOEl3zD6WFxuyXj6tBwZLrzDJIRPedq63s+/lv
	 REUz6Qw2D/1KQfSp6Bv19VQNXAdR384dD0+9UhoiG/vhaLtWXbnwQwmpjWM/6x1eM1
	 iQbBrcm1nn4iA==
Date: Fri, 20 Nov 2026 21:21:13 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Sasha Levin <sashal@kernel.org>,
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
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
Message-ID: <awCruYkI2TkxJfPC@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
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
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
References: <179424040477.1704532.18231793404479518924.b4-ty@b4>
 <av8Uv7EV3sLqUBfr@derry.ads.avm.de>
 <20261119194738.GC875856@ax162>
 <awAtvSIQeLJq2hvF@monoceros>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awAtvSIQeLJq2hvF@monoceros>

On Fri, Nov 20, 2026 at 12:25:48PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Nov 19, 2026 at 12:47:38PM -0700, Nathan Chancellor wrote:
> > On Thu, Nov 19, 2026 at 04:24:47PM +0100, Nicolas Schier wrote:
> > > So my questions:
> > > 
> > >  * Shall we keep it the way it is to keep the original patch order
> > >    (bisect might fail on the two commits before this patch)?
> > > 
> > >  * Or shall the patch be moved before Uwe's (removing the 'Fixes' tag,
> > >    and rewriting the commit msg)?
> > > 
> > > I am in favor of the latter.  Are there any objections?
> > > 
> > > 
> > > [1]: https://git.kernel.org/kbuild/c/f1dc66c38b7eb4b2fb946a2fd6929250ecd2d85a
> > > [2]: https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.1792144769.git.u.kleine-koenig@baylibre.com
> > 
> > If history is already being rewritten, I believe it is always good to
> > fix potential bisection issues like this. Rewriting the commit message
> > (and maybe some of the diff?) and placing it in an order such that the
> > build cannot break sounds great to me (but others are free to disagree).
> 
> Full ack. I think the danger to hit that point during bisection is
> small, but I like the 2nd option as this reduces the small chance to 0
> in that case that people yell at me :-)
> 
> So from my side: go!

Thanks!

I'll send a patch that combines both patches in a few minutes.  I plan
to replace

  * Move struct cpu_feature to <linux/cpufeature.h>
    https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.1792144769.git.u.kleine-koenig@baylibre.com

and

  * devicetable-offsets: Get struct cpu_feature from a device-id header
    https://patch.msgid.link/f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org

with it.  Please complain in case of objections or inappropriate tags.

Have a nice weekend!


-- 
Nicolas
