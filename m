Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427935;
	b=vr/orQMSGe/LcSAaHvJsZ/iugBaJzElGz+5Hl1/nfjLp9mcF8aFWJFGiqZ6taoswBCxY
	 0ANN/bvfV+PVH9bjOkT75YlbktWP/L374c1JeKaeFbVmDjcvJ5Gd/wrIM+0NhaI/xWxQA
	 NnPC2RJMrSUr6FvzG8K1Aje3BWCLHOH+HmYBh//iSRp43AGJ3fR4/SpPhivpgst6JmGQ7
	 BS2dlUWmL6C+AKMTOTcUY30nqP+FGzGQ4/KZl35Q2mQNDmEEhkniqQzW2IvsDSXUWYqjb
	 I6i/qbimcL7Z8+pf/bPt/FicaNBMMdDaBlb4L6gOFhb5Pgk5r8vqIvYC5Xyge0YuK+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=soDsQaQleIHRGr5VnwwdC6SrhVH2RL9zLHqGRzL6t44=;
	b=Wr3iNhydrDmSRTN2/7qbVyFGIBJ/pcu5WQM1dxESDsRaC/D085pzGiIjJ7Mj+dig8Ovr
	 UnMjjFJea1ZpiCzsIPmAXYkRiE48BFL3OzAh/RdWRng9YzuRROvL0fUrZWYtbpjMUi9/r
	 EczCkSVk2Fnkcxp247XQUQMZc8Vle8nzAFWva6nUiY2emeBvpvJ+aqbtpez5ybCAvNxgO
	 Fdf0tebh66+psM9M6r4lIDS4wSAM8cyrh2oVWwxDYhXNYSA4qUn0N7ZHmvmSpdVJHGOy0
	 lJd3CEaq4O+YrhOD6ToyrW2/NJc9xltfwAzU+pNqBd21CVZXZHikuYq/ol8i8sYulYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkOMCHSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1F606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkOMCHSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F90F1F00A05;
	Wed, 11 Nov 2026 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427934;
	bh=soDsQaQleIHRGr5VnwwdC6SrhVH2RL9zLHqGRzL6t44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkOMCHSSF/KtYDQd4a1S8yRe2xz+aVCYNCpfxjxMD1t3iUhWD0eiPGlR4nMBXcS32
	 yzp/k9Ht6R3aoP4EeYUPOehW1fM0qw4mXkhBY54d/KtaexK36ZTBiSFmH5EQveDwTu
	 eVc91GcaOLN8YylocWbbps+UkXb39KRYxNHSDBLHoUhLk7bX+2+owl1jWTlVH2iiyq
	 Fpvy0F3SJ2pqkuhDsC1N4dSHv1xqv67hzzI92HQal4J0EN3eT2gSYBn64gBV+XIr8I
	 UJ9qrsDFUIpxZTibGpN03itHC6H+OOVfxsWy07P3zn7CWvDxFuSxi+IoIv65boSQV1
	 L5QExYEykIFcQ==
Message-ID: <sashiko-outbox-209619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/14] s390/vfio-ap: Data structures for
 facilitating vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-3-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:12:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D2

