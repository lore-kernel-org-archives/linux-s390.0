Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA84749DF;
	Fri, 14 Aug 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721800; cv=none; b=kCeTQ/AaJS/YBM08PmcFqxa+QhsTdg6QGNpAoZsOakWoiCg+mK6xXWfkjjzk2xZIWKx7Z+zF8AmRgc3TyHyo4F9WHP3Jh8Zd76fnDwyGjYkJKnnW1pJNPPP0JpR+0zLJtxqrNa2V6sfqNGuuKv1mI7jgNQJAHI48PAW0thG2PIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721800; c=relaxed/simple;
	bh=PQIkyo7HBubH8g3zjI9SYWhaMUDhOOXr/Ae4jDKqfEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ys6OW0ZvT1HgpRmmI6h8XpPnzx8WGor6VmA8XYl2wQoMFugMKmLJNh7RCAMPeMMJPgEqSwJlRVr35wrrBX3UusDL0wlQz2uG2+CVxxS/5sx8CwBzgCdZEI8Yjq5nTf9oAcrH7p+lcZvyDofCNMY3By6FpwCGVzBZbnVSfzvOyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1iCb/wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1iCb/wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC83B1F000E9;
	Fri, 14 Aug 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721799;
	bh=PQIkyo7HBubH8g3zjI9SYWhaMUDhOOXr/Ae4jDKqfEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1iCb/wJ6ZG8MaK8teuItWrg3jOWRTUPslK+k7nfH7pmg/QnxBHhXhlOB04G+CwMk
	 PjtK3rcXUPHbEa7OroWd8j/1UpDX5EilKUz7ykmAeUVgREuqHNLWpkLgtasUAgQvSZ
	 8ZG5l7aW5JoPsudX2m61RpCWxpgkh0EpvyTraJNUN9lruz8+0Wgj9FLjTX7vq+5EUp
	 OumlpyqTEftxuiSjMA92rmVYKaIgzgzVd0/MmShfC2OQc//2OvyNdKoh79PZkPt/yx
	 kB0Qt9gmjqeDOIq2U6OVeaEkcIyuERdl3zd0wRVmbowDIBciYLSCQ7PdUE8efcOHEt
	 /dJIpuTEKuefA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] bitmap: Add bitmap_allocate() function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: media-ci@linuxtv.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, devicetree@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-4-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-4-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:36:37 +0000
Message-Id: <20260814153637.CC83B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> This is similar to bitmap_allocate_region() but allows allocation of
> non-power of two pages/bits.
>=20
> While at it, reimplement bitmap_allocate_region() in terms of this new
> helper to remove a sliver of code duplication.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D4

