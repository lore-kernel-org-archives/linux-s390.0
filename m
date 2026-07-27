Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09643D8123;
	Mon, 27 Jul 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182066; cv=none; b=GfO5p8Rk1jpGCh0EsExdcvscJKOPSvnYxgpGgxSljLiUiOXWx/o8RSDfS/jzriqj+g2Xkk4xWnxG8qWbmbVdxc31f1pDCm7r2Ih0d/icIovTvgpk6L9Q4yBL/sphbqlMRTMStrEBOFLQ6SXqIZJtwjGjyU3N+8DYivdmbagZ6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182066; c=relaxed/simple;
	bh=N8fvS2AXXoxyFLlhud3hJhJ3yeIGYwkM3RxjPKIFXrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuXV/jGMkjv6xoJ+HdV3uI3hVD3/J65oo9ThbiGJCTBUWT0d3TFlxjGaZFO4S1Fx+SYXqd626a7o2xsbXwu7VndppNy+j73MZIuVVoYFLHwfOCsTBaVZjEiurssn/Cx2UWbZmkWIQSZb0FTfoJ9UE3qIdUFGqFNGc9a89LsLxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mswU238j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mswU238j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF761F000E9;
	Mon, 27 Jul 2026 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182059;
	bh=N8fvS2AXXoxyFLlhud3hJhJ3yeIGYwkM3RxjPKIFXrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mswU238jl1NSpY/PcWgGKqF2vqT0DSblWD+ITGzbAe0SaPD7tUtccUx1RG4/dRtTj
	 jKjD249IDPmQra6gyJGbZkY3DFK4LXyKGFnR5WzoyhxZLLxsmMX+izjxc+rF5UY27d
	 2GWLwao9v7SJMnLx/VaqQ/wdGThiIWfDNgIJvRAiwlu65Fkn3oMFK50E7ILfEgrw3t
	 K26uP0nLPoLYQ24zhRJ4cM8TSmbf9ZmK+pgDhVy2H0X3XXUm+Pk7WH5TbdM+58/PRM
	 WOE4jcuSN24qKFO2qjZsWA3VGDdKN6gVwYLF5q2lfjbdixlz9YbzifeZDtgbKnu9cQ
	 9FBrIeMTcciNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-6-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:54:19 +0000
Message-Id: <20260727195419.8BF761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko pointed out that get_guest_idal() unconditionally calculates
> the length of the IDAL presuming everything is a Format-2 IDAW.
>=20
> The output of vfio-ccw is always Format-2, but the input can be either
> Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
> the size of the guest IDAL may be incorrect and should be trimmed down.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.o=
rg/
> Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D5

