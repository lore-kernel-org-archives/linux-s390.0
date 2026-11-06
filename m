Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944898;
	b=5PX5fEURVQ73FZJM1sQkaU1CDVWwhlWo1ExDZMMknOCoUrhCtOA+Z3ksqHBDKkJ5yPVT
	 VzuVMSeE/ia4qppwpqx8WwhgDx8J3+OXtJV2dWFBnV3L6xrR7zMOHXeechl1qPHMxsUsd
	 mw240VLqiYhtFpci9BIfqOYQBfW91Dk/vDkpXQtJOYF839jDUi7/h7gf/bJaZwYQRomcx
	 nYqtLBCj1dp19kiNB/uV7tH7pdH8ZMl00LR7seYFDfUOD0Ov7JdoSU9A/AHHCSd9GZwxg
	 J062K5x0zS4gMM2Hu8sbiqiq29fik/dM4vc67cCjxlQB7OOrkuxl6P8D2vAQilBpLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944898;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NlQCs40FwNKAbByPu6h2cMH3p3rYrxP2YWbZTU36SKk=;
	b=kAxcuQcxYKOSSXwdJORRraFDsThO2MJ7oyWKHIh3+HKrUUuyB1CKtCTVeQ0+zu1tqlI9
	 8vzSBu3U8R0Ax4r5oLLTXlEV/7Y9BldqlFCcLe6Vm1f5jl1ogh/An8Go7Fr+9ivRYceAa
	 /Gn8wuu4SGDzK00qp6z4XRWHiGBOHiKM6b3seIHGAH5gFsbiS/+LsX1x59uszxTSULWRO
	 uc7TzKlSwTxhel9gWzQHOUdjaRSdw1psVRMjMxoQu8rRKY75tZg1HjXf6TMp2zS6ZMYwt
	 uINwwBAcuZ0FbNqamK8gYN9VwymCUsFW5nTOSP6K/jkzaPkLwPXjGJ8ndoeqdEKXk8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFigH4jQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718C606A326;
	Fri,  6 Nov 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFigH4jQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8C81F008A1;
	Fri,  6 Nov 2026 06:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944897;
	bh=NlQCs40FwNKAbByPu6h2cMH3p3rYrxP2YWbZTU36SKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hFigH4jQJJUD0KOnwbVuROkobes2mzB0+VO0elHUXjzOJ8G+8aTdpc4n37mzFZnut
	 Hf2RTW6qZOmalOD6hhfNvwbPw6JzyaYbqfXSG1EWFp275njIUPRbgcNUQpHxaq8+9s
	 d177Ig2WHraWzmHEGG+jfV9OmuYS4OMxXdSzzQPkdjvIpvXQ9A9EJ1yEYurZXjv61t
	 BeZS2lq2gZqw28kT9SaIbzcjHW8pNO9uasn2RHTzvKJ3kXTokmuMOuvCFBOxB+SzKM
	 LAiYP1MyuN+NPjaZnSslKuj4UpTx2jzqUHvBelFk2BxrFX8Q8rtn6X/VSzlXr0aP1a
	 j1yYoVC01lHfA==
Message-ID: <sashiko-outbox-200877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_ring: return an error pointer from
 vring_create_virtqueue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261106055635.3019889-1-stjepan.poljak@gmail.com>
References: <20261106055635.3019889-1-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 06:01:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
> on any failure, so the error returned from vring_alloc_queue_split()
> is lost and turned into -ENOMEM. This is especially misleading if
> vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
> queue size is not a power of two):
>=20
>   virtio_blk virtio0: Bad virtqueue length 100
>   virtio_blk virtio0: probe with driver virtio_blk failed with error -12
>=20
> So the error points whoever debugs it at an allocation failure that
> never happened.
>=20
> Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
> or vring_alloc_queue_packed(), or -ENOMEM when allocating the
> virtqueue itself fails. Make the callers, virtio_pci (modern and
> legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
> with IS_ERR() and pass the error on. The error path in virtio_ccw
> deletes a non-NULL vq, so clear vq there before taking it.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106055635.3019=
889-1-stjepan.poljak@gmail.com?part=3D1

