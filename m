Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0728CF5F
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826121; cv=none; b=SpWRWheOpoBGslQ5uGf9z+Or0PUVbkdMdEvWD+lTMrRDfz6N1pren40sQ6i/6hVpcze1rlTt77RzCi5as+2lRXz/rlPL2dlpaZEZStJQp15CJPfH0X6ZqmPYDzLgUWeTXvj0itaNVxdgo0lUXzGNYcsWeqM+PLwW/2c/Tks135Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826121; c=relaxed/simple;
	bh=I1zvcLgIa6vVLBTyajNW5URg6BqjnsU5oNGS25BDFBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gKq0X4yECjX+0HO+pKTuShkMj5NKX38C7hx2ko4DyALqRe2SbeqM2kmh/C02OqkjL7P6vEv3VKbzaUrTdnzHLGlAVOogVno1HZ6w+vWNaYPMKypdsX+GF8Iopk/KYbqQYItF9rSMrp78+SYkxp1yrsEsuS1uSk4GSHMep4SRxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwPsL52P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwPsL52P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23151F00893;
	Sat, 19 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789826120;
	bh=I1zvcLgIa6vVLBTyajNW5URg6BqjnsU5oNGS25BDFBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwPsL52PG75Zaz/xJ82rUUpXhArj3jdy2g3gubJpRqOT07cLRZJBNPsaLnpRn43YH
	 yxntGpP3AX3+qgbdmJGBUHsZYFbMvjH2HLYoz2obKsQ/0uwQE7Ym6NttCC0ni15Tip
	 gAvwFlYQYZeOhCMHu9/DjgV/sIVoVjlKLNon78cctagYHnWuE6Pz8mdv2RuEVSR97B
	 gpYRJ7SQeBW/KEqHORLVungXB31+2JtIMbBoHA/aA1AQ42yxUWI3Vl1EhyEgQfkK1T
	 V0gt9giCUP+VYAiK27NZxptgJA0nXbkElt7yZlfYZxE8qEvKAKFgE5rHsbdtdRz8Oj
	 qvmm8GSzlku8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/2] rtnetlink: pass extack to
 ndo_bridge_getlink()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260919134333.49379-2-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
 <20260919134333.49379-2-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 13:55:19 +0000
Message-Id: <20260919135519.E23151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> So the bridge can say why filling the link info failed.
> No functional change.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919134333.4937=
9-1-iprintercanon@gmail.com?part=3D1

