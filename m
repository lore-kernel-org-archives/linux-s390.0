Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827817;
	b=hkfdcfPFVEpSw6ihS9fH7AbrWrbeVLfAdvmrlZ2XlYPJG0pcu2ERbXk7nnApiNq53+LA
	 n596YHvukbDuGQd+yJkQOplv7j5TOUU/5hWZbIGfNhUDk1jIwZP0HXUdAN9kpDvHJzEU1
	 VbXAJgCf+zwjy8PgUBtWskvPA1HmAlpbN2c128xlGV9kNNmpz3/D0DLS9bj89R2ohd5Gd
	 G7sYoXiD7HzU/WDxSci/6510NqLE8/oKgw4DzmP+4BFuD8iJmNSROAqON3yVI6BdQRuvF
	 hkBQ0s86MkGraVMBFUbvCRQIyPZ3UCwRlsVUiExY3nvjIxHabTv/anHTH74mGxWSgZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zhptuZThbZfgkBJI1F7n1c8MZjLAf5rjucKZDtp8XZk=;
	b=mNmtsNLFMWU+Eb+ukXmdJixIfRmk785CkYaZ+T0w3TEsvlEapU39EURW2gvAz+arz1x3
	 diZ+F+vWcD0cY7vP4eBboHdy5l3Or2/oT/Se+RecspU7HVOvZkm9fVz4K5lJrbnl7gIY4
	 6GOgRxQU+ZAtS15zNdRo0WLVN2JdTv4barcilvhdX735ElnxhOL2Po9ResXBbf/DMH6Ol
	 lQ68pm4Av3CQuJRX8lFtBhSZXOEcbd8/M2yzJ4Ny6pHr8NffXvn1lBjbyRpsblPuSudGD
	 CV1YbpLQo8fd+y4MELs/dDunGiWX1wgCNAk0F+WZT78gIJU4iERYT6FTkXUYNNoMecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL7gc6kd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A8606A339;
	Mon, 16 Nov 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CL7gc6kd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DC31F000C6;
	Mon, 16 Nov 2026 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827816;
	bh=zhptuZThbZfgkBJI1F7n1c8MZjLAf5rjucKZDtp8XZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CL7gc6kdtNOBwtvYIiclBn+j9MM9MJfLAdxAY1sqC9Howaq5M4CkYn3Nn3OFIm4h+
	 Q94t7fP2kDw50sRVbMH2zIJPfh1yK0AHNx4udO7xIVWv9/XKAOxaIlPsiiGRjHnOpF
	 +r1bBGSVpuXvcwG00MRezvItcJ+yU1gNzpf4DcZqEoexJh/oO4Y2Tnnpj2JxfUdOlo
	 0arhyVWxAhnlXdXsqQq64mPhLwZuQRYRoGKeXvtpdyvx4QTUaJFpicJHeOh9ro7MoZ
	 Y1H4wF78xqIBbiMEdMk/j529kMN5XyFOkxlnpCA5YAkK0m5um/Gmz2QOqKmUUgf3Cu
	 hxGZoinPPV3tQ==
Message-ID: <sashiko-outbox-216873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/44] nullfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-10-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-10-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D10

