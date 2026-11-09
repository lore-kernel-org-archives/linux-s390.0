Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215123;
	b=a94ATBub4IAv/agk3j6YJVt/6NYVH03sVlQ0SDtz5VwaepQxTjoVQcXeCxYyhcN52fsH
	 x9OQ93DC49cLCWjj5MADQ1aRnCFez6lFcIBxpzVBPf2zff4F5bhzTm0Fn8QUN5fqLrY7F
	 IOJuG2nHKU6jVZFv6nJNbr4YiSVztt1iEYU3Y6PhGHXb6DqHK56A03kQ7ICKWDojRzcCv
	 7/P7IW8qp0obF/ykxQ3nSUC932FUD0SyIJZUPBzJtW+GBXt7OwD/XvvUVyov4naP3fbIv
	 GRwvZdNCwE6oUwAbCRS5vEG3Jk51085SjlVx6a+SLH5+L8OaVYD7rB6f2KoCLK8OJAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H1p3YLpb/wk0/aNRUDabZKCgA1VJQWjgD/dPjUaWfwE=;
	b=JMPdE33ikS4PWkzkkz2xHRbTv+LkCCZgULtNMisRcntk/GqXRi07SkHwTSVkO0V7p2z4
	 GnY8iwxbW2DmdpfXdKXYOikaF1PJ49C0hNWZecluv6zFgns469tzDvN6aYkY8MNS46wXR
	 pBbk60iy1F9REYxxS5eEsgaB4MtODTu63HiCljaWx+UY4VqbPE/3ja+BdhPkkSL46+oFT
	 mKAcuuMowBdnIUH7JHz8Q0+eTIXD6609NhMLX84oJGgHr4t7O+CeeJjzaVNAsf91jH2Fe
	 x4hd/lLgaT2RCB5L6TNih8JYbM91r9Bgs3LDYrCp/GQGnD0GDL05FbzSRBCvMQ6sFSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ1g8AtP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E6D606A323
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ1g8AtP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF05A1F0089F;
	Mon,  9 Nov 2026 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215123;
	bh=H1p3YLpb/wk0/aNRUDabZKCgA1VJQWjgD/dPjUaWfwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJ1g8AtPbJ3PH8c8v8zI//4z4b5X2NGK1BVVh+eOGZK/2DBr0eaY7xwweg/OGGiYG
	 q2QnbFybul6lgtGqXlZekukf9Iydml6vM9wJ6xM5yIe2zHw4hRohyglZw8512WV+hK
	 5j2bJz7o/PfQg5zS5ZlnJvEkrTnDVKUP504JNPJ08T8HwIDxy5DTFQa3jCY/PCdlkQ
	 WuGyzSpzgcJkQ8eeBCwXXg+hlG332meu/IRh/OD/bkDbIq7EaDHmhb6OzbtNRbHhTB
	 g4RPmjWzqgRfEELU2hgTyNzIDuPJHceDeqq9iGrbD3raenQOJgqfJLYy+LvwXyiW/V
	 aIBkEu0JK1OUA==
Message-ID: <sashiko-outbox-204658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/14] s390/sclp_tty: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-6-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-6-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_tty_init() allocates the SCCBs that are used as the output buffers
> of the SCLP line mode terminal.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D6

