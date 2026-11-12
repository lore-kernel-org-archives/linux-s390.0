Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458690;
	b=0I/Fx7XVx5DWpfRUB/cpHUdo0vDV7IXJjhH7TOND60+T5EuP0wfoQZX64HHHUUyH8c0F
	 W5bvfMESSPqvH+k8i9pQL9hs+Eq2SMODBwi7VhQIcRA1L8f6y6ic/HM5FZkGaj2i8JJRw
	 lfhGVzBWUP16/Fs6HCuhzj5ijokbO22tXRGZFE+NxWZDIY8CXM5RiwNkRt9qg4n5DL0Fr
	 x4zm6WumWEJDWbwea6K8C3Qz2hJrn2+Y1fyJZFyp2fahhVpbRUk8P71+rgDGEdZUSfhHi
	 NlyvTI3WSOqN96ELVjlhkVsz+QK+mefVPStKSItbbHHJZQ/QEaZ2zQE9U4KYowl9OdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZBI13w8bTJo2L4JQ+pUCb4yq+WqyCEDukfYSHlJv4XM=;
	b=2N1zIUgSxWdhETS+pG3ggZ19WzLJfusfoJFQc8AFdD41gt/8Vf7KblqUZtPe3brsGnYu
	 lWFLj1jJYfokaM7VhTrAI6hP8gPA3WH5AyfoTNu/IsshUVMISwnc9KtkFZzqc6ZJFQzqf
	 9/ii5DtmJOhoc3H4Sg1Jvl+tO8Jo3Df9yVudRhCN2CqEVMHYnOZXvtJe7iXTyh+2Ux9nd
	 7QPXVCV6kNQ8fwe84fb1ZlPrlVTSj3sOdUtUh+wZdyT1G1H1mLjiYvzjm7XUvDVc3DMx8
	 dKlei7cVXwQPkAZTz81zgJY9O9i9REJgPsSMQaI1uL0TybTHtnePcGqTFviLzTdajCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+Aw+d4R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8B606A321
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+Aw+d4R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F21F00A08;
	Thu, 12 Nov 2026 04:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458690;
	bh=ZBI13w8bTJo2L4JQ+pUCb4yq+WqyCEDukfYSHlJv4XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+Aw+d4R2xT+b9reMrTOgOWAtvolUbrsZqgjbkpqntXmiq9qSLO3oYlaLhcFOpOGH
	 Pgpk3QhRLSBwexwzmK1LERgCvg+iahpDfIMq3ZN/KUlAuIs0b86s9IReOTgJ4SvtKL
	 e1KAIVXkxpOII7k7Tx1XxHQYjQ4gGnf0FO/DDU/8DpXULySmPvpZVYI3VjtV4LYKX9
	 C06L9JNftDjQhRcveasBmEpCM48yb859UsTxWxwjcbCLsUkUTC3gyO3K/Dx53TiRWb
	 pgbq46YeJzuoVhTUZ7DzNbE5QrOhKdHdq7Raq0CteOARg126JVzL5wG8mGetDCz+PR
	 2WfmvjhR7SjAw==
Message-ID: <sashiko-outbox-210387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 5/7] net/iucv: serialize HiperSockets receive
 with the socket lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-5-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-5-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:49 +0000
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
> The HiperSockets receive callbacks change sk_state under bh_lock_sock()
> without testing sock_owned_by_user(). A SYN|ACK, SYN|FIN or FIN that
> arrives during a system call on the socket is applied under the task
> that holds lock_sock(), which goes on with the state it read. A SYN is
> answered for a listener that close() is emptying: the child is left on
> the accept queue of a socket that is then freed, and nothing can close
> it. It keeps the listener's name, so bind() to that name fails with
> -EADDRINUSE from then on, and it keeps its reference on the net device.
>=20
> Either needs only a frame from the peer at the wrong moment. No
> memory-safety report is known.
>=20
> Take bh_lock_sock() once in afiucv_hs_rcv(), for every frame that finds
> [ ... ]
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@=
proton.me/
> Cc: stable@vger.kernel.org # 6.18.x: f38bce9af9e2: net/iucv: take a priva=
te, writable frame before rewriting it in place
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D5

