Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCA4446F5
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630086; cv=none; b=jER/xdz7Z0emBIopILorsAlJJEvQI9td/RiKCxUi3WbMZZNNI/EKYC/ZB+7P6k5W7Gb+DyGEraGnpsf6bCNlSh3CldX8/eQQqqgFiCgMM620bpiUdI9A7XYfjwhGiiyC/RucJweg69I7bJ6fkpDvmJcedvqMxt5Q7lJ8WpW3p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630086; c=relaxed/simple;
	bh=2WMn66SGzg/LHdMY5xULfzsuIbz+ecNBk90wdW4FT4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LyY6JOt5eJhbBYHgxZZu/Kt7HaLEnV/H+/un+R0/Tjwnl18Xbl1r1Or2KoYI3cTEt2PujI0CRvTaB0ERWPecx5/X2X2BRqr93Gjwux5b/FI9HyUTd/XofQ+ZxrBvrJAeybfqG8bvv7vvUNVjxtYp9AAZNri2RNMTTxgrdZ6fTFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keQHpdCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keQHpdCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207C1F000FF;
	Thu, 17 Sep 2026 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789630084;
	bh=vRUGkV1gcbRe5aQj4T9e2NRjKpbhwedgBGI1OLmo8aE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keQHpdCLDVP6Ui0W62zhqzaqNBbz6VlPQh374UyxXRYwl+8qFyCoYYZ2t6tuQWiVs
	 wguMQwHUvwoV/6OoFY083MCkAIa/ArFF3lOZJJFlbBrYsQAUqF8gboQknRSdwTlnpL
	 MDhiHOCEVZyeCbWZYYrGrSj7qEoJEOSBMrqtctATOGIJKmvRGa0Rq4Miu7RHKu9Hed
	 qYmq8IPYUssW8IQ0zyI8KxCfM5CMvQqX2/lsCXYy9sqK00i2n1Dk+vr50mEm+H6QdW
	 rDY5Iycr6dq5h98ONcDhQt2+7dyqu4Ha2m7HHH0nHRXH/IOkOyFmEx587kEWUqx+Kt
	 VFzPucxC+othw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/iucv: fix races in afiucv_netdev_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917071706.23831-1-nagamani@linux.ibm.com>
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
 <20260917071706.23831-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:28:03 +0000
Message-Id: <20260917072804.6207C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> afiucv_netdev_event() walks iucv_sk_list.head inside a bare
> sk_for_each() with no lock held, while concurrent paths can modify
> or destroy sockets in that list:
>=20
> BUG-1  Use-After-Free
>   iucv_sock_kill() calls iucv_sock_unlink() under write_lock_bh
>   followed by sock_put() which may free the sk.  If the notifier
>   is mid-traversal when sock_put() runs, the stale sk pointer
>   dereference at iucv =3D iucv_sk(sk) is a use-after-free.
>   KASAN reports: slab-use-after-free in afiucv_netdev_event.
>   Confirmed with KASAN on IBM Z.
>=20
> BUG-2  Locking correctness: iucv_send_ctrl() without lock_sock()
>   iucv_send_ctrl() is called without holding lock_sock(sk).  The
>   notifier reads iucv->hs_dev without the socket lock, while
> [ ... ]
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Link: https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecuri=
ty@proton.me/
> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917071706.2383=
1-1-nagamani@linux.ibm.com?part=3D1

