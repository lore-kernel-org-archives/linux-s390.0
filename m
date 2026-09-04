Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406747143A;
	Fri,  4 Sep 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519408; cv=none; b=ptimIY+6/hBYbnN3YZOIyOgSaYcZHf+ZXVy2yQrd4k914Dlz0YTFDuOKpxxgybFbhbr6ctlKJLrm5BeLUPpfliclNqEK/mnqwp1bqRAUmQ8CgQRXKesnjanMyPvZA9ViTT2fWBK0mpCJalX6rGzweY3e8b/YfHsWr7uktz0QW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519408; c=relaxed/simple;
	bh=3xtslc2D80gdBYd6ip6x8G/YBhaOiLglQojQPTnbmMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RyGTwmXEdNxjlmPJ4en2tU/YW6t25557EgpU9jMvyPHBwU+NdrX8lZYbBsU5yiR7rzyPKlmdR4uJVh2grhSlvtX7UzIghQXsk6s+fXdDkSTY5ElO/elQN3gR8the3F3yP+nGg2W2oaBu3IfEQekE3kKDwCcK5ufLBz+gLl/CyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3OhGg6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3OhGg6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C21F00ADE;
	Fri,  4 Sep 2026 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519406;
	bh=3xtslc2D80gdBYd6ip6x8G/YBhaOiLglQojQPTnbmMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3OhGg6K34/+jhZrqZoAJEn6lx79LB7yIU/lbBPQxhtXT4TAjfeXTCAmdwH31HCB5
	 OQfuIiICwKunFAe5I+YehQayhJAgv6YJ4ItqKxluA5OMt64wYTAs6Bonx4sgIa1C1L
	 HwCHS8xHBf6BTxTwf0A80q1qsXzeX+ux3Btcjt1B6bcQkdBvTHwb1cHdoP8qZzZu9T
	 bCkMvHbXOpYaDA+ZEli59zSNTuQX/MvP2vr+AWWNz5yckoJhqSgLlINDCMs6agmyh2
	 wDOn6PdVtIAvjPNGBjcVeRe3Vqjfp8WDXwjrPavgduSoXRhpTWu+a7IlJhxlfEQCR8
	 y0dON4JR0pNdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/12] dt-bindings: display: tegra: Document memory
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org, conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-2-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-2-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:56:45 +0000
Message-Id: <20260904105646.148C21F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D2

