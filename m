Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E82C2360
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216968; cv=none; b=mgdbobMdf1cfkYHByr9hhvuDeLxAabk1AOr1WrooJcB/LHULr/pkLzapKYBxQrcG7623r3e0sezCUimUDjh1boGJ+KZJp51HkVN6wR2/cGxr5hXyE4ITvmuK7/mZuBfXjQjvLY32BI42xo+5wcSHp9VH6i7XrZUPQj97qX8BMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216968; c=relaxed/simple;
	bh=lNQHQuCiGivyuRgehlQlclxRGX5A4Hyg1LE0FuorHk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZ+yfRiXCt/VCUC1nuDrDgiibGtb65M+kDJRKK9CXC7DVVzQin2ot9B1bTnqoIQlRBeVvnHpPmEUYeV/0RPC3zDVAQrA/6Z6KhObudKoExuzKhoLcJR97DnasubKelbtguv2Ui521dDhvErBinrnn4I9PWPhUw2mCOnQP6eEsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISVFrIXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISVFrIXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D561F000E9;
	Tue, 28 Jul 2026 05:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216966;
	bh=FJUagrTBc/DsEKyaBUSqHm4G5x/xe4CB8rleHvtCqrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISVFrIXA2XlfMOeOCi5mwSxYYO3OihVHTekeKbULSiNLhWSLP8KQj2DoCtPBN9kcy
	 rf1R6fTlWtfQjIGN8J8k1phccgOLayuhpn1I0AHZPhiOSQ2TuTEjrZ1tsssmdv292j
	 mfZvQwomcmBbBRpg0hVRz8x/pWRqp/901ZgxmjGrOc0wbLxmH+zfxs+QM9bl+k1J0W
	 ZgG6u4tz0xQeR3KXapzJZzdjn98zIrcseN3HBQzNsWgpYDSYlPMrdC39LbI8njOGWz
	 IBeabhwGItJ2AHpb/jYAOXQc24HwxniTd4MEa0zrAvboSfY212kU+tOFIVzwAxBcT5
	 x6ex/zSvCUaDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] s390/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728052540.4728-7-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:36:05 +0000
Message-Id: <20260728053605.C2D561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
>=20
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path.
>=20
> GCC generates a:
>=20
>   nilf %r1,<imm32>
>=20
> to tackle arbitrary 32-bit masks and the same is implemented here.
> Immediate patching pattern for __runtime_fixup_mask() has been adopted
> from __runtime_fixup_ptr().
>=20
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D6

