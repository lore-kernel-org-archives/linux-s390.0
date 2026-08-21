Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F62222A9;
	Fri, 21 Aug 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342593; cv=none; b=kS94ZrEkuCDp3OHIfVnHlFMrbwyirdOHe/faVAjLM4aSFJahuSd9ckVC9E/HfKZTjGvbamitT5sPXBBwfzXmecwXGJ0sBYVO2zk6Kzx5PZtYviG9/rpF51dYke4dlzyQMC/ODFRwgdYQcNAWDjMKB0CaS7NAmh0CtDFtvyPqzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342593; c=relaxed/simple;
	bh=JVU03gVVzRubKM2zew79XQSN5Xhl1GmmEsS/uWBPiig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JNU8vPxcDeaXBIiUyqHVxiIng+a5JFgRCqZb+owXKQ4wqipZy9CvEF7xROXiRaQvn7xh556pIPIp2F8PPQLdfFEzJwn3RPMB4WYpzGDBlEjguYYs1zShtXZrbk6oIcmaunrxQvthc5oUpuS68KaxqGt7CEEBmQZJrUqbmYBcNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLBy5die; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLBy5die"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBE1F000E9;
	Fri, 21 Aug 2026 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342592;
	bh=9FUQjJFPwqj/lmcEKS5D5h6F2ZSZRA+CT1DeklID3sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLBy5diekOgPpbilumqX4c32WdoQA5IWu1xjWrF80KEY8izAHcnK2QB7mRlt8HM+q
	 stkpVY05aVhFIysWjTjHGBaFfBfOHSZMvwYgOWrFEfYD3/9/35CA2xejPPONR3lAtS
	 Z7gvBOf1QekASmEc2Av4qFkWuloHiFkZDm2UHQvgAxO1hPf58QznnnAE2ufsYRLEvs
	 9vyoPp11nJYW1PzHEtpj3XP41yJoLLqUVR0G6DBzxJhzbzXhCjb1BW7LsqN1X1SR4b
	 D2IRyKv4sgx50+PQae3KNAaodUoKvd7aEo83OB71nLVBa8NwIr41MeyTWhqUz1EY8S
	 9m6dHmQlJe6Yg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/24] unwind_user: Flexible FP/RA recovery rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-5-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:03:11 +0000
Message-Id: <20260821200312.00BBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To enable support for SFrame V3 flexible FDEs with a subsequent patch,
> add support for the following flexible frame pointer (FP) and return
> address (RA) recovery rules:
>=20
>   FP/RA =3D *(CFA + offset)
>   FP/RA =3D register + offset
>   FP/RA =3D *(register + offset)
>=20
> Note that FP/RA recovery rules that use arbitrary register contents are
> only valid when in the topmost frame, as their contents are otherwise
> unknown.
>=20
> This also enables unwinding of user space for architectures, such as
> s390, that may save the frame pointer (FP) and/or return address (RA) in
> other registers, for instance when in a leaf function.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D4

