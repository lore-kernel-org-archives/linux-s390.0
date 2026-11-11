Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428488;
	b=oPr1yyXDuk2dc62f0nmXQ/VrqBcdkWpFiKktVQSeSmvr2jJUJV0TFoaeUQlHk1QlM//f
	 YtybDxDTly6FXbAg/KMfvpP695WwYPcEMmx0iHeAPKJuv10LSGejt99FYu18s/BL2Ktv4
	 bIshhUbAo94FK7jdyoQ3iRJLgAUXdH2PBX+rog0o7l5lQ/8c/4J1xUGZehbqQtRnpti2U
	 dZuivMne9RWAnGMbxANAn7P5NLKnqCCYwISP6fpZySACmrCeubcJ5vFAW9zkMmhnjSWso
	 y5a4+tRr5M392qDXlT5S186rTYzsuJx6Iof04uE2MCzkDIb9LhYEZaiJGQInw9AZTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=toWkUBjiulueqlx+zdRF376DssOJoR/QLNts1kqP2VM=;
	b=mXdugw9+rJ+jhj4S8LQbkHPHQCljYfy0sle+gZvfRyEh9V6S17zXSeQKbhrMcbc5tEMk
	 1y4sdHYXtb4wO5yaW3HFhS6B0bYMC89J9WZWouO/uJTp+Y1gyuo4/is4rWrBllDnqpklJ
	 TWHWrj5vITDXGXuBnCTxQ6+6ShTt1xwNW17mIDUWEFgSdc8lDvKovnCPylEPSU0g/jURK
	 DVxUX7HmxKQeUrWpcS6O7P6H3WmUmE3d/Y/Wm3S92M2tiwN6AeI9hRoWXyFLztDvFP26w
	 Ws/gfB59tuZx2uCFZb/VvK4cRj02XlbltMYlyPq7HrTWRbfjZoshMF5w5du9IO/gLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjspXIoy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91E606A31C
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjspXIoy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458DD1F00A06;
	Wed, 11 Nov 2026 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428488;
	bh=toWkUBjiulueqlx+zdRF376DssOJoR/QLNts1kqP2VM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LjspXIoy4RQVKZfwq0wdcEgunt+KBCqPtrMYDd9KpfpeqRh+m5RTLPha03RN2ELmA
	 zksHmASbY695zeU/g2DWzDhYzlJensUtog0XF2h6mry4+qdz3fezax9U9kkqsOssmV
	 qDrKu2KZUBlHx92ahQYCbzscQpdF2otkORTaPWQyuClQ1t0M4I+hpYNoO5NEYsbEr5
	 KTcXGJNZBv1dnqcjPBWF4NA642rPkc1SnqO3EObWKQ57jU0X8iDrdiLf1aONYzn3tP
	 NPVrkF4ah21dKwOL/yve33WPLpI0USOKz4khk9Qmga9GdXLm8fUOJjO2f2S8kvP8Lt
	 vlBbaDK0u8wkg==
Message-ID: <sashiko-outbox-209640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/14] s390/vfio-ap: Callback to get the size of
 data to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-12-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:21:27 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D11

