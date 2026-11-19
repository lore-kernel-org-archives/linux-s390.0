Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.42.244.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101900;
	b=aSquxkT647BJlO0ezvEO8dvlboFAYQJp3Pj/6GyaxUPcWC5Z84yxCs7Tkr1pILurQ5lN
	 2OL1a60onEgSkC2tcLtMpTOf3OYgm1rJl+JON8pD1wlAqZXeHHRr6sEnw5kjAHOK4S/V/
	 QL0s7SIc2oKIprshhL6iuXfKS/ezoERTRL5YtqUJgi3k9znpcVJhsmku1x0BeHm/qpwy8
	 AohR6KneQ8nuazgwtSsHsqnOtqLaTRABqWfe3DjYyNVrZC5YST0mPoAnJzjnug/ZoHg1A
	 m/JJG/rtFIGpx+WLgWyIFrpuCvVf3AR2/DHOy4vJJuxu4ekkS7CggJh/7aZEkvsoTdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101900;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-purgate-ID:X-purgate-type:X-purgate-size:X-Notice:
	 X-purgate:X-purgate:X-pfmilter;
	bh=UeMwgVjDLnDVqjMPlLrZzad82di4zvuEFr1fKsZ6T0U=;
	b=R0HaKpD7xaVWLMFiuEWWm/YyLK8DAl3qPnuOX/8/07INFtYwKStCd0d2y9Xk5PaBftZ/
	 9MQRyu3IOEScLiVC3C/48WvFXyiivSOrI++Hgdiwz5ZMUL9tPkxidf3w/L+xRETTVz9re
	 hH+SZOEvvPsnlFte78ZunnbKi8C1x0rYvuC2jUtEKJSNHJJGbnoMNV2jNNgJcKIsYfCS0
	 jSfUEqol3go4i9qFqEdlTemvsN3kvUJkoe7G/A4fCDcA+JDf9XZNclFYr3dIfCS5bAfJ6
	 Jly3LPp+seLJDbMN817hm5PoQIYdvA2sgw7rdUatltl1MUPQ1bbQdc8yE/x7nd2t1Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fritz.com;
	spf=pass smtp.mailfrom=fritz.com;
	dkim=pass header.d=fritz.com header.i=@fritz.com header.a=rsa-sha256 header.s=mail header.b=KSPq04XI;
	arc=none smtp.remote-ip=212.42.244.94
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBD606A320;
	Thu, 19 Nov 2026 15:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BBD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.a=rsa-sha256 header.s=mail header.b=KSPq04XI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1795101890; bh=VUtPMxOjNKGPZQ6FkAk4L2n05vBEr9KfdwlyPB8FDFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KSPq04XIh/icCo8uVqSQs19xHVWrI8882+qMc4rh4bnaLIrVTIRUI5hta3IrnJmKr
	 LiyH5gQnmHg4hi6fnGQQBTCKUhzPV5pUnddTLwq7tRo1sqFXC60ubABjjxwzr5BZpW
	 xWTrAU/q3VmuS9xkaoOGD0Jn8oy3l4DTPHEwBClrN0JI8F1idZN9rc232N+9cBlDYK
	 ACrbDLomre7mciio5dpLUoD4CR9a2MKIulNcOOn2MdgHr/fEhjD84N0ReNb2vbEW0l
	 Lnh7zob5INdPpt9ISPclBVJ2Qwnd7Kvc739eXQJq5JMQwSX7BtOtazOhV28Kxzl2ng
	 8sp7wX8P0KG5Q==
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <nschier-oss@fritz.com>)
	id 6aff14c1-b6d3-7f0000032729-7f0000019f2e-1
	for <multiple-recipients>; Thu, 19 Nov 2026 16:24:49 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 19 Nov 2026 16:24:49 +0100 (CET)
Date: Thu, 19 Nov 2026 16:24:47 +0100
From: Nicolas Schier <n.schier@fritz.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
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
Message-ID: <av8Uv7EV3sLqUBfr@derry.ads.avm.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179424040477.1704532.18231793404479518924.b4-ty@b4>
X-purgate-ID: 149429::1795101889-B9515B85-B73617E7/0/0
X-purgate-type: clean
X-purgate-size: 1742
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: F259FA066E  external: no

Hi,

I have a question regarding best-practise:

On Mon, Nov 09, 2026 at 05:07:05PM +0100, Nicolas Schier wrote:
> On Mon, 09 Nov 2026 09:14:41 -0500, Sasha Levin wrote:
> > Since commit cdfdbc11552b ("Move struct cpu_feature to
> > <linux/cpufeature.h>"), devicetable-offsets.c includes
> > <linux/cpufeature.h>, which includes <asm/cpufeature.h> on architectures
> > that select GENERIC_CPU_AUTOPROBE. On loongarch and mips that header
> > pulls in <asm/elf.h>, and from there <linux/fs.h> and <linux/mmzone.h>,
> > which need <generated/bounds.h>. devicetable-offsets.c is built before
> > that header is generated, so even defconfig fails on both:
> > 
> > [...]
> 
> Applied to kbuild/linux.git (kbuild-next-unstable), thanks!
> 
> [2/2] devicetable-offsets: Get struct cpu_feature from a device-id header
>       https://git.kernel.org/kbuild/c/50ccc340

I applied this fix on kbuild-next-unstable (and rebased today [1]), two
commits after "Move struct cpu_feature to <linux/cpufeature.h>" [2],
which is being "fixed" by this patch.

If we keep it this way, a bisect may hit the issue; folding does not
look correct to me as that would mix-up related but different things.

So my questions:

 * Shall we keep it the way it is to keep the original patch order
   (bisect might fail on the two commits before this patch)?

 * Or shall the patch be moved before Uwe's (removing the 'Fixes' tag,
   and rewriting the commit msg)?

I am in favor of the latter.  Are there any objections?


[1]: https://git.kernel.org/kbuild/c/f1dc66c38b7eb4b2fb946a2fd6929250ecd2d85a
[2]: https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.1792144769.git.u.kleine-koenig@baylibre.com

-- 
Nicolas
