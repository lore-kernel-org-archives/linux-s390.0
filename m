Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E38496D33
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817792; cv=none; b=AYzuPh6DPfIBHyo11s7ZkHwArM+ASk0udO2f+RonRxVnC2gv6Z9Q+cdp1nnNTMuDXnfMPqgN3mkdOBAPCpAZpQnh/J7VsXmtP3YYLDRgSw3YOLsOrULmmr2nKGqvJJbUM3+A5nrbjlUjKETTnw1vNQo0+XZgi4pO/GHJb9QBx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817792; c=relaxed/simple;
	bh=VoCIuCJ6NEYfF8MJb8T1Y88/duWLZ/gxLcdFTYooxX4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DFJoyMXOvT0kxIABlZwsDO2nvHca6nviQGzwgc9dBFHs83QWDgrADTeKQxO5qpfK9mwLbsedY3O5w5+I7HfjLft/ZYZiSE1ocxWDEH0Jt7UfsjVAr2/zlQgsqJaasdOHtjWVwxPK7fkhq5h+ZHAVD3SeZQK6HJx3dA/JzLmuZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZApvIag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZApvIag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92AF1F0089B;
	Mon, 12 Oct 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817791;
	bh=VoCIuCJ6NEYfF8MJb8T1Y88/duWLZ/gxLcdFTYooxX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZApvIag17a6+UIEScVRiFAApsPZac0Qka676e0hb+BqRbVpk5E0CnlIN95Mg0MP7
	 jTr9lj1MZbqTz1sJssPulKi+85RdNItXmqYL8sx2JK/07LshcA/+ib0Xmzxh5zOLmH
	 /OmKqRirgVEDQS7U+Uxdq56KrKyWJzvHIBtSsNtO8zIcqLVDasBudhzebuxP5cz9Tf
	 opXDtmpjWYJzVS0u5C28A6n9NodLeWBwQMwBN2nakZc+5FcsWP8nwv+iJwAcWWaJW3
	 JY8N9mlf+XF4yDDam5uUjJb3pK0+k8FKEwGU6rrN9Vny2Vc6Brb6+yWjWOqApTuO1j
	 fTHn80PSmFS7w==
Message-ID: <sashiko-outbox-168319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/sclp: Remove redundant memset after
 memblock_alloc_low
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261012150404.555918-1-ekffu200098@gmail.com>
References: <20261012150404.555918-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:09:50 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> memblock_alloc_low() returns zeroed memory, so the memset after the
> allocation in sclp_early_get_core_info() is redundant.
>=20
> So remove the memset.
>=20
> No functional change.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012150404.5559=
18-1-ekffu200098@gmail.com?part=3D1

