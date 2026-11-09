Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263307;
	b=c7IX9JnlbnYfbJDTrHdoDZ2fGrSwMOnJPnFDYoYG9dFcYf1ggKX91QFifHLD36EuHcL7
	 qwKM/XDB0Wnmdqbz6mr6Fqgkmu8EurWEMM79He23YwLEUcbQJOja4iSHNfRHO/P+NpTuG
	 VTOWIUJDz6V7V5rzpoeCX3nep6LHLzrmKzSDyEOftSGXfZ5cA3/mJXTI+04PrbjACPvRe
	 aVylM9YEUlTvP+f1woMpaueauhMaepuXHA/aZ4BHg86HCd5Jb6VDsXnSbAS97X3pMYwJt
	 IK3SKh/vLFi2fSMbtTBWSn8+OyoFyi1JAMPWw8lSTROjI5kAu1NOWDfz+YwmACg8hLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r3PqNgteELRxiJ7AKkIk6Q3ujHgVGxCaL/L6cJtRtFI=;
	b=UhLMS6HwzKToGSAF5AFfog9fwUSKZ6n2/q3O0Y/qPVPFuMhvNKljtu19q7iiVXztxTgA
	 qUzxxSjINgeJJ1ZIzjgwoS41o2XNJaOBbZ/AHOSse9SpVD9ZLaCF5vSB0swWnIP6/V+tZ
	 hIsx97mKLWHQKSw2sUCdbcg9WGLNloONZHFjI5qg9na0Ee+m0V4+FnWCqiMJFjGHASL6i
	 cz7s5Zf3mduKYq0mzI5BQFWcpJ970DciYkfHVlVIusysbhkn/PtFHHGHoFOYB95r+HgGJ
	 9UwMB65XKVUCcQCkMRX4JYHvN9ew89oCnNmri0E/8PFshuIenfWf6Y3WCwKgYsty5xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joc0FD+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CB606A331;
	Mon,  9 Nov 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joc0FD+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BE1F008A2;
	Mon,  9 Nov 2026 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263307;
	bh=r3PqNgteELRxiJ7AKkIk6Q3ujHgVGxCaL/L6cJtRtFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=joc0FD+cW3YYgwePhdfM92dhkfOPpxI9vXmH/PiFwZRvvCjZmnCLDP6AzFKwp/Pfx
	 9/fDTGqiVjZ8jkU2JA0i7uzFHeYnhypkaynIC6t9FLGEfhOkNkz4AUE8beFIDMhUoc
	 z7KaUW0VR37zysJTNQ9j3I1sL9kX0VoePebMkUNLg5DXzr49f7OUGcwsYyj+Z7YQ5/
	 z35qVKlqvUiraIJ8lNrFDdcGNIYGNWIE6eqEuRLKWPXkMSQQPr/zJ+yOSrOBIMTnO5
	 MqCYZkT6Et/PUBcp0cPhlpx/LnblMjq4gE+7KeB1Ta6DytA98aXLf0vAJARvbFHUTI
	 of/EDfiMAlJ7A==
Message-ID: <sashiko-outbox-205731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] s390/cert_store: Start tracking subsystem keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-6-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D5

