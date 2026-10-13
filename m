Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A18521898
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906635; cv=none; b=ESpNgyrw9vsOpSx1iCD2FOL6M5gaKUU/TlUmhiAtCGOg0esoCqZdyI/c81+o/RwX2LzwhaFDi765a3Us2kHesYpJS7WAeRKK+wOtF2jj9XM8xVcff5veIxc7gIeFQJaW6YB0vZK+aFPAoFhwix2pLoY8uBmHRiRuxPBTpRr+OgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906635; c=relaxed/simple;
	bh=u1TNnhN4DiGOTLqcMxq91tRlyA64CZMyp0IKDErbPCA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NSHcvY3yNb0RhAuHcVC+DFdNUT0E10nHC3RUnPocrnq8x/QGsDBJ9EXrCM9K41djlMACqw7kw4azFa5lJFwtXEuUi5LagWT+pZGlm58dUIrrMUTRo34tDjYhetKQmncbr9YA5PqnlZDOLjLgzukAQf7ev7qJpHboOdX1T5VoBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZS7VcOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZS7VcOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B5A1F000FF;
	Tue, 13 Oct 2026 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906634;
	bh=u1TNnhN4DiGOTLqcMxq91tRlyA64CZMyp0IKDErbPCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZS7VcOTEPMbRk6yr4z2jXd3a6VhvOVfdHS9c/aqqUsecl6xn+M7p/X2/onVUEDv9
	 i6ESpb4ysqMt+EzfTu0QsnqJTFjP/2pwmpXYtJTDx8KWr/zAq0IcqNyaFr61vdEZMl
	 C9LizBrnXDimwpjdFrZnQ5okJdJc1KZM8A1efDTGL2ABO209VTnhUvY+5PHrOR51Ab
	 fRR3Wb8Kj4u2s3ieBChXGS7ddRY1I8OjbgMtulpseW/6XqSyf9UgMFVoVGhnvt0kQe
	 eMf9ovHnt6jj2t6Qe9S3v50pap+VY+432GGyeQfL9kHh0uljK6R/Sp3n2lhWTo8N18
	 nt/jbEuBq0dZw==
Message-ID: <sashiko-outbox-170052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-5-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:50:33 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases the migration files and frees the storage allocat=
ed
> for maintaining the migration state.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D4

