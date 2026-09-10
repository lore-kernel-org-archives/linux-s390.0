Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1544582D8
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038963; cv=none; b=gXko71DDTDbREgG2h8t90ox43Rx2P3/hlx6J1p6GuOEosv6vPExZ6tns71oOrNpy2mWhuYJouUXNs02R4lRThWGJOSnMXj5dsIiLe49joiOCgYPiiHINkOpZe0jtRpcqa9Yy7Vx5dlfqMCDjRwj3DwptrBlkyMEU2APU68E3B/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038963; c=relaxed/simple;
	bh=4naSrvMZ/EpZbyrDui5QaPjGv4zLOEnv7o7+ClR++6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DR/CsdQm1EiTfvR9Ds7Y2B4CaSjhmtEj7qmyZiLa+TONYIvYj2+saC+VdYElmFSGxXJhoGGC+6kWU80CzoM3/OXTCJJdYR9PNh6PLTXpu7PAKd9s9CZrwFZejLMYjiKQPhn/h2U+fqjowAuzhCLvikDN4oxK3lNWEYlgFndCo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKRc8STo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKRc8STo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED1A1F000FF;
	Thu, 10 Sep 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038962;
	bh=4naSrvMZ/EpZbyrDui5QaPjGv4zLOEnv7o7+ClR++6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKRc8SToy8Y3LXdCjEmAfbl+6J2leWC4tTMdqdsXQAYUgxzeIM2sOcxPg81OvL/SY
	 1LU5sGxizDiUT5mPOY2p325eM9Sz2V/dWL8+z6VA5V/+tFkouIQLhKAn6znZirF4if
	 tks0Rlxm+X83txEj6nR6v7qY9l3meJoVk8bCXo343wWgnT1/21uFfXSFYmAqOeTTjC
	 VlLo1yFW5MGdUVR0dzKr2ssD6xsN6h3PtEObdb4NbWcZkzX6pmzsJfjM597LOlXWOK
	 t6pkaLiex98rDRsL7j5Yba0sy+S/+fiwV0MbhNLZkG/Cs7GUPnqFELENTAqNiuQ4Ac
	 972/0/DuJ/Bhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] s390/qdio_setup: Use kzalloc() for the storage
 list
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:16:01 +0000
Message-Id: <20260910111601.EED1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __qdio_allocate_qs() allocates the storage list information block of a
> queue.
>=20
> This memory can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of __get_free_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D11

