Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722308;
	b=G5qrKQ7XHi4p0aRx3uz5QMyReNUvTtLh1aZ0x5e46aCW2K96M6N5QocRtXxhan5z2Npk
	 VzVwpvHbCbquMb7fubV2WrFyML0gg2k93iBBYaJKuBhefjL4q0l9qoT1n59wyRaF4czDU
	 WLbK4Fzw6606XlarPRdf3q5RJt3Ie+yKEzBg2MRho4YKr8Jj237uepWSOLhuE/b9qB2WI
	 83h64oVaiF84eyEj6X1xgyBA9X2teN7eQH65hddXWI4uzfZawOFw/bnqtHOY4T/hXVhEq
	 Rz+ZMlhGtDxsaePNn5U8TXAwwgdb+wJVucyOXJl3NZckcQ+gdkPCaKQs5d03sORDMDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=69SIbt0uF7BfXVsActnsMjToQV+jXBYEJs+HwXzpRoU=;
	b=atmr0g9u/mPEm/65Yg/lRaH7M5GkylLY+MPRO+cpkCn1Jykz986PKiq5sfS38GgJYfZn
	 EYe06i3N3aDDP+CU5uOXOmRYJhWrbvET9dSbLCEXqXqeMoax87VxYMRVp3nVFwjKoFiNX
	 6KF5qBbZhvEJ4Z5vc8TQd9tqYZB4FBERDidTqH0ckKa+aTSYdgkjQjhQxD3VnxnMfvKwE
	 06S9ow2cvzuPIwpK5geU9tq4moKevCRGnaVm8mNI0HOT5rhaEFSoBOLK83Fe4eI8t5SRQ
	 +83Sc/mE+ZNGe01NIQ6BG7JkKLyOLdH9b5ciX4/LXtMJP3ClfRkQ7AF94qI40FsAyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRB5JQkA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDC606A319
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRB5JQkA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C933E1F01825;
	Fri, 23 Oct 2026 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722308;
	bh=69SIbt0uF7BfXVsActnsMjToQV+jXBYEJs+HwXzpRoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRB5JQkA5HOh4jnPOu0aWh/8TcDm61vR4AjZqQx5Xk7TBJPonFybohpIBhWaH4VQJ
	 IC3sbbEXpBgIdJ1I82I9JfUpwYSuzGiAP42lhMFKHFZ4bZ4L9IKCRb/2Jq3pJnB33h
	 bFmPkvXnsGtJTkqF7PpsFt/LzGjGnnYV0DnW03VzXfx259NKgDSsqY/jxN3T2Mm1x4
	 FMVaAa71Jw3JqBt7mjYEDgKbSFVogQ7qWxqkM1hEQCMzkzWWLc5oyyZ0FXXcRZTTLL
	 RGE2T1/LAYHdAoNLHKoOZEK4hvbkpABOt5GuzxjAji8fj8kmuXjRjr+qj9DpLfdtWK
	 weKZuSbmsVy7Q==
Message-ID: <sashiko-outbox-182230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: zfcp: bound the RSCN page walk to the status read
 payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023022056.3106651-1-yhlee@isslab.korea.ac.kr>
References: <20261023022056.3106651-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:25:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> zfcp_fc_incoming_rscn() takes the number of RSCN pages from rscn_plen in
> the received ELS and walks that many four byte pages out of the status
> read buffer payload. The fabric chooses rscn_plen, it is a 16 bit field,
> and nothing compares it against the payload. A value of 65535 gives 16383
> entries, so the loop reads up to 65532 bytes out of a payload of
> FSF_STATUS_READ_PAYLOAD_SIZE, which is 4032. The status read buffer is a
> single page and its payload ends at the page boundary, so the walk
> continues into whatever follows that page.
>=20
> Every iteration also hands the four bytes it just read to
> zfcp_fc_enqueue_event(), and that event reaches user space through
> fc_host_post_event(), so the bytes past the payload are reported and not
> merely read.
>=20
> libfc bounds the same field. fc_disc_recv_rscn_req() refuses an RSCN whose
> [ ... ]
> payload size.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023022056.3106=
651-1-yhlee@isslab.korea.ac.kr?part=3D1

