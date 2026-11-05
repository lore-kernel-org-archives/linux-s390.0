Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863009;
	b=RW3N761Uiiuj6XH38PxarNhp+shBJxSKG1eMX7B87Z+O4ogSTRMaZjbIFkZ3rupquBFb
	 0JNqNKOi/wecnuP5xAGzAPSsElRDw4/soJIU/u6vc0lFq3DAiIx3hSZDJiAOQbN07a9hU
	 MD85AmuzHVHxZGPZJS6B4e5ZqelwWuT4gwn81v9K5qvejdcQxZSl2qMaJaBnNDCT43XHh
	 V1ZpOxiKN0+1Ue2E7uW19Z7+exFj9xa2MG3sSj2xByW1u3tFinPFGc8yTcRK7R9oKVOcH
	 C+0385hP0/nmZztt2NhBZhM9qf1xMIyZjV5stJNZV7YmqoQB0OlNRIZeI7o5Kuk0b9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4T79UX3iTHetG50EeKrLgNSApx7YdWeZ69MgrJNYA4I=;
	b=rb6IHhMoee6zAnjZbIwXlVr8sF+X5fsZatI6mQoKJClFrOYaaOEP7885K3WMF96EIXwQ
	 614v3qAZIwUDQ3XkLsTXysUR8+foHoAC35uQMCTpQAt+HPYg+QgSo4wZkvwVWwMfz/XsF
	 aC1SF239W9c6wTrtxScExEhvUYCIKdCO9kLJJgBaT0+Q5CBacKgw0tztCdef/3esmm+q6
	 zf6S+8h04mhzpVCy8oRwzRnB6033D36jmlX372dxRmjae0+7vGrKBx75d4Alq9U9SpJbV
	 /No/gWhCeHgXV4SKTvsNCk+traiyLlSpwvCTfbyjB+4oPlhCvNLP9Nmn5fPCwC0lDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi0MZmiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A3606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oi0MZmiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7441F000C1;
	Thu,  5 Nov 2026 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863008;
	bh=4T79UX3iTHetG50EeKrLgNSApx7YdWeZ69MgrJNYA4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oi0MZmiWRmkl7++r9dxusDfXpABX6lnK42bFO4TCZUrwPoSsJf3JvqqOm8pb6l9rt
	 ZVvyLaQsHu3opYXzujHwoHMQ6cLuGNGh0FqYCi1WrXPlkcdB9r8MOnP6WefFySN7i/
	 A5Mtbv90bAhM5NM2t2+99lT5zb+XUK5fTolRLf/2xxcgsZK/DNzbDAbmf6QDB7GBin
	 4tqOj0EjPc8mK+el1L9Y/58wvo0amljvtR1vqH3+VfvkTTftHBBGAq0Z9cIObF4UxT
	 EhnLo1/fgDuTJ8YqdXF+fn0iCQgmE50jQbYi+1ETYs3VhO6wOl1K2i0liQKSLUFoXs
	 Ze13meFb+vLJg==
Message-ID: <sashiko-outbox-198651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/mm: make
 vmemmap_populate_compound_pages() static
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105061217.13302-2-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
 <20261105061217.13302-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:16:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vmemmap_populate_compound_pages() is no longer used outside
> radix_pgtable.c.
>=20
> Make it static and drop the unused dev_pagemap argument from
> its only remaining caller to simplify the code.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105061217.1330=
2-1-songmuchun@bytedance.com?part=3D1

