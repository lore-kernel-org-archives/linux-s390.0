Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EA3CFF5E
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095304; cv=none; b=K3l8UI4uZvhJtWj2phgKVWBlt8bePrX8Slxde/YGNICqnSoyMQXhfVYH1LP0CS+Hzs/0MBMu5p20xUxTQQSE1vXVm4LZuBHQDgpcGOY/RowSmlC52hhIfMqmmry+3Wl7r937bnpB9xjMSmVkkXf5XKY7o7BeLpvOg5EpkqPsajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095304; c=relaxed/simple;
	bh=MKp03b3qUFXteeKKy4H3/tfANbt5DeMKXkZucjLpj44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqbOPWlZeVca6rnXo3lYQKLZEJvk67BIL3MQDuloElskDvS9IlgTAPY4IH5R3bshBc8Ds4oYFxkNJK7wFSQsL2Enu97TTMHcDDggJSL3tTlYZOqQShHEI4pK2mmYCDVcnx+hINcVJgJC6abCBMTihr1pTdUPoYqpDJxyYbemiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VapoT6cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VapoT6cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479C1F00A3A;
	Fri,  7 Aug 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786095302;
	bh=MKp03b3qUFXteeKKy4H3/tfANbt5DeMKXkZucjLpj44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VapoT6cEIUG8cwACqb/EiFZFjDwx4MI03r7U7dJPyhCevAQR++j2Vz3BLo89LT35w
	 knXMqHyekotBX0BiuR416XxWbytN++Ol0FKWs0wVZZ3gi/Ir6vs6NKRRvEo49BB1bz
	 MXE4SyQgn4xe8Ko6KC5NZQFZ97BNrEsi2Y1VF3uNE9bISIG5+kBCIzeOANDcWTNbt7
	 5G6vFfwYBCue0RPEA/MjTDi5+dX6awXZ9jY1WNaIkGMNrGR1xa9zkFjk0vQtVVOFJr
	 waHyNB5rYMSE4xKuF2ED/LrfTTRxt3x1s0/yqktUlQd9Cc0lUeYaHzVPKY42PGmEPj
	 op39hlzgw9HPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807092612.2202005-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:35:01 +0000
Message-Id: <20260807093502.5479C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Realm guests and protected KVM guests may require swiotlb for device DMA
> even when all system RAM is addressable by the DMA zones.
>=20
> Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
> guests, as the reduced number of slots can be exhausted during CCA guest
> operation.
>=20
> Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_AT=
TR_CC_SHARED")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807092612.2202=
005-1-aneesh.kumar@kernel.org?part=3D1

