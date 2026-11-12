Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457895;
	b=GyoPdBe+TKLzwZQ/OCABBEzA6UfCui/JyzPh+Liv2Zm8DdDYW+PH57TOS3uEO0nSj+zz
	 +vBQsUP/3bOz/3sOZjwemVzzXjyl8GMdIbbCIJ70SEIf7dS2tpIlCtIq7VIacSs6MYIDX
	 yp7ygfZ3L2lTnXWS4Wlm9b0xaFyJ7uo9YfQc3R8RcrzM+Ihwoc7yW/JrFhE3NDGNTn0mv
	 oXprKBK+cVQ5ZP7+n/aro6A5Ca08XXv2fyAggd5Ct6v7FSn+KwxDR1bexbvuNg+FzgnOF
	 vt/VhH7GQx/b03gPQXUreujxgPYzhSWPNCvlPby+8DE/HqMFQemgFsvA09CsGTvwAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j2vo6ekKeeqsgsElj8W9Mvxy5ZyqdKm6yNLURS2E34A=;
	b=PyYR3aQ+Mt7imTZPuDEXwe3oXvqy9nxtuTU5pGDmtsydfKJB1ChTT7UX3EbbFAeAOplz
	 x6Qc07NwYBQ0d69R+bZID31IjNtUgQ99wUcXBNNTFGrFfN6WjseJufT5o1ISLeosT5L/j
	 qkwt+6XK6M2IYSCasUghpZpS0judyGoxgV13b1nlNOGvTnmrUWnGPPhRWn/zDK/DJ3JvY
	 5qhd+Wgx28+jF+5XVJnJys4W8mSvrp/+/RVziAw2Qi1X6bZlKD+WL44LQ5aXgfBC3hxyR
	 bdGq0R58tRlbwABYpNgwYOAd5GqMRoPW3knfG24HFusMjfJIN6HcUhM23QKCm5TwA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GM+JrTmc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22797606A327;
	Thu, 12 Nov 2026 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GM+JrTmc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955971F00A06;
	Thu, 12 Nov 2026 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457895;
	bh=j2vo6ekKeeqsgsElj8W9Mvxy5ZyqdKm6yNLURS2E34A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GM+JrTmcDzS7NomZHFQqBJhl3EOUDzWIymEiPDTZt6bzfBJbpqNyj6rkaLwCzvu/P
	 BrDPn3zyZjMZThnKV+okx1ocPD388dwU+LrFn4GCn2ToUwFn4QqNdzAoaqF1UXnfrM
	 XD9N1tAOqkI07mi11nSBBkdBQr/wH+XFEt1EdtVtWW567vXngPGXa3893JXnqciCpY
	 YK5G9Zl887MD9I5mbUe95SE4u2YePhYUcqsJPvwVM7YeZxH61s5LO5jOK5IF1+o24G
	 bdzAWPLy36pgrykm5NtmHlD2LKjUJxqsqqQEdPGMkAPuI0YzyBXvVBksnrbtiJlIfy
	 hRa6z2YHHo+sA==
Message-ID: <sashiko-outbox-210355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] rxrpc: Release conn->key when
 init_connection_security() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-10-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:34 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D9

