Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FE516140
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906939; cv=none; b=nIBWiXmlE+9Ge0QDfOaCq4OzGlS2703wy60ptWOoWFpIlBdHgWiKAQvvvIdwU83xRDnH2ADwxi+a3Zj87TstJoLeb7n2leS8eQxFLremkP1al8Uy6fMBx+9Wyakigh+J0Tf+56rXJ1bQJvT/DMlRaBQ2/ZLWgEYMeh8BvyQpBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906939; c=relaxed/simple;
	bh=VxLmm3woT1jolNG9zeVZs4NC0enDXGWmr6g4ssNh7Os=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rHyOu24NvPIHKl1eN3SsSmfl3iaN+jbuhorhngCaG4l5tiCaZtpHJ/1iu3cnYWR93hkLaQrc6J6Qi70kodb0U7V0CgN4m2Z3oOW6oIYS1d7MI88M/zlu3v0KpI4NRgDeVuvVDaRGV0oeSNlMiYx4n/f3VTTQirw4ZPDfK4nR4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE23+o8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE23+o8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1D71F000FF;
	Tue, 13 Oct 2026 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906938;
	bh=VxLmm3woT1jolNG9zeVZs4NC0enDXGWmr6g4ssNh7Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TE23+o8oTayswfPXprUHBi5DK1LYjuoa3CiqOEv0J0HHP64Z9FZlHMf21I5qArlqY
	 lY8qu6CH63VY0X6ojk2ddFU1+IprdgOzaB8OFETBbJvk+ML3FoTChfENnazJ8EzRHJ
	 s2LwMCn7QCZuiATo+5POAaSAovMm8pVqYlcASxqGbnJmDKfjgo2xWg9CzJC8XYZ9I9
	 OtnZG4Ears4LoSGq9KWm8N5VpohagF/3jexqU3glU4pV70d5FtpHRrf4WZGKtvb2Hs
	 4dFlkUE90GgcqeIn72rYofKX6AfnnT4w3z1wUfSNJeFcRlsbq564N+wBXzOf0YCufi
	 3Ausur131xjtQ==
Message-ID: <sashiko-outbox-170063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-7-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:55:37 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D6

