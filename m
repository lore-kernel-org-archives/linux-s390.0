Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772492;
	b=VFQjGgq278V80c8szWwWg68q+DVu0q060B4c+H0DE2VehRPkvM5CjziRvvkbdYPU6BYY
	 Sqt3YyV/baHaPbeRadxBZJoyJYcBm94WB1/vJ/GEdA/WWMKtdj3ql1Gsk6cIT3KYDEwRL
	 y2BzourvogDmKyWIhv1ZmGgyMkUT87DWN7iQ6uHWB1jiSnJ11wQ5/iAKuU8CuYRihkVnI
	 St4r/iNSDxS/n1Cf9SELTeYEHDsZQ/tbGc18r4G/Zg8d/zIrlZkqMaM9aODgoBHD8lVk/
	 R61t3a4UWU+rQ3RkClSZ804+Vjenqi/DnBFhC6WCbl4N1tMxeus2RIlt80VHNekfZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pvS1NrLiQObW36ENkjaYM1eIQkybPA5n2HvBQdma5mA=;
	b=ocykicEFrJWYQ2NWZyel1T7rmS+Ihlh8z8aJBuzwd27/S8RtN7btgt6XFYMI3mCD7S3O
	 eIYQzhiryOL3ySIXAKwz6z86EEdP2t8H4HatqY+QItrPN4l2yy3GOAD+PIGGS0GKAmFa7
	 BtWCpv6BYEUOqrR2hb0tDyVITyzaIzMOUeBCJOd1mYVn/oZ6AGWicVEs4hUSK+P4XHX38
	 L1BvI1ZVH3wpKHKSNOc++UzhRde7hakoFOWrQP9m0AATX+ZUQPb1v3r7EkPaJqy72ey4U
	 J+06YRXg5OnJpF0dp+BA5W7w4kwQZtIs7lWbPX0xqZWWypi9h3gZY+RO8zijoHaZdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TMKV3W+/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC792606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMKV3W+/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420551F01825;
	Fri, 23 Oct 2026 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772491;
	bh=pvS1NrLiQObW36ENkjaYM1eIQkybPA5n2HvBQdma5mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TMKV3W+/vShxEvNM34RnN/A047/BsVbGSX8kOR03WlGMVh/rhkM7Hri31ivysN3Q7
	 VqjKVC+qAwPtqi9w266625HAvmBKL1veyfneDsZPbAHqolxC58GXqKW5NIaHFOazu4
	 1sUF28z0I64c/yZUM6is52+iBcMSoD2PCRZOi/19Tqa8GpYWVHgMyemnQn/gqVh3JH
	 xLQB7RQLh8D7C5LSTqrkxLqQPjkRl69tAPP7jXKy9Tx6BuFRGZ0bBC3XfN+9INDiQ+
	 JyOLWvY/Zade1mVSURNo5FHSIQb1Yk4MYT6eg3tJWM1HjWCWA6jkP+1k4zPP3cYqmB
	 SEA6/q6eRwHbA==
Message-ID: <sashiko-outbox-182945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] KVM: s390: Rework some helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-7-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:21:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce export_on_unmap() to make the code more readable
>=20
> Move the #ifdef inside is_ucontrol(), make kvm_is_ucontrol() into a
> wrapper around is_ucontrol(). This way the compiler can remove more
> code when CONFIG_KVM_S390_UCONTROL is disabled.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D6

