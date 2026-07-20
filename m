Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43E40FDA0
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559099; cv=none; b=jBO5f6Jt34a6//GdCkqHoNgH86D8wRVULhwHxOUDHIH15KU+0BHtMJZxobosheHb64EYB8RN/pcDFFeUdnteKHcIIzPdMdt2UZLCwmzW1MHaAO32nApEdFzvrliT6xZ7U5LsM0qDBxpnY4K0zpr5zO1of/NJ2IT7yawmV9ir2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559099; c=relaxed/simple;
	bh=DLvFcKo7mHSk+Qc48m3QP53JC6UsZlHoNPOfakfSOZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KTujXHQZZkSn+uvkwfeqig8NLh5oO+TlCEYOnHPzbbPLieG/LMtOXRMSgPBtKEu2vSRAs/mxbQ18PaNiLfH3doOjhocG51oo4gE0SoJNAQirvgNaoSWY14aJ4kLfh6/DdDK++lky7MAspWyXtrfmJXCGQt0J+uYusEQrX5cAvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxGdEoTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxGdEoTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D81F000E9;
	Mon, 20 Jul 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559098;
	bh=DLvFcKo7mHSk+Qc48m3QP53JC6UsZlHoNPOfakfSOZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxGdEoTiYLPyc7IBCeZ4XAiwVy3G5BbhwoBIsx68xlbVr0ILjItPlxQGHDaGrzpGH
	 NSI8oqiKsQFh8QAPDvrOurVL7qd+BXJbGXX07QOnMI87zV7JZuHZ6GLN4a1RwBwvN3
	 naHzwOb6xOF/J09D3kW6AzMRnYBgurGq4jl2+DBbTNGnyeWEE1/S1oR5XEvaIFMEAb
	 5ZZsy8SYpXTRYWuzF3VKNlorBwgXP4pxgLXmfT1nR37rsac4TmZjMCCAjC0LZER9ZP
	 OMMA+zeMXwXZ+3U1b513nUIT1HHpb2K3iR+eYJsND7FGLDYiYoqLHd8uZSWJq1fUF3
	 8YsRZYhvPs56A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/maccess: use proper PTE accessors for copying old
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260720144734.1003497-1-agordeev@linux.ibm.com>
References: <20260720144734.1003497-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:51:37 +0000
Message-Id: <20260720145137.D07D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Follow the pattern established by commit c33c794828f2 ("mm:
> ptep_get() conversion") and use proper PTE accessors instead
> of a direct pointer dereference in memcpy_real_iter().
>=20
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720144734.1003=
497-1-agordeev@linux.ibm.com?part=3D1

