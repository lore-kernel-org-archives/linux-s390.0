Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B93AC0EC
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158700; cv=none; b=swuWYP3I2WC9Mfsa5Kp0/R8bGRi0c/p/zVwU4w2/UyS1wyxC7NBHU9jyRF6omRDhMa8nhio8pDz8FGy/I8WpjEn6Sgww4zHa9y5A7eAxyGaaIRsBAKYcM20Ro7jlyDHiHayeNgMiBz0ReG7xwxPLsiAsUmdmcPrObEd/ZL6A2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158700; c=relaxed/simple;
	bh=LtR0LOXnS+TMdfezAVhgpBc1ZPbAU+2DhlUTfXBX3UQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SflCkKtTlUnoFlid4YdrUd9+Bo7YS88FMXZpwDbgGlrOloANt368GQusLOhbD5irVPzTHhA4ka2uuuIc8o43/j+9KGx6Dp74aFXTeNv65l4PWq9yqsDSRopr1+OddH7jV34xxdc4ddiZ1LIDPDkwPfu0jT0X52hT1XE/1+gZwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJp6Pm1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJp6Pm1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162C91F000E9;
	Mon, 31 Aug 2026 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158699;
	bh=LtR0LOXnS+TMdfezAVhgpBc1ZPbAU+2DhlUTfXBX3UQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJp6Pm1T85HMHoIkmrM0uF5kHFLHwYlaPCw/BUZW8DoZcN3ZiYPcup6P9WLtJxbua
	 H3ARvXtqXINt2SCtZkx93XmJts/Ju4KKBAdxRxycY90QNRCMRVNk7H2shrpzyN9xgm
	 97+aHJR14CK4e5aEkX0cwQauQx2eNZUakSyIl4Ar7d4bmmdwyDymH0SsGPAaMIBH8O
	 ihe1EG2i4Gcb8wMJdt8G1/NtA95YAcE+D9GuDH7nUxVQPWi9ek+MrPDTF0eXB2k7sh
	 YkxXPb+DiH8geOaFmFmQ7KPw6r0YJDvom7FmkM+sMNDUkKGQxQLRtC7eefrMiuwXY7
	 tg7Ql5xQVg8nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] mm: Drop pxd_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831054331.625505-9-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:44:57 +0000
Message-Id: <20260831064458.162C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There are no more users left for any pxd_ERROR() either in generic MM or =
in
> the platform MM. Hence all these platform macros along with their generic
> fallback could be dropped across the tree.
>=20
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831054331.6255=
05-1-anshuman.khandual@arm.com?part=3D8

