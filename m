Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF00384CD4
	for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061998; cv=none; b=j8Fe0H+2eunAtr31QLpvODjYsnl/ylqMQ7mMOjOlrIaO39eyzLxfeq5qPgOalulgVMahNrfLd46Tu9ZHyoY+vs2ggia0TKPBKo/gC3SZOVHIhPampGU1U7U7CAf93D0aMcsdrT5+tKvMrG3du01s6W0r39zinfjXnYOjYrYSOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061998; c=relaxed/simple;
	bh=a1oYN7dc4cyyVg0v45G/XH5EYJ1MXe4P73X2uXsPqMo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JWuOiJ/dUQExD+NWHMRWhxVRqL2LZU2SLllu2ry0LIPqnKLRyFqjhIP9+uDAyLBiLk+eRL5EmK4Sxf8rOBN/IATmH1ifcaqBQ6qEdMFfCXaKpiTY1iQ8VnFZ3wzzR17fZq3AzfhiezfpOIhTuKHxbtLLp11sqPx/4HcAK5d2oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnA33Hci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnA33Hci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6391F000C4;
	Thu, 15 Oct 2026 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061997;
	bh=a1oYN7dc4cyyVg0v45G/XH5EYJ1MXe4P73X2uXsPqMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnA33HciDSxS1GZcSImAg2SSIYK2N0p5IZ+mIYvgUIWEufJITozfhyw34E21mfsEa
	 OR/QiXDoxiOIKKafYY6Py4CjBxZVQUbCnPR/wGXs453rJuOxEKWzcNr54XdYboh65y
	 9y7h9NuvbxSEI8D9tr214pMuMB61j/t4kmCmScinQbOIutqp8TfYKJsjzgUsPOu3rO
	 8sYubrrwV+M/Hi33N5PRQZIbWM2sF5TS/2vHtW9CDADWznzMpOT8VkCoOIhw/OnTBt
	 TarFohjtEjjteT1y9U3x7iT4UgF1SObW0Jr8h7SDpP/gMrqRAg1vAZl4Ln9vZwWlt6
	 QpqNfO8loEWFA==
Message-ID: <sashiko-outbox-172702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: s390: fix ESSA addressing exception
 injection in migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261015104822.77062-2-ggala@linux.ibm.com>
References: <20261015104822.77062-1-ggala@linux.ibm.com>
 <20261015104822.77062-2-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __do_essa() treated any negative return from dat_perform_essa() as the
> normal "no CBRL entry appended" case and returned 0, so a page-table
> walk failure silently dropped the addressing exception.
>=20
> Return -PGM_ADDRESSING on a walk failure and inject the program
> interrupt in __do_essa() for the -PGM_ADDRESSING return value.
>=20
> DAT_WALK_ANY is required in the dat_entry_walk() call so that a GFN
> backed by a large page (segment or region entry) does not return an
> error: the walk stops early but succeeds, leaving ptep as NULL, which is
> already handled by the existing "set exception state, return -1" path.
> Without DAT_WALK_ANY such addresses would fall through to the new error
> path and incorrectly inject PGM_ADDRESSING.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015104822.7706=
2-1-ggala@linux.ibm.com?part=3D1

