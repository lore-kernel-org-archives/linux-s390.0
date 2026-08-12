Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA53ACA7C
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521772; cv=none; b=fCau3SVjMuRI5ZcDlpYCqSpICxJ3MbNDh0G5xsaCXKZKwUFSs1HYQChAy2R3TXHvfAnnuv3CW555AfP/k9vZ9x/XmIIVEWdEp0ezNSsEBK8sfADkrcSHWlpFa7Yj/LokoCjMaqnrM6nU8jGZ1EwTHKUi7rhptL/tj554kQ+t7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521772; c=relaxed/simple;
	bh=WeclA6hpGtq/12hzZeNwLr2k3cWYGI+sBQ+Xo2Ez3ZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I51KxFiIsBvlF+OON1/jpE8jcesUQp8kQldO1gJYCnU6s5xEI2nxKEl1YGzJuLYyYM+aPoLKJBL7Fjlu/1SPBqkKmz2AUYpIzrgDCVC4VcbRd5cgMMK36YRoDeklj6w1wp6du57TCQKN93W6kEGNwOrF7c3Dnm+11BvM+iRgaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4JFzCW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4JFzCW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C0B1F000E9;
	Wed, 12 Aug 2026 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786521771;
	bh=zMKWbCFxNs+UTbvigaGnErTlMfeQCiXsHRHCVUqovps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4JFzCW2EmD/DLzo/hgRkQ6ugfHyQR6JFZqipTulnx76qoKR07LaQPgAdY16xxgMl
	 leLd/D9op4VrwCLzP4TrovhNqIIOmRX1cIUTQlGJPLbgRTqADcA52SkmsTqlMwf97j
	 CfR6i2LLbob/F+DkrrUeavOPJ/UTbENVSsHTFrL4Com0J/iBbjByH6DLoc3vjo97D2
	 5vfEVNW7tPrB3P9RBjAVzTqrH5DgFaYT2lHic9QuEHzi7W7BBFIIrMLgZ/BGXs+DaB
	 swfTNdP5kM2LKsbsQmBMOpowh/Gyv9wK1q5i6Ca8FcT3yy5+WBmptz7zIt7rxrpT1c
	 tXsWS7Hjimyeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/debug: Fix deadlock during unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Oberparleiter" <oberpar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812075319.2007940-1-oberpar@linux.ibm.com>
References: <20260812075319.2007940-1-oberpar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:02:50 +0000
Message-Id: <20260812080250.A8C0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Unregistering an s390dbf debug area while one of the associated debugfs
> files is being written to can cause a deadlock:
>=20
> $ echo >.../vmur/level    $ rmmod vmur
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> debugfs write
> debugfs_file_get()
>                           debug_unregister()
>                           mutex_lock(debug_mutex)
>                           debugfs_remove()
>                           wait for debugfs_file_put()
> debug_file_ops.write()
> debug_input()
> mutex_lock(debug_mutex) =3D=3D> DEADLOCK
>=20
> Fix this by splitting debug_unregister() into an s390dbf and debugfs
> part, and running only the s390dbf part with debug_mutex locked.
>=20
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812075319.2007=
940-1-oberpar@linux.ibm.com?part=3D1

