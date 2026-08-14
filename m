Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283D430CDC;
	Fri, 14 Aug 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722249; cv=none; b=U/Cjpbj3dhQemCLck2MmppdCIx2r3QlOra5HEt9hWem/OQyQcQdKU8bZuXT2owqsHt8xrW6Je3AfqR0Cq4LtFJyXnt3YIxovT+lETHjz6Z5O0fBzbbYQlxw5QUsBrg9DPJ93K0jrdQiSZ9IaeA9klSKfD1Mqe1wQdRCnTfsEpQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722249; c=relaxed/simple;
	bh=oH6Itit7sXpXdfxkFH4iS60KRx+5GjvAWa6hE67W5g0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nxOsX2x7DC/mLDN4l1tag7UVKazxvKxBbJqtxHbNSQwk1keAbnydv0lXqAZLCjCLVQof21eLuqJ0fWA8farfTO16HhVNRqRjRRwkiYDRJQeGCoHbt9iozdQx2gbRL2hSCJyVXmqgCGrWr8zt+ASUYJCMU3gSoDGNjxT7krIXzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUeOZ7nR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUeOZ7nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6071F000E9;
	Fri, 14 Aug 2026 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722245;
	bh=oH6Itit7sXpXdfxkFH4iS60KRx+5GjvAWa6hE67W5g0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUeOZ7nRi1ZnTrZwkJxwUeNU7iRp+MeMv4z6P6VHnFUtOBjSvpAegyufy1PW2+CvU
	 SAwY7q7VKepdikJoJOrgEUAGhl6j71WZE7j7RpZeY4OLmvDGTgpiwmyhl30jSmJlN3
	 isF1rFBItkYA4Kpxj63pqQ51BH62aKZb6yMBC9CNCfhiQNWrSub3NQWziwAy355Wq5
	 GCNpmm9MB97pIawXK0caVXakUtbFugfOgwo/EkMihCcTNsPRiR6sFx1By0ddE85YDt
	 es8TQ4fHOIRZVkz6SJY5h5RYGhC1L2qn+5VenmxmOKXXO1ulYwklxIOS1gySyq1tdb
	 8jRY26n2y391A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] arm64: tegra: Hook up VPR to host1x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260814-tegra-vpr-v5-9-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-9-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:44:04 +0000
Message-Id: <20260814154405.4B6071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> The host1x needs access to the VPR region, so make sure to reference it
> via the memory-region property.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D9

