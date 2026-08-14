Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0320483809;
	Fri, 14 Aug 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722094; cv=none; b=cm7i5qPeeExbM3ADMzmoGCUgYdC4VXII75Dm36MYRydm+nGYvcQG2HeDDGzKzH/bPW4oz6/89TiFAINm4nv1Bb0neKLFtAK8cz37TfHRt+KuwI9UeIJ/a4nLu6wGU7IDQi8rkjbCRM+ipqbfOZ4xtR8OOb+colDiQJQux+6Wq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722094; c=relaxed/simple;
	bh=44S4lkUYqvw1YWxAfIu8ptu2+8w9BuSAtJbFKJdAek0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nlS3yyE8hfTkl0EdUideqfNiCU/RPzY3pTmDmccnHJcrx7Y1xrc2yTimxfnDZcf6oUS/gr/sO12gKVZ3jhU6mGuxqdZpRsSNvnssvi7tcVzRu37e9ajonhcpOZn3tI9vqSMIVTOaKirgdezwpm/kX2jYFc6cpcg3+y2u2/ckU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdwB/bIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdwB/bIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35931F00A3A;
	Fri, 14 Aug 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722092;
	bh=44S4lkUYqvw1YWxAfIu8ptu2+8w9BuSAtJbFKJdAek0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdwB/bIU10wtEggZhP8ftu2Gdb2fd5jS/i7T6a80fKVV6OBRZKB2ru2n2Ptt3Dpbf
	 fIn59cNn8U2b838/1lCRiepjNOPW/IFz2+GWaZHZ2I8Q45Qkhhe4NjxI3CG+Z4ypBH
	 UAL3AKSj4bwSVECytaqXx6p6NRisEOuXr/bXs+IcTn5C/r5UtX9EmuQBYug+ohrN4b
	 s/n4G37j5OWPw337tYUWnme7ja27hNE3pTw4WltqPp24pEoEjgNjcL3TNSX2G/j1Hi
	 058YGKrkJJmBEj+Wpb5D0pvuNUZIs3mmPUOf3VEbrtL0Qyp4nGYbLhCnWWs353gQe+
	 Z6jEVYrivJfMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, robh@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-10-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-10-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:41:31 +0000
Message-Id: <20260814154131.C35931F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D10

