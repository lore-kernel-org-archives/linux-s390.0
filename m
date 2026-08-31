Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7D235358
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156608; cv=none; b=s7cbEc6FX8M6X9q1Uh1h+Re4gUY2/3UxuWBYrOXb+0HfD8YFEMgTiRwlDjqFKuDqpyeAzpCtTBf40EmcihnjKXwQj0cLpnG44RnxsPlys0x58BpPtPugmM/YX1dmgw6vmy08beb5t/lVmvC1x7+r8KAXyKJAXdD2XtzJPe1mOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156608; c=relaxed/simple;
	bh=jWIYXGVpbKydaX/o4PXNWdfFsimatR4jFSXF++3dPTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RySmsh/2/suPhLTkeWUbkqXZUrBHJ+3QyexWjmgYOHMPSEaPj5SAfYVsCeojcSb4KG5SvbRluw3nO+4DPRZmyN1aHjulySWsLSrBELQNW0BCiDW/VgkNqZY5uiyNgmjf6fLXJz/MyhyUiC4QmGx3NWfdDWr/ipkrvWE1mubNHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIvntSBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIvntSBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBE1F000E9;
	Mon, 31 Aug 2026 06:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788156607;
	bh=jWIYXGVpbKydaX/o4PXNWdfFsimatR4jFSXF++3dPTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIvntSBHTljl1dJMmEQzP8MnAwMnpvXrbJvXwOz0QuxTTUer44MpJMBJV3VV21UAG
	 liubRy1bjuNsGt+PZXXD3aDIN9ozocCudX9xb4TcemOcCpmfixK0ldhB34LExSd8gI
	 oiDIRS1YRcytWPX4GPWgDh6JZ74oSXB5m4iSkH5ZzyjJGHan79GwVq/Y9UrxvEjZtD
	 bZve4DxdEDSlaN5ArqXx/waWkaIqu0xOqIvxriRPoqa6LOt6kELt06sRqk5uqf6n+O
	 FNUmy2fVet46IDbytIxDrICruI4oE+vXCpQB3giGOGU7Np2uE1EQIrarJ7M8UU1LAs
	 cRln4X3IxHsyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] loongarch/mm: Stop using pte_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260831054331.625505-4-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:10:06 +0000
Message-Id: <20260831061006.CBFBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps =
in
> eventually dropping pte_ERROR() macro across the tree. In this new printi=
ng
> __FILE__ and __LINE__ has been dropped because they are always the same a=
nd
> don't really add any value. The new ptval_to_str() helper is being used f=
or
> converting pgtable entry value into a string. The error message itself has
> been cleaned up as well.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D3

