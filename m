Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9523EBF02;
	Fri,  4 Sep 2026 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522837; cv=none; b=BjyrRCEpQY0JOCMOOK4qRcswGgcSUGc8nar1TRiIK+I6LosJDz7IJ1QIBNIy3Q2P/gLuSphDDB3pS4Z/qflXe5cLpsTrFIqg88a8KWmWBTJDlsQblLyseG3+spEG3K3R+UMFsasx3EXeXQ3PFypbWs0ipB10RGu1pj0hLdZpNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522837; c=relaxed/simple;
	bh=9MvvEevaebnk0LNal3y1+rSwrnqS1mDIBJl9BcYOPhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=maMINXEisSD35ju6XZozJRIKvDqx+tTNO/ZdvId/xS9/wfYPNGhepHjbkTJvqADvHRC8lgF4RSOBNMDm/A/sAtUNXb88ftzu9UtFGJ/WFog9cZLyjN2FUzOhTqK97BlKeKkblVaMLIiNVQF8rHVsBIAD6EA5/qLHb4iv/zqf0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+MkjO9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+MkjO9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0924C1F00A3D;
	Fri,  4 Sep 2026 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522834;
	bh=9MvvEevaebnk0LNal3y1+rSwrnqS1mDIBJl9BcYOPhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+MkjO9Q8BJq/aXTwuXz5fJW9B22ZxzieXMTfOA9T1zcvwK5EzsSUWD6g9JAYy1im
	 a7jozp+HCGaufy0Ykot62cz46aswKEd8gs1U2Mf9aCeRKJ+qkIJqU+ZCaQEJjPY7jC
	 b5Bf0UoszDlma1nvVaqwIOX/Me8Fxu+kw88lZxK0QpmtfMXKZ/CD9467oLoiZpCErV
	 o2T5P5csDCN4wTkgqUr3YzR2X6UJxjYH2g7Ra70ObWFxqC5BVl9lEHxtQZoh9fHRSW
	 DIB8xppmD5W9VQ3AqU0zKc7hD40hXjrLecfpHGWKLGpk/BW8H6FVcnAxKLtygFof9o
	 P4hcjLnh8+rHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/12] arm64: tegra: Add VPR placeholder node on
 Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, media-ci@linuxtv.org, linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, robh@kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-12-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-12-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:53:53 +0000
Message-Id: <20260904115354.0924C1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D12

