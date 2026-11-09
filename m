Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263312;
	b=w4Ppm5PfNx9JrHAgAXElaO5hwk3dyZ7/Obr3hQZpcDcmsAf9QtbIINJEuhyvld3GKwcM
	 CoB6ttq29iq5TGaY9InLP5hipnAgGmWu8Niz6ixbIQEvUDKzz+jS4AOXnChcNHLqv49hb
	 SXPQVtHCkGcdVFYzR5aG7FPLmxnJjWzrGisW6xdboczRoAsBWGeLQb8YMvWTIbHRFdgWW
	 opJXejjgtVX+Cos3vOqey7xl5Iok5a3guX7rPSDR8mTdKQWU9ein/augwSJZCi0xU3zRS
	 vPIeY1YCu2TA2uADIiNicvAl+MpP3z3WT24JgaIA4oXtJVj3D4fR7nPlzbTVgws7bqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6I/EF01mEk0FpGdr0jDZzFUdoAI/0GJD7hSl+8bvFC4=;
	b=HtBu7bpUAKr8aCZET5BbKtfVpZtpBHTemsM/t7xBw8Gm8pwR+AdqiKTFSYg+5YKwzZ0N
	 wtYyg0Sa4BXFXCX+6pfO4cQ6Dv49nZ6PvEiGlDAL6u9acXC6AVhgPKFZkr02C8SNU57uf
	 OUCkpF+Qv0fkZq/KsjnxjfK6E11dRlKlRiWxTaEVVpTM0XzIigIBsfAyxMhdhsIFRvueS
	 6v3QUsLAvJHttV5OZC4X9RUr+HF9Qcx9sha91M8msQsy6UHJOP2p41o0iiozCEP4orn5t
	 Cl+q0K7uIEF9GAl9ZjQq4q3VXnWdpI42g2ypqIPfMVcqbXpQeAY9np0UwB6sSuDhmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFoQnA2o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F45606A321;
	Mon,  9 Nov 2026 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFoQnA2o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F01F008A3;
	Mon,  9 Nov 2026 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263311;
	bh=6I/EF01mEk0FpGdr0jDZzFUdoAI/0GJD7hSl+8bvFC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFoQnA2o33Kd2vArmgpewS//DTt3U2gXobqXOOUDse8x9oesNf/k7kOZTZTYnbUUD
	 Ieoigjq835pXWrTeObarWsJK8wyGwfGpnWL2FAx01DYcCRYs5hCOeuqKsHGlskg9JK
	 wV66LVQGbfCyDeN/shsQApMOoA5VOo2FGCkj66cxjPeU3W/k+6fCjR1bI6qsR6VQS8
	 KGURNMOKO9PxDp8yYAb2llxltGMTt+wjeHeTl0R0OvdFmYtyHXM/iYbfTHH+Kkulwn
	 gys23nSIhv/aowu3bSYW6qL/AjNaLY+U1YwkhHgL5wOjd1rV5bQcmUNiL9JsfSXmwI
	 6vlBhvImNOn6A==
Message-ID: <sashiko-outbox-205734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] rxrpc: Release conn->key when
 init_connection_security() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-9-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Clear conn->key before calling key_put() when init_connection_security()
> fails, and pair with READ_ONCE() in rxrpc_connection_seq_show().
>=20
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by=
 userspace and kernel both")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D8

