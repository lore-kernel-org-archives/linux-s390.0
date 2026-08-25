Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63C3431E6
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674675; cv=none; b=YDe2CRATk1F5RW7Ze9x0j/+xa/bFKqSPgIOQIP8r8JbOJZWEMInpOfG8d57DgsEDBHluFgFicJZZFu5Zt1h8JB2fETmJgX6fxIMs/JqHguXK7yc8UPigo3fCepo3VbNsBS04sjE/JzK4wO+zqN+ICr3lIhkROas1X+uf/KTwt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674675; c=relaxed/simple;
	bh=K+JFepslZBxhih+AucNjs4oS46pDP1aW8l1n/6EyTIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4u0/685kadtklKSrBcaQRCWAEJd/Tv3Tw4XT8R9tWmOgzPhXUIM/WnjC1qPLxq3bJAybRzs0I4y+tjUKUOhFqGyPqOjdHplfcydHle9drsLU+7UaIfoemMGCziJ+QDe5dssfkkboKrhC3jzLZVVrDNStNcDd5K/S0+maSJEPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvPSHb/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvPSHb/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5181F000E9;
	Tue, 25 Aug 2026 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787674673;
	bh=K+JFepslZBxhih+AucNjs4oS46pDP1aW8l1n/6EyTIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvPSHb/jYeVhMcyuWpvjnVTrrUyeTGWaICoYkKMq7zhH4dHTh8dA3c4WEGcP0j+1m
	 CMmv69xDFBKFQ63QL7Ir8TN70KhCxLqPQJpX+HgC2AQpm2CI0+rYdPXKK3c6Yxv/Fb
	 Y8h/eD5KQ9VcODpSG7cQ5BkuD7dAO5+0FcA9uKVQEjIfDFcvM6GVMMJ9pbDR0oSYBd
	 LK1TVK8ku6O+ZImz9ImM9tPIwR8zGQueJnAaHWnYsTlQ4w28HVBORc7tQOLbO9TmdR
	 Kji3sK+Dru43vqzehyRv8vqGSN9OMgS2LF52KZmCdbf4H7WRWy+d+DS5TJwMnVKGYh
	 CpG7J+opgpqBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Fix uninitialized padding in CRT
 key structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260825160154.106501-2-freude@linux.ibm.com>
References: <20260825160154.106501-1-freude@linux.ibm.com>
 <20260825160154.106501-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 16:17:52 +0000
Message-Id: <20260825161752.9D5181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The zcrypt_type6_crt_key() function leaves padding bytes uninitialized
> between key components and the modulus in the CCA CRT key token. These
> padding bytes are sent to the crypto card, potentially leaking kernel
> memory contents.
>=20
> The initial memset() only zeros fixed structure fields, not the
> flexible array member key_parts[] where the padding resides. While key
> components are properly copied from userspace, the calculated pad_len
> bytes between them remain uninitialized.
>=20
> Fix by explicitly zeroing the padding bytes after copying the CRT key
> components.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825160154.1065=
01-2-freude@linux.ibm.com?part=3D1

