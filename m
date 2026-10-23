Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792724441;
	b=rTCrzHj3cHEEqNKvG2d9iZA7tl3uXzZLBywiQRCC6va/a5hn8qCPYDZeS2S1W1ecRtls
	 e7wICNkADSkc/mu/c+qxK+A+ntDBkumXoAH+AEoWNS5L7xUWwWRr5a9SR7SvZcK8sk5QE
	 vkOmkHlIypILYTym6X1YHYETb9s8/qeOIyfKU0N8yyg5pgOVY2jEi9hyRJzWYRl7Ae+kv
	 jdJIOdla1p3Wj/wiFfB7w3Om62CmiLFOW44rIxzHLmQVnS8J/KpsEWZFSw27A6I9TxKcd
	 ViZrHmmUNOb8y/PhoD8aSHn9OMVsoCtfEem7wy2rPD1aVYUXsOSlswfZvUhDWHQzXrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724441;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TQdekinzc45MdGcjZeRJ/aowbCJoLro0y8FOJCa45c4=;
	b=QBDGxgI3AihQyW9z3fDqlTB0GETyr5A1JKSzxqoyQY8fTimTZ/4kRR15c+tdGhiY2ZtQ
	 vH9oA7ixogqQRb4/49LODJ6+tg/zNT0KHY81K1M1TpWNl3CmCG1txfnOUsghiBNJwS3QD
	 vxcSURYNL8hWcdao9E2ilEy1+2reNiWQhvi99CCELsYkkQB0G05gHQ1AM2SVlPEIlbqBx
	 E5SFElhnWTpDwyP+b2OHbJYvWuYiyBhch1+m5wwNf0GvOF0mJVcLeRD4w4NkLmYAsPU+y
	 sRuhqTEHr0zlplEibSoHYYESAUmwTQnUFmyBgMzu4fS/LHwYPNggscJ1iNS1+6XZmfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX+vyVFF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECA606A31A;
	Fri, 23 Oct 2026 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX+vyVFF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792724440;
	b=Kb2EzQ+R4LeWGfB4RkxHSwToTX98CGQ5jW+8bI+bXBUDyXK7go4Hvw2/ZnGPfR9X5+nQ
	 fEa0qRo9xAtUa7OjVliSDayX0x3bqQQxdSsA+IGdRekDMh+W3i9Kx5r3vKeSVpTLiDuz9
	 inewUL6fVBOVwrXHSYbZODjvbCqCDtf0JPcu0qfc2lzfwtd50xAiG9HK7dUyISRh+9nFV
	 1nSVoamnZ8QdKOlltII8SAZxS2v62NDOg8kPLjeFa4BVw4baF23u6ZRNdkVdM2ziBp1PZ
	 a4kQppV/aRgxvkhtglgL/x8ud3PecKNTDqrnjNU1HKXb1TvfGnGHTkDkWgbe3oaif8Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792724440;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TQdekinzc45MdGcjZeRJ/aowbCJoLro0y8FOJCa45c4=;
	b=AncVyVm1pRmBQx6nBq/ayanbLMhmEm1h5xnvUjUgEYVqPAfuoRcPQpAkmIaOSdq0qncP
	 uYH7PzRv6oybNQXDWnETr7PbkRvblTdd83/ruzRO5yEFn143InL7P4mQzREeBZDVSodgc
	 oAVcA3l10h5PHA6O3Me/BRbf7KBZrtWism+RHdkWJHix4dRldQ/4tc2SyzDKEGPiAfHNa
	 F6jvoS1sKdtiYEKiJgkCcgVgdysAd6iZqJYv4ogUfsqZhzpGbyGQw0nh/JNOwYNAzsQ82
	 COFQcNgUw9dW3f9L+6cUzoGmmyrz+qaqUY9D6nTLxx6I7Zy7YFS1hGr1I4PBLzBbNnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D27961F01829;
	Fri, 23 Oct 2026 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724440;
	bh=TQdekinzc45MdGcjZeRJ/aowbCJoLro0y8FOJCa45c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jX+vyVFFMyMnWI23q2rCeQhXDVlmnsuM7q7clKRi3yQTXCgyWgibOx34TT2rPRVwJ
	 cgRU0utpK3L5YtuwKVpQpUlBGSg079ZwD4n9AF+dICQLZNBl3CsqE9S0sRt1rnufsw
	 frfhpiqcAl/JY0wbgWVSfMXLlOlNmBc5VwoMOzPh5WG4nrgMVDgkyJYI16WZ58vlF7
	 TlmikGncebeS8Yx7N4ImQJE4dZACfWf7v6b347wRXibtCWdTvrf03c67xFGckYN9uG
	 BrXhnchUVhGajIw5eaZC8Os3AeVRz4xzjx+38scd9QDXbLvWddf1adSQjCGLOPkZ1l
	 /k9xkAoBXtmqA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 45CF1421C4;
	Fri, 23 Oct 2026 03:00:39 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 22 Oct 2026 22:00:39 -0500
Subject: [PATCH RFC net-next v2 2/2] net/iucv: return EOF to a reader
 parked at the HiperSockets peer's FIN
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-b4-disp-1d26b87a-v2-2-7ee1264d812a@proton.me>
References: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me>
In-Reply-To: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me>
To: Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Nagamani PV <nagamani@linux.ibm.com>, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792724438; l=1759;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=Ytt4rdgE3BbqtAZEFC0wW/x24kWLpDfDP1W/jHpd3jI=;
 b=wsmhQiDrtMkx6fzxvVixsY08gIHWJdFxewlSlNNNKLBPs0Ql5HZRBInijiCOiqnmAtLEpcofs
 5C9pHQxg6X0D3Xq7v9qenCgPlc0RBKODhV/HcjsPfwBCpTPYmvszwAb
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

After the peer's FIN only sk_state says the receive side is done.
Before the previous patch a reader parked at the FIN returned -ENOTCONN
(Hidayath Khan: 14151 of 14151 cycles between two z/VM guests); it now
returns 0 by the IUCV_DISCONN test, while poll() still reports no
EPOLLRDHUP for the peer's close.

Set RCV_SHUTDOWN where the FIN is applied, as TCP does: poll() reports
EPOLLRDHUP, and recvmsg() ends the stream by the test it already uses
for the peer's SHT.

Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/82691101-92d7-4838-b16e-2e41a83f65d0@linux.ibm.com/
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
On its own this covers the HiperSockets FIN; the z/VM sever reaches the
sleeping reader through 1/2's wait loop. After 1/2 the write is under
sk_lock.slock in every path (the owner's release_cb, or the softirq
with no owner), where shutdown() writes the same field.

Measured in the emulated setup: poll() on the parked reader reports
EPOLLRDHUP at the FIN with this patch, not without it (1/2 alone gives
the reader EOF but no RDHUP; net-next and v1 give -ENOTCONN).
---
 net/iucv/af_iucv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 15ce99e90c5b..f1a7bfa5a4b5 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2074,6 +2074,10 @@ static void afiucv_hs_synfin(struct sock *sk)
 static void afiucv_hs_fin(struct sock *sk)
 {
 	sk->sk_state = IUCV_DISCONN;
+	/* as TCP's FIN: a reader asleep here wakes to EOF, not -ENOTCONN,
+	 * and poll() reports EPOLLRDHUP
+	 */
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sk->sk_state_change(sk);
 }
 

-- 
2.56.0


