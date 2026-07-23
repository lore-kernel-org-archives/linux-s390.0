Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3113B8BDA;
	Thu, 23 Jul 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831010; cv=none; b=UzvCyVVSwH9YpUaiObpYKtS4R4meYzZuyElIm29lTRcdadABZO7H/O6cVX77boFpsLFiQ934wvcxWCVcfNRKxy/eBuvgH5OVgPgRZkjAaa8UdJjcBPMCzVpw9mwnzyYA4roh/QGlmDvUxOX5I7AidbjVI9oGjqobntEO9ryV2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831010; c=relaxed/simple;
	bh=Noqt+0tmRr8LIFJYhNxP64b/yrPsTpKusr/1IgUil9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fv1LdEj/dsrBmDMHH9ESn9LdrW7IcCxo8aZ41X9X7JYTy3IQpnlN5ulhkbHqPlWwvN7ZYm7iegoOOUp08iHZU8DYoAOWn6+ZElUKqSvjY56WC1CTK4C/PfehNGLn5CgIPderQsKA6AYcv2NAI84/AozYZzkM4QnQs00xuhdcLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B01B1F000E9;
	Thu, 23 Jul 2026 18:23:24 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260723174751.1180334-6-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:23:19 +0000
Message-Id: <20260723182324.6B01B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko pointed out that get_guest_idal() unconditionally calculates
> the length of the IDAL presuming everything is a Format-2 IDAW.
>=20
> The output of vfio-ccw is always Format-2, but the input can be either
> Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
> the size of the guest IDAL may be incorrect and should be trimmed down.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.o=
rg/
> Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D5

