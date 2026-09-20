Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B53C3442
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871642; cv=none; b=DXwxznXjbilyJsD31OU0Y3m815LK5aB/tth4Tvb8/3STA8X1Hl0ySK6vZb/dpLnR/iWmGj7gkWWAwBvGdTLP7/zEKG3sAvbwl41po0IFAcAu72zHNXu1AmGI5/mQp9O5U9e257d2ZfRxtRl1iGfwUFXH5CKjgDNWU5t5bCBxgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871642; c=relaxed/simple;
	bh=kFJyNEyMw6lRwE/OvLOM4ZtMe2jqGuukJ3SKdez/kqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BkIMzbS04ISdRBPQeRklJBIUrXGE4vA3+BBbfzBqsvUPIF+L9mslW8Z1FAt45C/fzosUOSkeNA/95HXfXL/olS7rmki/QWDVW8dCRPmaRHjx2XIJ2RMvkPq4l3V0waSm8iC54/fFnOkGnl3bqcz43mLk3NrX0cc1zPC/xmF7zMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdTegspL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdTegspL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600E91F000FF;
	Sun, 20 Sep 2026 02:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871640;
	bh=kFJyNEyMw6lRwE/OvLOM4ZtMe2jqGuukJ3SKdez/kqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AdTegspL5BnGP1/RrpvqVailWvwx+v3Ns73yi3VNfnMmvDEvqfq6ORbL70rhNWD7j
	 lKWuJEOcGPpsc1r5hekXlFcqlskSTGxIbgp1KhifQaB1gOl4oPEXdLlu6EK9GxXp3i
	 hGMBNDOyX/NGcGXEKnK485943iI6cpFaxHSwGIL2aWKhCn2dz4f7vkE49BckTeacNW
	 AEHibOjABFLXErgKiST5MALUGwvmIZisqg7sXEtk2HHeo/C5ASPKlK+Siozv7si6gq
	 c3TSGhZ49fH1X5sajkXba9wIR1NxSf4B4HBOI9tjbaiJFdhDYXRMTW9kl+XGBcz685
	 E7kgfGOXFVO3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/time: use assign_bit() where applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
References: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:33:59 +0000
Message-Id: <20260920023400.600E91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920022804.3145=
894-1-peng.fan@oss.nxp.com?part=3D1

