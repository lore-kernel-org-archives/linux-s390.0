Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B03EBF02
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372251; cv=none; b=ZEzu3ALufzFGQxgCY9+tbiQmjshP/gO3+fj9QCz32PvY+ppY5SRqv+Ft11BqCJueYY3qOb5RaukpXCfVDcSgF5KmhDD+Z3t/sxctQ/e6627gQgIL0urWSwI2ZqSzFMpIgZuF9HdKXxZIDqIByJQQI+/Odk6XKvfv/BE1tP3ro3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372251; c=relaxed/simple;
	bh=kRD8cpyBRznT2LiwISZzlm6gs4Uw0AzTTY6Uldg3OK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/d0ZTCDQJ/Ph0FIhNTfaQ79l2g963ZDpZqeD6sKFL6Gd4ITliuexPORIONoi7CpewsaA3tCSGPFR+CS0EQ92A7V4J0yujfwD542BYrm+Ofo0DP05DbIPkMID/8/cLPC4paZdKITbZDWy6xvL1jQMaKMi20QofdJBzF6FpN8reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3xX5RF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3xX5RF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9141F00898;
	Mon, 14 Sep 2026 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372250;
	bh=kRD8cpyBRznT2LiwISZzlm6gs4Uw0AzTTY6Uldg3OK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3xX5RF6msHrRf5nfqqSyzYZj9F1RgWBdW0+SeGjJjnYrV2TrbCG5thDbsF8Jo+VL
	 0ByrhYEyk3dhPH1rGUArfyWRxEF9KQh4PWR64FzN2tdbr4RCv/cCxoLLG4b7v/ellp
	 AV3LMddBK3mEvjy39MPMmGDbRmtIk8E/jzy1WuncRFJAWXjidLs1Pvi+PU2k+A6WtS
	 arKvkQGaHYAkVYxNl7BHn+khemmHsqo+ANsZuWBdkYAa2tn0XCZYpwfUYa5GU0ime9
	 2LPHxTTGMzdh+f4yegwnz/BAECp413XeW5tXPEHylD1AG5rcLORoKyg7pwqUEfIvab
	 klxvkI5jDyzDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] dma: swiotlb: Add an overridable architecture
 pool opt-out
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260914070135.313337-5-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:50:49 +0000
Message-Id: <20260914075049.DA9141F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On x86, iommu=3Doff historically prevented SWIOTLB initialization by not
> setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
> controls both whether a pool is selected and where the pool is
> allocated. If another requirement, swiotlb=3Dforce selects a pool
> independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
> the addressable range of devices which need bounce buffering.
>=20
> Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
> pool initialization without discarding the pool placement constraints.
>=20
> Unlike swiotlb_force_disable, which is set by swiotlb=3Dnoforce and
> unconditionally prevents pool initialization, the new flag is an
> architecture default. Explicit requirements such as memory encryption,
> architecture remapping, or swiotlb=3Dforce take precedence over it.
>=20
> iommu=3Dsoft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
> software bounce buffering for devices whose DMA masks cannot address all
> system memory. Such devices must be able to reach the bounce pool.
>=20
> Clear both flags for Xen because Xen explicitly requires a remapped
> SWIOTLB pool and may allocate it anywhere in directly mapped memory.
>=20
> With no override, iommu=3Doff disables both hardware IOMMU translation and
> SWIOTLB bouncing. Direct DMA remains available; mappings outside a
> device's addressable range fail instead of being bounced.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914070135.3133=
37-1-aneesh.kumar@kernel.org?part=3D4

