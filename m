Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30DF4119E0
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059974; cv=none; b=bRTaxT+aSNgEwPU0ER+cfamFas996gc7Tx693dvF1KgPdwt/+1l3Vt4j6SDMrAs3PzxUXN3/uxhNPAKbCghtWME4dFiOIgWUYhPsaBVgUjTtTFx/+dkvN8fI0a+WvLZ94chPz0DNw+IBYROlPs6880XfJvRrqKfHEa/31cQZl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059974; c=relaxed/simple;
	bh=qm33WeQ2btKjkf7ntwEkGHNPXTgzoJ2R4NC7eGPWhwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBs/JT3EB2a5KSr0UpUz4cK79B5U7Xa6X2iT+FmaFQGi5S6YQU85mZvF4RqITHGV2oWSsYQUo369MnVWvzJSZGqH412OkvBZE5wQgle2skk6cFbNWmWK6c5YgDIgF4LY6y+eHLG+tEkfX+KpYCcnZa0ir5hexA8jQUulB4rPJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLFn47u/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLFn47u/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159471F000FF;
	Tue, 22 Sep 2026 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059972;
	bh=qm33WeQ2btKjkf7ntwEkGHNPXTgzoJ2R4NC7eGPWhwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLFn47u/BV/kLsq2/2itW3q0+8zJpG+RilVmsIeug7xYO507CtV0p6wZF89zea4WH
	 7H/2sLgLmaP0Y8Hw14lDGuDUcoG/fo75GRWar52tvz50Xm7zCjAjN6KSUC22Oh+FLw
	 hJPYpD02dWpJAiRG6UvejYs8YTkEdU+g4wmu3AkxUxIV0KZENVmHykZCVw9avAEVIx
	 /sVwITHjRtcpLU/wXWF60osDZQtRbWFMd7CozztSowF/4Z22r9r4wu9z+srz5aEYpu
	 J76t2xo5eB1SPaG/b6LYjIF439VxQ2SIl08xVS/AVFMRLh1qxUezWXELy3Fdm2Eqtc
	 oDfEd4QueTMmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922064303.524293-4-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
 <20260922064303.524293-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:52:51 +0000
Message-Id: <20260922065252.159471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace manual and error-prone iteration over entries of a GDS {sub}vector
> with sclp_gds_for_each() which deals with erroneous entries in GDS
> {sub}vectors more safely.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064303.5242=
93-1-egorenar@linux.ibm.com?part=3D3

