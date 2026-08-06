Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BF23E325
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032388; cv=none; b=TCzA3+n3EaqP9NcDJb+MXARJnkNr+vNi21ETHY/XPppL7JXaqte1ceUCfZOV9AGsu4z0xrkYKRwgKksokjWdHKj8spYDCDbz8bC3CEY4IxR4x+mSbTYXQRmlyUE1MYZFSDpHnpofLPnTLG9PvK31XraVN5KuN4/kzVfMgmyF9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032388; c=relaxed/simple;
	bh=dzLwQ65QDVyV9NfaEfSaozoareqbrCZMv6pojDvfaN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKtvThpbsZDzKwy9M3Z+rV+oBbUZ0Et0kJT1jkBbxMotZvadaguZNsZUG91VqMEA8vZ1AWEvdgNycNSnuri5uPXI72+0ko/Gs1HhRWcbUcLyCvLejyll7z7ol1cUajoAZEngHCR7InI6pxjXZCquyZGzURerZoolMw8kFy6Gs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/PFR0nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/PFR0nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE171F00A3A;
	Thu,  6 Aug 2026 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032387;
	bh=dzLwQ65QDVyV9NfaEfSaozoareqbrCZMv6pojDvfaN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/PFR0nXb7qdhJk+mRUwV37XkojCySVBtaYr/X7W7OlgrM5madjH9RfKGv9DOFzXr
	 nVRy4ucHH0JnfOts4F5/7zQrKLR5gC4e1mO1RvFQFf54cXDIUY5zYVGSy71LI7xhVv
	 dtQEm2MVtVrn2hICdNZEF4bmtRlwM2wmzVJcQBM6YebjkfvMZAfSAkUT/hyzaOvYTb
	 FYOG1lqZ/ywwRXmWA3ZPuOP56w0TLGSPPatcTb0wsPxM5oqGHV8etqF6OZJfbUO0rH
	 3DKj3mP0PCJe236wILUwCRm9U6yayrO50A9PRbyHmNVm0fu8WaGLGmPJaoFCpGljfA
	 FWge4OBMZ+1gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/char: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260806155303.2675932-3-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
 <20260806155303.2675932-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 16:06:26 +0000
Message-Id: <20260806160627.3DE171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All character drivers pass clang's compile time context analysis.
> Therefore enable CONTEXT_ANALYSIS.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806155303.2675=
932-1-hca@linux.ibm.com?part=3D2

