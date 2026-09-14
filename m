Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DD3B19C4
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370684; cv=none; b=kTOIoASDRSwc7ZRqdInp23w5vuFLbJPYNfHbZ9DGS1pKGBG7PtV9LAZuzZGS8oss3Dzk+qvW+kQl4arce9vRRpOI14l/vugNIP6fQbcGurN0bzxht9Iv3Gz2FdfBxGAyCH+wNzJ+9dWkoLrSnO/EJV+0tA7qOWUupYuuYxc/qNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370684; c=relaxed/simple;
	bh=+wcNgje8bWoAz0Ehe/l52bhmQYpWGW1gIX8hAl40ez0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mVetAEWqXRY76Xf15O4C6oRj47p3bMH0drYHdUGYFTOCs0gq86gdWxzSF822+knVmecP/xZ72K/sWHKfgn7+olVDE+hzFkF5Z0A+7QHvZzmwDjAkj6atF5qJnFI+np2UDxGvQTbNwfr3/5VHbUyGu6e9TJvusj7cxNIwMvy8Hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs3BcA0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs3BcA0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A21F000FF;
	Mon, 14 Sep 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370683;
	bh=+wcNgje8bWoAz0Ehe/l52bhmQYpWGW1gIX8hAl40ez0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gs3BcA0QmCviIXWz20NR2Za1ywUrKDBX4bC+zha2HnXXSStFbisH6n+MQtgF90/uW
	 +jzJZqRt1buD/3ANAQqOuKnAqT5kccKo1u2clkjiFy366lcx3gO3qCmRJ7jfv9xqgt
	 13J2biuTVjUSe+fyP9NhZhvrS0s0bM0TtXOzX9gmK4A3xDgTMTMdJeX6Hv3r+asjeG
	 QZrHoIcbPbABasUEp3UzG2HfUiwiYMTsymDht7ubVDghRwLwH9+HHhuD3ylQuvJwHA
	 yn3wuyt3aJLEAvNfXye1u0dqlfuwnIgUQE7V/dVAbrbDmOoXWkC5EVuN2cMq/A7/h9
	 amwg4ioYpBwOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] dma: swiotlb: Centralize default pool policy
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260914070135.313337-2-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:24:42 +0000
Message-Id: <20260914072442.B03A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The addressing_limited argument to swiotlb_init() describes only one
> reason for allocating a default SWIOTLB pool. A pool may also be needed
> for memory encryption, unaligned kmalloc bouncing, or swiotlb=3Dforce.
>=20
> Replace the boolean argument with the SWIOTLB_INIT_ADDRESSING_LIMIT flag
> and have architectures report their DMA addressing constraints through
> the initialization flags.
>=20
> Introduce SWIOTLB pool policies and select the policy in the core before
> allocating the default pool. This separates the decision to allocate a
> pool from the policy used to size it, allowing subsequent changes to
> centralize minimal and confidential-guest sizing.
>=20
> Set the shared-pool state before memory attributes are updated. Also move
> the pseries secure-guest setup before swiotlb_init() so its initialization
> flags are available when the policy is selected.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914070135.3133=
37-1-aneesh.kumar@kernel.org?part=3D1

