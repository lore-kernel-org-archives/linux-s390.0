Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE53D5C2A;
	Mon, 20 Jul 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540908; cv=none; b=q8BrJb1ZDZBWmXRjOTLcN30wtK1/IJMxS6OrCELXkBRxWlUbMT7imBczZbuOXkiTEoxtVUY6eP9e9zSBgB4NneawYLkYoB1vl7JxJYBLL4BzIqmNdHjYqP8I/U6yg/mxsEDSns6XAZOq0mTwZRuXBqQa8XziWEu2vwDsIBHVV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540908; c=relaxed/simple;
	bh=gTj+XWANGNhUZSu/Dp0IPF9bM9sJh5nLCMHKDM6Ntjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCBwpEzAukA/jwccTURB0UPkDXLE02kWtIoocHuhOkKrFNVFBggwhbXvelmVovRwL583ncaRJ3acKGN1J0LcaSZoPbe6UEYacOG0sZW4m4C3Dx8gwWbJq+DXNB5MaeQ8y0yh8lvaqhIFAsv8L8A6ULB+GY8ZZBH9nh9/VLuugzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC8hrgkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC8hrgkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26661F000E9;
	Mon, 20 Jul 2026 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540907;
	bh=gTj+XWANGNhUZSu/Dp0IPF9bM9sJh5nLCMHKDM6Ntjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gC8hrgkzj1S8WwPT8L69LkjtUdqC8Uu/T+D6uZzA7n7gQRb7tNM4BWnV7h6Zmibni
	 MqoDt/4DCDs/EY3KYp1NEfAdqZXKjDGmyyr1rXyQl+G0bbr7N7RL/BONQ9QvaI2NyP
	 7bqvB1bRwF9QvmC7Mxq2Yst9tKesTrDZ//FN+9lUmKzYlciHVa3tlcNw6kTm1OKOHR
	 2bshiRdXXleNO1uAnzYQ+ok1oA30qF4qdTMwgRdF8fFIxLxd5d9EbrrWOaAMvdq8mk
	 0pS2ODebxo1jt8FYHF/E4pJ5X8o/cRjRFbkTFyW6CSBpFZEexIYat9QfnOZBPSk6tL
	 c43SiM9yYaFHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] s390: Add support for DCACHE_WORD_ACCESS (again)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720085834.898025-9-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:48:26 +0000
Message-Id: <20260720094826.A26661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement load_unaligned_zeropad() and enable DCACHE_WORD_ACCESS to
> speed up string operations in fs/dcache.c and fs/namei.c.
>=20
> With the secure storage access exception cases addressed, add support
> for DCACHE_WORD_ACCESS again.
>=20
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D8

