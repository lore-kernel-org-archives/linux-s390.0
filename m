Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724033;
	b=LGVti6s8Vo+B04Qf4N/1R82Bz46cD2C2M/7wlZhX/ViaVO2PbSXP6Yl7SgbKsEAc9ko+
	 TQtOvHA7p+dhuLL2lVlPvv8AGwc84QAXbQjpSzzWjT8BD1u+WzK9zJhr0UQdP66K8h9fH
	 YUJs7wXNW+96umiVne2h8judPJjYsKUxDj2VD40WqkSaFTTKF5qAUuDLVsbCVXdieO7af
	 AfR58Yqibz0/pI4bhBJgnm4IWSbsiH/uRL5Xzevbj+1xUiiTXgYC0aQTzJ1TnEZGosHA0
	 c+kM/6ZQDJobUZJo8HCPlffJNSaDey/KR1bLytlFaPacd2yLxAk2+A7MIsRYjKc3ybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sodceyJ10Pb65e/zz2JsZmZm3PKFfk1Zn/CE/mFj9FY=;
	b=WcEnoSIYUpT97MuaowxrxEXIE0FGLq+JqZPa/WNUd8BOLpfeAB6klsKnwmwWdlrBZGRt
	 tZL6EtSInX9+8cFJHPBVGh/tsYN5WqPF47aMvtxqOpDwVnVEhIfPmpi+Z+VGEjkZrawgV
	 f8CIFhSIdDxa+3sYuR5F+eg2icFIwStEOHBmHeZFwMHb3yFtIEeUjQFOOUXnwrKa75aNI
	 zGFfiO6Vslu+3WjPaKNvRj22Ls/dU+yR4kCnU4aCHaa9SbbO0hafnBhb4F9f9tSwKxLjR
	 GmoYo3Y5cLlooPj06o/c5VDpC3Sl8IayZhaRFXpJP7+lQMnshqbT0ZnItSPaymNgBNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1CPjckN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF91606A319
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1CPjckN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73E61F01829;
	Fri, 23 Oct 2026 02:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724033;
	bh=sodceyJ10Pb65e/zz2JsZmZm3PKFfk1Zn/CE/mFj9FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L1CPjckNcQoaLB7mkwiK8J3IzuLlzylPbAMEHj68p3fuD2M3PdYcgbCuO6gNZw0oI
	 ni0TKEskoAukwsV/VVSxx4gxjz2cYKAgHTcgItUux8JaKEMDtqGBBgdN1Zz1qb5Qni
	 Oi6jESMJZiai8iNcQIETJ/OxDYTyndXcMiAMk71l9s6dDdr7OPqnDppCXWMMLr7pd+
	 7pgS/XXUTOweFaQCm5U8KncPKmHJl3qgLdos3gGWA3kgL83RHvp5VvbPKJsspcD+K4
	 FlPFMnL30dCp9Vl9sPote3wUkg8S/cgAkr7ruysJ8Vg34eNNmdi+7KcEEIsyn6OJCD
	 rsVRbyGRYfF9w==
Message-ID: <sashiko-outbox-182251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: do not count the SHT frame against
 the receive window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-b4-disp-b35a9153-v1-2-d74645876195@proton.me>
References: <20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me>
 <20261022-b4-disp-b35a9153-v1-2-d74645876195@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:53:52 +0000
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
> data frame, so test the length: count only frames that still carry
> data when the read consumes them (rlen; a partial SOCK_STREAM read
> requeues above this point, so each data frame counts once), and close a
> socket over the window without the WARN; -EFAULT is kept and nothing is
> logged. A zero-length data frame sets RCV_SHUTDOWN, after which
> afiucv_hs_callback_rx() drops every later data frame uncounted; the one
> slot this patch no longer credits for it is lost like the slots of the
> frames dropped after it.
>=20
> Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
> Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transpor=
t")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/netdev/179183431327.434549.44634814883785=
0426@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-disp-b3=
5a9153-v1-0-d74645876195@proton.me?part=3D2

