Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479423;
	b=jLEDQn3ByxdCyN5mfcd524bpu55/AaHcETH7MrU/0LC0spWThP9X/RFbCpWm3V5FTB6u
	 Nr0FWYjcduZDP7SCDCnqj8SkHK93ga9J6tCahg1Qt6rjJO6aRegjojQVRbh8mpaJxw4XY
	 uSf/JfKUbiFpbYk+bGhGi8L1COzBoXQ1xaZMKjVIMwsFPSZDz07GAMRScna6sfRjlwzrV
	 OAfcTc9FzPiG9Zv/7LuZk7m9z+HsyhE6R7ZTzgxP/QbfkbSE5A8KEBHopIG2oApeBg5HH
	 mR5zoFefmKAHimToge//htTjSppHgjYde1tFB0RJt9vDg7WZNmp5dmNO8YqtTPRHNjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479423;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uPf/eqCV5w/PR47PMxwGbQgaFFJIMyg0/e9pkrG0cJY=;
	b=URHz1c4JQfdtk++CqKrdSCtVv0fRzN7P3niIMnliT/dHfSk0/Xk5Nxl+Xm9tyDI3oj9Q
	 os5v+pTWlcNFkturENhkfSvV7yDB9CT4QRPW2RezpKBQLQJVAZFa6nKvHNVsd9dBRk0CA
	 5TaHJCCanJDlFEAnNlAuViQNQ0J82KoAfxCj9upTWrQGBycj40QCPx/T0OfZneUNOd115
	 cPQsxXrmgMjSapTF3scKH+Ki1TOYK7TRHNgoo2xvN7TXZwiYieEVqosA9z+WL5LTIsU2z
	 Nh2vAzNjV5ogSon40EeFHeCch4pOM2WHwflfx+zraVNej1ue9yPDKAdguJG0JH8AxGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1iduO4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA292606A327
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1iduO4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186551F00A05;
	Thu, 12 Nov 2026 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479423;
	bh=uPf/eqCV5w/PR47PMxwGbQgaFFJIMyg0/e9pkrG0cJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1iduO4UfMbKqolQ5mhzsqz9DG6u+RHdeMyY2oFdghyJScWzlmCFKiKGR0lH8Qs57
	 FxmRDS3EAnSdlKvRmS106fmRoVEiw4m4CqYBcS14zUsOTRnTqC9lYDLq5UwqtbmRGL
	 ECtm2op6tlwG5ii9rLrPAdWbsLj1C8WKxgfUk7LdyUppS7jCRRHA4UwrfsSDAraEXT
	 WPiMLG6XHf9OWss5+ui5/9DnE37gLvGJjIj27GFvgHkWWgh3I6H7d0uT5thUdlj6hC
	 V0JFbaI+KDQ6yAa0R+HRBgaalnOyGWz432j2rKtobfr95SCUIcFK4PZ/9/t4Zx9hcb
	 VQ8idFmhZOFPA==
Message-ID: <sashiko-outbox-210946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/dasd: Fix typo 'immediatly' -> 'immediately'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-2-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
 <20261112102608.1057852-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:30:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Fix typo in function name dasd_sleep_on_immediatly().
>=20
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112102608.1057=
852-1-sth@linux.ibm.com?part=3D1

