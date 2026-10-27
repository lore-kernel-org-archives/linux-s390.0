Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141011;
	b=emlvWuQj2qJC9xQCncqSg5t1kDiV7ud9M/AId28VtfrJTqWH8Oq82YF0y9x3LTkZVwJF
	 ehZR22zrLwx5PPsEV9+ZOOTzDu2pvWQfXMNgD51yOHlcng0WaI63HKceMWh9Fp+aMPGdx
	 2n4USiC8LSFxnC+N9/PPv9cRnnmx4ziTIzblMa1DPyFRZAfnorUs8JCY1EDOz+Z5ilkVK
	 S4DJxftiX+nzKXVfRcHPkSbrfY0PlbldReOgPzDjCK4zzv2SQGRjYryTRLbrn1UFZKRM3
	 JrGN+Wk7zhD2EOCXYOaS+ytMTyNyTb9o0JhUxLlgqC4GOxBqdH2dogOd90NjDE7yIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NUJVZxF2Cp+49ReJAjaN/0XqNlIgjiQJKyqNXow/+FY=;
	b=19/NuWPMHLwMJOUJ55F3QpjQPaD97a3wneUYzoP0m7mcdb1+Q9iJKXUNVPaEFepKxgjo
	 V2N2+c9craKz0i1mxEwMisBYtqfwSLIpcNkJL42Ypp91CrNOd6I9xqaP7y2PTS3Yb+S5U
	 jWAXVJPXn4oZaiWqO2QmsLFiAPf+SqAdw22YHv7lnGH9jlueQWWIfzhUdMTrHp66Ykxnb
	 wdwWKRny1dzbw5HRy/Y+hFTzLQRaVKA9ZnBVoQaSojVOKGT3udm12UuE8m1D18ByIS+FZ
	 8OivmOtfAacEta/GWJ7CmbDnOngR21NYbVKMW9vVWzFr3J+H+eZBvO7IsheVRcuMhvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUU7pIPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18807606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUU7pIPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5711F01825;
	Tue, 27 Oct 2026 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141010;
	bh=NUJVZxF2Cp+49ReJAjaN/0XqNlIgjiQJKyqNXow/+FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUU7pIPjhuhf11tlJSGzgIsRglkW8oYabfIqkVgjC2tdos/QYl6VjPTo/wxWH62Sn
	 KtJcU8OzXSkQBELN4GLFrRQdotHWwOHXXU2vEF9JY6C4wxlIaeQsl4+SZMXHhnqak6
	 8bFkdYHZ/fowKGJw7kHKzCriB4lKPnysD5G1cFCamEBM+F5/j2iGzO2oTH1USWyu2P
	 hKHcoXoIpknVr7fzA5/0vekTRa+Kljzu5V7V+Flw5rxYVyuMqYRDyfu7GtFwEpjA9m
	 43aHNmbwb7jTH07l7ItGrbUjkf75j/37IyLQyErnkdv8L6EThtR5nLQyG6Evjrm/IY
	 wY9GGqcKd8HTA==
Message-ID: <sashiko-outbox-187174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] Compiler Attributes: Add __must_init macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-2-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:43:30 +0000
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
> Note that Clang does not yet diagnose file-scope objects declared
> without any initializer (initializers at file scope that omit the field
> are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
>=20
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
>=20
> Link: https://lpc.events/event/20/contributions/2392/
> Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gre=
gkh/
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D1

