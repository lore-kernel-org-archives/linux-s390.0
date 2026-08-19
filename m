Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3837B41B
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130418; cv=none; b=eZcD+KX4Kf6+T1LnxbFn8IyfaKlKKS5R6pnvzQZQqMAnsuchFDLrLWEvWlI/jaAQ+/q5maDhk9GgnUVJ4qOZfQXw77bFvEEaHciYkxM/1ewvhDYRDU89CkIoO2eOzrwMzapPSMk3FlFwNCeCF++pkrn7rCKkhx3HDEPPgy9NPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130418; c=relaxed/simple;
	bh=rnNcTY2rGeqmlN62zCbivihIE0L/kSCwnxm7aHK8Mi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ox4HUDJYXIj6AmAUOe4anvG6WgRtnJKLuEFFNlkMnF8dcKeqaxLN6ZjpolYdT0TX8xNurgsxJe+HFFqn6HybHQsuRO0R+KmtfW+puyLJZkLa7QRQMx8ZvC7WQ0NoBUs6cLHJ/4MZ+OX8hBoTLKpaAHmZuSLIUyxi92h0skB6Qoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT4odTnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT4odTnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC1D1F000E9;
	Wed, 19 Aug 2026 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130416;
	bh=rnNcTY2rGeqmlN62zCbivihIE0L/kSCwnxm7aHK8Mi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mT4odTnvYRFe61gYODVdedFW6vfYOjN5QTZ380fWnXvML1InF/wTzGq4bsmcVFZ4O
	 FBI/hliUoN4phDsyvwvXMC0dS1k9Ewy/cDMaL1U730EQ4d5e0Lh6lZwMI5LUjDYyb6
	 0lvUgotSIJbwl7o8amoda0s9IVDCrasYOK6N0afpji0WbdZQ9KKb4kuY1ZzL+wVDvo
	 ROzDbtfy5r4Hxiy+Li2ny75Et4zTI5AiBGqfh+E9y8bv6BNYdkkRKqOMWXjcNNWIca
	 n48/in5ZG75/tQ/nTVP4zCWvXHVz4APwMr9QMMDMPl982VKLWLsAdocJEmZc1N5KXW
	 bAXpSjr4tPYsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] s390/pci: move MSI affinity flag initialization to
 boot time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-7-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-7-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:06:55 +0000
Message-Id: <20260819090656.3EC1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The MSI_FLAG_NO_AFFINITY flag for FLOATING mode is currently set lazily
> in zpci_create_parent_msi_domain(), which may be called multiple times
> when discovering PCI buses. While setting the flag multiple times is a
> no-op due to its idempotent nature, this is inefficient and unclear.
>=20
> Since irq_delivery mode is determined once at boot time and never
> changes, move the flag initialization to zpci_irq_init() where it
> belongs. This clarifies intent and avoids redundant repeated operations
> on the shared structure.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D7

