Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792566;
	b=zBl663OIYY5jw303BxORc2nFykCzTfiug3KFPO2VD53cJQXg+K8jSy16UZBQ3T77yHSt
	 CAxlO2i7RIr3fzdShC22yqjzPW92d6MdRzvCOquDKf6VFH85RyXOM7qxffwn7clfjW9fG
	 +Z5rKsDstr6LNzlqzo0qXmD5Hucj0JqPZndhDUSQAoC8SU6jDnVlZ2bU2Hx3mHnUSte4N
	 freaYL+gd2gOkUZr7QcbB0yf2B0N8tL3y2JpAhbC+5S9fpcQFnxpIgE1A9kwvkSB6tb//
	 rCP/8cQ/cRYhG0yTOydTSafjavsT7KA0uNQPOhTjqcrwtzigIc9RUbnXjRFVyh6vu5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KnRHrqkpHdZDKBjKDizqq7GHoNMfa6r6/nhLfpMNFDY=;
	b=Q21W/KuVEvPgmjP/dAcIwHMLmP/w0t6eB+qVMmc4pFU24kZpg2+NpzZMLZa93rKCCJlZ
	 SpvM02IRGqA6OpOyJJDVbrqyPdKawgdMypjsKoIBYUG8lrzABPwECtYILg2As9grgVJsk
	 JJW1gsbnhz9ydyFxkXaQjl+ZUxZWLdmF512DebRb2amTCDkYNNji7gjOLOrHAKqwkXoXQ
	 g7pKBz6Vvnqs89/VExCWKFGXM2DyDbcFVQpjky1NRSIO7ctJq6U+qZAeJPRV67QPO5k/W
	 1T3BuhdKXGay+o7YikF7cQZbDT2vYoNwC13RilhVAioSJsHA01egLWqqr4Gj2sDfiXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cO89QdPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210A606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cO89QdPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FE01F000C5;
	Mon, 16 Nov 2026 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792566;
	bh=KnRHrqkpHdZDKBjKDizqq7GHoNMfa6r6/nhLfpMNFDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cO89QdPBOl3UrPlUtofphxDrXBRbe037w9B6x6vCqjIPLWcvT4tFDoWwCPQXhPlX7
	 7HQ8j9xV4296XD0sBzuR8zzQR2nJKo1i9oPgF/mzUlleh1Un2YLfAC5O8DyiESQzNk
	 1kXAyZOFN6rQWBLp9X62kHnH1Mso2ATeE3CMtWkl7N4dKCIuTbaESU5ym7LWabpV2B
	 mAEN0y4qjrz8ULv4fd6zJ+amRSpQ/iu1RQcbaxZMHbvMvlIcpGAXDZNMnkPH6LFO23
	 H935ZPa27ER+shr4ICViuLboVsPFKMuS05EKxN2VLqJqlgIqxbqbbDxAbi/moRIMur
	 Rm59G+6xEqpWA==
Message-ID: <sashiko-outbox-215995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 4/8] net/iucv: run recvmsg() under the socket
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-4-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-4-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:25 +0000
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
> recvmsg() takes no socket lock, on either transport:
>=20
> - Two threads reading one socket get its data out of order.
> - A read that finds the peer's SHT sets RCV_SHUTDOWN with a plain
>   read-modify-write of sk_shutdown, and can lose the SEND_SHUTDOWN that
>   a shutdown(SHUT_WR) set meanwhile.
> - A MSG_PEEK read leaves its skb on the receive queue and holds a
>   reference to it. When a second reader consumes the skb meanwhile,
>   that reference is the last one and skb_unref() frees nothing: the skb
>   and its receive memory leak, and iucv_sock_destruct() warns.
>=20
> All three need only a second thread at the wrong moment. No
> memory-safety report is known from any of them.
> [ ... ]
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@=
proton.me/
> Cc: stable@vger.kernel.org # 6.18.x: aa5ec571b93f: net/iucv: Add lock nes=
ting annotation in iucv_sock_close()
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D4

