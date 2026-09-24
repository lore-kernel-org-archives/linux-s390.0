Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9B2FF66A
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253147; cv=none; b=bnj/Kdltbrf0nBkOpBPLGqbqyEMNdbcMz1LW/NWjDtKnfyvhgg7mMOHtfpg/dYcA36FbE3IVCId+cJi61DugIt+0wcnsgYlQmimeeQlRUHi7bMssQQ0hDBgy7/XVpOpDu8rqIkzECIqbQE9eiJemlNmz7mNPvCyLnG6peOYplzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253147; c=relaxed/simple;
	bh=LX5w1RokCPiZqiEEzXWSZR4iPVWiiyHkwoaP95gUzkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rWtPzeq7ouvO2KPkyFoN5pwSstLSw8LeH7YcDrxVQ2ZAprh70gspW+drOctgDC8K+y10erjUuS0Ygh+aGqmzvb3pNVwEXiQB3MEtouOP2L7U5Bfw3JGPrWe2wKXcmKBdPnawT3/dkiIxDKcBsmnVL+NdbiwZ/W3xckT3CJ+iqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZGH597b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZGH597b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A161F000FF;
	Thu, 24 Sep 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253146;
	bh=LX5w1RokCPiZqiEEzXWSZR4iPVWiiyHkwoaP95gUzkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZGH597bKkqUn5/A8gHlrK0BppzYMaDdfBCdLIUM5wYBbZHxAOkGE4lrVZ6PWZr9j
	 TnEsOUYTC9QS81Fk3QvtXpAqoNebCupNFIoDC/Gk4Kgc5xshdOEycDwOkOayNE9muK
	 4sOLuVLvrDrsyGYry27UG32xYM4Xbq98qNuYXVAyE4ICDWiSUVY2ZCA3KhRU6p28Yp
	 OdaUi4/R24wcyJMAnvnBmFcvPZzBA4GdJoYdOdNB/gjcwIAnup8NGIkyryntgLQBRT
	 bnYXPnxdUnziSvNpxHt1JUUITBt+kCPSmzKYZxi/iEnzHFteTkfRsC6CeyDrLCeaXV
	 TJ+GuuH7/LijA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] zfcp: Fix integer underflow in status read buffer
 payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260924122400.1185067-1-ajaykr@linux.ibm.com>
References: <20260924122400.1185067-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:32:25 +0000
Message-Id: <20260924123226.36A161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zfcp_dbf_hba_fsf_uss() only guards against a zero-length status read
> buffer. If srb->length is non-zero but smaller than the fixed header
> size of struct fsf_status_read_buffer, subtracting the payload offset
> underflows and can result in an out-of-bounds read from
> srb->payload.data.
>=20
> zfcp_dbf_san_in_els() has the same problem. The underflowed value is
> used as the scatterlist payload length, potentially causing accesses
> beyond the reported status read buffer.
>=20
> Prevent both underflows by validating srb->length before subtracting the
> payload offset. If the reported status read buffer length does not reach
> the payload area, treat the payload as empty rather than performing the
> subtraction. This avoids the unsigned underflow and ensures that no
> payload data is processed or accessed beyond the reported buffer.
>=20
> Skip scatterlist setup and payload tracing when no valid payload exists.
> If the reported status read buffer length does not reach the payload
> area, no scatterlist is initialized and zfcp_dbf_san() is called
> without payload data, preventing any access beyond the reported buffer.
>=20
> For valid payloads, preserve the existing tracing behavior by continuing
> to initialize the scatterlist and pass the computed payload length to
> zfcp_dbf_san().
>=20
> Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924122400.1185=
067-1-ajaykr@linux.ibm.com?part=3D1

