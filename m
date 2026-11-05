Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907659;
	b=ZxldOkpqy9b34voZvo96EsaEe+IiQ4ctB5ECm+bCdQN9WN31LgXPwr7zIGH71KPcjZkb
	 xaGPHa+55YNzMHbJbCTfd54cJ8M2nwOcLrNpuR1IULdZlQFp0NVQOfZxQABgFVuDSEQom
	 WFkffB+ifPKKApgjbUf2vwAFOPIoQQpHzxiMdUm3K6TJPQ8Z8yvQ4V/gwlhh6XZXaVg3j
	 fSX7GGZpxAwbs48hGOFp80MhrEUc9vPs+XYXJpjWi7pEs06r6j/RBNjbJTjceZ3eq6+8b
	 wZyTXMKYi7if0lFmtiQ6kh4vmoJfmeRh1L2fDtC4u2tVETpeHh6TEOE9/VQZBJ4MSLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mw8qDFduLLS1bt2eiSfhGMmNq7dKso+OpUDZcSmS2OU=;
	b=VrbYyTt3V8lrbhJzGd1jiWJa1QvZYmpNhrmaop24+s43O1Eu9rwYEmiMVkwsKu0LeB+4
	 2affbni5/iFp7nUINSN0ZsQH8iuAmMrCJJT9BLQ2g3TR8ObRbvCMimlfysHQmbwo913Cy
	 Gv6aebXGCjkBvBcNeSZyZor6THkZv35SsEQ8atESlFdoHxVVOTfE2j6ERpHTsQL5T94pn
	 xlsnK/7RvNUO5rlLxughfX1TECa5oycE7zDUGfL3J/D9theOzK5e6UHfYhz83Dx2xC9kh
	 J8veXFSvwYr+fZpw5IsfyXbG/wYfYmI/XqWch5RVup75G3wxmAJZKHBQUxrLPbSQfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDzrdKQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628960818F4;
	Thu,  5 Nov 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDzrdKQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4771F0089F;
	Thu,  5 Nov 2026 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907658;
	bh=mw8qDFduLLS1bt2eiSfhGMmNq7dKso+OpUDZcSmS2OU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDzrdKQ3blCzRqGEmJqotIYCeVd6D28Y1QMN/+MGsrpVUE3h4O997wKLWlQc46pI2
	 v4WBLyFCURzNFRYmuafUbKRe6hMFjiGk0gdTYVFE0rnymMFVHJbhQw6P23s41VYjDF
	 anfjrbjA3lraUnZfEuNdSpYaosSE8Y7svHdAWDZEvDCDqLQlWE43Ztag8bw9SUiZlx
	 Jlwxz+E9bTRY/XaseCkTjLwA+zBSzv4owvLuOw2e/GN2HMvSQW2g6VUZSLRwbsBJGa
	 Z4cHM94o67d5EcVxFJ520Ic+J8fbBXoLDG6i906f+/9dcfKtRXtDNNexMXzZpCY3iA
	 HayZ100bkryLg==
Message-ID: <sashiko-outbox-199968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_ring: return an error pointer from
 vring_create_virtqueue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:40:57 +0000
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
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193426.2999=
631-1-stjepan.poljak@gmail.com?part=3D1

