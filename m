Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048F3CE4B5
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851340; cv=none; b=IRMKN0cCTIA6ClBhFxQdtvBQQZCQObUkuJ6lzwkWto5IklyxeyOSaiEgFc1Owrm9yJqzYe9j8biAnxJVGz/oviwmiOsClGl+4GYJCRWyxPVe5sNmlYosPFletCyEFBNJvAznmNTqf92dnZQs9I5lfsQbUXDuWGOni4DBWNejCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851340; c=relaxed/simple;
	bh=+cKaf1PfiVDXFTxrDckgojKC5GSWY5Nir0Ufb9CnyRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jeelCu2wF0HRHyUtLx7naL9xY4F4Q0wHZZsHg5VYn2U/zr46tbNKqZk3UG7ed8mnPU4uwRE5NA+nugi6CL5wYpTC2TRghIjAaXrQBneHRtjg0w7U2jBdSeNIv7TMzMhH/18lgATl2xjOV1SGNm4nwIt0+70hYrxazeEi8nOKZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAP/UC8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAP/UC8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3031F000FF;
	Thu,  1 Oct 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851332;
	bh=+cKaf1PfiVDXFTxrDckgojKC5GSWY5Nir0Ufb9CnyRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAP/UC8iEY+tbwgi+gUgL0Uwcdogdtcerb6YA8kqo7J+34YPl0jlTfSZbwbArcI6b
	 p4Imb+WX5emsM+lpMEZPONWMu+tyfseL6CfMuy6mLfNUwmQ+YN61Bxk48H/eB2hk6l
	 IxUZRyQYLxUcqwFto0DZq/H5CxsZHJDazY4Ln+ip/YTH48jLGfU3Ur405snidQgG/K
	 /hKwhDvZU/EZ/tS2HhLYilO+uYJMAueyT2vLeUUHZGNEBStN2cKtM1tUcvSObfhsbP
	 i49OzQftx3M95+5Zkr2vXUDOTanTVypqcGpg/kib4pI5IJdUO635cl2uBp4gzFddJ+
	 p3jJFEWMjfqfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/32] s390/traps: Handle nullifying program checks in
 get_trap_ip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-8-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:42:11 +0000
Message-Id: <20261001104211.CA3031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> get_trap_ip() always rewinds the PSW address by the instruction length
> from the interruption code. For nullifying program checks the PSW
> already points at the faulting instruction, so rewinding is wrong.
>=20
> Add a nullified[] bitmap and return the unchanged PSW address for
> nullifying cases, or if PIF_PSW_ADDR_ADJUSTED is set.
>=20
> No functional change for existing callers, which only deal with
> suppressing, terminating, or completing program checks.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D7

