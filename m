Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B0378D87;
	Fri,  7 Aug 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118970; cv=none; b=sXb8uXDxZi6I74BuNv8gAKxLLn5Nchn43m7Sn4flyFnablPbn5w1SWDshC1KRw5uVpuKmb/2/7C8jaqVBMpocroNffBsRlaccZDGJbKpRvRoi7AbNOLBvzRGGXwcsNa0dYCpm5cMMxe35gEwdagsyeYFMr6tGej6sYIcmx9/6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118970; c=relaxed/simple;
	bh=i5J2dRc8hhYNRdnFx6+Yskp3/ELg4aKmgxBRtJYEAoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LtOxvb6JYYyTMElUm/6V2dAzu6p8cPP7bKEuTzFKHLmc8q1gpuqJJN1Zsj/G6Z3Cdx5tJLjp+ptejvoiSZaZZJPaGSFsy4f3EFdrXQWdq3/2Pgj5l224G3flC1nWMj6ep+Y5GLcpgNdOTugrsuXJ8Y4pcqti+GuEMBNgeAH5l+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6z2TjSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6z2TjSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB881F000E9;
	Fri,  7 Aug 2026 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118968;
	bh=i5J2dRc8hhYNRdnFx6+Yskp3/ELg4aKmgxBRtJYEAoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S6z2TjSnCFLG/YLFbH7dfeWGctTlmvPL2ZFHcW86esgiZaJyVKdJv9rWmzR0Aeek5
	 nntjRpCf793bOBAGC5PU6596GIQy9x9fw/jyx5UgiD/lTFKuWMVtQBQuMvhmcqn1+O
	 u3DoY6wcTN1UPkKcGSGqyNcJy6V1PDLOAtI+e0z5ghaCbuE7/UNNjpuYe/EZwsARlJ
	 cxBMAzfKA7Cmk9TOUxvegOnIicZ9PXtg0/hmt94FxJDXQv1Donhga+TFx+s3CFAhof
	 p7bijHhK8nsEGNHqUAl3NhXPEM8INqh2Nv5pewBDRJWQttL7q10mnUySjgkOb4OhA2
	 WWTJk1tdIjflg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, linux-s390@vger.kernel.org, robh@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260807-tegra-vpr-v4-10-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-10-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:09:27 +0000
Message-Id: <20260807160928.3AB881F000E9@smtp.kernel.org>
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
v4-0-5510d16af89e@nvidia.com?part=3D10

