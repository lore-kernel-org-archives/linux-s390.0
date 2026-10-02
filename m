Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3147607D
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937352; cv=none; b=nnXAKFXHwIHOapN8o0EdQ7kn1827finHsUDxPkzM1Y7p57Ft/kXSC+CBMLENv7QBCaSN3z/ro3xVk4a7nHnD8uHtIjjZGiHDmy9vNGKvRQed8E7836t5kAPzPLAfjBtDFZO2ZnxNN5Te7rZVwOHkccfXxo/CCrOFvyiHblHB048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937352; c=relaxed/simple;
	bh=xgNWQUchNAqGqXxKQxnqF+nSql+qz9RKaBdPyT40+R0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BWdC6+vCw5K/Ot2EPZTx+NHl/GKtKjzJ/zVfuvkA6nNcKLJ2A4UswM8IXECXEIBRJ0iH3fCPV8xrSwodtLeHFSGAFH6bKAGeM5t4csFH7mKpoaWUlflJVv2/+Q+9cFiEk1kbgZBvgYY+hm4ESGF6sfaWhuMPZ0RTLlzj/hXcAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhX+0Rk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhX+0Rk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6229F1F000FF;
	Fri,  2 Oct 2026 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937349;
	bh=xgNWQUchNAqGqXxKQxnqF+nSql+qz9RKaBdPyT40+R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QhX+0Rk87oJrH+X3RdjmceXGyJb0xQARaxRNZUUPfu0RZmqmaLl7yGGPZDWmUmhVL
	 BvYjRj3FpCzrBUSD0pbRBkJnzBI8wIJYk/QHOW1APfm7n6u0nPSRT9a6AefxvowokO
	 UcjU1Nh8dJGon8jOJrofaMU4Wab8ErDezrdgOEzMo2J+UF6s0B/wXE6huRCD28Lex1
	 Ui1UUKe1FXycMMsvIXc4N/1XjEgH4YA6sq4y9NKq284+sRGW6NEF54au+FdgErQYIM
	 N/CoYS7sYflNledRM9hA1f5EIzQAUgYLNYIojSxxL+blNTxjBGg31+chcHTJoK3NUh
	 ER+fV+SXS7OYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/extable: Fix mvcos instruction decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261002102750.1994830-1-hca@linux.ibm.com>
References: <20261002102750.1994830-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:35:48 +0000
Message-Id: <20261002103549.6229F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If either the b1 or b2 field of the mvcos instruction is zero, register
> zero is not used for address computation; zero is used instead, according
> to the architecture. ex_handler_ua_mvcos() incorrectly uses the real
> contents of register zero. Fix this.
>=20
> This shouldn't be a problem for any generated code, since the compiler
> would only generate such code if it is possible to prove at compile time
> that either the source or destination address is within the first 4kb of
> the designated address space. Such code should not exist (also confirmed
> by an allyesconfig build and decoding all ~7000 mvcos instructions).
>=20
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_co=
py_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102750.1994=
830-1-hca@linux.ibm.com?part=3D1

