Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240437;
	b=azQdm/rH5YBg1aLZ9WHuo8cqk/ZNCbJR182xA6xUjR0r5/Yy3sZPltWUcpWn8BR1GDuh
	 cuTmPCX7sqzOBvuDeYVtZlwYEzVn58LHENU2lBhCk2+xRCDYWEMpJGU4PuCYexx+RXFGA
	 ZX6454RJgcZiQd3dTpP2uhbjSp4s1tIuQB5G8FI4NEqpJ1/V0J5awYhQPgjawZmHNdkmr
	 EfMtqFzLM745wSF48hOGCfJlpy/W/lMzyn0nU9BqV6zm7h1RxoZhefWQUvq+NgSyQP7h4
	 Bd+RcY15PZP3nu3weDdNEMMEfG7tRdpgY1+6yTLi6tdtbN60FdUInLCiasVB7R7jNZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b6ZiqFg65Q8jcuRQtMgdSgXv1NV9xL4x1lsgIjnPzEE=;
	b=PGXSmldCHrMySSOgoX9VxN9EjStmOQf6pnrerlpAb+bBFnAJheO2XjaIpridE2zRFEhS
	 1Yb2p7Jp/8/nix2Evlp/2PJGfvo7KWpG3HV6eKqpGBN6oiAAWJRmP/hWm4vVn+XExEcVD
	 Hm80Iy3/Bxx1hjX4AYyrbUq1wC08toAHmo6/lHndBkSYnXdKyG0Tqb/EPy1MELDFWoHdx
	 4CwL4JooZ8LbPDj19Rm25+tPGjiRiKfUBIDSHTjwlqhcQCr2iIeDm+sc8Kb/LJ4XVghvy
	 9furxXwrPHvOovC/DCahkLqpKAx3OteAqNHQV8VylXJ7pFdufD5bdlQYChqXbogtyog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELCHzGQ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B25FC606A31C;
	Mon,  9 Nov 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELCHzGQ+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7574A1F00901;
	Mon,  9 Nov 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240436;
	bh=b6ZiqFg65Q8jcuRQtMgdSgXv1NV9xL4x1lsgIjnPzEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELCHzGQ+PVhJJNpqL5Yc5x3lXv07lJX+TS1VntjMDXbR6xlQ22Fp1J9QOB3dD9WYP
	 cHKPAbGfzO3G4fT1iHlGOdtiO+03ztJgj8Ce+e9q9hWIWR2pCnG+RqxzjcvhX9qqA8
	 yI1QTIGXFsTtDpwZRj1CyOIQTfD74gp95elad9mcxBWoAYPn+LYfniUOqGP8JNQ97l
	 NAPi+rt7l7U2dQgc6V+lyWnYMLj9TiOLdltVu+sAKdVafz7vxMhyq5VUXuViUsuYnX
	 xH0CyQZh61wuIYMVOXX7e3F7B5eol9Sb6NAAubw4IUVzd5EKD/QXhDuwg5PgyqfAAN
	 6/NRxfrt2jhqQ==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a device-id header
Date: Mon,  9 Nov 2026 17:07:05 +0100
Message-ID: <179424040477.1704532.18231793404479518924.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org>
References: <f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 09:14:41 -0500, Sasha Levin wrote:
> Since commit cdfdbc11552b ("Move struct cpu_feature to
> <linux/cpufeature.h>"), devicetable-offsets.c includes
> <linux/cpufeature.h>, which includes <asm/cpufeature.h> on architectures
> that select GENERIC_CPU_AUTOPROBE. On loongarch and mips that header
> pulls in <asm/elf.h>, and from there <linux/fs.h> and <linux/mmzone.h>,
> which need <generated/bounds.h>. devicetable-offsets.c is built before
> that header is generated, so even defconfig fails on both:
> 
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[2/2] devicetable-offsets: Get struct cpu_feature from a device-id header
      https://git.kernel.org/kbuild/c/50ccc340

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-next-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-next branch in about a week if no
issues are found.

Best regards,
-- 
Nicolas

