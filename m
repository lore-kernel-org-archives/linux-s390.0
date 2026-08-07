Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400C37CD40;
	Fri,  7 Aug 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118782; cv=none; b=mfBJl9AyBPEgEIfONGTq8AaaSbPIPkRe0Q2AYM/jTSqHdBltnOnHfazmeTsrQrjgAi0cmviyW34W8WCDhfCHhWYsOVdbga0V3080Juz5q6eQW6UF3FWBJKHWaEswbqNCdkI7ee0paiQcamPNS0oLRv+xjWX2vg5KdSxOojumrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118782; c=relaxed/simple;
	bh=Urc/6Q1Pe4+/ucRIjiP/K3/3xDvcTb6U0/VbrwDRbs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZprFGZ3zREwNCN0fp/1X9gvQGaqHjAhEfT0GWCpEQlS/zQAZqzHaHuOmN6sYzdfP9U+GVbRzGulde/NURjha//K9+Sc97Jmokcg04NZfWdFso0algCo+WvfGZ80yySMkKY7B/c36QZfMZeISB/uR1N0RguBPPhOG3QdBm433A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwLIAp3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwLIAp3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFE61F000E9;
	Fri,  7 Aug 2026 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118780;
	bh=Urc/6Q1Pe4+/ucRIjiP/K3/3xDvcTb6U0/VbrwDRbs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwLIAp3TgVpkr0iyEsu2H5eb41FD9ern1Adyv8B/iIV3tBQATY5vIuv//gYZ73rh0
	 1koW/rTfGurA9gJe6IIZamRPZ5dDJHA1aPvHWz6OTKF9MfjQrBCqRuNvNN/7WfVZIH
	 T6JMgBkG9ZtNskMXx8thqfxBEcp8E3PxnW3PbrwakIxJHYMZfTC6xH0dTN2GUREE49
	 juq8b2y1BOaZMQyv7N0jMx6chzGIFyb4BM+h1bcpEdfzASgWxEUn8D0IM4V/gMFYzK
	 B6p6R0aKfirO9iiGwKwJ8iH7Zbx29srdkD9HdBvuz8OF4ymsXER9z4v6CUwaIWTCLb
	 o9CGQ2J9X7F4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] arm64: tegra: Add VPR placeholder node on
 Tegra234
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260807-tegra-vpr-v4-8-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-8-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:06:19 +0000
Message-Id: <20260807160620.4CFE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> This node contains two sets of properties, one for the case where the
> VPR is resizable (in which case the VPR region will be dynamically
> allocated at boot time) and another case where the VPR is fixed in size
> and initialized by early firmware.
>=20
> The firmware running on the device is responsible for updating the node
> with the real physical address for the fixed VPR case and remove the
> properties needed only for resizable VPR. Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D8

