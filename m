Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B642F7EE0
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851221; cv=none; b=fGOfRKJ7fPy116g1Ys9/LJVD/IMlx+ATVjuz3YinVLWCVlVgFpYLQXWvXnVAtfwPQ0bZLmIQtpv/lEOZdWA55BaygXoVS3lDioabMLx7s97sy7HlWxt+pTSOeZ+HTgZnyJ+uXZK9c99Pnmrt7t84qPffJEzywesGWeBDiMxhapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851221; c=relaxed/simple;
	bh=z32mz+T6XXw53yr1jsNYEIzUYmSs8TU/dcbwb/nBo1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBQQVACd5PRFR2p1uiUFJ7Z2XV19AV+wksUUdtD7Adt24z16FYuxEJrGEYssi5SqfZsgyQ1pmsoFKBa4ZbS22NMNkG2ceuSrwsBIRwM3wfkAuOuCm7DQ0iltC6mWp7iIKRpfxKj7m2PQBESsCVn9wAQGgROAi6WIpF2jjMxrU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+xM18FX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+xM18FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472E01F000FF;
	Thu,  1 Oct 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851213;
	bh=z32mz+T6XXw53yr1jsNYEIzUYmSs8TU/dcbwb/nBo1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+xM18FX6+4rCh0pvaYDXoCyH83hTXhMHcVxu2dhHQAOdLxPnUMJMzMVckn3uVLzR
	 qXq3ScxfqUt8js6drPW/6NH5TvMGa6lkqQ5EeHsUEe8LOae17nFh00enkOYksTkbyD
	 PGDU9O+VEcXivI8IySzKnUgmxNl2nvVRf4znuJq5/GdYyfc0ITgs42wDtNfFANibfV
	 r5q5Hw+eUqIs5dhNmhH51SvcG7u+RpZrtkurpthImvjNNEtm9KibA2Vq/dS5BBefL0
	 r4Q9ZWQLffqWIkKrep1jhyCqGBTc8FHp8ia57OYK9YaPjsTx8iHM/gYxxtOR08UHY9
	 iGHOaQGbytd4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/32] s390/ipl: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-19-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-19-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:12 +0000
Message-Id: <20261001104013.472E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the diag308 exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D18

