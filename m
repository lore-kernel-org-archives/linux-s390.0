Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E25370ADA
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907409; cv=none; b=apUThsRBO5lPvRqWUqw9z55BwVOcWmyyZsG2x8cutpmGtIzL7AWcOUybpNJmBGeSCrH3ha0GX0aqiJS9ZV6KKaPZibe7WYCG4JOMYJ/FAsqnYZeR+oOhMGSKMCKIeupR1iAuc7xig5xIzunEWx3H2zlksDs49PN4r/fxRPXeVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907409; c=relaxed/simple;
	bh=lmt/XHsnxeGxi+7hrITKe8D50ZfOqQXqPPnixLg6spU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FAe81qUp9HGPJfSqxVk8V76rnqfN9wEEpcybAfQKBFkuFffmtXj/2FMF067J5xMsEd4ZXei5Y2+bEmwhMjhpQKpht05Qz5dhY1shx694n1xLpgCSkplGicbU5jhcDfqzCoupBiqMR3DDIqrFsWiTfz94IyJRjd7nJsVybsvGYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keBS0WFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keBS0WFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D40E1F000FF;
	Tue, 13 Oct 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907408;
	bh=vNkOW3lFCtWbJKWod9+nBZp1rQyZxR+dWuOQ64v6Bc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keBS0WFR0QQ4tZoFOFWNB7QMekUWygOhROVdxRqXyCtJj1bxB6lhrau/ub523LLBI
	 5rb54H9JQXiHJOazAHLwP7DS/id0QG9k0qI2Gt1qsEpa6GdLME2roFU/z2C4VyH8c0
	 5LoFH1luavJK8W7hHNAAk1AQeW5HUvTgYcZQSamrrevX4LSTCHABMj0wY0uhXkxbyN
	 Wh0uuhyMu6OtpAR2bTuMTxBNzGGQZKpFDYIkQxyig+9q+vExDsl7WSc6oxUoW+a9dP
	 tfHlrMTfPzunZBuLtoT0RmDcv63P2lrOF5HDJ5QaeK/muc7ha4xykbGvPnJI7G+uOD
	 uClYWHHbUbl/Q==
Message-ID: <sashiko-outbox-170083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-11-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:03:27 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Adds a new vfio_ap_set_new_config function to set a guest's AP
> configuration. This is needed in order to set the state of the mdev when
> it is migrated from a remote host system during the RESUMING phase.
>=20
> Key changes:
> * Refactored code from the ap_config_store function - handles changes to
>   the sysfs ap_config attribute - into a new, non-static function which
>   is callable from the ap_config_store function as well as the live guest
>   migration code.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D10

