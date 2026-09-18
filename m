Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3C3CE099;
	Fri, 18 Sep 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743325; cv=none; b=Ea/o3mezR8IOisHe2wivcletZIPqqDzpVYfRuYuKpGJiRz/PObgxYyViPqtQSZZj84tKrPpCs7c1gJqVUQ7H75SkTY/cMjq8AHvZ2q8HXWV6e2fII5PB7+1eXzXecFzyPhvHIafAmuIX9xB51Dhu0YRIekp0JshZpqdDl9aiYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743325; c=relaxed/simple;
	bh=ant+yUoCquYJmEHKAdK9Gx9OeUPYrsBMKWLcrsxQr0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kp3M5OAp/DK3EIPkFQp7qZ7fTcUeJvqYdURoPFm+52EuFS4eZ/sk1vb7mXaEBpSICU8LPN4A/aS2EyBcElECutInbE8cLpfIES5TWTDlvdKmVfUlkYaWPKC0udNmc+vMB/7BPnQkYFoEsDTkCwfm9k8T1H06bQjk1eQVyCVP744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5VeWfdk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5VeWfdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E701F000FF;
	Fri, 18 Sep 2026 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743324;
	bh=ant+yUoCquYJmEHKAdK9Gx9OeUPYrsBMKWLcrsxQr0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5VeWfdkreUJcELyTYGmxnWlVeQLqmPuAqbGWGAarmL9/C403JZXkvv/geCTh5biw
	 xYfuxXqNKcV5rOevKv5lHGJpgyrZyBoE/Nc1bnTuzTgdHSKZGBQapEbaQNANSciGut
	 ZFmrlajRAT1yCYWmBR+BTmEM7nDHlQvlvphiMAtiXZ60j7SwODwJLS4mTKcrGekD1/
	 tVLKn6Vb1BLcINEBhD12IhmsrSEpPi+cHWqLYwnhyL12WvNWMiLhRDU6oiRrPOs1Ky
	 x490kKHCdPVLeKVUhH09FuKcmHwV2lbUwfon6J1JKh1n30IrVEnOC93S/XhGrrGN+Q
	 pxbdU6C31UpZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Documentation: Add missing KVM s390 crypto attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918145151.2116991-1-farman@linux.ibm.com>
References: <20260918145151.2116991-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:55:23 +0000
Message-Id: <20260918145523.E5E701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Device attributes to enable/disable the AP interpretive execution
> support for crypto were added to KVM several years ago, but they
> weren't added to the documentation itself.
>=20
> Fixes: 37940fb0b6a2 ("KVM: s390: device attrs to enable/disable AP interp=
retation")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145151.2116=
991-1-farman@linux.ibm.com?part=3D1

