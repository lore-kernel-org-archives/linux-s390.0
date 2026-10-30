Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336081;
	b=cvWZjT7+jjNJuzXKd+of9nqeJUm0zb/F90T9h/XYEEh9VJOCYLCX1Z4T8bSwmB4Sp6vt
	 /Vk0ikzrk4vj2okESJjUwGGQxDNeqsySITm8ITNPMkIAi0kEr7smZfZnlRvlS+INVQw4y
	 4m7dMKl/5mP+zyQYtRulTynvehFvU4Vp5tgjcZP2nR8zEVjHIPIaZg4181iYqUTQlPay4
	 CnLLkYPi81CaPP7nM11jBxixuah9wsGPDLkK8fjqbZncPB/faJpQnotlytj7z2ANCj51/
	 2d4ldBR0j4FyhkurS0pVkfPKejF9B6DB0lkL3RhyAhrUK1HF9Vdx2HBZtukh1yBaveA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WZfFeDqbdcOih6qA1/0BBGjlPc+vzdZ9HbJkxb4c1zo=;
	b=5gGEHYLURXY0aObolyiwddko4UCGpbETiNVAdUq1xiaOI9T0NEdJs7/zM4wY0vzi+Nxs
	 lFvkzguocdtI61XGNx8NprtVsx6VqlXuE+JbrFpckObeDF/QsdSHE0Rmt23gn9/83S9NN
	 gydLzyfJ8u/NgY54dWSW9Djv6JUWf9goqBnmRhvUi4xG3LYrW6AajOz/WcUgKbaVTBy9e
	 8CQuuQxw8P9s6wzz0pjxfH6wFrCidRgrAb6bAatudrREgu4kVJa/87DXWdDjoz3H7/Q7S
	 ch+LvFFbbVODqSFQbBl0mAbqsrJduQkZkQvYjA02YLWRzywxq3RNplYMSHZWmMZC//Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jvbky/YE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43529606A31C
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvbky/YE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975541F00A02;
	Fri, 30 Oct 2026 04:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336080;
	bh=WZfFeDqbdcOih6qA1/0BBGjlPc+vzdZ9HbJkxb4c1zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvbky/YENJDroiuh3eoYVE6o4UkZNl9WmJIynh5ZBQYmFmDZQ/TQG+rGjlCrHqi0D
	 3tbIho+rSyF2TKXfCJUqdbZfEa1ga3honDWvn2raXsxejD9BvPTAj146wzOKyG7Fo5
	 xL7NoaEqjlC2L9NmBrNHdBjF0ueL5YMqFcG62OIOfnRoyLrFqLh3qcjMEnHqm97oIP
	 /ttFgYSQURY02gPbxh2TFPWHgFJ7+XKEym7MrF91FkaGUFDeO8sQ6iGQL3PdpENk3T
	 iGgCZ1kYWaKSmsVrzuEOj8CMNwvjXolzSu7jgdE5phG2HHUC9pzZFBGjOJuTSu56Fd
	 jPn+wgLTvqQuw==
Message-ID: <sashiko-outbox-190539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net/iucv: do not count the SHT frame against
 the receive window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
References: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
 <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:40 +0000
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
> iucv_sock_recvmsg() counts every HiperSockets frame it consumes in
> msg_recv, the SHT's empty one included, while the peer counts only what
> sendmsg() sends against the window it was granted; the SHT goes out
> through iucv_send_ctrl() uncounted, one per shutdown(SHUT_WR) call. The
> next window update zeroes msg_recv and takes the surplus with it, but
> recvmsg() sends none while frames wait in backlog_skb_q, and an SHT read
> in that state pushes msg_recv past msglimit: WARN_ON(1) fires, the socket
> is closed and the reader gets -EFAULT instead of EOF. A peer that sends
> past its window reaches the same WARN from the network; with
> panic_on_warn that is a remote panic. The SHT frame dates from
> 82492a355fac, the WARN and the close from 800c5eb7b5eb.
>=20
> The SHT reaches recvmsg() as a zero-length frame, like a zero-length
> [ ... ]
> Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transpor=
t")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/netdev/179183431327.434549.44634814883785=
0426@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-b4-disp-dd=
3e4ebb-v2-0-3747658d59bd@proton.me?part=3D2

