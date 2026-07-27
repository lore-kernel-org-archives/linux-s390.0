Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69F42D768;
	Mon, 27 Jul 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175238; cv=none; b=S67oHPyOC65YkheeMLjnyl+szncr2gQ+gwyiurbd5qLRmZk1JY7cJrynF/gGRVLjrwzcXnPzZjR5mo9YQeMmmtjKQUB79kc/eEkriiUZYFmlA2TR/ijZUb6wsNYOT0n4wnzSzgOIlSFaiM6D/FAzSKZKm4OGOmEqYF41oShA4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175238; c=relaxed/simple;
	bh=mAAL66y6X9NiP8mvYeWDPbwChw9U9Y8mpCVPM7VhqIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e0iOvAJ8Pr+nuTZ7juigWBliuzvoBOPnQPEr4oQsbIrBZqHJJpB0vHW36gGIj96swAnYlc3FepfCE2KfKInig0e+80dL5z339Fvp/TnTxbYNWSb+6+XLQqYfDMsJgOGBl0OrR+Yo499v8Wiq6k7jPsoooM6Kc+pmcpapZp0CYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnVaDFRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnVaDFRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E175E1F000E9;
	Mon, 27 Jul 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175237;
	bh=mAAL66y6X9NiP8mvYeWDPbwChw9U9Y8mpCVPM7VhqIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnVaDFRiPfchvvxphDmerXs7N5j32deE/XVnYTu6ZScChglnQvwmI9fQ1n5KjDZho
	 DbjhxOiDSsygDBpNHc5ywUY6uiYxIve1Cl0AqbRFgcZhzuW7e4aewK5H6dkHwm9MVS
	 QiN0vEvMLAJ11AbW+c4qCHP7xJVPPKXX/B+yxQTuHn9BNV77CusxxIE+FgDxfHQqu1
	 YUo+Z0mGxh7dY/frrkmg0WBDM0PU2TXXxm9yZp2xhgQmCwDGubRxhy9qs94lswk5xp
	 yaVV/6qK6yZbv3Bz0d3nSGzOegGbvzvmsSDRIjBbeYPIDlVzpURX7xYaCFyJujjEiU
	 se2v7cDI6PaWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260727173239.2420754-7-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:00:36 +0000
Message-Id: <20260727180036.E175E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D6

