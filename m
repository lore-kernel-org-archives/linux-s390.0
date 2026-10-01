Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690E3AF644
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851520; cv=none; b=bC/g1RZu8+ewzo3SJKjTXzqDQT9U6IhQtTWVNBQNklnqXxejhvXfdR5ALx8HgLSC87y/i7EwFrxC8Le5O7HKZkcKyx79OLp7EzBcSId1OR8Yq+OHOqkn2G6KZTJSpny0ZewlVUdmoojuRCvyA5tvAhqy7ZmAECX7wkc+XYr3Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851520; c=relaxed/simple;
	bh=FK/PR3wEtunPJSIEcmXY/Q/4lXrsmyx6U8/OuPB463U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhjfxZ1fd5JnmYd6CmTQXIbgFy8Cb3kBYLeZQ9M0dSrX5xZhygkhGcAyADL1YoKqE4/v4/iXP2Pia7NF9gI6AnAJ9YD2UUdiGbzH4bwzcYvNlzNerUh5h2fd1E8F1X6Kwj1sKCxyurJupFbZQwGOpC98DWfg7jxZt1L0nSH5X/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfgZKPXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfgZKPXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60ED1F00898;
	Thu,  1 Oct 2026 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851518;
	bh=FK/PR3wEtunPJSIEcmXY/Q/4lXrsmyx6U8/OuPB463U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfgZKPXSrWjjxekruMmvKN1/8CvDBU2SvLK3WztKkYszgVa/3tFEkyWcaNKAoCOZz
	 5HXx+Mo89SJDO5lNUZ4rldKFs4rkolp/ncdvZFQXdDx90zgLrKGFIYiO0Veo84+Lb5
	 w2GFxkfV/aAQd5zIrtEmDcpkhS33ktq0dV0yiCcv3Dxbyx1UKJVnRFrNYyDmcIVwIQ
	 1o+EqbFFPH0w6rkK59iujMQTlOCoa8OrDQhrCrzDKq8j/9vGXzdFvsCeQKr74f/77f
	 KTO253bPLiJa90W+JHX2C0fN8z3GU8ikqKh1kztqnsTg3fB1sdZzMNaeFv+Skm6B9t
	 uM/MUkfFxMM/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 30/32] s390/sclp: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-31-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-31-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:45:17 +0000
Message-Id: <20261001104517.D60ED1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the sclp_service_call exception table entries to use
> EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D30

