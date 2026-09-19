Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CC2DF126
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778710; cv=none; b=qc/x67O837rdI65K0XmIE2/khSyp4kCg6MU104kH+h/uCfRDbuIfQwfJl/cYcrzLwH3m6493enf8rPgcpZ7Cn9Pmib8oov2IXJHTO9cgMV8Xh7QwbCu5UdaDPFVzgnW1EB9iX+vpBR23+SNESaxcJOacw3hH1smZlCkBHyWUrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778710; c=relaxed/simple;
	bh=OBEjqhzw76l/37VYzw6iXRo7RVt0pJoGvJPPi5d0Aas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzv+ryKgaj9BFRxUf5QA39HHwXEtffklkP6sFGKo+QSS7HUxpL7P5Lk1D6ym/4mPRNQiwQKXbEan6mmg0kKbnhJRyupOmQeWiEH44n2V4Ubw07J3GYTRLtZBoHId1EECC2hPE23CHbL/p7cl/Iu0k6caJ9VPvdREhF+ILqoB8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktjo8ABC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktjo8ABC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA42E1F000FF;
	Sat, 19 Sep 2026 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778709;
	bh=EnNDgoDeFvPfXi1b9SBc2eaMUE95pMA3CLKlyIE+cMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ktjo8ABCC03Rscd5oKmrF03dSXgcaZi0CI34nf++55D79Y1KGh48GYYjQP6eAYCWf
	 hhpbp84EzuA2MXo+PYDHKhPFTHab8z0pUut4wbVvaOF4BTeJWz+h0nJES4d4fHo+HL
	 00Qhgy3f7/anmiLyIhr7BAWNI71w53h4VwC3M82o3WnUkjy7PfKqtJ2oyAOaCAxN5y
	 EpAFG7xkdoXEctFTVKcTXQE7fXlOAYAhhFWetvUoEjkgrWYeNKYksoycclrhi+xUb0
	 WrC2XPoBVq0s0yvHbWaO9cAf3vq0A94CpRMatzOuyExP+Jy1DTOnw7FTyhF559h7Ot
	 s8gBsMS54w2zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/12] sparc: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-5-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-5-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:45:08 +0000
Message-Id: <20260919004508.BA42E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - syscall_table_32.h would generated lines like the following
>    __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivalent =
to
>    __SYSCALL(422, sys_futex)
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D5

