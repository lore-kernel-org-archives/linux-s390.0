Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391A3515F1
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931698; cv=none; b=tUfPC70mCycg3QQOuiwMYCCuQzuTDjY2QHiIKPZpEjJZ5CMqvShlf9q+ncTf6Q5uE6U1LUspHzbPk9y1mN39osJH8yrQN6TCVGyctzH/+4T4iOohlwINvOy4ZpNrohMmuYa+OITc4KNEydUY9Gf56B+E84oDA3OBS5LlfoJX9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931698; c=relaxed/simple;
	bh=XW/xzpWTs6q61jF+kKkrY+NsS3vOyyW/LNfJ0pj9+vU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Tkw64Ui3+cPNDz5PPyjSp+sxOZQOIP620m7tmPj4Qk7rcThxhmzj33wrcOKk984kPG/I/3XH1Hp/c8pIPJ1mndS81n1hWivluKhCOKtGH69UhDv2WJXDImRSU7ge4dxSWLUiVJ6YmeAD2/B96SfIk/hweDbT78/Nu5aWBTY23vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJZd7kZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJZd7kZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F711F000FF;
	Tue, 13 Oct 2026 22:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931697;
	bh=XW/xzpWTs6q61jF+kKkrY+NsS3vOyyW/LNfJ0pj9+vU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJZd7kZaUhazmpyP5KTtmuKmbL5rZFS+p6xcY492LSCI+QSIJqTFNq4G4y/q5p10d
	 ioqRRBlV1IAGyaKkqskUv4Fx49sbebf0ingv6F0tJaOJn2MyDVRQgpI/VE8ZX6Hqv7
	 tyqgRb4Cgq9xYWq4QXvsgUb7BUomc+sELEi1GMS6N5OnAfMAGHVsmz8yRPrb6leasx
	 Jok/SuBCiu8dZB0KGTiPCwPUPGuStzs0Aumz9LLlc4ywQA1/xJi2vdY0aiWmJIebLz
	 cAlcs64jXrR0Rh140+YTTBHW1bhia200fa4IJ79XGSBp7nIirE1BbkeRLRAEtKknIl
	 TuKrXQyylEMXg==
Message-ID: <sashiko-outbox-170598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:48:16 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
>=20
> Add the __require_explicit_initialization macro to
> include/linux/compiler_attributes.h (which is included by
> include/linux/compiler_types.h and include/linux/compiler.h) so kernel
> structs with error-prone initialization (such as mandatory callbacks or
> cleanup handlers) can enforce explicit initialization at compile time,
> as discussed at the Linux Plumbers Conference.
>=20
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
>=20
> Link: https://lpc.events/event/20/contributions/2392/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D1

