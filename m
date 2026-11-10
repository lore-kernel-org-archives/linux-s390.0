Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302967;
	b=dvuZ/41UTopO+6qzCgPclDQ7aBM+mcG8aIuLNHdVvguvi3pw7+xVG39lFx31HJOhsun8
	 4NWOHNXgiHBVnnt3ZVriSptSmVfgmTdhwcG7MqMrwie6NZvaVcv9sEHSjdqJwURRSDQPS
	 A3EjQF73FvIOOlQ2H4VgP3n1NNEKq0gnlTO0HMnvT8XaHxYCx14iY7zCJ12hdpeNXUkmO
	 qwwqrL8HGr4jAzkn+ID+juZA8G8ZG8rQG7cKZNu9Rri5HqR2DyzxvkEhQMbiWSsQA+KYZ
	 w79upe2CI7GgNCCxnQEY8kYqoPQJ6n84SmZJkPaoKaBqYQb6EN8zupvJmA89VEq3tPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xdGJzTH17z1Uu+qFbPIHuE9upPtBL58iWq/be8hE6aY=;
	b=cCHXQZPLPMtOU3KRSKMzr44jcLwqAqClFEe9ZOU68uZqiogXqXtNir3nv9Pzw7PDjM+h
	 7c/fsNvPTXHaYwI1FfMH2nmmESmFAHrUSqeqcFww3gjgbv4JcIqq6Aq942RHS2C0xKS1h
	 aCB3KgcD4lRmZ5uEsRuu6QEXnbrHxBeXiA5SB2Rg2bX2Pw7uSqlPUWPeo7s7Snx6fnBGr
	 N0zAZW0K/GnlSjUJtaFzW+pcbsr8+08sDA7PQPq0eWXI7XDzUJUq6vGKvNZtgO0B6q2m3
	 xNrcuuhqDFF2rP1n4v6RVhIClrFq9dRB08VT61Lw9LqZdktMyaHFUMBTX1/0e9iPVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cySmMegu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCD606C651;
	Tue, 10 Nov 2026 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cySmMegu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107FF1F0089F;
	Tue, 10 Nov 2026 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302966;
	bh=xdGJzTH17z1Uu+qFbPIHuE9upPtBL58iWq/be8hE6aY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cySmMeguNScs2Y+ruwh2ITTyZX5b0lcXsR0g3XJoi6gBAse9iPjNosCXI0tv4sQo1
	 xGDsT/VnRHJbEoRZVPfSrc7g4RLzOjjiVjrqXJuWPQXhV/iiXgztcH4enfMO70Nv6i
	 BJ0H2L34lStIcFWj/uuwGqYD38yyJ5xRmAauig1cLq/Nd+AKite1BjWg4C+mHjzpCy
	 im6XmntjQXqGaLSqFyg9XFlGvk8I/lJB6s4IfoQT/WY0CI0YpJ1DFMibBLTEFB+CXS
	 ONqK+MloZL1XvsgrGlGwtPt/3/MEhI7+qxrwyF+BM7E4IFiHwahDGwVteU18fZvLel
	 d8jQyjUOpL7cQ==
Message-ID: <sashiko-outbox-206759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:29:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> File-backed mounts take any regular file as the image and the same goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D40

