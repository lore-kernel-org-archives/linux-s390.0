Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428651;
	b=kQH7FyJgizgjAASW8Y+Dgn0vcjPpbTaFqy6f1FfakQL7Ycuo+hQ3rYzVV71tHoLnNTqg
	 Zk0k0SuGIgRNFI5buMOfuOZ/ndgjFzDjw5yDFYU+yWpFcLED0Z9nrfDXzjMYP2qr3RNhm
	 KUrGP63IQqDZninmk+Pa5DQEE02dMsl5ns0gs10v32zV5sQ9d7PTz5FVFOY7UCNGs6bZy
	 sOSHCrZCB6o0KuOto8sCqZM4OSOGU8G6C99yFUoRtU/HMimsAmLC9vq7l8abPdyY8mGGP
	 wmRQuyE+J/J3yDfSQMbqG9jho1S56ydrODLfxH7ocaAYIcHtcwvBUpTZQFGXO2spdhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aSgVrV6usYNHWsGl8HHknOocra7fwgsvGNtAKiMIVUM=;
	b=ZK3PH/I6G2rhGdWZl4Qgp+1fZX0067MtCmWZBXGrOU59Dx6Y3/0P7HAqN05g8/YtbqvM
	 AZd6RSlPW+FegbZ/bWLbET7HXj5rtOQCXnL3rIBAKlBoBCH1/n5afKkI9KylRjCHSIR0C
	 Z0rgy2CW+gyEpu7/ojRkImXv2H0SG3e884BUHhPHoHX3Oadc8DutcZaFBTQF4KfDEEGY4
	 Lh6ptc04Vu9gYpXoAtVxVEFRjW7rLYRITNYXpJQ59h6jIinQwMD9TLC2sy4xWT23/diH8
	 jwj58iZePLPn4ja1acj303n4YN+38J6FMfpVLGJGNfNSwvpCuKgY2Q67gxPRP51OCkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErY1f8Wh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C43606A324
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErY1f8Wh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB6A1F00A06;
	Wed, 11 Nov 2026 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428651;
	bh=aSgVrV6usYNHWsGl8HHknOocra7fwgsvGNtAKiMIVUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ErY1f8WhThG+QmwGAy0u12L/BRgsQKJlJIFP3bqePv2zHiXVkuvTnoB4B1pPn8DTG
	 vgtL4lojKGRwc+3yZo9ZS6pvsVFiXlDQfNhKrm4Fr70WkN0CKHMO7Ivvky4IasJXIL
	 eWdOAO23Ixue72VrIehfSRCzf5AMNifF4Cz9+cYms6RgOUcMXWMaVlL20IqMP8Xtra
	 oFgnRYgYq9kRFJsFwJmySv7xToTnwOLyehHC5F3GVpYugKlMz7l2EW9VeuSu1tWJ5Y
	 w4xUOnyTQmhkX+0j8icmOgemrIi/Khf+sIvEyaa+gtzzjr8v9UZmj0bOITABsT796E
	 59WLoPyq9q+pg==
Message-ID: <sashiko-outbox-209648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/14] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-10-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:24:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Implements the 'write' callback function for the file stream created to
> restore the state of the vfio-ap device on the destination host during the
> RESUMING phase.
>=20
> Userspace reads the source guest's saved AP configuration metadata from t=
he
> STOP_COPY stream and writes it to this stream in chunks. The write callba=
ck
> accumulates the stream into a pre-allocated vfio_ap_config buffer. Once a=
ll
> data has arrived, the configuration is validated against the destination
> mdev's pre-configured shadow_apcb and hardware capabilities.
>=20
> In order for the source guest's configuration to be considered compatible:
> * The migration data must carry the expected magic number and version.
> * Every APQN and control domain in the source configuration must be prese=
nt
>   in the destination mdev's shadow_apcb.
> * The hardware facilities and AP type of each queue must be compatible
>   between source and destination.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D9

