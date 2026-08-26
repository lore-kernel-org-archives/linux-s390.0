Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604813DB626;
	Wed, 26 Aug 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756967; cv=none; b=TKgQm/gLrq6hjuuJojbrBj/NphTJXQ/yGZmZkzmnf8awmxRYthvkh2WX1k19LvRRifT2VT68XMvsYLv7hy0YCYTUFgDeO180i2SriTjbkOQYFMMhap1Smv06O8yHwRRf8DgPcUq83o0LAF3FaHN9FDNx818pGTJr+DiPf0llrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756967; c=relaxed/simple;
	bh=orPrMe2k5cwl7lmyoExw2seZaF8f0kgXpRM4e/NKSbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hqb8OaHPn0w4DZuuSxLGkmpsDK9WynWmVdQEb5M0WDcK3lHfpSo0YuWVxS/zPnWf0xQk10y38QgoaxxkHQhFwsGUjuQFzCTRFe1ZDUeKBfwMCYOn2qQOfTA7zA7wInE8b0lRz+drsdBc0+u02GghNyLDVpTnTaxxDSnQ9MPztCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd5mqeOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd5mqeOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A91F000E9;
	Wed, 26 Aug 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756966;
	bh=orPrMe2k5cwl7lmyoExw2seZaF8f0kgXpRM4e/NKSbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xd5mqeOInzlebIUMNnX7MTEODD4IQGFO0p0GHNEQFqqNHdgjtYe3/GaBkApOBWTo2
	 HJotU2V4i9/xxZ1Ysul3yAo4HUymqbeLgPjhHjafECEy8ukUFvCcKUCyQLHU69Hx9i
	 JBFpaVbxYTCKu7XBz1+suQbrJBYFfBj7rNT2R0qKVo+bGfJYxw7kNVBKyPFKISNiom
	 MDhoUMl+e7qvV41FMUO+kgdUTrZtv8fJxjHthjJbb2FjI/hPdDykb3yR4xMBqMTTd+
	 R6PwUZgjOQPXyCnEHcSLTW6IH9C7lVJdFx0UbyUTz/WynWQxWp1wJJKSD+clqApkTq
	 0a9RwFljO/pwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-4-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-4-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:09:25 +0000
Message-Id: <20260826150925.8D2A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the required guest-1 structures for the ssca to the SIE
> control block for use in later patches.
>=20
> The shadow SCA features the address of the original SCA as well as an
> entry for each original SIGP entry. The entries contain the addresses of
> the shadow state description and original SIGP entry.
>=20
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D4

