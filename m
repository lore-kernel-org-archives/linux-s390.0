Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662892;
	b=vhjJGs3UIb+LG1PxdmV/9buuIvX5zCQu+fCPM2N69lmg8vDoUon4BP1V9YyQMOkx4FLu
	 xuiRNgc6kwNupdeBi1SYsSK5e5v0L4H6m06oJT8OT2c1VnCPWjGjTiRbtWm1QnGZ5Teig
	 SUwQk22zKX7iIe3gOOn1SRPaTZ5h71utnbBnxYBY6JEcpbbj9HXyitqchJf2WSgbP73KK
	 bdykXHJqRhLosJKjB0QUuZh7dDxW73wi4GfUxC5LW55UyVkIz4ShQ0BhOlAr2n6kAyb/l
	 II0lWhc5uqnfOAmBwRppYz7K0PBE+iX23I2DZoZp3gcoqGBpRSLMM/BTF5yFezh8w1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MQKkVPmgp1o0kYAP+MiIJ+13LyCNBdiDK4tIqYLkmPw=;
	b=c1vVzsPg52razfXxBx+i5wpBWqrK6KN1UjYJGR1qmifMdHStUWZeY9tS1YvsP1ek2f9M
	 cfJKRG0uFJhLBEzUmWU1A+n0Oz0bajQ/9f/rcolboIszLzYkC1YesDYRE6Ax5/r0tmN7o
	 kUkiDflP8EIwJRiJm1/dNys5LnFI2eLoar8wjACG6ezu2jfgkUK/FrPpos2/r1QUwn3jd
	 fXhFQz/XITSNwBku6OzZ8czmNHWZ+eT4Nosov1WDBE8ScgVOMQYPrMeaDPMYT5DqTUknb
	 WLn1hqu/cW5awbAYhVBiCN0MmJyQCLV3XkdvZgZvCJtQyF8/ena1+JEg+sp9JT+vXKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhMM+Xme;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCC606A327;
	Sat, 14 Nov 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhMM+Xme
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD89B1F000C4;
	Sat, 14 Nov 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662891;
	bh=MQKkVPmgp1o0kYAP+MiIJ+13LyCNBdiDK4tIqYLkmPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhMM+XmequDaWuYF05WTrTPSKZdhJiIZtqJC0l+5WUrne+PFHZ1Nc3aVA7HSj/z1P
	 E0XyGgX0biwXS5GJztectwncqj6eMsaZcU0Rwp8n/7GrgFx95lvDP482dbeE0JEnEF
	 nAH780yNRP1Lc52e2IykQwN8fevarcEL61HpEuOqQnSi5H1woZyD50Yq4cHXZjTnZn
	 m64h0diZ3kNkQbH7AO3DtH53a/YlYU0AUu7hg9x3Uk+Pqz53ZVkpJal/JxW3m9pFEo
	 sqP4+SlPKiIv8g1k8XC4VLZUnHIgI8J0sGl8/2/ySO9NyoFBvWpMYZzoH3MQOZ1GBv
	 aNBNItAbrHcUw==
Message-ID: <sashiko-outbox-214568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 34/42] loop: refuse files on pseudo filesystems
 as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-34-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-34-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:28:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Currently loop accepts any regular file that implements ->read_iter() as
> a backing file and any that also implements ->write_iter() as a writable
> one. That includes files on procfs, sysfs and other pseudo filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls ->read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device all
> of these checks are done against the loop worker instead of the task
> [ ... ]
> now happens before the loop device is locked and it looks at the inode
> of the file instead of the host of ->f_mapping. For regular files and
> block devices both have the same type.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D34

