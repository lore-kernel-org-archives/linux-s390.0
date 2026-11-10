Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302793;
	b=2FNhucjKpcJx8vtkjQtPnM3Po5B9epEh2VshqN71E9Rg7/4j9/+Yvkz8jVhaalBrbMvW
	 B1OmB59UJqojhEDOs8y0prXhYuoX2PQHri7L8cGsi9douzW4J8364SwBloOhwg0vl3bVW
	 ySsNxHpgSK3r8GemQ09IwMOIC/spztrbIqSH6rXCM8t7OUy4CMfFmyvIVY1vPFult3Ien
	 7xKxJPlmILJBtbzLtxZw9zjrigjjvASYcF34iEk1kNTiXg8GhMC4SlpGKUQSO5poqez7g
	 eG3k6D2YsMfNCj/WkHc1LeuJ2df0hJeY/cZg/mbTDGW1yXzsl1tPIHk31v1mox9MzLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C+xyLX8kg7P+3iL0Qyr0v8adhQ55nWwTU1NKjvFozsw=;
	b=RCueny3vZBpvL2Hqzi/b50eLANnJcH5AfiX72fCIcbA0sm8jON9yXk1kCk/cLB4hasfw
	 PbnSDaavR5tYvpVaVjiQ2ILFCMQri4WdmgmIY4mjl7+dEkg/Si1MR9w/HX5Uaa1WQ+uIu
	 IAUiWTVW5EjVKZg9cDuGkITVUNCmsEdA8CGN2CY8mSe3f90w2YX8JkDYuniRXAENuuLQb
	 GNJ7xrxcLwBqBafqGO4DfcwlLQs0EusFNJ2/I/0pMMWVMTpxnFN+EFm0Zr8ve4O/msRVu
	 jZn8FgexuFS8HFDSZHptw5BKP+BwN7E/hTJpmCycFI6OGE9z0NmPFjii+pVlU7nCgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlE7lFkG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971C60A2613;
	Tue, 10 Nov 2026 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlE7lFkG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B0D1F0089F;
	Tue, 10 Nov 2026 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302793;
	bh=C+xyLX8kg7P+3iL0Qyr0v8adhQ55nWwTU1NKjvFozsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlE7lFkGhutgQGlBbkZHybtbQBl/KpiGj2aCde5h54gCHc23nn2FG+SV40swMIgDm
	 YlX2KEjxB8uFItmIXpYZmr8J923VUu473qaFTvHIzFRqTkbDi2/FIA+LZ4lb55M9MD
	 VDKKdSIJfvSL8SBc5u84+3v37k3iiqRqeXqbufPh8F79lNRSZd9bCjd+X1nrJPr85v
	 Ab/HYWCYw3tgs7viqVSMROZ5zWAfvIvowf2x5TfdJdIcLY5l62Cg9WVfMR6p4ch395
	 AfMRdpmptGSnc4kUa/o3Sg+nGM0753O/7/vbwGoaZw1RnTqXD3kkkjd0dK71PyXLG0
	 hd28ibBb31Kpg==
Message-ID: <sashiko-outbox-206748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 26/41] xenfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-26-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-26-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D26

