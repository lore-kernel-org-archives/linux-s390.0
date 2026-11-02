Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633000;
	b=syOGGSj85j7zAnDKrZ8v/0QquN587bMgi9cyoSv3WbRT9ci6tMr8deNOl4W7I51L5s4/
	 /zPtqszHXjZm2/2ELXD8DQSpRiiRcOwp8sagpEzbDrncBuGO5Mp602bgxr29jc2gaNtDj
	 zDnunzG5k0Bm3eITxSnuuWMVnZigvk1F/sU+/eV0MzUuqbs73Lhprc7gssjdkGoR9Fnny
	 NtFI6uewmVYWR6mgjEGDYamtxplHcNBdSzmBhb9QL1kXRaY325Hb4YbWiCe/QgSCaPyrp
	 +U1Kr+zWtQL5Jx+NsFjuXg3be9/qEgjn+H4WPyP4AJe6soWlBhAhzbMFN1pIVuP4vTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wSOEpiIwaQvP3QhHsQBh5Z1j6Oj5btERHdL+QJjOEcY=;
	b=dwc+1QucZAOIB4s4xA8FhTaR9MC9OGm5GvMdwza3d7WWqVcxJqSNlzzEfg9fAGzWZwfN
	 wY0I114kIrQkArDZ9BhJu294NwGhaPg70PermmEUhU8JPzUaXMfJkjf03EvVLhY+DhnP3
	 rw/4ag/FL8yaHQnxLFhWEywyXfIKTONg+kwA1OAjGMwAvo9fI2bi+EZ9vTi36Gfn3pI4w
	 8vPoK+hBWQtB0j5SL/jYsdP9cRA1T2DiAElOT+D0OFkpquqKZNxVx4bNknPsiWFS1bs32
	 RnZ/pGSVyVWWoFgi049SZkjgRGB0NffJ8vvOa378QCjC4CHcDWeY++PyP2pkUdL9/lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L+k/9v55";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345C60A6F47
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+k/9v55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8BF1F00A16;
	Mon,  2 Nov 2026 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632999;
	bh=wSOEpiIwaQvP3QhHsQBh5Z1j6Oj5btERHdL+QJjOEcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+k/9v55UsEP5uLZxm8JEjrLp7N3ENsw4elkC5K4JW36C0jMU6oitzcRhZ2Sbelfp
	 RtI1mK6kC1C7pe77xosRc+jNgOctE7cLO0uz+/yO4OmJOUW6hW/gw/eT0iVlBCDq6x
	 4saVMEp36j2aWjq5Jly/k+K1Vff1dCaqWEaS3NAK4cKqY1+I276ToaWtvJXinDkH4U
	 R/MkeeywsUKTqqVWP3FQjvO063Ht2Yq+Kx1fu6PYwu19XDQ7lAdjANkUztKSosST1+
	 H8F1gWWagHB2YsGBgZRtJKE7wOoumOF5QoNmjuh72i0guRr/TRq71zJa1UfjNJnDBW
	 O6tyUgwMT+fZA==
Message-ID: <sashiko-outbox-193656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-2-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:23:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D1

