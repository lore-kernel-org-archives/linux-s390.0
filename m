Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D9385D98;
	Fri,  7 Aug 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119096; cv=none; b=t5iHMIe05JvVRWXOe/N1+uJ48KuKRhRjEI9Ru+IuYmS+QIaxqiJanKaL7Olxe3MW5bu7i2w4sqQSNXr4fMzxiBMTzVGG9KnAqR7Ad8DxgPMJ7S/RjQ/MWQynEJy5h6WQfvqQe+cbIJBee5VbgDNIt66ZkLAKwfhmZwpyq7fdNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119096; c=relaxed/simple;
	bh=/uehqPtO6fzvorRMmv219lG/7VimKmOUdSTBW8oIl5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9Zzq61B1Bg5zXUxO18uJxZO4FF/xe6cmZP2n3u0uMbAVZ1KaYn3pZvdVQ8jBgDjr5ZuEr27ptbPX/BWUPkiKrm4ihop3BuCf/bldEdexxufI+Tm758FyB829OhbT7PJlecjublhK/JbGrx5e8GlO+N6JfqXVw4HJMzoBR+L6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+kxaUlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+kxaUlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB61F000E9;
	Fri,  7 Aug 2026 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119094;
	bh=/uehqPtO6fzvorRMmv219lG/7VimKmOUdSTBW8oIl5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+kxaUlQONT3sLNGEKIRX9f+F4zKkKkIabkmQljybGp31Q6KWjO7ziUymsBSPXp4E
	 nZDbTCAFsx5D0JAxfzGLNMLG++lzL1eYLpwcS+AalcPfvQbVMiL/hKth3Gjfqp7qot
	 631vmTn22+aq9v8l/1eCB4/qttoIaykS//C10qh4nD0nvPhS1V8AZ/g3ep55l/pyG8
	 7luys8SUY2gmM4bSJzOxQgNJ/dtBn8bmuectYO/bl3iab1RsbPnE2YGO0cw+AQXvin
	 Z1sSlgq6SieF+flvJhoG+P8AhlRE0tn9Vf4g1o2CDOQCt5BwU9I/l5immvXkINOVjU
	 eN+6fM8Z0fXvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] bitmap: Add bitmap_allocate() function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, devicetree@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, media-ci@linuxtv.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-4-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-4-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:11:33 +0000
Message-Id: <20260807161134.3ADB61F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D4

