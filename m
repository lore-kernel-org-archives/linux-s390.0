Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662332;
	b=ZgFxuEPOHimyY1Y0FQ4w/T/vSQluM24ngJ67AvGc9UzV5oMQ7HjzfyjxaVHvxtREk+Im
	 ijwMdTF3urMlzeaZclMLw/nkAHxtDefPaCn/IzekAUEwXWM1j023pWH9ZX986XJ9YmUJ/
	 NVlTPAJOHMgBnfeHJXyndOGnefLEh/HvGpwDIlsjxeXUR/Wy0n+w4bAq+JcL7f2zsbo6t
	 B5FhrUMM2/CeX93yRz5YuyfXMDtcZmhJ86hjB0KWVtnlPR8lgcaI5kYJdhQkWjwsCC02C
	 0EO47Ze1RGuhs81Fj2D2KPmuuCLF7KcY0lElo7PdAx5U9eaSGMh/Y1H8DTCRRo5mgrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+iV9NuG4Td614hksCY8A9Jv4vxmUUdhnWTle6woB8hs=;
	b=mNU8lZiFOGa9xd0YD4Y0VkWLYKzF6zSWfDO8u2XDkkVxppip3jGxnS+m33TdMNlG+I6E
	 kQnBMO1dmw6oN+OAEv/3lMWWtyxDQ6N2RctCL1vq8NC6SvwY4Ja0P+xsB2+A3RUht2B93
	 6dwOXcPSDjOxDL6e7v4VQlyiGY2HEvx9hS6VxAPBYg6AXtOPLGs/pG+P0ZHkafN97sKdo
	 Yq5+teRyi3CIFEHoJ9c/Mg8FyR13m9BTjC9I/8bcRfKDwIN5eAIBkJvDzx5fQWRP0kP5O
	 pTOUz9euvHl7P9x9I4OcmSYXFWfV1I5leaUAeE+C/3EA5pVYmmoQuMoXDzJbpPPjfiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy6AhoRu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DD606A335;
	Sat, 14 Nov 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy6AhoRu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6311F000C4;
	Sat, 14 Nov 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662332;
	bh=+iV9NuG4Td614hksCY8A9Jv4vxmUUdhnWTle6woB8hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vy6AhoRulZKb5pLR3xswt0e5f6KZT9BhsEZ9pOs/GlnDC+VQNUNftrTDKsV7bWsxo
	 jkRENOzropFVTABmIGBs2NMeqRUOWiPCGpdmh1esh5mHjIep1fr5YiHyc7rB6wEV0k
	 YkU/GxSCmTTAQcJnE1YuTkAor907MPmXyGygzJlPBc7Th5a/EhBQeH+c+5uAOnamRr
	 9PqIFZww6PXma4njIHgJ1vwC9sA8JE0yPV0lcxMs2CCTLggWMZrwP3XLwnqJeKUY0G
	 NGMDPz9qQZd6NMHLChrAV2IZ7iGv412Cdy3YNov6T7Oyl4YJAnAKkqrZqgRe4Sykvr
	 AVXeCt4eMCKEg==
Message-ID: <sashiko-outbox-214535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 02/42] nvmet: check that the file backend
 supports ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-2-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-2-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend calls ->read_iter() and ->write_iter() of the backing
> file directly but never checks that they exist. Everything that isn't a
> block device ends up in the file backend. So a namespace pointing to a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such files.
>=20
> Refuse them when the namespace is enabled the same way zloop does since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D2

