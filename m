Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A96471431
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518445; cv=none; b=asa61B0vLy4AkcrYteNN9YlJZrESqo8u05fJl0zdRhFgu4/F1R7uDYLupi3oCgWXZ+p+wfRJl/y8iuK5XLIIiH16hRcgnQVifVlIbI2sfOJJgTrVQFTGnUmPthYj1e4d9p5pfhtB83kGHg+Z80doPffoaa1bdqa2Lm7JIPEe+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518445; c=relaxed/simple;
	bh=tpn3FQRnkVqXZTYfeeJVVnyLPQr5svrfYlANf6ZD3I4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NlcQHr53hrrDRQ+Cr7Mqz7CIcBqil5mDeefmtI46sJw+mekVApsypP1e8+WuZLLR8ul0J8uO6aTt4J9/wg44zqH7aJFqv9vUMsXBAm7nVk6leydlC/2fivfCu8V2lmCUVVQSXgalyEZtS5gLcYNabAO/jpj31gs6O5FIjmCbyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiyVk09f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiyVk09f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6E1F00A3D;
	Fri,  4 Sep 2026 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518438;
	bh=tpn3FQRnkVqXZTYfeeJVVnyLPQr5svrfYlANf6ZD3I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iiyVk09fxwOHv67Mcjq/LGnad13I3WKHHYtricA7XMSBeAZiGwcLy458kSvDVqIbP
	 8FT8vFOqjcQ36ve5is39pXrZD51r1Pk7GL1Ee8CaCClaf5bRLw7ae0trWrLPusLd22
	 /M37izo34wgtZgFAqMpqjfJLnmv8YxSWtjhkC5QNwMxPKQM+DLF6hDPvdnKyhqW0LI
	 jYitNnDbfEjb8xcqAqr1B7q0daULvkv0V8e1uzW/wJbLHiUoneqjLrsjBGmWS9/fMH
	 51Tbv6BIM2nd3kLH9cZ69euj3DSXTo4PgxGLaC1ADrBlR3JR/5IFvV0050vOB10aQQ
	 dfgFygt7yX+7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dma: swiotlb: Centralize default pool policy
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904101810.1193505-2-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:40:37 +0000
Message-Id: <20260904104037.E5F6E1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.1193=
505-1-aneesh.kumar@kernel.org?part=3D1

