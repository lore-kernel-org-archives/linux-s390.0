Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457889;
	b=at+U/6iaMvmDzyE8vJyoDR1Wps7HVd0yNxGTOoEJOJ9nZKydfuNJYnyTdR0VzT25rhkx
	 f1m37mlxDmk+ZG0+6VHYHTQiwKR8B+LvSOAxY557cZ2S3Az8SpRzSoEoAyCDPWxpo3/dP
	 Dwd8p0npCrvictVRmy+tH0IU3sA4eVWK4lozfl5yCRzYSzpOVCgXazC9X75GGpy4YyhmF
	 hwAhzMPCNIQHZ4mlpAEFqmG3W2DN6AwJEnX/4z+AVOLKZyaeDyuTeXyxTF4U/sIXadakm
	 hAVD9lSEgFbvpjVEzmNL4jteb/lg37qRLtD3ixVWP0wgiY6gYmxVPUXuiUHhgTHNnww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dWfbD/H2grZqPd7/joigppnBvcKagEu+H9pTv7tDcn0=;
	b=pjfuRLFbkpXu8Yd+i6ZmTCtZw01ABwOJwCqxU5uBVYBRUQQgohKr/zojCCbDVsJcSbmB
	 YeXFZlQ4PfLfdjTX0tM2SOtyrhwk8U1wy26yxTpyqWegsfK5/SnSiK3LDldWSrpz2rI1F
	 NW7SedBu7S/9UXLm+ncoAvQ8SQh2ScwVG3TfOYBj6IE94Gr4Cy3x8eX7q60DXeRLVcfZm
	 rGG/FoQi8S4pfoGovJ22fvSWJtfDZYws9B60JTdaPUDD7yXoYuY2Gw9AtQOapwZqdu8iv
	 wLP7qnX/GAI1PtqJ6DGp8EYhjLE/kJPbX1/jAAqrPTQICInfN+PJa0mtj4xKFOOyzFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J39IMcAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A29606A31C;
	Thu, 12 Nov 2026 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J39IMcAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9AC1F00A06;
	Thu, 12 Nov 2026 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457888;
	bh=dWfbD/H2grZqPd7/joigppnBvcKagEu+H9pTv7tDcn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J39IMcAURTTYILTmhHn3UyBs/GxwbERmWJWN+OajgLzj4dmbYAcEUdUl2ea79Zvms
	 2KxRFUscLy5zxVtjrJ6EE5/6CTDCAczVaofgogyUAPYXADP+088R2t4AWlmsY9vXd4
	 rI8+RTwHqC4t5xSS6AYRIO2QXEJkLCaWtV9UY+pLZzD4z8xSjVS66Z8zpjLyILcC0h
	 1xYhyR+s0f3QVDesssp0B55te5suXZ6uH6xHQKb7F97ecVjq3zpuFQzZ54j0QSCZoM
	 jMpmfdk/+lP84TL9g7e77Rb3sK45ui+7df8DL6cfLBePTHBNsVNMrTAfDeJ93OLI1l
	 5iECzHKYOXq3A==
Message-ID: <sashiko-outbox-210348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] dns_resolver: Move the key type into a
 separate module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-3-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin to the kernel module of their key type, having the DNS key
> type in the same modules as the resolver will introduce a circular
> dependency preventing module_exit() from ever running.
>=20
> Introduce dns_resolver_key.ko containing key_type_dns_resolver. On a modu=
le
> exit, drop the credentials and call key_gc_flush() in order the drain the
> remaining RCU callbacks.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D2

