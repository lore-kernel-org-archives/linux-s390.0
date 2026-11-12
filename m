Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457891;
	b=sP6EuGAkXjrAbnwt2yqvWDKg0FOUabnPp4otakI5FJhxn/fl63MaK48YMQQZuhLXD683
	 n2J4xY2OT5HwPyw0fy2VBkXznB42d6ydCiTqNCAPtWrviStPFMGK03VFMeg9KMMYWozGr
	 zBp4Eo9YnzAnM/2t+IOAFPCkJ3KRqToe+wL8ckyJ4nefZV2/97Sb5bR8wWnmg5UugMTbz
	 VSIAc2fW+SiKmlOKHawnOmRh4lsusInotLLhRQJkMR0Yq2rpcBo56invVPv2koeYnYU9D
	 KreMxbrWxa2cK8PTOuk+Ohdq5vWlhZ+CgRET5iNqUPMUelCBtCtN5qmUwN6GlILLslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KRKmWg1vJBrgQvUZrLFgb9KrSW/Yj7Nz4paEbmPso2I=;
	b=EePoMYX1rInX/i1crRXkRfb1n4TJ2IixxTPZrsO5hPcLe85UE6dCN27v9tHT6jHce4ph
	 upvWXDr3743HhydqM5Ox+phaYAcYP2pwRruosq06s0Ly30Hiycu1VBVYZP1G0a2Oo4lSw
	 2LIoU3FlPukTJU4jBEa/vFB1Lmn5UyG5AnyQovcOAWYyUuwUa1sv07KoLoyK8qdYZb5Dm
	 5B0cyLPGJuZ/llzSOQ5Jl3q50YCuxETXbR9S9LWIhyM3ZK8lnydt1KsOWnFNUk8CmCUiP
	 xJMkWWpk5X7yFIS6fEDUI0GeRl1AdshYcnDnVCwlBWSGk6pqYQxR0Po+3lpO2MGakUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGDYQK4c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DE606A32D;
	Thu, 12 Nov 2026 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGDYQK4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1991F00A06;
	Thu, 12 Nov 2026 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457891;
	bh=KRKmWg1vJBrgQvUZrLFgb9KrSW/Yj7Nz4paEbmPso2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGDYQK4ceX0PKXxuG699hh2EkDI/LjBgna5Nl8Yo+PyhbT3jkObZ+YLd5Bx5KIF6E
	 9aSYfpkccBAEVRtOI4gMlWrn1Lr5SLJAlKqw9qEJerSCSJXnKK8Tb1mQdKNY90NxwL
	 oplqoywKNO8Lyc2SedCJWDXrju1pzRQW0OBnqyCn8BdWLUQts0GbjnjEgL+H87huuj
	 q8HtrSSjoJpS6LIMIa8FKitlVbkwAa7NAzW3uuF2JNyMSZKutVEIIc4Hb8FrJPOk0P
	 lLKXP0KgMq2Zo1s+IlDU/R9MgzRz6RPoskgP/8AvK1/1Q8KSLgdimCGxhKq/+fLHMz
	 5UP/3o5eDGdKw==
Message-ID: <sashiko-outbox-210351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] s390/cert_store: Start tracking subsystem keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-6-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cert_store refreshes its keyring by unregistering and then registering
> again key_type_cert_store_key. Once keys pin to the kernel module of their
> key type, this is no longer necessary.
>=20
> Register key_type_cert_store_key once during init before creating sysfs
> attributes, and track subsystem-created keys explicitly so that the refre=
sh
> operationunlinks and invalidates previous entries directly.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D5

