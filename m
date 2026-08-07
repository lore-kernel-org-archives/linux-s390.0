Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21023E49CC;
	Fri,  7 Aug 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118749; cv=none; b=VtGC0p90iTTZinvwf+FbjaHEiHVKENlYblCZIu4V2Yf2DjDMbmhx/4WpFCaw55w7/CidjJM5rjmQrUegWhleALgS4xe04RXINOTwLnexJ/MgLF7F8ij7YlL2mEZvFpQBn1G9i/fKfn/LKBee+BdoK8MXa06miPN5dfIPyKJ3rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118749; c=relaxed/simple;
	bh=S0SMr5hHf6De81dA2KYEJpkRtQZeFcGScVbJMtaRXhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHqRfS7gSM9Td60HRNUYVSRU78+eTN4raPx242boGKCQUzw9hC1qEUEDA8BE3WTOYbfttTD47PjMhWItW5pvcTQqNW6+BdYtDNwRrCtFXu40CdBQmoaUn3vEt9qEKuVLMwqROZhpcZ8+USWmJpuB0Or3raNDFfu85Z+UdJMl/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jffF9L1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jffF9L1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C351F00A3A;
	Fri,  7 Aug 2026 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118747;
	bh=S0SMr5hHf6De81dA2KYEJpkRtQZeFcGScVbJMtaRXhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jffF9L1BmmP/5Hrzjr6cpxRvD+TwKy2wadSIU9kSouAp1K5IH0OMOfRvgxDuVFxlS
	 KtZdTkuSWaWImcgNTYr4WdJkbp0CjnbuIheEnIgRmXIiLQeOngjkqtYWS0VkBkwuMa
	 S0pdMFoiBak5OlM2Tuyf6QS+OiAaaxTJcbHydo0OAF+uKY0wV5r5olGQHv9448HV5q
	 DezdrjBvlLa0qFrMn31K/QrpAwuHESmnR8DdtvO87+7i9celw7mFL5P7YL3KYVmg4y
	 v1wpdGe+7ul55N6UBHU8k3hGe/bpa8o+4S4FaCryQ2qxNV8ur6TeawhLAkrmsCLexw
	 QWuN9F1T3aljA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: display: tegra: Document memory
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:05:45 +0000
Message-Id: <20260807160546.61C351F00A3A@smtp.kernel.org>
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
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D2

