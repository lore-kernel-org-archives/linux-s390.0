Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEEC426693;
	Wed,  5 Aug 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949669; cv=none; b=OnU28bIinqUKp5/WRQT/3IPiYWEZXudCp+lYjq83RLLoAxJR9vizwQl1hX3BcrrjDzmlUDaSpKwFPB80MhGjX4dcLwNhUYac/IjjHF408+uLDLe7EVhbCo38dGjvxxM7YbZjKgGx3ppEZuw2Q3srNxAJx+myHIzHjzULO2yqpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949669; c=relaxed/simple;
	bh=uT9PY8YHPpr4KqDtEK6cM6LyvGvVGtzHuVtcMGP9aiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mSLmLjmgoG6GC5QEDCP7HoyH7gUu82BilFjRrYLFWnny9ITKDZ19i5n0JhSX/UIatNfSVjo4OrcwaTZBWLMh7oOq74OjuHa3RKx+3QQX461Nv5XrZmK2xI/BvkRYrlm/QBA26Kht5PLGzWbi2wFTrc2uTYlVw8Qvi8AzmwwEDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2Yqw3Vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2Yqw3Vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055DE1F000E9;
	Wed,  5 Aug 2026 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949668;
	bh=uT9PY8YHPpr4KqDtEK6cM6LyvGvVGtzHuVtcMGP9aiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2Yqw3VyMMarCxAjraDoRsIYWoe/8llm3ts4HZL5whLA9Ru161dIUcgndpy714QhP
	 ZVgzoXUdRxifZynkC+v0EqS22CRG1C2HAvWa1Hzlp/g4PiYYI5GKvoIPvPu+k6IPLd
	 dSeuFzBNDwfS69w8FJKJt6c3g8QxTYj4joBLoOjJn49bLX4KIuCdaXBhndslzPv+Hh
	 sfK50YN5wa0YUlaDTm7kNTYKmFbcxF4nNe5qNKC0NJV10Bgb5srzwmjYpQKpmtRSgw
	 VDyzis4B1MLZcGMWYidMUq05hrE1QK3/g2QwchWzBI03v2sHNnW0PRFnAXCTspixOy
	 sPwIXiI0kkAEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 4/5] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805165518.794-5-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
 <20260805165518.794-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:07:47 +0000
Message-Id: <20260805170748.055DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805165518.794-=
1-alifm@linux.ibm.com?part=3D4

