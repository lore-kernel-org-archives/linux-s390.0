Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458691;
	b=AL1ZtINPdE0pxCr/ohVXjhP0ohpnzL3O8tmBh2Y4B3Tfrxs0KaRj4QlN/hPGM2ARkH4o
	 fvZOVz7MYfFNGeOkkbgvMCpgonsq/zSYDGlfcrUPQuIFiqeB/mWAzw1wbxra962JZ6vlK
	 DEl3/FFIhMraPUp3Zn0iieuU0m7oW8Cv2UqsGM72EnusAVP9UeoMpjazgBTeS2+STvRQZ
	 i0mn8avs9LQelasJ6i+hiRl3ZxrDWw+BjLXrrGT3kgLCmddytxn7c0gdPx0+SMyQ34Yw5
	 PH1GIyMyxBEQ9WXsDQmXK7hG5X28T9nCpVOJaMnnHA+5D2TLbdKr0K7qr1l22nJ1Tvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MKfA4uZ5zei/FnwWNJ4fI+ZvCFupdU5Z4IcFZFaoipo=;
	b=IodgSf6Nq7laW9h4cV6z5SaFXLqRKn+kVY/9q49C6tWur1lTDU+WVeE430/r3RnHQAfb
	 KtVrAG9XNgJRgR6rGlNYceqXtvrxQ32olcr1Es8gKaU9lBY+c7pLhYQYKZtopMRzJGzx5
	 a8qg5jC4CTD0v1qxqT4/pgIAcXchOXWCv3OMxMDL4KRZ297wjyj+j330q2y34Dn8H+clL
	 kedxH1IYlaxwOLod2HeVb6GuksYF0Of1lYZfPiVUOfbXlzkoOW2l1aGPlSgDdVtyRrfal
	 vWVAsQOKDlzzaZ4jLWqk1j0KHOPIsMIwC6+kAFI8RKSOMrChs0R7Ra9WuhoMx4pjKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4djdmDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65E606A333
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4djdmDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D5E1F00A05;
	Thu, 12 Nov 2026 04:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458691;
	bh=MKfA4uZ5zei/FnwWNJ4fI+ZvCFupdU5Z4IcFZFaoipo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4djdmDtcN4wTBiOAOoIgMso8qAOfTSjZU7cEsrCSQ1Lp460sLiadAvWWtK+Lthuu
	 D2rEuWjZlcOfXicFaWgaaIIGOPczrF/sIY5dHsG2zzmLQQjIHg0+Q+jmjd/QyObtDL
	 yZbksJUTRgaoJb9rcFSNiJUqsJfykgApjtqYuS1PCaARxnmhrW2HYZQfVS4pUvfwhF
	 kdoWX1MOROmv9TzDWfjImQqW3ub7pRIVpSCGV0SzgMBFUiVWJKaV/mSUcP3uGSGpFB
	 Bmb1rcDt/eLZwqfpaqH0G5l+NUIBqpGXyhukG54qjxus95/tdHqyM8tHTyJ2Z51/gG
	 zglR1ifCGMk+A==
Message-ID: <sashiko-outbox-210388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 6/7] net/iucv: set RCV_SHUTDOWN under the
 socket spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-6-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-6-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> shutdown(SHUT_RD) sets RCV_SHUTDOWN and purges the receive queue under
> lock_sock() alone, and nothing orders that against a HiperSockets data
> frame: a frame that tested RCV_SHUTDOWN before the bit was set is
> queued after the purge, and recvmsg() returns its data after
> shutdown(SHUT_RD) returned.
>=20
> Since the previous patch such a frame is received under sk_lock.slock,
> also while a task owns the socket; one that waited for the owner runs
> when it releases the socket, which shutdown() does only after the purge.
> On HiperSockets, set the bit and purge under that lock. recvmsg() sets
> the same bit under lock_sock() only, when it reads a zero-length record,
> which is how the peer's SHT arrives; that write and the frame's test are
> marked WRITE_ONCE() and READ_ONCE(), and only a frame the peer sent
> after that record can race with it. iucv_send_ctrl() still clears and
> restores SEND_SHUTDOWN in that byte with plain writes. The z/VM branch
> is unchanged, less a line that was commented out.
>=20
> Without the previous patch this one changes nothing: the frame then
> takes no lock that shutdown() could share with it.
>=20
> Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
> Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb666=
7e@linux.ibm.com/
> Cc: stable@vger.kernel.org # 6.18.x, with the previous patch only
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D6

