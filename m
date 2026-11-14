Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662318;
	b=0PNZB+sKdgmkBCCiSHz8fYz/tcOjmGycdE3UcM4Fp2AZiNfsKgl14v9TkdBYIw8XyxW/
	 1KP2PB/3SqfBU9Ri8ge3o3LmMmRrjbdlBRx2UWHvI9SvjeL8SRdQlSZHofSQUE9cAY/mY
	 i2rI+1Rp6hnvjrS5ifRoiTmIDB9c2L0RidJxZJc1KQrCQXq4c3krkE7wg4tZPCzjFeeA7
	 OYGB/kDchY0rwselZUjy4RCcbBFYTHJb9pC8ljtY31zKyQ4Yqsz+DbeZbIhm1svZrxz1c
	 PAmglZv56aVlOIcmBsPsHm5PMW8sgVuP0J1wty0W6a3K+Xk3piQ5nveNs05q1czSUbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OkVowIU8hVXY+qNzcXXij8aQ+UukCoKTHOZ1vDRC1SE=;
	b=3mlhbWPmo2hYIbQm43wvv379aBn5P6hYizymA9YNANLXjDVu8RvGLwpMJFYQagpGRNd7
	 Jcw+VkIOyG9zrGYspfweKAqOONT7y8Bz6koA0pu+reVyRiL8Y+Tmtku2A+FEDLo8iM3Ml
	 2Rd3N9a5HMM1PUb6EqBOlc7GWr4pjh6z1QAjUJxYSOJwa9g5oLXcZbX9msdJO/I9eJpFZ
	 hy+wzSF0q0Jp362bLwX5G5ZjaCt0nlwcqEiXMJkcFfm3rhehF6dGezK3Euy+pip+o5F/D
	 PP/3zGrKKUQtF9q5t2gfqDzjd8cm+W4mcaR63Ay0oOuoBWy6rOO8QGtVF3bhNAXY+Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMDXPEmn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82579606A330;
	Sat, 14 Nov 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMDXPEmn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4321F000C4;
	Sat, 14 Nov 2026 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662318;
	bh=OkVowIU8hVXY+qNzcXXij8aQ+UukCoKTHOZ1vDRC1SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMDXPEmnFLOB0pS3CDbJlXw0/pGGBLCfDIbOVdJIZvVchpQF9Klws6eo80CcG0fAz
	 nqs3mfXoQzGTOUzy7vx+fjVDtFiifoiYxoDcxziTCt4I38IoOZ67CpcRjEpOpGM8+X
	 ACboPn7VtYvWPm2/dTviSfC762Tb2oQ1+bCMCwf4lqG5V8qzeuvsE+KwdDT+ccMYKO
	 Qg8RQjqdaja3GAASbmkuvIvKWrrRmL2mJWx3WJJuiDIfjbHGBRLhxO2ej3C7bwXqXN
	 +fSCynsGBdgcG2QtLMD1V48g0FlzHkLNTR1zNRELdH0Z3ip+NTz+vLJoUTtzJlbz+W
	 f0Qjk+Wphv+1g==
Message-ID: <sashiko-outbox-214531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 03/42] target: fileio: check that the backing
 file supports ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-3-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-3-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct an=
d async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D3

