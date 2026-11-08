Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177951;
	b=evk3UZy7QGhlgRKsXhhlePlRO633B3M3TcTBBSx8U1AqQmiA+OFo2skTUzPXIgQFMT6g
	 iuVK8icMB7sTUxWCFRFvzryy5qvFFMO4Ns+2UlYJIRvUo1wlLNY7SFeWwCc/UuI8JPLFY
	 92ceU7XRpz43IXMEicODtAPbJb2Aomve7hrlN2yFPHMxu3CQnuKno1G9fT85DkHSWv3TP
	 plK9Fm/8wlkG0ilsGuY+mxBth+54MF8XvqKNqJgdUWBVzfzXURhaPsxF5tL0Sl6UxaaNx
	 473N6bWuzO2VYxW7WfK264iD1bORUXt4EfQc+H/LYLemOOEYGja4bx2bFOwVc+L0tkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XLgzCq14K20n8RSHilURE64ptoPVxwMZEwDnJcc9wsU=;
	b=LoYBqKPyP1ID7jCD0nJU3fjskArhaZy9Tiyuw18lxUXGdxyr/rb7pQTdKPd3x1PgSqbW
	 mqCXUucC/XojmlAbhSu1mc2IFgSfekNKr3tNZFz8gH6nPCthfbpXWgF/A0KEXn0a/VOoH
	 ogMmRclsrUw4a6L92XGGfbjzqITox4DDUhhoeKHW5SUlOEbKJamDBVb2Hl99yKh7g2qql
	 ohrJl0o2Gh8ZGmSI5rvFJs+/AOuLg++bCbjFAXF+B7j2ETtf0PimzAOld+yY4h3LzuZSA
	 iQ5PAmVpX/sqGns2UdbjAi3KVMvPjBPtTXtPxKOrmm+mxgB2aT0oSDHKPC3dTw1kiug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBMu6a08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E29606A320
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBMu6a08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22FB1F0089F;
	Sun,  8 Nov 2026 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794177951;
	bh=XLgzCq14K20n8RSHilURE64ptoPVxwMZEwDnJcc9wsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBMu6a08nTBVzPEPAXcmpblaAurY8Tdzh6RiU0RMTD0uzgXYAgwVoyp2FzRzhnvjd
	 ozTAIyRgm0lS2YCmhIU2CrFMQhG0sFaJyg+ArMweuesVYdeWCvPMjj3RaNHiQCZMbH
	 KBzcsefZmBbT/uJA4aO5Dp2ohvzd+bc2m8Y1Ihx1MCy/FAwc2ch3MMwoab1dTt9WgN
	 BlcMoxQIsSXoZlzhsn4+i5vLvQabQ25sxwAJtPPztkJs1PjJWjvmjRtFCbM8JYLGov
	 SH2/JDITTsgg+u9JEaAgl10ohIEFGwwa61Nq3fx2C8qHsAq03FHpmmyJgs018GHISN
	 IL6lfj6l7Me9w==
Message-ID: <sashiko-outbox-204129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] Compiler Attributes: Add __must_init macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-2-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:45:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D1

