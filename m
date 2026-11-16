Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828329;
	b=qG3JsOsjvgK1Foe9wTboHnJuw72WRYC3mE+sahvZugIHbzmbr3v5oeO0I+QuQxcgBMnh
	 K/YeeaT8JHsu7EAcs1LSteUGVChSFiaLBTWV/ngNvELvcEgtY0K0FA3eo0QyB3lh0RKLe
	 ccnvd81H6R0V9DBor3rd/2hpzugi0uAJtoUAcZkyQDtvdzNDXqUNjfupYOGFBh8CfyE3M
	 U5ktOS9My4XGq/MUbsx9/ewnw18oqYUhsDbfeJcA7AVETYNpIlCqYtQ5brvU9IO+QqxSG
	 eUqg+t4FGDku50eFm2UynDwkt/sgVCjkEo99fqGyaLv2cdVfp0ZjB9xwOFBle1SGIug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M9u+vhR4NiD7L9ho6Zrx+yJ6Ni1WDBL1u9UzfZwFoDE=;
	b=xlANEf9nCoyQBnhoiV1z0Y/K/drOYbidd2Agcu9otiU7+DFCsXVlViDjLR61y9WwzaR7
	 b1cWfNRJlGCjPjKSEaWKP8AXOVQkdqPxy03B5K2h6OoQJnO26Jz7wq6r1B9Cj/hmfPZhD
	 yTkIJfR6yluGXnIa9YVWKAKWLBtF5+uwi3hyYLN9sLz+5KHRkuYo9EcybSnfo7hmGbH0s
	 ARgOy8KFFSq0M9tZ1jBZ7Su6ueUlH2gSjFYyLAd+v/JqfvdgDcm6sjj7XfR/jFtnFwxrI
	 DyPO8WOflrKQ1YhJfkCgo9PPkBPiqbMPDyfnkPi9GY1vFal7h/IjtqAAoTUyAhda6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSnor8gU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40199606A886;
	Mon, 16 Nov 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSnor8gU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4421F000C4;
	Mon, 16 Nov 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828328;
	bh=M9u+vhR4NiD7L9ho6Zrx+yJ6Ni1WDBL1u9UzfZwFoDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSnor8gUv2jUZNNxbQxus3zLEO/QPeZJw/+kpQii4FxwER6dPBqpANQjMiRvoZiw3
	 c3xspK/c0Mu5JjwK1vDmV077Bfqgeg+OP7zjgecqb5EFfN6B9ci/xLAIFIezCZQ59h
	 mntn2jXiDqjxA6WgxHDy0/30uBp0dZMYlMpfYCXETseM2VGDfrQnt+SxH7Mjg1mS5V
	 UW8o8S+zgfhb0REg4046EufjsVkS6uSzl7CN/AEdQFU/vmQ8r0MZoXhc2nUpNWx0hf
	 Nv1nd0K3MnCj8XrjoveLKdspH7UFCIKhNLsVnrKL+mcbkI8VqjD99qwDDYKmE0ZNUJ
	 mMi9warfVUasg==
Message-ID: <sashiko-outbox-216916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:25:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct an=
d async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D3

