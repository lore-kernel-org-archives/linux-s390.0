Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056F4B0E34
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578147; cv=none; b=qE9U2u2mMD3CUTZEKp4wna9mnignwlqn3njG8nT24SGD1GuA8iIneQsFhze57cEkGSCGSOs19sHll2CmvdtNeHCdYBpzETWUSi1WC8L2pagJ7MI7QAnnSDKVKwzgqcHwm5PLC13MTAA7UNRZXOJbZXabIEqbP8Hgb6YgdI6K2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578147; c=relaxed/simple;
	bh=MdDCd1Ju1WVqvxQmmDbk6jfMUTRvqmQ5b2JBdd2eADY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utjwB7lIcijPAwvZX3KZXspjSQS+/HfkTYgcjEAd9c7bh3bhyPWmyT5lQzRjEfmh2QZzxgXHk8u8UPfdW60DbR3/11zZ4QhLpIkJSQz+ZUrOshqaqdKVcB4vrLQtiRZBSWtOaUVrYOeNOD4U2ujbGBsIV0/iUVUKuoDmosdHUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOOHQGHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOOHQGHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9861F000FF;
	Wed, 16 Sep 2026 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578140;
	bh=MdDCd1Ju1WVqvxQmmDbk6jfMUTRvqmQ5b2JBdd2eADY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOOHQGHsT+44Lcbsj8BbkhIQu/Ve6RIRu7yBYsXlkPxN0xaLndcITP1wBrxB+KOCd
	 pHP6SKvX9/gbRYfQ0qsv7K5q2mUhqZBII9zsbf245KeX2gN/dmFmL8Z2rD7cyU7O24
	 l/1RekckfKDXvn7NAmM+39fW4rxx6S2l6S6xio4MIlfOi6F/AnOv0o2GuMeLbCnPkl
	 hC/KU/Y3LWYOS+rjp1bvE8LhLrwv2lN3QtB2C00OLqr5sba3GUz8lQDeTjqnor+Ie0
	 YUO0MbowJQyZn8xMvXynBIaWCtsb5q9hMXoetRtUpu6o61vzNQDojaksxb+Zb8Gign
	 DwsfN1nDSoKXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/debug: Reject NULL debug info in debug_dump()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260916165330.2309909-1-zaslonko@linux.ibm.com>
References: <20260916165330.2309909-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 17:02:19 +0000
Message-Id: <20260916170219.BE9861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> debug_dump() passes id on to debug_info_copy(), which dereferences
> in->name unchecked. debug_unregister(), debug_set_size() and
> debug_register_view() guard against a NULL id but debug_dump() does not.
> Nothing reaches this today, but add the check for consistency.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260910110147.96E851F000FF@smtp.kern=
el.org/
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916165330.2309=
909-1-zaslonko@linux.ibm.com?part=3D1

