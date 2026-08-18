Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB137B40E
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095376; cv=none; b=e/qlrXlUtDQD2GA+sD+GteUoERcKOpzYkIvIkrnX1jp9xzRJ5u6ctZ+taZBeGgspbfUe8eUkGrPReigJGwaXuJfE5MRK9RaApAHd+BzX7vUlu1vUh8yWdPHFaAmHkltkfVQCo0iCNHdgqbRoAsPT1mPvMT8cVYhnUEu0pTbfPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095376; c=relaxed/simple;
	bh=srDL0764oRX28u5FkTXgSISko2j2IHuuZwgQfu/d2H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFyHAj7Cedww+hdmOxXzo9Pskh+OcFPmJmo9+whVXKKlTADdPo7VRHXeqWaTq8NwlppYOExSufSZAYN0WM9ybZYOTxaK5v0fhAXNlUMc7f3AwswCUcK2wKeV/6jv6cmb+Trq+ZY6ecefnjAohJqhX0iwmeEr6DYH4gLN1dyiugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVUhtA7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVUhtA7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42F11F000E9;
	Tue, 18 Aug 2026 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787095375;
	bh=srDL0764oRX28u5FkTXgSISko2j2IHuuZwgQfu/d2H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVUhtA7OAmCsQHmHjH6DCIuJEkjYSYee32vWLwzDm/dPEUmmMjlzd+mLTdcCQD6tf
	 Jxlz5iXqGcKQ+qtTw7V68jXDZWcoxgsweIwvb0AQtEGPU0TMGcl7ZkEm8DMeRMhnsB
	 36XTr4da18LiBura18Tb3Xu+b8hGB4BV3Zg8odaHB2CZVI91Y6Ibr2iSnoaxJZ6wHq
	 We/kjbNur2qZseyQQomYb/YhRy1a3Yq3fIX0lrHVdY1h8o6pew/WXjEOtdZ2D6vU80
	 qngNbPGYRhV8K9BU+AGZg1NMQZdmCCU/qjufdgGlgd3vqZ2fUR78VvZ24tMUq7RUXv
	 TUwGrcizmojdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] init/Kconfig: make config INIT_ENV_ARG_LIMIT
 user-configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818231646.804507-3-wfelipe@google.com>
References: <20260818231646.804507-1-wfelipe@google.com>
 <20260818231646.804507-3-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:22:54 +0000
Message-Id: <20260818232254.E42F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> INIT_ENV_ARG_LIMIT is defined without a prompt string (`int`), making it
> a hidden Kconfig symbol that defaults to 32 (or 128 for UML) and cannot
> be configured in `make menuconfig`.
>=20
> Now that CONFIG_COMMAND_LINE_SIZE is configurable across all architecture=
s,
> users who select larger kernel command lines (e.g., 4096 bytes) may pass
> more than 32 command-line arguments or environment variables (`foo=3Dbar`=
) to
> `/sbin/init`. If INIT_ENV_ARG_LIMIT remains hardcoded at 32, any argument
> after the 32nd sets the panic_later flag and causes a hard kernel panic
> on boot.
>=20
> Add a prompt string ("Maximum number of kernel command line arguments") a=
nd
> a `range 32 4096` to `config INIT_ENV_ARG_LIMIT` so that users can
> configure their init argument and environment variable limit when needed,
> while preserving the existing default of 32 for standard builds.
>=20
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818231646.8045=
07-1-wfelipe@google.com?part=3D2

