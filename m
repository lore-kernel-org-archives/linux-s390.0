Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428510;
	b=bpWomTRT3MsEa6GZo40tEDViINC1c5nuyNFhh650fn1U7jFpedgKwzAqsCnaO9V1tLez
	 0Mod/RWPFhf6wjdAps9HCrlwIPP5vP1fnwnGeT0XyqCth7fkk/ASawese2vZsOlHqyCvx
	 tlotztdMD4uoG9LtcLyewCgcEJ3ROHR+ZdYQAPjUKZZBpXQBbFn7QIPaoTbiq9t1Mb4qs
	 QBshwprtSPz7A0+kKC4HJUfhTqhXCEUk6CMnmJt4gdF2+NcNRCWWeZLkh+aCHsm571ubr
	 rfP0YLbQue2g3PycuRaM9WMf/0AEvmIEuNzXU6a5MNdTzP4S2m1L/wKtoAvVmJCjIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h9dChQ3AzSqQzeGFTo9H73GU8OS30qLdLYafM7vNmdQ=;
	b=j2J46x2cM33WLgRhzpMUQgQd9MdGs97yQSMc4XB7vE0T7ijG8PcHUDNwePv7roVTpS1Q
	 rrM9RQQIn3QIQyGrlKRitXCGh5f6S/yYV7lQ5+7rGRgSeVaPGGmVnUcS1uYAfjLG+s2Jh
	 ZmngNXAt2n00TVFRRv3Sl6NeAnifIYNBeqNOPIVM+1YFHMJ3TcHUWI9kk8gLVwui9J6+9
	 0yMn/JbqsR92DqReG+sOfQQ8Wtjgag75Yyj094etw1Phq+sNycvMPl6SV3jJqcYWNUtPx
	 4HQp4xOGUIA7Woh+3OFktQQ9JbY4dRdzGyMOsFkDI3u8mob6sznVFRURtAd6kOxjNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NJe/abKx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83589606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJe/abKx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD941F00A05;
	Wed, 11 Nov 2026 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428510;
	bh=h9dChQ3AzSqQzeGFTo9H73GU8OS30qLdLYafM7vNmdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJe/abKxWF8DygZX7DIl+PRBqYHJWrhy/ye41ExYcwAwGUlWdrHY5msg2ra73391N
	 gEImi2XXtdMBhQ6wggNSg7nAtSpiDHcV+hrlVth7XOCV9nZpLgEqk4KJw9wT7Gnmpk
	 LYKSXF7T/y2xRZpbpTB/9R2gkvsajsHdivYrO84Ev/ygJl1eG1MNIdc6gZBsq5ndpQ
	 5e/3XdYgvbSvI81r8wgVi9DWnbfyVsPiB6z2YLgEzxXp7CL5M1VKdHeqDargvAnBvy
	 9OHQ10jsiFNNCD/m/ptxA9oWspWgWSZdZfhYjSAE48BJBbqHjiCPBtKEt8u5x+gudD
	 gL7BGuytk2x1g==
Message-ID: <sashiko-outbox-209642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/14] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-4-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:21:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides the functions that initialize and release the data structures
> used during live guest migration:
>=20
> * vfio_ap_init_migration_data
>=20
>   Allocates and initializes the object used to maintain the state of the
>   VFIO migration. It is called when the VFIO device is opened and does
>   nothing if the object was allocated by a previous open.
>=20
> * vfio_ap_release_migration_data
>=20
>   Frees the memory of the object used to maintain the VFIO migration
>   state. It is called only from the VFIO device release callback. It is
>   not called when the VFIO device is closed because a migration file
>   descriptor, which references the object, can outlive the VFIO device
> [ ... ]
>   pointer in, the vfio_ap_migration_file used during the RESUMING phase
>   of migration. It also clears the flag indicating a complete AP
>   configuration was received.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D3

