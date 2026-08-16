Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74716334688
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878190; cv=none; b=cjWx1VLTaUhs2SdXoWFRH6sdjFYg3+BHH9gJWSVoSoc7iO58IPrbyGStpoWeb/WE2RgGz+YyfqooSQKau81jTK4PGERtGZIuWnNXbZ7iGi1K/tn3pJLYtAx/q0Ykx98Q/V8q4Rx8sqS9wzY5R2Hh/61zjWVgq/6Yi864evS4WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878190; c=relaxed/simple;
	bh=zxya7twctowInfwXiGpbjukgFfviL0G5uolVJrRnwnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SWpoFNluS35odGNkdJ8NWulDTaFhfPRmtCldIKr5C4pSdKfKP75Sr590fk5qNiqT5F5zq/28d1bhrGBffxtFBPHVwyzrQ/Z6y6LANaIKuZ5+/9EanFBk6noekyGDyEdvp0OjZ16s2ZqbWmwswmOpue+jnGsis8ULtG5TkN6yUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw0IfuaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw0IfuaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BA21F000E9;
	Sun, 16 Aug 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878189;
	bh=zxya7twctowInfwXiGpbjukgFfviL0G5uolVJrRnwnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bw0IfuaRtG/LrH0SJx7YBZukhr33CLD0pjNTFmB9aNG0qj6LbqJho4SU/x1w9K/1J
	 vD68faN2izRdHWF7QiDrNwJQMiKP0WtxD0OCf+4exTLjsm83fhlP4xefb8MNNglEUJ
	 b6pFsc3KpVvBipEkRIvT4XvOR89XIPicCSSwkNmbDtO7W5G11kRkIStBODMlt9bKBZ
	 6eobOXhQktspDd/P/baXpDig6MRrena7jnJ3AX6/ezIxthPZOvUQKRdXVZLd7whYqe
	 RK7ceKx4nek6jRqA5f0z0Vzgl02hz71+Z1VP1+W4kGVvz1dBeGTLbFagAmVpAr9V/6
	 jYegdQykZmLiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] mm/vmalloc: constify vm parameter of
 get_vm_area_page_order()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-3-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-3-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:03:08 +0000
Message-Id: <20260816110308.B5BA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> get_vm_area_page_order() and vm_area_page_order() do not need to modify
> struct vm_struct passed to them.
>=20
> Constify the parameter.
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D3

