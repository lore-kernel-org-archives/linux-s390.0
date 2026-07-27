Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA1420482
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171257; cv=none; b=AjEShTBT6FJ3gn65gmpRGa+aQZ1XiaaUb2P6QmbSPnOtyXefLzNI8gXA+bISZF72+tU6GUmI7C4sgdgrHLcxfJhJVFD8HETFfMLE/81Pcf8KzB1Rjg73xDmy8HtfBwA1mM6+eV6VPZmsrgQlJjGa4uU1gmOLjBv5bKMs4PTjNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171257; c=relaxed/simple;
	bh=DopizIfOreKiI/rVj0XuY3lYVY4Z46qegrc6BE8VfTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=naptLcoG8MJNDMIttOPkI3uz95uXDIvUT6dHgoCo3MD25hv+LG62aImYDfx9BFOBVMxbN8U73cULN2QT/APXs49cGin/EP/agoLyfA/VOnlf69MhFhfM+pgKfPowog73/quu9xurui4TzpMClBL9fxwIuB5cu15bAOhS5ObQz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgomTBw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgomTBw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29DD1F000E9;
	Mon, 27 Jul 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171256;
	bh=DopizIfOreKiI/rVj0XuY3lYVY4Z46qegrc6BE8VfTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgomTBw3creDeDrDMXxSIT81RtsB9qmIj3ZxBYd/joyAZcekqgDwUPeBtqp+Q+uLF
	 3+aV83bHew51nsvR4OA843la0a8jdk4uKY0cvjgODKCoscfmzM0i9Iq4iACyTGR2wU
	 +Lka3vc+htr3yW1CQHIqg3F2X1TkeDSu0sbr8MliyRBpc5kJB9kbqCizAntSPPOZNp
	 as4HILnVQSHdxYFOY6fX8M/SOQW9LWPBBPjrYYeM+L59XTMh/+EzOxwT36LZG6YMHq
	 /l2FEGk20NnEvwYHVlL6t56WmYg/pPknBca5VAl7wQDvLFoxyPObvGOqOoVAFog1HB
	 X6V9irozCfbWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727162430.1599396-4-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:54:15 +0000
Message-Id: <20260727165415.F29DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727162430.1599=
396-1-hca@linux.ibm.com?part=3D3

