Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662374;
	b=LDof0LC5B5v6vWn9CSTj4Vprct/nNyWOgGY71KIFBNt8rwDdeVwqP7K1afmds/Mrp3xe
	 UTL1LtFIK2vO+kBPBu8qtjWjN1K4n/CS5clgYDF59VzAKWV3tDEsjj3OK9z8M4/yV+QUc
	 TjTDsszkQgVVJJnOBtj5OuUvzGOKqT3NYQdTrKjdXX5rl0H4pWHLmxJbAmgo1b9EoH0Gh
	 2EDPYpGQG+wAhbyzPcg0y2vKxfSiDu/DnJ5s+sHCu+67W+xgvOwn2URYXJ2HqSNZERdGV
	 9eBUDpmx0WeS7K4HQLs55BqnvVDQP4QSMNY48qwRj3ub7E5qdPFMMGD6Fn/6JTcfWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BppQier/no6YAbI2ELhYitnS9e2Uf7y91YG6Qn8f7X0=;
	b=AzQi//HRUnBzdISBdmG7AdsdqrWU0mHKp2016Fif5GHmJGrIaxbTE28SZBzsZTZWvyKL
	 qZK3+5wEoUrG1owcPLDJDWWW4qkg7UYUvxSFrYsaBPAsJqOPwo/jBCrv4QIe5nxm/jDLM
	 FD2vcNplDTGJRBfTO5X2VILTnPjN6lUON1Elvc8piUJTvay5iN00YcYtPqrYrpLREhgeW
	 zGVE5jnsEMjy9p6nEUuI/EeuD2qAHU98C+3MeI8a7d8GHm3g/OgAAt3tma4Q+iUMUqxx4
	 9G9MbfkwtLk7EfmzSatquqhRCQ7+VRC2T1PHAKqgLEqZP/b6cRwhDt3cTLeW8VjwjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CPKR3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5B606A327;
	Sat, 14 Nov 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8CPKR3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8961F000C4;
	Sat, 14 Nov 2026 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662373;
	bh=BppQier/no6YAbI2ELhYitnS9e2Uf7y91YG6Qn8f7X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8CPKR3ijwUA9dhyqSibzYgkhQmoBHKbg4xgTC3gmJTV7Q5Yp/EWw+PjURxzhIgZl
	 ya0qZwXe4uqL4OK1HC3F2vbPzvGKkLD1lom45yBvuxxVkU5tqn0XOy3OmA5+z2RU4U
	 to/7o4Qy2HVaGHVyNwcP6H679kLm5A8KSWtB1idOKvmEILag3hbZi/u9ulm2XT2uNA
	 UdHvghaneQIO3vKfx4FGJ/ALXsQUqiiiYn7UuRAhySfAmm7b17U4yZh8cTO/y2mY4i
	 egSvfirioBNG7pluXubFCLzIx6GXsiqEXYbnsXFet19tbze5dB8l7rkMwoKN4HkzUm
	 GbWfM8HJM1tyA==
Message-ID: <sashiko-outbox-214542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 01/42] loop: refuse backing files that aren't
 open for reading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-1-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-1-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> loop_configure() takes any file as long as it implements ->read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses files
> without FMODE_READ. Direct I/O has called ->read_iter() of the backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O") buffered I/O calls ->read_iter() directly as well. That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered=
 I/O")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D1

