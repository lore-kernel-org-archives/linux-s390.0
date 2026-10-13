Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDA525A6C
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907219; cv=none; b=sKboWrAKSntLQOjpmbazYIdSkefGVIWkgs0Z9fJu458OPV0wCcwc31yBtskS/Ooe9bvI91dlMDO9v1RqHCqv5zii0W2YokTAQ4y34qvsglX7uMnGYxNUVUOgBwO+uJO35OZYnZNxIdeNdK9T23b1vuEJtZ9EzazcqtWGMGh3qGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907219; c=relaxed/simple;
	bh=Z9phkCjvVZynMLziJDLdm/LxhqQIiyp+Gtdm3Jm7hNA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e0hTavKBZfbqB8lQhwsM9YGEYCZ7KiQ0mH18+umusGaoHaKFnll6qin+AS4SXZlefxWjaqWFWWipjEMEltKPBvt6mlVWtd0Rnp2d+/HXhvddBFI7oaMQCg9fu2Vo0jTW1GpnTfol4sfWZbMjdZgo3ySyLI0pJzDuqivQ4tAtTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDGrisyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDGrisyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DB1F000FF;
	Tue, 13 Oct 2026 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907217;
	bh=Z9phkCjvVZynMLziJDLdm/LxhqQIiyp+Gtdm3Jm7hNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDGrisyy32mtBBcQ40x2k3ExYGNDAHASs1YniUq/05OCn/t9p6RkZuqw5u6eyoOwY
	 ca2Qi4Cigr6Duoym/FoPHSl3oIZFYhfKpRbFyUgdvF0fHrEq8p9OGKwhfEOREUjwzV
	 HUZ1JlA7jGmgqdaDNwxxNYAT1G1eRnjbvre0HZ5uu6PiumJ6zUhkSNXAAfVAvk2mca
	 DZ7WQGzXWmvi5yVTGhsQEdrXyUED+a6FJask2aHVZBJFEDM5gzzYBbHzzJPbCQP7oY
	 1nUgxLbXBHrO94FdzKDmGfeIg2BcSIZVwCQlG6YikXI+vEFtk2xV6oEPPQhn8RAtwI
	 1uXp73Uhoq69A==
Message-ID: <sashiko-outbox-170078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-9-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:00:17 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the write operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D8

