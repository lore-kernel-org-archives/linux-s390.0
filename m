Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD883655CE
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485868; cv=none; b=eGyH7CjsnM5Z2t1tAS4KrD4/H08G9HHvEJpGZ6cwOrh5PUiAeauqvOUvbwlZ+w1O4vWeSkTPCiDPDU5uu+hL6Y1vFQU9pNA6ErA2lzbCckdbrex9glK8kMOJgBIlYFv3VzaN1ogsmMs2J3KRAj4aXPh/RczTjqoNOw6x3tpbsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485868; c=relaxed/simple;
	bh=T0mGoZwZTkbcN+5Ahk9KvW12QvtXbqMyrSLrqAyGhlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJprFKNr6uOOrbbG05YkMCG19xuZeINNXrcOOWh3o5325iP67f4llueQUTP1cRe/Q+5uY12m0xvskzynQWh7jQ5KQvwuTwbAXZ+jazNo1J/FrUSVq89lw7yAeOmWhWV2ONQ22iq1mHP18UEMoUqZDnmR+DaQOFJuXL6LCNAz6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP51oJ+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP51oJ+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997161F000E9;
	Sun, 23 Aug 2026 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787485866;
	bh=T0mGoZwZTkbcN+5Ahk9KvW12QvtXbqMyrSLrqAyGhlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP51oJ+8gypYvIJryVKMR0j3UWWi3irZb/GheEkDKDdyqgHgCTk89xsHm7cRkzSWF
	 hD7zsOx7hZgieE/+QGPgTbtZNmiImROyU3+1dpNp//2DwOM1S/SFyraJrUVNn8AXKp
	 PZKZPO8ZtDL9uRpEywPDllKRbA55KEMh3Mja6woflj9WwSRNk4RYEzPivOdGkbpN5q
	 Np+74h0cyaTy3nG+B3bYUT0jZ0uLouWT+B215svA7J4UQTIw/5d7RYld/2cLiRtwMo
	 syQUpjcKZ/B251f7vfUxHaod0gp3jzk/i8BXYo98NMZ3bprohsPTNFlbcEvUL4imKQ
	 gSucaCjWOPlGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] Revert "arch: introduce
 set_direct_map_valid_noflush()"
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-6-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-6-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:51:06 +0000
Message-Id: <20260823115106.997161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 0c6378a71574 ("arch: introduce set_direct_map_valid_noflush()")
> added set_direct_map_valid_noflush() to allow updating the direct map
> for a physically contiguous range in execmem.
>=20
> As Brendan recently pointed out [1], this API is confusing because on
> arm64 it means that is sets VALID bit in ptes, while on other
> architectures it is an analog of set_direct_map_default_noflush().
>=20
> The only user of set_direct_map_valid_noflush() was execmem's ROX cache
> freeing path and it was switched to utilize VM_FLUSH_RESET_PERMS for
> resetting permissions of the direct map alias.
>=20
> With the last user gone and with set_direct_map_{invalid,default}_noflush=
()
> accepting number of pages as a parameter, set_direct_map_valid_noflush()
> become a copy of set_memory_valid() on arm64 and a duplicate of
> set_direct_map_{invalid,default}_noflush() on other architecture, it is
> safe to remove set_direct_map_valid_noflush().
>=20
> Also drop a stale comment in arm64::__kernel_map_pages() that Linus
> bothered to add when merging changes containing set_direct_map_valid_nofl=
ush()
> to his tree.
>=20
> This reverts commit 0c6378a71574daa6cd1534ad42a956e3262756c7.
>=20
> [1] https://lore.kernel.org/all/DJ69RCVRBO0Y.3JCYSW50IC4RC@linux.dev
>=20
> Reviewed-by: Brendan Jackman <brendan.jackman@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D6

