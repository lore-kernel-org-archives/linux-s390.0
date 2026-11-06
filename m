Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976497;
	b=NJ7AIvg3/c4jxL98rxngMrEe3FOF82Iz7xiPYCOXzTdioHzz2bEUPeT1aW8MrTlOCj9k
	 ISSVwUGDL+90rQ+bgFjqXg7wtDvIQeE0lmGKgRlYwq5FfmNLeaHIiUOE8k9V2RTH7veLQ
	 B7APlbsoH+blsB1SM7ZZjy8UgvizZgM2rLtqbEQMDuA4s+yVFw0zns9FN+IbLoHDe3lqW
	 hJR0vc9k2ECgVRArtU85RvQEp7LVqMQBibu9gZ3Zx7KMxowIdF59cTVvqgD4KDz6RlDFU
	 fL381+n+wlK2ub1nIzA4NfvYquo/t49MRN61jF4N3YvwmIPr+9aXW8yy7NGX6n9krVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IiuUOS8PRrbZkBfjOtZ1E6POWC4eHtii++YMLXEgi4U=;
	b=VLiytkAFqucLKG9tdLBCggEkVgoqRmf59Sg7EWS5hUoIAB3FkyMxHlTCH93aGyqpnM1J
	 GMLSbkiVHms1aa+6nQCwmQ/3mriFRNjTugRHGKyEASqKoloJJcU9SzDQcJe4syr8AMmeY
	 N7kA7qus9VK+rorng72APfwvcQKHIddvSTjiEJWuPuH+9Lfj+0lShEA4UkSjGupFsWqvd
	 LLd7Ea4oWfoST/PTPt5w+QrdgR4PqXALs9olENKx8MCiG7N+juu8+C2meEgLgR03hvVVV
	 oK2rUvi3OSs/ABvT6AbMIsEWs24ubrd3C5X0QodCzJ6cVWZVmMeeaIpKf11lX2rZdEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXRykMD6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58F606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXRykMD6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E0B1F0089F;
	Fri,  6 Nov 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976497;
	bh=IiuUOS8PRrbZkBfjOtZ1E6POWC4eHtii++YMLXEgi4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXRykMD698WwijMQMRYGcfCAiKKiweO6zswYLFG+KJ0nffd2F24jJ6kILwMe4e/1z
	 Y2C7iU2JP5v583GhcgrL7Gap9uTSkVyD7F2k9mh8YKuGIWaRkCY/2DUkppqaLn7mbx
	 vzs5EU6pdpd3kBRuPdnAsTbnwyH587iyxjNQDWnE5Qr0Hu18xBe+aGw0HAFmcz7/os
	 ZMa2ey5z8FYpFmt7t3RAXfU7IZkmEeBMSwMZI74MVYVOhUe5tNSfzHMmORJGbf2yU8
	 V1K7vTMai2rC4nMjWv5J5+gqutGYszvj+VpDTTGUwYij8WZ0n04R1apS7ZwnxkpZ8b
	 Aj7U2KMuwJHpg==
Message-ID: <sashiko-outbox-201608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] lib/lz4: import upstream LZ4 sources verbatim
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-4-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144254eucas1p12df3a03a5f8e74ca4a04931ae80812bf@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-4-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:48:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the four upstream files under lib/lz4/upstream/ without modification.
> Nothing builds them yet; a later patch adds the build environment.
>=20
> Copied without modification from the v1.10.0 release tag of
> https://github.com/lz4/lz4, tagged 2024-07-21.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D4

