Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2724B28
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973294; cv=none; b=kCWkgMgwZ6ISBCYI0eXh31e4W3D3h1nL+/0rJz/oBvDDgnS06Co/283x6pz46+Uni2CvmI22aePTfzW7hEwY4h+xTDFGDTw9UUuPuMX/ROw9VXLtZHtpDYCyziltynlCmp7ONXu6wI4BXdfQfpuabo0anFo16mIHt7IdlLXMz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973294; c=relaxed/simple;
	bh=ySNKkJo9sWvrvSInxNYM3dqbHzeUZdvx2prrm4xnqDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5q5adTpEMRJVXyYc7HOxiR+qKvKjHr2o9Cr1uMilOMg3SE2TlOh/6mjQeYSCg2M5x1U9H1btpEcR2DfLmQSkhE2QpiKKcLXtudLd5TTfb0y0zgqJA9uGFEZax3l1O5/aH4gzVAurmNUxEahyRt4RBKD3v9PWg5nlT5MIzmOD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osd8LgzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osd8LgzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF56F1F000FF;
	Mon, 21 Sep 2026 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973293;
	bh=ySNKkJo9sWvrvSInxNYM3dqbHzeUZdvx2prrm4xnqDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Osd8LgzTMzeZxVgpBWes8/6mM9SsXWebHZHXKsrnk2U3BOaKC+cUKXf1Yz6K5kpN7
	 3nIsN8Ta0fxACIB9PTutL02s+amjuzopAkrtwLJ1Wsj8oVF8n4J9whsmMX/pUNyM96
	 LrvkPytkRP0heJVt6Z/Jq5Zl/OD56r5/+Ig22fe0ipfKXdIjVu8HIEk+GApkSDiG0Z
	 /kA0etBEZlx2CjKgKb2wt5l7qGtHFJtaro1OndWZpVj71BT9Xqbg0ikHaH1+vIpeBZ
	 1RZFN/t8xjWbJ6EUgdImxB6O8nstUrxlEuHTu2yB/YYBu2OlntSrakKpKMYpYQl8i7
	 IRGf+c3hXX2UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] dma: swiotlb: Remove SWIOTLB_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921063628.362078-7-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:48:12 +0000
Message-Id: <20260921064812.CF56F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> swiotlb pools are currently allocated below the architecture's low
> address limit by default. SWIOTLB_ANY overrides this and permits
> allocation anywhere in directly mapped memory.
>=20
> SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
> need a pool that is reachable by devices with limited DMA addressing.
> Use it as the placement constraint and remove SWIOTLB_ANY.
>=20
> This changes the default behavior for callers which do not set either
> flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
> architecture's low address limit and also constrained dynamically
> allocated pools to the same range. After this change, omitting
> SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
> use any directly mapped memory.
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D6

