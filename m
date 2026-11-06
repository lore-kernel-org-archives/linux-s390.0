Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926452;
	b=n9ltTmQp1I2KLRNZSTGdf8tOOpoP4v28ASl2/T5cZzuTSSBq5JZ7ZOhsMVWCMLhz4Va/
	 d6+0hgO+E43+/eVQwZxlff5PQ6GCi+fpQJOCLqXL3bStSZx1hBr2qZz3EYoXks7DBtORA
	 p7xhaTfLpEXhYKHiQzsBkCGOXWxsmH1GXbMgqe4AQZ/2yb81xbtmCYdjsSRg3fREJdqk8
	 Os/R7ghmcGu0Fgqp0g+0vCsl+/H+OD3E8taEzsJeX/EQ2nkQ6G8qkuHcFO7AlALwKFlP7
	 kZMAv4qeTBv7Tb+7t0RxA+9GlkMrESOYhh77RxgPV8AZe2C2seUR96gBQ1eALzl8g8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pextn1CStqE59iySVWJ58Eu3F52+OndAIbm5yZtjvnc=;
	b=cEFKIWh9QSg3JvKe3YecJgjM44yRxlhdO9csfyi5CAugNC28slAg9vq5FXP6Nz8ULmPG
	 tWxONBHlfJaeY3OfjvyX1lq847FPnKcHy9bDticxKe+xoHK6Y2RWiT1EzpW+CFDivOUkN
	 COLxNws2r1EJL4a0eeI8hd79eaEZbfjd6uarLoFrxKpWUCMsMqWbMy/FAhbbAU76zdcla
	 I50veHHOjaDDwp966Hzduz/kab815o8x0WeztlSII2T+EcRI2jpGVotpZ6CEN1DqECR4o
	 4MIdFcfFgSVeO3x9MzJgrJcWD09V1jHLi6HGi1r2Prpa+t4xrZPDOt79e3l3HAmHe8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJSz6R1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02087606A331;
	Fri,  6 Nov 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJSz6R1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADA61F008A4;
	Fri,  6 Nov 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926451;
	bh=Pextn1CStqE59iySVWJ58Eu3F52+OndAIbm5yZtjvnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJSz6R1ycs0WeNxDjXswxBEylVziSCqG5ALXF26dKBvbOuVih034opPVDBdAt2bSK
	 zPs928Pbr4lomeTd1yn08r3PdEl+GtPsO35POAtcXMW7oDcRWMYo6z2xR9NbrOTdNV
	 ba8L1O0IL4NRlMqmkC6RiHLDxkDIc0Fygk5rfmkhukRB8MiEtiynnn2NNi+9r8ejdV
	 EhS+TfP5nkbo0GoDhftOKxX9sLmiy0u20URjHJSOXDghnvN+bL433/tPkFwGDXU7Ya
	 7Emx6KkiH6jnStLzx6tr+/ksuQslx9+NcCkEvv1ePAxBjpSDBuLRV6srMn0fcEHNKA
	 eg/IYLyO1lzZg==
Message-ID: <sashiko-outbox-200463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 08/11] rxrpc: Move key types to their own module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-9-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin the kernel module implementing their key type, hosting rxrpc
> and rxrpc_s keys inside the same module prevents unloading the transport
> module while keys remain in keyrings or cached connections.
>=20
> Split the key types and their preparse logic into a separate rxrpc_keys.ko
> module that rxrpc.ko depends on, and flush key GC on rxrpc exit.
>=20
> By doing this, rxrpc.ko can be removed while the persistent keys pin only
> rxrpc_keys.ko.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D8

