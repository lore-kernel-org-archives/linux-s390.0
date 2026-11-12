Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458681;
	b=tkFYq3gknj+gJQssRsJV77tvkxAiAIdaz9Ggm11rk2ZC9FyQ6t6R/J06ZxVqqaCC/i0R
	 6O1/Zg/S028vHfwuIbgBj8Q1ygLVnJG4MPDieTN1Vaay9inhwyjaZM2IQ7wqkE9upaSta
	 aUo1F4AFQ5qKhGNi0MZBi+TIZxEo5/NrBOtgZsc9M1+BdErqGq33EaStQhzlkqj9Syc1F
	 NtM+6+A6eesz3nAKgxpKRtdzwjKUHDROO3EsJGjS8A4HCNdz+OWWThC0rWVitq8Qitzjr
	 0Fd0SO2efs6ilIN9Qm1Ee4tXCvyg1ieYKZteepgy++EJ/TqTO36S2V5KyqoQ+Y74ekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+4QVF8CnlTdJEVG0/a/MRa2Cjnha0b1fnwzkRhzlSqI=;
	b=CmJOKh55rgcafOz2aTYh/X1EDK510ImhaFGgQyYTVJvX2YhVvWtFPIKNv4R1gIqZFSAd
	 kv6tTSLXmnYh+3YXHLEnFMVvzqhfIxaaWwtRei9BpqUr73uQSLJ93hcAS9sLyGL/iL5ye
	 CeMNVwFyItrvuHIoVA0S0H8sKHGyzl9Du9DJEb8uIFQjjJ1F+ZjRD5CizCCW95/2aSaIZ
	 Q3rDnt83Gp20wYlZt/mtIwJYvyCj5oYulPmN6w711NO6chVGzK9shik2JTVOZ/G5d+dqS
	 qjkLKzPgmrjHsM8j+ZpOG8f/wECLbb3dpYdnihCeM7lFnPlDf91k+LugBaxrkAbLqGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ8oHzKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BA606A321
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ8oHzKz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A746B1F00A06;
	Thu, 12 Nov 2026 04:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458681;
	bh=+4QVF8CnlTdJEVG0/a/MRa2Cjnha0b1fnwzkRhzlSqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQ8oHzKzLR+ClJTI4qzaBEXORSfkfHSt5VOsb2G01Z7vQwfh0Dxo03TU6j8FiElPC
	 dwNKXn3ncGVXkqhSOsxeF1N9kJHNInL7zZMH5JQNH3SDBdN/aHUdM5N0SOcARBf7EK
	 awRCj1a2PrOq0YcvzP+wF1n7NLX0V6IYe1uQnGxtVg2ewA13Mn9/l+0kBno4MaNvw1
	 r195XCfL0S0KC9Bp8xfhEy97BmLBnHtZAEakG8ziWnMHN/tFjtmLf5LXJkoZrXaOWt
	 on5TI/VF5Ch6MU9Yjew9QC04yIVYmjehHuMT/s9d87lhWkKPn9NqHaZGvB8hwnbO+K
	 9uarYLtdWLopA==
Message-ID: <sashiko-outbox-210384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 2/7] net/iucv: fail sendmsg() with EPIPE once
 sending is shut down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-2-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-2-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:40 +0000
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
> sendmsg() tests SEND_SHUTDOWN on entry only, then waits for the peer's
> window without the socket lock. When sending is shut down during that
> wait, by shutdown(SHUT_WR) in another thread or by the peer's quiesce
> over z/VM, the wait does not end and the call does not fail: the writer
> waits out SO_SNDTIMEO, or, when the window opens first, sends its
> record after the socket's SHT and the peer reads data after EOF. With
> the peer's FIN in as well it returns -ECONNRESET for a stream its own
> socket shut down.
>=20
> End the wait when sending is shut down and test SEND_SHUTDOWN again
> after it, ahead of the sk_state test, so the call fails with -EPIPE as
> it does on entry.
>=20
> Fixes: 0ea920d211e0 ("af_iucv: Return -EAGAIN if iucv msg limit is exceed=
ed")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D2

