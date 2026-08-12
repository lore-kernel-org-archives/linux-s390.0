Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6F376BC6
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567008; cv=none; b=m/AYdwx1Ru9brMi+hAbXPHtk6KU6+eWCBLNmYG3jTiUeCxIXnEulFR5jDv1ha2bnE7yj6TMbEqJkDOdYdTOXfvxwF4MRjn4zgC7zpb3+exWgtIsDxXMgFaZqmfIbQyLxY7omkXjXB7gHE53m2lddkNnZfTzP9Q/bFuNvg+bp+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567008; c=relaxed/simple;
	bh=ubZ7drl7hG9W1OTnT758wAgWYUW0FDxXE//L6c13WW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3cM7Gwosu21JoROwo+VBV+ZaZgmZIAavkMcVDTt90QLuO9dO7QRhmi83ZNsyoe/cJvGtiIr1Eh4X3YFFTOvo5dRNZ8I821txUpg7unCoud0CBud8BCkNFAJRCnbzrMrNco6EQT/XWM4Uwlrq4MnICCbiqFzT0XUoRVPz3+jzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faomOzwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faomOzwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA3F1F000E9;
	Wed, 12 Aug 2026 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786567007;
	bh=TZxhIq+EY5u0kQ5ovYmY4AySES+dV10OMG1mGsuWNDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faomOzwPlBaiDGgqXocqYyXyLGwQMhWIlkQQzGtZUvn8ECA0bbrUQZPxgqnH2Jns7
	 4fH4Uq2RnR+u2s47Rf0t3hEOOnI2qrJPkzpYJtaVQjFe7zfNvw+8CIj9z/lcioLDBQ
	 MFjrvIh1kdkePHzTcywGTR3hKzXKTMmbiBogkmLq0CihOIE3oyOY+nq7Z+5tM20A6k
	 ZaN94udJsUbO4miytUA0WUQx5PQ28x5MCNBLDssD1SEDpU0Nrp6AQWCVi9wCpSO2sl
	 Sc5B4tgTWLTRjZOjqvLingTUsqK5RS6fIohihMmnRzj3iYptw94M5VcuIyZad78Fk2
	 eY14bhAjZdSCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/percpu: Fix MVIY_PERCPU() with older binutils
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812203036.3018-1-kmehltretter@gmail.com>
References: <20260812203036.3018-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:36:46 +0000
Message-Id: <20260812203646.CCA3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a737737cdb9c ("s390/percpu: Infrastructure for more efficient
> this_cpu operations") introduced MVIY_PERCPU(), which stringifies
> arguments that are already C string literals. This generates an
> assembler macro invocation with whitespace-separated quoted arguments:
>=20
>   GEN_MVIY "459712" "%r3"
>=20
> GNU as versions prior to binutils 2.39 drop the separating whitespace
> between quoted macro arguments during input scrubbing. They
> consequently parse the invocation as a single argument and emit
> repeated warnings:
>=20
>   Warning: missing closing `"'
>=20
> The .ifc in GEN_MVIY never matches and GNU as exits successfully
> [ ... ]
> supports binutils 2.30.
>=20
> Fixes: a737737cdb9c ("s390/percpu: Infrastructure for more efficient this=
_cpu operations")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812203036.3018=
-1-kmehltretter@gmail.com?part=3D1

