Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828195;
	b=SPtG18XnmSLRETGHU/Jh87Cmj2FtbVQrVm7DkFEcjx2yHW/bsyglUNP/VKTdT0AzhTtw
	 3KDJxwm3IuexmKzJ3QWFPaIrIQA8wGQwhptZif54PIu0ZNCxHvMqjaN8VYORusSWgK7Vw
	 5Uatm6VSFz5dMQStG/s42/xOZk2RzRoQjlAwnuxCH8WvlzZS69BfPcp0se4nqqxK3uIYD
	 0QBPsPZgI5lpmE8djXhkLECIY+wSFptNQ+BtbBD6MMkBgFHVXmz377I8J1wBzB03sUWst
	 cKy5wJqeeIMp5Ssr1gjZxaUgXaFJdI/hAu0AxKC5Hg7KedZqy5twudn5oNnZxBwvXKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aYXO2Nnw2LWFYvBotPR4CVvM0GIhYAjOS0XYgSMt5tc=;
	b=qSMhOxebWMsz8Ecb9qb9GPimGfVqhZstlKiSFO87FzgAy0ikH4dSLov9os820HBEAMar
	 YJXWQx8h4C/kRcBZ2mJC2LIIe5Ygztli6C7G9HkorKrno8/DeghVzZqpIrbdCkcGHO/cy
	 BrcljVgBK7T7TYECpM4qr0qmrcIOnNhJ+zv662jr6AjXawJBO4Kr/jsfrIqW+3hme0YyC
	 Ew/jpPfgV+D1cNwrxJL5z4E/Z2Va33Tqh/JUnYQRjB9Bme3cPYusesuzeWnhSKlo+lyG0
	 HFQlc0yWHR5klEtY4yAusKw/nz9XbRjYcck77kvqQ8vayjxKqspoInXzC1uUFCFWDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv3fUXe1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41664606A332;
	Mon, 16 Nov 2026 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv3fUXe1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F541F000C4;
	Mon, 16 Nov 2026 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828195;
	bh=aYXO2Nnw2LWFYvBotPR4CVvM0GIhYAjOS0XYgSMt5tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vv3fUXe1EwoJnBAIs01bpr8O2yky0DNIceKmSvsuQvEdy96oN0mqp9mu7tLw9p1Oe
	 36L/zYlPDHsrEDRuUzvnhfxdGvPaHYJvn2QzSK9zJ48gDPWyE0BZxBh2n5aNbJKkW7
	 CxZ5EvUbu0xYiIP6LYbn8Fubxfm2H58hrctDopOW5yYvJ3O8cOb29DiphtzJtry3pO
	 jOttE1jIEg7L+4O9iM2czCqg9WkE7GUEy42GnuNTaByrfhU/mAaidpGmWn7zdnpyaB
	 iF2b9dMA/9k9aQBFE7vdiCVnYMN/rI8mUMP0jeI6fDR0Hb9UJviZOLU3MP16mcexny
	 gPZrmfCoYE2SA==
Message-ID: <sashiko-outbox-216908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 39/44] target: fileio: refuse files on pseudo
 filesystems as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-39-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-39-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:23:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> fd_dev_name can name any file including files on procfs or sysfs. The
> initiator then gets to read and write kernel interfaces through the LUN
> with kernel credentials. Refuse files on pseudo filesystems just like
> loop does by switching to file_check_backing().
>=20
> Do the same for the protection file. With DIF protection enabled the
> fileio backend keeps the protection information in a second file. It is
> named like the backing file with ".protection" appended and
> fd_init_prot() opens it by path. Whatever that path leads to was taken
> without any checks.
>=20
> Note that the helper only accepts regular files and block devices as
> backing file and only regular files as protection file. So far the
> backing file could be anything with ->read_iter() and ->write_iter()
> including character devices and FIFOs.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-206765@kernel.org
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D39

