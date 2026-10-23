Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778492;
	b=fZf+SuKex/vQ2gKI4nVhNbYK2mPZDJ3nFT0QnwVDST86O/uppqYhty7jX8yry2KWxz2I
	 I6A1wY6DtWXRs9z7u2bPfkVH02nffFyEuVwaV4gcL1SfCzaVh89YP9I0ErJjrKADMt4vw
	 l3v9phVsmZAVwNsYnufU8g08gA1oKca/gKOkiPcSL+QtrF2jzSzqn/oUuUWoiF2gJ7xoH
	 efiyYoM26c5Y/b3p5GG70mQhHUmNkkUkWCp0l1vEOhrXy8yp5QTgLZX1+nStoWd885Dys
	 NNt09wQXvTRQeZeazHLKGwxP/9ACDK90BfqxxygviDRL1i+vRXkYL1i57eFY3WEHOzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RIXTXvPqpbfjD93B+N8ScFjW6sm8IRN12uDKKZnxoAE=;
	b=Pj9kVszBJ0hQXa62NaBXlKQBJiGH7eBhXK6X339FpUGFBrrpRI7qxptK/nE9/QN/XaFV
	 05lj4QNpON/XjZmone7q9R172bTH8xw7NzJMHBcjn5UNgpgnw9ZjIyxGV0GvPPrLa7WVo
	 yCHH2P08NK9Xn9ZjxE+CaArebcLUjRkaA+RFywpNw8Q2zTTl6fDGK8Q7RXYYadYKiprv2
	 obVvcgnGTp+8yU/kq7g/wvkVXfj/I2oW5G/iGRTLJKgemllfE+BnmwtIeJ36exGhDnqCZ
	 uDRpGRjiqLxQJDVLy2ElRtRvgEkatZVqhRDnT3C/wbuHhULxTNMSCY3Xa5MJB5zJ9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAdU9s7K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE118606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAdU9s7K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8251F01825;
	Fri, 23 Oct 2026 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778491;
	bh=RIXTXvPqpbfjD93B+N8ScFjW6sm8IRN12uDKKZnxoAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAdU9s7Ko6S6gW+1gZBseTu+VuNvtz2LvzMS0yiYpjhUPfqI/o5QPY2+wQK/SzKD3
	 mG5Pawndxu8bbQPdSKbkOk6WNeIvcjHKwn2CaZr+w3eBzNqdkXcHEme0Lh9Oh7zk8t
	 FPthAL0Jys95GHcArGaAuaUoqRGxb8P0KdjKuWBgOcuTcuP8IDHbDJLoixOSj5Fxfc
	 ytlpN6Cd/YUatmkfY4x8IyB38dWCyH+dL68zN758rvHDgw459ownWOcHfriZGwXbjQ
	 N2CDviNAa7BzI7RA4CtxC/XZlUBbPhc2Ovgk0Bry1BPYZV2tj9oIL3GUoyYOAFjjxW
	 E1keiuowNkIxg==
Message-ID: <sashiko-outbox-183029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-2-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:01:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D1

