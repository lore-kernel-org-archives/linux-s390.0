Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2233C194;
	Tue,  4 Aug 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845810; cv=none; b=Hy1RMj0LrGB/VXb2wzgpdBT1L39dffIKSVivko3xR5wz5f7pr4KQ/hAhqHvkHJtd8LzrX1f9QryTeWJuB0ksX7wYyo/sjKO78+duKyEmt4R9fRQ10pqp7OTKkOlyMJBZhR8NIeD1mYel+c6N8bWowxHDB7uc0RuI5juxqhc0XYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845810; c=relaxed/simple;
	bh=c2+E90HYTY+cCZmcrGc5ThKcPTBAoNrQjVyoKvGyVWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h5Ky6avZ8/spHLEexO7EN5UvtcB+RTnUoN9u7Is4sBZQKZ/qngdpGsGDh3QDdskEfpcHXSvx/2Nicj/lrIhvLuBSW+FUDm5YfjRBtZOzs1jyEJambTnXOAnJYhElYpYig6QvTRz7VIH8W3pV66s0qqj+/IiTu4UWh45tUUDquxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0SHd3jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0SHd3jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7881F000E9;
	Tue,  4 Aug 2026 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785845807;
	bh=c2+E90HYTY+cCZmcrGc5ThKcPTBAoNrQjVyoKvGyVWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0SHd3jgoY+zyysJkwKKFKgbV7IZYCs4An3zpQCjcBDFLtsIJlpId/wlWdNF+NpIc
	 eduOxEGjQM4kFlGWaFpUTDMQqt2LSlzda/wb4c8CbJvrk2UFDV4p7xNlQ7KjsrEZ9A
	 YyjvsYoPcos598W0oiEoyg7N0fvXfSXP1HOruKvvDx7+E7qZ1ve8GuD3uBGun+M6V8
	 aNREpg9ihAIbKsQtJevD3D4WD9RP2TO/G7G/ryhkGY3PHgERIAbFEPEqgpeSi0LZ5+
	 bN3X7LC2a72tXzq7zH18xxjM9lqvyR/KT+F3bX8uy/GWEdMaGMFBPkbJ9+5mY+gvXM
	 KLoKukcQqFgOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: s390: remove user triggerable WARN_ON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260804120631.736919-2-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:16:46 +0000
Message-Id: <20260804121647.4E7881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> pin_map_page() fails legitimately whenever the userspace mapping behind
> the adapter route has gone away, e.g. when the VMM unmaps that memory.
> As this can happen without a kernel programming error, remove the
> WARN_ON.
>=20
> Fixes: 8c0141b7c13c ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Cc: Douglas Freimuth <freimuth@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120631.7369=
19-1-borntraeger@linux.ibm.com?part=3D1

