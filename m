Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778643;
	b=Gd3wZuF4brWQFOz1MSqgykYkU//aZAw8n/LoQIPiT2FLWI93+u5WR4O6Jv7G4sYIxxD/
	 dRXD09gp5Vwkv4TTVkytyu7ONgG4k2eMM32x75cau2JVr5pGwhwmvrUhwJIwTX8PuFcjr
	 6BOgAMuJ5bx9LX3DRyFlwFzeSDyjl2Snz+QCS6qR+eSiqJN3LQo9VglL5uKsTpaT48yk0
	 20Z2grEIOMvUMM7SDCLqRz82svKgwNviOlW5masv2lOJBQQ1Za5YRXZVETKd2wdbZNhy3
	 gCzmcobngCb3+1ndWhXjxLO/ykVtMUApe/C4ZtJvylbOGURwTBaUHZKiTykYLOJNrUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=15Wf9TFiDucrpVUPtcaR/MASp2R0YpbWXDLZWEK/3ug=;
	b=N2+zTV4++5JEK7LZIYLMK39L78Mv+Dn1rCykKk7fOiU9mUOZZiqvjCU0hBMsJki7y5D6
	 WXxF7mKVwn6YJcQQ8DZJYYvLo3kr4oniCFyyZjEVFIzoALVbbk2rINykAmDIGj7Jed+BF
	 tJYLMUO7EKBah0HrB9Q9DXJojyEbD1cgtv0fbXJ8oubLlTZWv9ZHXCXPrIIEq4NhMJqyq
	 6pbOQhnZ5yS2XJY2jhTlgyaAckQyMt3a8ERIP7wS6JsmIdXFNUQ1xO8OyDajZpsoEi2AE
	 qofP8bJvHV6No6PbOisvcU4CT7yhZ600L+t5ZmoRuVqpGzx3aWjocBUIrSJfVe45QtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5jNQmyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5jNQmyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC601F01825;
	Fri, 23 Oct 2026 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778642;
	bh=15Wf9TFiDucrpVUPtcaR/MASp2R0YpbWXDLZWEK/3ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5jNQmyRfqy1hzTe8caOxspFMDiYf8WPMlA2gZ4kI36Q+fILafYIeI226KQWKi9ty
	 hh5b5wXuLbN24H10JBkpt2ll1RiBhDRPpLixFbQXEsAduqGx3At7cl4IXOJCnIUT1w
	 rXwU5ccr5YS8Vqd7N5b7EYIGGr83aeCBu0A3DRtqkCcW2myt9UNvl4pNj2ajZYiC7g
	 d9RQ0prs4V7aTJP1++eEXJi5Ei/Z0B3D2RMWgJHj/jb1RSKI7NLKipKbz+tRfzeuwv
	 yCvPKpg4KagF/X8/pCEp6IocqUgUgmxn1Qwn3FDiUz+1RcQS931g+oHBmSy0sw4qKK
	 kfCJjMHeDuhXw==
Message-ID: <sashiko-outbox-183033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/15] s390/vfio-ap: Callback to get the size of
 data to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-13-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:04:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D12

