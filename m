Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33D1E2614
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441399; cv=none; b=an9QRCsjbq9vm57zjP3yekw8FDCmUtdAU7x+3E2Z4bNeQb1DHmYCkMhpDfxGDCwYqSRAmhLK0HJrqsnOj33igK/bw7gxUZeeF/ZQiWWwb+6LmBVMTzQgv5sgn2yp+GFVlL/gEeGGjBB7pIhnUrA6xZHtGRNDZt02qO+SwIkiLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441399; c=relaxed/simple;
	bh=sERV9Y+WgwDHq5t/cKvBuqtSDYed2mzU548TgL/FLBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okkUe5cLK0yv/9SWK1ojRojpt2winpoVDruc4dq7L7QsBTZGb6sR8m0XXVu0UQoiVmrzYHidfQE/W9/wOam4Gck476qOlj12UYWIetIskeJ3P2OhC4ZNsvTi4aHG+RDS9c9/XlnVXjkICqt2XMT2+eEzPCI4jSQ+l8lree1a7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duzJOIcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duzJOIcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ECB1F00ACF;
	Thu,  3 Sep 2026 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441383;
	bh=sERV9Y+WgwDHq5t/cKvBuqtSDYed2mzU548TgL/FLBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duzJOIcW7wKm6+dWJr/q77RD3sv54epfWyI3RaYqHQsDwzKvHr2Kud4Tg+RDdswb1
	 kuJVtoiB3M01qw5tk6txn+CTMmV0vWJ9U1W3ERMfkkrTwROGixyGCeK+SrBBMN/hbX
	 UgMhar6XgdaI9dDtIIEJUx/CEVPpNZBBk3t9uQTnqEU8+zARbO0zU7jxKcSYQjM2O2
	 rCPBsoAz2H3xpbICnE3BLCPBEn9lk1hRMQOOo/ZGtbGRefaC71Wk/nC4Q6vBkjJJiD
	 eXwYqfr04J4ac0VCJHHhLuSUYJ4M9THPO8ipspsmOg3vGxiM11GvV3f1Gp6FsPOdFC
	 jIMOZeG+vbDPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] s390/debug: Fix NULL pointer dereference in
 debug_set_level()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260903130733.709001-2-zaslonko@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
 <20260903130733.709001-2-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:16:23 +0000
Message-Id: <20260903131623.A5ECB1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a2cec6863709 ("s390/debug: Add s390dbf kernel parameter")
> incorrectly removed a null-id check from debug_set_level(), introducing
> a possible NULL pointer dereference for debug-API users that put
> debug_register() results unchecked into debug_set_level().
>=20
> Fix this by moving the check from the internal _debug_set_level()
> variant back to the external debug_set_level() wrapper.
>=20
> Fixes: a2cec6863709 ("s390/debug: Add s390dbf kernel parameter")
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903130733.7090=
01-1-zaslonko@linux.ibm.com?part=3D1

