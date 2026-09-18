Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70B47124B;
	Fri, 18 Sep 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744809; cv=none; b=GPxt+6wq6g2msypD/MxVd/eXoUeLhx0WowuNJjh06noXeVthRPrhwvl0udicmQu47mFJ57j3r068FA8tmKlG86n6pVAiV6hToy2y1DjItcpXpHJCdPAnzZcnpRnjSfM+z07VSnHyebqfpbl2gmEO4oF7gabxzxKwq4V35V4Un5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744809; c=relaxed/simple;
	bh=Zbxv2G9NHKIgQs3Qj0mr/Ej3oFkIhm3IbgD0UfKwg4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwTpSsdORFumjgPpy3uPcfUtOp+HKf3zS/SwEwl5ucDPZYXWqzMX9f+ClT3fgkbNuzXWcNgZxAnQlBpUXRGtjr/WI5D8ccy4IYHjR/4slx3gka8T45FWOR8RwUXGF/kfNJqR+O3ltOhiDrNI+2Vrdgxf0piMhRBK1vthtcnIwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kofBX2xx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kofBX2xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397D61F000FF;
	Fri, 18 Sep 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744807;
	bh=Zbxv2G9NHKIgQs3Qj0mr/Ej3oFkIhm3IbgD0UfKwg4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kofBX2xxKh4YWoHcj8F376UR37ty42YKv7qFnGST0wwBBqdmgXflZF//P+3FSDY3g
	 BRE59uI8LbesxV9m9nrMOtVyoZPb/hU9m7GiWvhL8VIleE1NMu+11qFso/83ChmbL2
	 kqPaX+uwzTs48HBWbAhYhF8bR0eWsQsuvSLpcYGKXmvvYHFoPngcxRCST0oWeDmmrU
	 RmfFJjK4JX1H5A17qgb1AeYT+S5hfTAunKfgGOGfPCr3Nw62m1f/T1iYvzAC4kxY1I
	 39f9kJg9K6HIZzbMRizHKvdeRihgMkBAAKsaAFfc/EX2McIWs0rXRoQfWLGDX8gB/u
	 nfHTx3wEXDguA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/29] arm64: ptrace: Use constants for compat
 register numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260918133107.1042730-12-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:20:06 +0000
Message-Id: <20260918152007.397D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define an enum to determine the register number for the mapping from
> AArch32 and AArch64 registers. This allows for a more flexible use of
> the register mappings.
>=20
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D11

