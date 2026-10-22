Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685117;
	b=n8ZwFMymsBtxfGa8WHnIsbBqki18JAU5cxf/jzdGV+KEHbQABBfHG2mR0s30KPfcgeoy
	 rIrOxKF2pLuEcikI6rHU+j8HQ6K2EPO2IlhYElEdtUDuaNGETqUzKB0opv1hW9U5n9Vsu
	 ED9rVeIiHSBbNQthD3ssls5YGd39PVgasWgtE5NHACMoKNDFDGbE9IKu2gWTz3ZUG+9Z0
	 BRUxqoe6BuL9BSL4o+VUUcbNDYWst1uyUy2HT0npEsi9eZpwSkrR5R4oc8nBkpEjKmtkb
	 09Cp06jb8eO8WNLvh9AKtvGHldWkteFpZUe3/AO8QhF9CM9cFPRIjMkKcN7fGFCSCPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3xdp8Eb9PSaW1RWgl8qH3EyVZyBqUpjMepkQ5v7ujbA=;
	b=F4hd0DULD0QtzaPEgEYR0xlsmdXze/ehzzvPAK5gnWL6OpHh2EIp4AccrFitQj2WDdrs
	 ahm8C3qDuS4lDElfHrvNyrlLSY/6UomcDfq8mSvrBrpmNCZOlF720bSaXoH8IKrKrIlN7
	 fNiivD2uFiI+9HIipzXhv29iQWRRP816XSTMnkfHqwlZPUqxyF+LDZD8hszkn/wlI6KbG
	 04yfEzG8QvAPNn5dfnHMe7WONKYuvA1goVwykc3eSw4vqmMEbuUOP1VA3uGEWMTZMwf+P
	 08AmMYreS5W89tAgLqDPUyGzvTCTLoZ8HcWWS3cR4/9EqAtE2ABnPglgDb959Amt/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ov4BkFUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C606A31D
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ov4BkFUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1691F01825;
	Thu, 22 Oct 2026 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685116;
	bh=3xdp8Eb9PSaW1RWgl8qH3EyVZyBqUpjMepkQ5v7ujbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ov4BkFUZyZPB+UEfCGNFdQOshuwYKLBP/o7k6RyVOioA4UUtYJHDxf+gZC/W0um3X
	 CqLGm7LYkIf59FPYgcTq8mdxdK63yQcLcQuwne9dh56JakJSnh+5KICcO3EqjbYdoM
	 Qru7VXspyLtkTdvkPfHgZ0tD5c+U6Kc8o8dOvJvZ/jgbzy688alz3+dEO5vIhGQINh
	 IeUmwzdP4T2Rll5FRLQDjIn3/hHRwtT2j9z+KTCv5LllyxDRqmtczXGMJ7wF0CiYAT
	 2UPhDbljYp3tp869+Oe0Vjya75HJmKYS8HH8zGNbyaBDMdmEGHRg72GfdblSQL5DOQ
	 GSxbrMPLkS5KA==
Message-ID: <sashiko-outbox-181754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/10] KVM: s390: Refactor and improve DAT tables
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-3-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:05:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Refactor and improve functions to handle gmap DAT tables. Handle
> machine_has_tlb_guest() inside the helper functions; the callers won't
> have to worry about it anymore.
>=20
> Add crdte_pte() to allow using CRDTE on ptes.
>=20
> Fix idte_crste() to add the missing table-type bits.
>=20
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functi=
ons")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D2

