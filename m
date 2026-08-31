Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CD3FA5EC
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170854; cv=none; b=c2oZwdQZzhdiIDqUx+q1xN7T24TG89elJ4wHgL7pWIrNhxuPq6v4mKGJGKN2tNJ7UwkY/CuNU3Me0s46F54HvGytM3j0XjYnb0e80CSrLpaijC//Ve/+iN6kJJy8yN8iK3CcbMqwgBQZlTWPVdgEGpBV4vDJUqZfovUjw1/hsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170854; c=relaxed/simple;
	bh=Rq9g1AkYCiVXaiFgD+SiCwalpEy7uJf7/AJK6GjN5Xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYN64si3AyNYcDPcK7kVAQxJttFRWdG5mtzN4WX5KeOBDhgFUTXz8BN3ca4yrE+Dn6quuSAIOFxZm8GUUJD2gmui0QDaeUoKLpCrYM6n95b41gQdBvhhP4KMm/0Epq1Q9YejWhcURP2kXwy2VlvDwd0rhibl6xF2nT9CPBxRfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvyeYwr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvyeYwr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA291F000E9;
	Mon, 31 Aug 2026 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170853;
	bh=Rq9g1AkYCiVXaiFgD+SiCwalpEy7uJf7/AJK6GjN5Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SvyeYwr+UrgJvwmB83LNRmEgOlmbfnPIDR1H93ae38NUGXlQwAMdD8rUELuXnQrkx
	 +CPvTka02gNT6l4CY1mY3JMT5U1Ef/Yktxrw3iN6JRnPpuuTdtBy+Qu5hufTG55NpF
	 xcvVSX8sHGF2eEBH7ntzRcH1sX4LlgOTZYXeyuko7hEOGj0HONCnFDAZ3Fxj6uuhFw
	 foiA092PN0F/nBtt21WRGSENj8rE2XBc7WVii3XuGGUNaLRzv2JNKv78fKH12E42ET
	 UvPRD2fI4Q8GebktdTUz9cVjv9ssfsIiXyDJ0jAm+hO7vgNgd47de7Hy+9Ykl5//iH
	 cvrgGsxso2dbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831-arch_do_panic-v6-1-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
 <20260831-arch_do_panic-v6-1-a1e170a9e7fd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:07:32 +0000
Message-Id: <20260831100733.0FA291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a hook for architectures to put their specific panic handlers.
> s390 and sparc already has ifdef preprocessor checks to execute
> architecture specific code. Pave the way for vpanic() cleanup.
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-arch_do_pa=
nic-v6-0-a1e170a9e7fd@linux.ibm.com?part=3D1

