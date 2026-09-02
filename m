Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02B397940
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384975; cv=none; b=DMwiKvoza52HYFLlcbjbDpDq1FKaNgNQOSa81g3tCAgSZcRngLhJ3h8Yvsg1lz4Dc6MgAYVCem0RB/xl7qnf0wxROWneULu2UWJxdg+xG70r4zHhJkF9zMKOtraijTqHxdtXopDA166UHq8ojh5duEm6VvI4mpWtjgFPdIEYokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384975; c=relaxed/simple;
	bh=bQikBTOYzzDpfmFcyk8kAEF8gB17aS6oG+n1+F8cqIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BcD0X+fjwznag2HKLiiG7uAGsjntm4DVyv/Vc8hohueLbeokLxrnrAbxSn0mhRn0arrCaZRAxGpfPE9RPL4sTf/LSU9HjKTtSrHnhGN18JJt0imNhmrQ/gvP0zD/PuxM+zhIsNC2A7v98DuBZE4Mf1ThysuW42Q2bbsPfgh04+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjrP1ecp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjrP1ecp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A001F000E9;
	Wed,  2 Sep 2026 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384967;
	bh=J/KXfR9JIdxQCsYLW7TM0WVANpZJtgl+0uLg7BsaOF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjrP1ecpyEDltgavgxFPyyJ96TpCXJY7pIZo03+G+KXI4gtKzZpf5BINkCYy8qgXj
	 F+14hKapYVHgpTMahafZezyPeD0ET/2lFhTXi5qjrhw4cnYDiaYw5JfnHsFavK/GWP
	 Br3UmZUcpbJvcuM0eQfTsrpeVp/x5P6k6qY057d524O8vU3z1s9c5pDMjd26F0Y8iK
	 EMvRyxwQ26Fj8f1KyRashgdN+nfsQH0BaqGy/pDewbhnkF4VZ5C5oiKlhD5T/lju6j
	 XdkExe0URJH13Z3VsZOJOiiEsP6CjodZBI4fbifzGLSRsaot/6yIwP691jym1UbkD/
	 DhIcC7FB/HDWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260902212400.674450-3-iii@linux.ibm.com>
References: <20260902212400.674450-1-iii@linux.ibm.com>
 <20260902212400.674450-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:36:07 +0000
Message-Id: <20260902213607.99A001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
> parmline, for example, by copying snippets containing non-breaking
> spaces (\xC2\xA0) from web pages.
>=20
> The kernel will then interpret the entire command line as EBCDIC,
> making it unusable. Distinguish this situation from the legitimate
> EBCDIC conversion by looking for non-printable characters and issue
> a warning.
>=20
> Accept the following tradeoffs:
>=20
> * Do not make this a hard failure, there may be a very small number
>   of users who put characters with diacritics on their EBCDIC-encoded
>   command lines.
> * Do not use heuristics with arbitrary thresholds, these may fail
>   intermittently on, e.g., punctuation-heavy command lines, and having
>   to tune thresholds in subsequent patches is not desirable.
> * Use the ASCII subset of EBCDIC to determine whether characters are
>   printable: the vast majority of command lines will contain characters
>   only from this subset.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902212400.6744=
50-1-iii@linux.ibm.com?part=3D2

