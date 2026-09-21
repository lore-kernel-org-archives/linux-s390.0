Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CF457E42
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980358; cv=none; b=H9kw8DMMePTh/vo2O1rxS94mov5XlTFOvC69uqsl957x6ZUUJnkQ0Y0XGQf510Tut4JYXiX/GNSZKcMOIpVmLc2wlV5XA8tUOeV37vtqPmiFtTTSVExN7OFx0EFTPGc1GmaL4hh9qToLyxVeOWKehNh27ewWFfjkH7HlHVQQL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980358; c=relaxed/simple;
	bh=QK3ckLwL3zuy5YkljRaCb1c6LIuqA8f0SjoblMoWQiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUaYdVf1cHsZli5dgY8srj+NVp6sXWGv07wE+scIeim2jPYfh9WMbyPOA1cEEDNUz29w9ylgxySmbHRuz9El02NboR1fdjxiMsBGVaS5l+rYNAl+Mxcp0qV39T8OMKaCQKsfvGOBP5xkjAENwvwh476jctKu7ozPCG/4ZSHHoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohqdUvGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohqdUvGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7081F00899;
	Mon, 21 Sep 2026 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980357;
	bh=QK3ckLwL3zuy5YkljRaCb1c6LIuqA8f0SjoblMoWQiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohqdUvGfkmLtE5aJzMLXLUl2nU8R6vTLeVq6WgbDEupm4ahav6iGhh5+jNSDK+pZ6
	 iBjS4Uup3DLBw4rAcRuIIGaySrUDqaZ+EeeNAuPUQG5nKx6R7R0EPyy/Q9t2p5kUv6
	 3fbtpqUHKqtqEDLVkfZKRuPYVqhKxMGGiYXLBY9BVRC2z3c7ICH0KUk0173G01HX3O
	 xBO1PczhaAsfer1FQA/NJNjTZT7u3c1YXVy8ygbRBfcAAzxCEyUFLV7szeUX3zv/qr
	 37qJUnU36nSknWB5y7zFw/TzBqWZj0nc6+fVKfnvtm0Puz63i1FJYII0CA8uJRLsmy
	 uELiuJtq4VZog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/11] s390/percpu: Let MVIY_PERCPU() calculate
 alternative displacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-5-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:45:56 +0000
Message-Id: <20260921084557.2F7081F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Let MVIY_PERCPU() calculate the alternative lowcore displacement instead
> of passing the same value(s) again and again in all percpu inline
> assemblies.
>=20
> This shortens the inline assemblies and makes them a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D4

