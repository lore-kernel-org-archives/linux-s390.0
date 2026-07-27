Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA43E316B
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143348; cv=none; b=nShnWEbenaZSE/YcXUji19V+GaA9xfJ1imlax+H5GSM4xEWDedtvRjA8h+jEqbGKD5sYJ3BfSvwUVJRiUM5bLcDvdOLA6B15McFadICo/+BbOLiA6FXgO2OA4CUNocEG54Ga+Ga9iommQ1A0M/BTweeFFQRyTUuw1Yn8MqDapDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143348; c=relaxed/simple;
	bh=0TpKgFlY2szm5UM/v29VJaSChnJmnH1VqAgxCb+VAjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=odcKBQzXSVdyWy7GFaCX/3LAy3qyAimBSE8Pj4Rg16/k5r3Zazih8fITqkDvQnBeP01LrVodCndPFa9YTzZHTGFF5OLMrg7xPkZUe88J9cyS6agdJdTtBPZH5XiiNx9j1+VCRwvg29Z7O2oaYwRWxOxU00icAkEIq7FYWfghr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8DbUQK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8DbUQK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238DB1F000E9;
	Mon, 27 Jul 2026 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785143347;
	bh=0TpKgFlY2szm5UM/v29VJaSChnJmnH1VqAgxCb+VAjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8DbUQK+KTfdXfx7SkshIvd9Hne67L6+u+Mg3cW0NYrFVFoP4QOp+9GZdbbj9nMhO
	 OD7h6WL4KaOy7/LfUXHcnwzYyaryeNP5v+DBXqljNGyqENl+Bfqge44x0pgaEA9nu0
	 0cSVMdhKt4o3cm5qj4HLyORO7dKY16ORDwI9AOYdUfHi0Byy86QqqADHjGiC4EuORC
	 Yo48U3EQDXzB1m5YoK3BChz9g8m2KnuMjzrQohtjnjQ3coZEqZje95ungpV8a4ZF/n
	 fxMm4EM/kY+T5ttBCEiemzFd073R2MNjEl48G6KWZQ6YunuTQigVYRP3Eh2X2ShS4F
	 cvVvY21M9hpCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v1-1-ca1777547c38@linux.ibm.com>
References: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
 <20260727-arch_do_panic-v1-1-ca1777547c38@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 09:09:06 +0000
Message-Id: <20260727090907.238DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a hook for architectures to put their specific panic handlers.
> s390 and sparc already has ifdef preprocessor checks to execute
> architecture specific code. Pave the way for vpanic() cleanup.
>=20
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v1-0-ca1777547c38@linux.ibm.com?part=3D1

