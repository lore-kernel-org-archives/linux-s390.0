Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE3339372
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486243; cv=none; b=bz9DbkZI4d7F2MTaW3vH8R8JQsImc7YJMCsSlmvevvPRQ8DiJhYYPeM1si3ijPy8NzWLiWXcZwFuIiche7CrQvLDcBN4KP67JgCqS5v4lYq7exDI0imlqqHIu/wxcKNRATIicfUkesrlsRTrn1oHeBnIg14y7tyTpy+pw5/rH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486243; c=relaxed/simple;
	bh=sfku1e9hNhyK42Y9t4IGISlVnjCWt2iDLmRs5iajX/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FyGYTtQVcNI0j4PmYVtnQDto2sXo2kEkh+dN9niK/y7/25UrOoZi/cyP6ZLi9TPkevsVTft006iAhJBVInWHaedDGn3i9Xa1IOY9BDsGmgSBd9qz4Y+jkifzZtNC3JLNtwUA9eVixhnAxFCbylkqN8TuNuXcfCJRJB7gnHStt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV9ueFLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV9ueFLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0871F000E9;
	Sun, 23 Aug 2026 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787486242;
	bh=sfku1e9hNhyK42Y9t4IGISlVnjCWt2iDLmRs5iajX/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CV9ueFLYF/0v8H55f4N1In2PKxaW/DQvg6wffsrrLxMQhuiigzi/uiZORUJ52yJ54
	 aMf4hfXZ5oEcCfQX6lsot8tMXqIsBGMHFFpNI/kH1o+GJaLy33aRxNabQD9nIsYWEW
	 xW8L5Qh7IwDQHyFVlLQmfoxelJr/uJwJbGbBC2VoMfDHn/RmzYrxR2AidSPSfWDHkA
	 k/WN1NOpALPZqRsWiGEelkiTjpZEIVA+XGeCuNOzhqn/MBnQiDxXdbG48afzh5IcXK
	 e2xSI+85zTa9/dx+QnFvVSQ3FCz/DlInp49czptw2+HuLxrbBY2oPRc63gK/tIrfjX
	 F1tzLb7/EDGTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] mm/vmalloc: set area's page_order after
 allocation succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-2-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-2-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:57:21 +0000
Message-Id: <20260823115722.2D0871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __vmalloc_area_node() calls set_vm_area_page_order() to set area's
> page_order before actually allocating pages to populate the area.
>=20
> If allocation of large pages in HUGE_VMAP case fails midway, this leaves
> the area with elevated page_order throughout the cleanup path.
>=20
> There is no actual issue with this because the only place that currently
> relies on area->page_order on the cleanup path is the loop calculating
> the direct map alias range in vm_reset_perms() and it anyway skips
> unpopulated pages.
>=20
> But having set_vm_area_page_order() in the middle of __vmalloc_area_node()
> makes things very obscure, hard to reason about and error prone against
> future changes of the cleanup path.
>=20
> Move the call to set_vm_area_page_order() just before the successful
> return from __vmalloc_area_node() where page order is guaranteed.
>=20
> While on it, initialize local page_order variable with its declaration.
>=20
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D2

