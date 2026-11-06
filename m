Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979374;
	b=LL72dOqx++ont62UUlyBMR18fVKziL6nirtjrNBY+lvgdjlO60Tyi8dz5wNkDtOfg2kV
	 lMqkAYUFs2lUvmyCrERNXg8eR9aQJVb6TLGdWZNZBSadETeWLj3YaoC70kj3EFCgzo4Ks
	 ekTOR94QEOB0I0v7l8NnGnUFZj/3RaJ1KxymF2RA0jElsXyQCpMAf26Cm4HZeKMCpP73Y
	 KP9Vhf0XKpLsJZiOkLxjiu0X41ACXQxmdWHOqB2JWkXdTsl9srdnuW+a0BDF4m+/Iag17
	 m58sflC2hBaZ+swoxa0J6HsBY3VFCGd0Zro2t/fBMxLJq62+joCfmIFfkeLR0K+w6PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xgMCsNL+FuiPACokWxB+YpocnGTg3RM0TCY/MSErDZg=;
	b=gH6rulciKlxsVhayTIeoyw7Mk8oWrItLTsbPh0T3o2x5oBnl2R7XSdGsErDM1JLxXScH
	 XwIu9hVsaSaA71x5iKK/0rS4oNmUDrr07PDtqTc452NRd6GOyOBiPcDvpx4KYz5podbPa
	 IF08TXqePy1ARZY1E3Q57rEZOWu4+nzMugFjWNAPDfcNL9zEjoGujcdljuDxCfUOefNk9
	 oI8qLAwQ/cDP6QUiENI3DWlm7wckp6BKxqUd7zC+4QvOxZH3ZPj1t5x81mahMUucK5zZk
	 Anv0M9IZd1mKDsu8YbNpmxXoOL7aI2lgKaK7X1X2QA1LW8IQKfJgPASCVxc7yp8Pthg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVmFtAv9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A70606A33D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVmFtAv9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1809F1F008A3;
	Fri,  6 Nov 2026 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979373;
	bh=xgMCsNL+FuiPACokWxB+YpocnGTg3RM0TCY/MSErDZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eVmFtAv96neFeapoyROuhclWZ0ip4gblTx2Wi1IAWuOlg+CL4v31oQZxx7BwvzD5d
	 u022UC2rnlNk/4UYX0Xj87pNfaXl1EwK9526mlUYg9tuJoaUZ0nQ4Kmt4NgxSfPdd1
	 gJ74NMZtgH+lUjc/ZGf/ZCyZ7mHfSiuW/Tzp9pFOTLryTgaXSnoomdwvaHE+kXk1Mn
	 +9PpUq8who9S6Z/b7hwSlD8nfQiyaupRBXo+XXj2n4EaDRPsMm+bXNZRywvw/thqN5
	 sfD615a6j/JgmbH7t47fKZz7AEQAnvsY7kdaHZdeLRCkjqtZi3pfDHKtopMteFniBZ
	 HpkPGz8H/I6GQ==
Message-ID: <sashiko-outbox-201704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/14] s390/vfio-ap: Transition guest migration
 state from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-7-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:36:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
> vfio device state. The vfio device state is comprised of the guest's
> AP configuration which specifies the adapters, domains and control
> domains to which the guest will be given access.
>=20
> To begin the process of saving the vfio device state, the VFIO AP device
> driver opens a file stream that will be used to read the source guest's
> AP configuration.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the read operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D6

