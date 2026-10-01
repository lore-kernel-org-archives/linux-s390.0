Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2D3F1AA1
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851211; cv=none; b=U6U4bVSMsfwe9fxhbHm25RWhJZc67DTrvjFA+P3obvXEy0cVIcddHVmcp/JQ8z2aospDaefeEB4cjhteBxpf7WcrNhoir9qZcpg/enoDUmtLRv2BAJwCvV/jH6baUkWaaLShRVUOKgFWHXPe2NYGk2wcbseBxjUzSJrUvrekIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851211; c=relaxed/simple;
	bh=OsucFNl53ZhuZ6ScFOqSDpprYS2+whNnQAl/+kTKlx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PNBrm2oBkhLe/ehieJU56dsmvMZEuDFWOswcKpPfDPSU8asHBJBGA2S4XYrj08hpFaNZktkPYHNfonI9ThWRiFAtklqCdrgaSRswvDDck84AsWjK+sUB2Owl6uf6QXmfj65hrek1QilaDQd2TJb/Vd3RU6JK0mzOFev3bVcOdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9Y4cbBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Y4cbBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465F1F000FF;
	Thu,  1 Oct 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851202;
	bh=OsucFNl53ZhuZ6ScFOqSDpprYS2+whNnQAl/+kTKlx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9Y4cbBvw8e9PL6fpu+DZ4jJRbrc0uUkFK1OkQ7EXskH/ykVXwAsJli0igm4rq8Vf
	 DgDUR4grUkOENYoUPjxBuORs86HyPfy3Q3ZxGSaUZx02oxTohzKRAzDSYVZSQo74Lc
	 1c5iBt6bM4q8KVa+VHpLVt0FHv1w4fm3TtfYfVlJsLJxJfuZ5M+kLhksXZhndOqZCq
	 ucyOhvDUQJC52tMSfHzrSlaYr1LQkYBfjBZwsG69izu+VvOTKdH+UCwop6FSIWaxBE
	 smvuUXYZkjMA1jfDOynmnnwot41GZ8XafGH4qfNGITCrvmus/ZU6y6T0gBemNjLA9D
	 8Cc0+M2EoWrQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/32] s390/lib/uaccess: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261001103247.1989111-13-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-13-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:02 +0000
Message-Id: <20261001104002.6465F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all uaccess exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D12

