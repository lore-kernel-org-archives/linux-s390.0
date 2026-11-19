Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116592;
	b=CD43vAs8EpBLgJNdWsDzjO+O82npjvfFbPCxNr33/zsBbeQQt0XmmgQWm4yYUGf9wHYn
	 HIOszjD+wxZTxBu/wjUEguzexOELsLiJzfkNb3vPS/+Pb35CySNb3ZBNG1rkB4MM4d3wM
	 KaZKGBYtWLXqpJ/z4jylszJA1FdDtsjX7AMl+e17LjjxnKEiRyfmY+fCb6POepi+t7K+k
	 Xphmv4Co5ZZw/8o/YuTExf2VcLS+2XHue21r3SmjLhqvZUjxI4G0OxvbDPtey4JL3z75f
	 eG4FQNDKRj9DlML5TxWtxd4tOEkH5kEx7ThfGtS16f4LykKGnRDeO8BRyIJTawj5GyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9cP1K6+igbWY7s8klRCQSvp3lFHhlYO8eN9Z8Epz/fY=;
	b=e3HXY/QQh+ws8nsszn0I+pqeDEjU4Q5eip4qoSR5c+38HKvwpl/UJjvPrZZxNIDH/YAU
	 lk+lOcD/XJfzQwRlqSkC+nC7/gYMun8Zs4sUjvuLMS2Rp1KUeXWs1F8kJMrg/ATBYN7Lj
	 rQFVTavWMaD1DKy3uvxWvH2ntviwNmwGLufDmLI/G/n1uZUBIvcIWIKJW/SYfRblTpl9X
	 fiTkSvatjxND47QmIylWKEmGaoz6iwdqeKHUFYX7Al1fjqlLvEm8XtHaOFJOMBCTWA4Cb
	 K+QFfTHfEGxwOgevTI0u1O9tQjyjsTgyGatB0UgzpN1Cx/gLfkKUEEkbdg42lI2wBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKR15U8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D33606A330
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKR15U8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF241F000C7;
	Thu, 19 Nov 2026 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116592;
	bh=9cP1K6+igbWY7s8klRCQSvp3lFHhlYO8eN9Z8Epz/fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKR15U8K+6NtIvCCMzY2hRC1EabW2qNLua3hET9hq5zfl9n/6rM/dYashwYVd5EyF
	 g2UolGmGA5lMfSwVfze1ekv3m/rvw1TcCosNFa4LIURsf7e9julKUSCuLmaEi/D2tl
	 7EX9hCSyHaR7wFXmUCpZL0m8LfddW0ikhGWIifceeUchjpwEtVdifCipKg4h2l0YMi
	 lETF0VyBd8tUshiwb5zweixHRUmM01VoEHhoJ+rsgyUvWWdJfkfaPvc/eok4mc6ga8
	 1Rko7zds6LOBmPwKVvUd56uM1c7elfEu1Kmueam8jEU146jT+qv2ZBsmN+PkNoZFZw
	 0sWXxkYuTJsow==
Message-ID: <sashiko-outbox-223919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] Compiler Attributes: Add __must_init macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-2-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
>=20
> Add the __must_init macro to include/linux/compiler_attributes.h (which
> is included by include/linux/compiler_types.h and
> include/linux/compiler.h) so kernel structs with error-prone
> initialization (such as mandatory callbacks or cleanup handlers) can
> enforce explicit initialization at compile time, as discussed at the
> Linux Plumbers Conference. The shorter __must_init spelling, rather than
> the attribute's full name, keeps annotated struct members readable and
> was suggested by Greg Kroah-Hartman.
>=20
> [ ... ]
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D1

