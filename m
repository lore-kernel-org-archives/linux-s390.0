Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3D3F5BD6
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851270; cv=none; b=QcFytcZ4E9Iqaz/MxHSDsR5H9PfcExNyY221kekXfXboWRVSNEDozvi+KS46CMXn8zoc7zXN4INdBAXjgaGafLXL8ljTXIPMu9C/Q+RaTu2UUdlXVFTjYGMPBCtrO1ImBmQx1WCrlvtwUGesneQOPfT/GAwN5yN5XN0gYl3wmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851270; c=relaxed/simple;
	bh=Rqn3rJ0Wyr4yzD485tKZpXIjqMeV77Y6pUb11xlU4/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/DilG/d1Ya412vVP0uLyfwnM+PPyAg8jdtfTHLiv1+FHtAf3L2TIczbJRkL2sua7H1Vf17KySMHFCWuRwuS8LOJdXmt3WYg6RgFAR/Tcqk6qEwqvRvZzC3H5Xx884jWTl5i4x6neG8KGZ838LD36L9CjsrITb8H4JsPAIYeYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlCO0Wl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlCO0Wl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B61F0089A;
	Thu,  1 Oct 2026 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851257;
	bh=Rqn3rJ0Wyr4yzD485tKZpXIjqMeV77Y6pUb11xlU4/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlCO0Wl1sh8oLkApNQxyzDol9VLhcuBP+C5fA6CLcI9FmcuxMA0W9kanSFdf87E6X
	 WLTQX4T6OFpvb1/sq2JuPdkF7wmMR5NOSjKz3PU2k9g//uSSIsOJjnBfOfQnWIJ3Fz
	 WO691wRI0A069XaW7rcjjOItctCD5ZOkuPIHfelav+GQV2CXsdszWpBY8yw2ybsFmg
	 FPqc6b1ECRmcZgYOI6Mmd2aQlOBLT0aickdiqgPD8XbA4YMNJKbfOkeMrXRTtNSb3e
	 bfHA6iZu1FLJhdOl3RWE38hkGlEWBNLZ6uq0+PQkMzrTs5Y6AZDCGxhiUQV+4ecm4N
	 7bw18DJnB9ZXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/32] s390/uaccess: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-12-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:57 +0000
Message-Id: <20261001104057.911B61F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all uaccess exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries and nopr padding are no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D11

