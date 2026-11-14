Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662552;
	b=uswh4HdnXY/VNnP/vT1xtDjw6Ns52FoElmBuTAohUe/3TgEZwVg1pH22tkWqb1Zr6z2m
	 Z9poJ8APPE/lBURql1CKADa0NYh4/0Myw3xk8uvHQKGFdve+7inIdJ8pdxSzb7fEh6nx5
	 isZ13bBoC6HwSUWsQdLc2kZeurZorVOd5ZmTptdkKPSTq45DWLIiAyj+bg5G7ip1CkMkA
	 q8z9ZB/PvOqTvEEknyz45qREBsNeUy+M/wsdfqOGo727/7DLbn9RNwaTjR1/t+dYQMcq5
	 V8P5X+/JSVmd8VxhV9FoaL4QNcR/GcSRwQS/8vNPgs3VMCySSPzAXyS7bXtOaMo/Tiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DnbK2013OUvbRPKHIzBBuyjCcbO5E1xbLmLAKsDuV8M=;
	b=Qfa3gTyEEfhPK+aC9O5AZT8jqZK8T+Xv0W+JCQ+k/5bxX6RyUA42OI8zw3YW1FKiA2nV
	 8AwCva8Zp5Tlo3d6i45AvSHGCJWL3mIBk5qa1bg6z1n3qWTIWlcph+XBdHZkyZY6eE01h
	 DjRGcDoXko0KzyewuxibEEwrlOinv6RPLrwDFYQA3yXEGFrSScsULW3Z17vln3+G2YCBR
	 oHOfa1IElbGfODz+5Qse5CXdvvOWjiseNTYRa2G/edIWLtomA7qchSfsbRSFdbZrR3+Ih
	 wv5orIfjnD7wdrm0sAZKMFtss8Z7FMYKE9HG8qeWiLbtUJYxD3hifRrsQPY5az7wWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U4Lg/Ph9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CE606A327;
	Sat, 14 Nov 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4Lg/Ph9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99841F000C4;
	Sat, 14 Nov 2026 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662552;
	bh=DnbK2013OUvbRPKHIzBBuyjCcbO5E1xbLmLAKsDuV8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4Lg/Ph9kFlGhNHBggJNhs/HQoRnZNS/0+vwkQHqKBV2NxF3CVx2O+QfT5jVUXOXa
	 IY0yQ6h4N2IBRyYkaUc/n7y5jDPybH6kgvA1CxR6lBbZ251D1xyN2fEKsr6ZxHSS8z
	 YRxbyRncvEnu/aftBvtCxSnX1JwUQ1eXFGc4QaJmY9Zn3xwstHAFHbiB8Jfw7UCExD
	 +q8AdUdrWkqzIDZgAY2tVBjSvM+TxZRHvEf2bZlIVGiR1vpZdqzqqHEgWhuKywUiCK
	 P0VMyG/w7flALGHvZEVLgU73JHNO/CNIr5vGecouCWZLOjn5XDcGVy3KlTmi0/V8G0
	 vPd7p7MPa8qJw==
Message-ID: <sashiko-outbox-214557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 37/42] target: fileio: refuse files on pseudo
 filesystems as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-37-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-37-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:22:31 +0000
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
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D37

