Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792567;
	b=mJUVmiJWlT3SXunXSScpGWVj3NcUWieeSKz+4BrLPAuWUYY/VRuFvpGZny3hNzrilHaI
	 y0+iLcC+DHDrgQkErvfA79M48JLfkAwNeeLMv9PL/ZYZ0nP2t+R3cNzWZ4Xppj9eScetf
	 cet2qyQjzWpPNMEi8FFIyAhXKV7yeLTiABfoRtzWjujxetYI9A6mbQT38X7PL8/Dzp2s1
	 Yw4Fvc6uVAi81HN4MUPabBlsk5wsmh43q0vwfrGBiMcSotrMAZU/iwayVRwKfH1OBbn2l
	 VtUcJcWJXgraQ/5vSxIUExNZPkyC6LYc8252lcgojEbzteVlpqxd8QWuhpHpvQFFT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k2SPwq0hw0HWpkrqKETM5cfaWXe/xMJXXI0bL4zvhzU=;
	b=XEkORK+Cx9BXKz3bjroYervIl04JqBkfjIG0igh1cJFgms8IxX8WSQjN2Zm5MszIdwft
	 I8ozT3G/UVrW1S/mIjA9C64E0Ta+CGWygnkb0N+8QwbE9q3BuaKpH11/4EWzwujraJb/b
	 Kh1R1KNfkJD65nKTjAplOwmK0wzjUmFc7rae7IgW5HqfxuFPApy+CnUVxHave5Wv9fBWs
	 dNYaqqSjxb7LNDd4af1H5KyBjlEFAiwUmlgPYe4bFLNTWCmDmjD39kuOShxMfJvwambnN
	 /gswK8HYUjtfzK+2PC+/1FdifgeqESebOQ4HN7k4QrxjrvvTc1kg03RVQbS76ozRjZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTQKv7yf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44159606A31F
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTQKv7yf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C126C1F000C4;
	Mon, 16 Nov 2026 01:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792567;
	bh=k2SPwq0hw0HWpkrqKETM5cfaWXe/xMJXXI0bL4zvhzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTQKv7yftdMjrxfa4h8OktJmQ+St96H45mbQS18ZMDlBh97Qyd8SfHIhCpbAF7Acl
	 98BEHXo3mJZ22FXEaPymHPt2eTK8d4DpG1tcJHUzSYPFM368a0L3BdQkwSEvLZCSnJ
	 l8dqkTo6NYRPj0ydStg2M83iml0Schstv1JfYEloCsYW8sJeufi0L7IgJNpP/+DkCA
	 fpmqxpClXZcQoc3G8KecEGF0LCh0ZTf+3hzmEinynf3Nb5xe0+UnfhL1dAoQAibbDY
	 LVzrC5nHBJwAeg4yiJjrwPr3OC5jcG5EciTopIX9rytNpW2vF39acchaqTwgq+WOn+
	 PjMDesEbz73jg==
Message-ID: <sashiko-outbox-215996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 5/8] net/iucv: factor out the HiperSockets
 frame dispatch and state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-5-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-5-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:26 +0000
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
> Move the switch on the frame type out of afiucv_hs_rcv() into
> afiucv_hs_dispatch(), and the state changes a SYN|ACK, a SYN|FIN and a
> FIN make into afiucv_hs_synack(), afiucv_hs_synfin() and
> afiucv_hs_fin(). The three are still called under the bh_lock_sock() of
> their callbacks, which now test sk where they tested iucv_sk(sk), a
> cast of it. They are defined ahead of iucv_proto: the next patch
> reaches them from proto->release_cb. afiucv_hs_synfin() and
> afiucv_hs_fin() are the same for now and stay two: a later patch sets
> RCV_SHUTDOWN in the second only.
>=20
> No functional change. The next patch runs the dispatch from a second
> place and the three state changes from the task that owns the socket.
>=20
> Cc: stable@vger.kernel.org # 6.18.x, needed by the next patch
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D5

