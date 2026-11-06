Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986666;
	b=utst7XSEL2pksyuGP5/Ql6xNarGANbUJcRupeXLFIDsXY2JgY82U7VIe5MFl2TMhz7ln
	 lGUYjyJCeIUG6zvPtSvtrB7k+fijoPyNUkTRasC1eHFkLcy4PsL0JhTLOq9424b0HJ0e0
	 KLjGbb4dDSi20fAG0J4s07vA8p3G+VqZW2qLDRe00U1PmurCvEqtR1KJLKg/2ZZta26ec
	 XkjmeCCKNXji9az4HRch071B6hVm5CzM7slPSMYwkcjfr03bCYlJKPD3KJHijtV8hYESq
	 l0CgfH8K71KaBil5QD29fZulNoeCQ5jCSmGfQHAYm1o5RLehCsRQm81XqtZzzmNjHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BJh+924KtZ8nadBfKx2AZ9bGazoILH43jK0Ng2m8TIQ=;
	b=erAQbgtPOyAqxfPpBF+yEH05XPIJtLWHsuJEPzrLM4lLsE+XdIYZbZYUj09rVvh8DCie
	 DsLgVzyRf7wlktNmfx5N+kT/nfe2YEfKPiTWGmqUICfDI9CixwQbMK0BfUtxBN327V345
	 BeIFOcBEHIMOYV34f38tLrQEpWFc4V57V7Pne3GHg5L6u1gnRPKvVrmCeR+zMjyhQBxQv
	 x8GCTZvtIiNML2gC58B8TjQgIWRor4AoGy5NFspk/0If7KEwgnAwxgNbyWMCrDAoJmbi7
	 0yszpL50tR/Mu41qT9U4TEZKFQ6IwOy4JJNkJuIga3EWSlojLObZyeqa7SBDZUperDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bjBd/IxT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2263606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjBd/IxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3711F008A1;
	Fri,  6 Nov 2026 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986665;
	bh=BJh+924KtZ8nadBfKx2AZ9bGazoILH43jK0Ng2m8TIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjBd/IxTDlxsfb+Z2g75f0j5VpmB0kwDEJlg/dTlnJfjM2GKaf4hcTj7c7nRwn+Ri
	 oU1XYQTO8mMCpP7hr4xiPpEt+bifn9TC1OCSKrWCdu60+cloWnOn2aEM9P9X5yQj9n
	 gqrRUtcCgF+D36HwfqTfczcXoSeqMTnpJvevqHawbkRGmqD2BpqjxE9tThd2VlUdcH
	 V3X6HqAjhaOEZoIxjYbVZecZOaTql0WbeW2CRQ/q/RZ05Wa0RxG0gUY8sKoLUrYRjb
	 7DVyhnA2Or+OxbACqzlRtFYx+jyxcyzsNfI/krs1DIHuKzE6HrcHt4xGScC367rFy9
	 RTJ0jkcVkPKnA==
Message-ID: <sashiko-outbox-201953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/23] s390: Query arm guest time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-12-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-12-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:37:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add functions to convert between ARM guest time (LSB0) and s390 host
> time (MSB0) using new ptff function codes.
>=20
> Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D12

