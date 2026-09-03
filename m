Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9D43BDC8;
	Thu,  3 Sep 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421136; cv=none; b=ULHvOzAxgyRaDE1L17C03ZQjyCx3H8JGsUxh2Hs7RM+OHbIQ1o4qonkQtIPHyBC+uj9zlF20N2gecKo7SyFM9wtIWA3tbgAnHNBSy8kJBQQBqJC9xSrZFklcu92oK+93fdhfZ84vG+e2IlwVzcGC8a2xp/MDp8Fx/Z84s2YZvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421136; c=relaxed/simple;
	bh=5Tps3Xo9A6ITXYjrQ6jCcfsBhSaD6gq3xi2rXZ2ajL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jfWSC+3ZAmh3kHnB3MGh2vcDc8plSVQEIokU9X5qE6lTj8COPl9CVfDu3LRqKvOfAnUA+W9pHMN7ZOfGFGAqyweSJMlKdpiu3Iy5cdxHZCkDrwyXwgpFjTB9bLHBmmVJRVxsKNKUWCu6ABWO2aQO9rVUPYFj3LuBhtTqJ5EEEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj6cB51K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj6cB51K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D5F1F000E9;
	Thu,  3 Sep 2026 07:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421135;
	bh=k8zKI6BLy+Yfs6FHOdNHufYvwQuFn9IxdcH9SYlPwjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nj6cB51K8OWQ/O7hLG+l0FQZeZXAUXrLa6yjldbSTOEJm6zNBDWmFqk9l/MQHa9uZ
	 rDFHIDtENi+3H3+zWtWevbyvCoUbb3oroJFPizjbn08Xj1vrgrTeE91QtxEfp5sJY7
	 ZtC5PGzHlfVz6CliUMcLIw5b/iZ1Z2uk2ns9wqy3PlvAIEhoh2WHBx4aHzF+PsfCA3
	 bLnIPDs+CAH+F79uFN8vAkv6tqsiOG2+XPi14ceAqmVBbyBfXWDFKeLK1dwTxoNT4w
	 zV/JIWbGme4aMbrjB+rzPg5ct9X2E8PAFlinJ2bWwHIa6PuV/GIpO2zGlG+lWKbJv3
	 SD4gAKuAerrNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: perf stat tests fails on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260903073554.1300334-1-tmricht@linux.ibm.com>
References: <20260903073554.1300334-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:38:54 +0000
Message-Id: <20260903073855.35D5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The test case 'perf stat tests' fails on s390 z/VM machines. The
> root cause is the unsupported CPU measurement facility on z/VM.
> Therefore the events cycles and instructions do not exist and
> are unsupported. This cause the subtest
>   Hide zero events stat test
> to fail.
>=20
> Output before:
>  # perf test 116
>  116: perf stat tests  : FAILED!
>=20
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 0
>  Passed subtests   : 0
>  Skipped tests     : 0
> [ ... ]
> Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppres=
s zero-count events")
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903073554.1300=
334-1-tmricht@linux.ibm.com?part=3D1

