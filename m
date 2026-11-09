Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215127;
	b=R+eRRg5uYy5f9fc/sckraJ0PRfXYMOpjJoRHLGrcqKu1DnzUlCc1in8SywsH/fvW72Ie
	 Iin9g4YUWEUZu27ENL2zCBy6J9V5e+MwI6jssNGkALcfwgbTKBOMEYIB3U5XEsqaLbvjs
	 aCrIiI4tYeGSVSWSvz5RhqyO9ywaYaZS5VExKWdPh7da7vMhPqL2ct29ixWSKEez1TG/B
	 xZhBsA55Exp6kpFWnO8RDNePcTIARzQNCogjnzFaP3wfN3BsqTY9ss8FQx2y0JuX/Aot5
	 Dhwpw9j7vXwMmIlYm1+EMCvoPpTyDfHb+Dklz0H4hK1zm/SB5dWrbAmpGHEt5uBXa1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2wYS/AvFbYsaHnGdTDGNcKhHXiRh7nxkDJxVXDbz5Sw=;
	b=dtUDW1VrZOLpP+/d3+M8lSn9biGWMnGe7CrLsPgPwoDgblTC044ExBoooOWVg3LGvjEj
	 1rahvsreEemubOa9wh/W3pe8J4xrjAn86iuu9VIzto5JAn1sFjPlTOHM53aXMf2BN+To/
	 zOyWdCin6/0N/sbZl3YJOrrVTTOA3bqH5LxEVfHEXC046T/eJSqXBNmGTtcIEPsO9JYAc
	 8TRJw1fnqVlaqp7TfbRshD99/5/ew5URyLyOQk5Lhfd2u9mb3iHy5QmMGp+dvMx25ouUC
	 P5+tS9rY4WiC5zZjcPan0ciX0ZnbR9egzzlKXDNpypWBIT01n4Zdd1nR2MyIGkkjtqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhMZDRbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207C606A31C
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhMZDRbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E1B1F0089F;
	Mon,  9 Nov 2026 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215127;
	bh=2wYS/AvFbYsaHnGdTDGNcKhHXiRh7nxkDJxVXDbz5Sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhMZDRbE0t0ZY5cUPONrWBfBOu8wr3Fu+fGR1a0uZRe+5GKwZefsU0ZSDtjEWs8q/
	 JYju9d6r06v3d3FFE28PlOBSNfpCaGdY5hxvEvQV1cncqdiGAw4WfbquJwmCZyoquF
	 3piWyrS2iTAO1QEKJqKlDAJUk6+tgcBMqBijMlAAIqh6mpo0WCChfxlTUyn5YdX7A+
	 iwhK6l0yPh1iCkE801PYsUmyoHfrGbU+UhyajT50UsPeU6jERr5mogV8q45lvnZomA
	 4XC97BchVPkAquzYirkejA8rkzaAPqz4BVEQUq4XiBrlYUeW9jPbQVjfnuRDB6r2Co
	 6Y1gh2xNcIDWw==
Message-ID: <sashiko-outbox-204663@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/14] s390/sclp_cpi: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-11-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-11-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cpi_prepare_req() allocates the SCCB used to send the control program
> identification to the SCLP.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D11

