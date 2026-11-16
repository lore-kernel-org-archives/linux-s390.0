Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827954;
	b=QXg10MdUPyEeIEOqkPFRQThDgh/ic6A24F5NsKY/bQZKHHGg6pHmlJeeKGCfhkW+U7tU
	 w37BGGB0E8FmuSqYJdGCyrZxjIgm6oHoAnh3qu79vbluL9uo7X/IBBVc2qeeIvFUwfu3t
	 cgU/tOD67N03EF5PTBh4vt0enYLz8dAQxc/WUOTUnXXQZ67bhN/2TsIWAx4WVYjtEPDK3
	 ZfvAcLL2Z+7JGHqRSmV1TZA6xasfr+elaQviSMKvWtyU8L2/L67KKZo4iyZnXBN447+LY
	 7zQKoJZqaWCMAmeUL1LN3Pgmy+kYPrmtxtpTO1WrbljmYZc7Hgm+FjjJjPxmhyJghNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vWcAAnToz/FMcRnaRx+QOEbVzkoaCYkbmuqhlBmC028=;
	b=W/b+H4D9Hex6fGKPrAmnQf+C8ocseFX+3C+F2fIGvk46Ck8i3b9Ny9Cd0qsY3SCcVmln
	 2fVlSLaGlYLEshu5oJRqWUxU0A0Zai0bqsWeZ+x0kUUlgtBXsETN6UM++UG3ZhB1ZHQiL
	 yQ+9ubeUF8fOF2F1edD4nyGtEbxJTA97xEeTizsrM948FsJaXue+mJSlZg5Fv9uzY/oLL
	 OJ9HEvhNFj0EKZydUDrluCjxX5dZhewxMJAmMei2Eg+xgpns/gdvgv2adt9rkUpvnickG
	 r2wGEuEgq9W22sztdZgBUDmDath7+dlsEbwD0UQdB4l+STPihG9UjZjSTTRFmvsNwog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kw/gWRZZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4D606A883;
	Mon, 16 Nov 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kw/gWRZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A51F000C8;
	Mon, 16 Nov 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827954;
	bh=vWcAAnToz/FMcRnaRx+QOEbVzkoaCYkbmuqhlBmC028=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kw/gWRZZFQ/Xhftx/R+HpuGGLJrBm9l5cwoaVj6s/vik8tjL5Mh2PZ+ic93inmAh8
	 jloc4E9TE0O5X3+tZxAPUNrarBJJvoc6ng9AnbPJ0nYTrxq+ChKYEfKy8RVSGwAgOj
	 BcUsOgsQ0MYl+e9pispmN3KSgqVN5/wbeCyiEGelESw3PcMObN/v0eqrfzDQKYKTw/
	 H52GPbVaX5tNDEYUt2oCbkrD5LKXx4vaPghsSUwOOsnjj73bIPJCFDwDzZRYXpFq8l
	 C4483gL6mLD0IXj6tZVHDngZGXoLg2eVXHU2cmzSB2+FYKjAjTkaRaALqZIztw0RjA
	 QIhJEn1U12kTA==
Message-ID: <sashiko-outbox-216886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/44] kernfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-5-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-5-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:19:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D5

