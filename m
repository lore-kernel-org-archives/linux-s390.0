Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249234;
	b=lhDffNi6NHSdGqXj8UwQ3WPYaNP4svkztt7s9x3xb1CSPTP6QYz1jEgB986BKudPM+L9
	 Fqn2ux9yiTXXZVkSsYhscucp9cvqKsWIxG2bKHsoppeShs387amOtf5WAbBfnsPXeTrCg
	 oKbZ1GtdAdk65NSU4OKixWEDeroxSaP7jryFQ9FF5E0y0vHmydgDyNQ7LMK1uEv8DTLOI
	 cRAOLfCGy4Yt7ezRdPIy3+q+FTmT8uvK+AI391ZaQb5twWyEVeVN+K3Kf8WW0Uw6deLj1
	 xVIcuccC+MzID0DV5mRVj34+ZarR8tR4hJ1vUkKpcTHAMdZuOvDBqq6ZEQeJAn2Iu1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249234;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UWCIZt4qaahjD1Y4aFHR35NaUAkunHopVmd0Os9Fkqw=;
	b=0++mlwsKYRFM7kaPD+J0QHir07op1QSxUR/4MTwV0InfVdcIZIC9K9ukLfmDLS0KOQSa
	 26Eb7QsjRzeOlLvnSOquEI5tKA015iW6N6xU6tfh9DWLNC1pM83tEO3mQsOmi1pLeZv+K
	 ElH0TOBZEZSjcnW6C9zarzWomZ+n5UW00jgmZ8kSFVdSNNl2I+foA9V1/xPuiteXctMpZ
	 901GRlt6vj006I6acybKoMbR9WPBtcOlpki9Yfrr0qwPU7YuC5FOjNkcXnu0oVp3m8Dqy
	 34vWe9ksqEL1S7DvmWAyIUh6wSceL9m4xXPjbSagHf7j7v43d97Lew6pOPhAc+FlJxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/l6h8KB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D098606A332;
	Thu, 29 Oct 2026 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/l6h8KB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793249234;
	b=vouOK2CCXqchnUa0o12FzUtnnAbG2/q33Qe9SeATZeI/tDXmGa2Ye9zqBm7CORxgTi02
	 fHpekKuOfzIHJvA1oO6LLPRBkKp7FL4hna6rqXu4cChBDewFZZib2pGVSUF6/tXQYaFHk
	 p03J7jqW2XaljznmqtY5aLvh2IyN5tObcY+FprpT9VIjXy1Q1gH91grNsdCwOKrlGmFCW
	 59/ZTjQ2EXnywR/hlE5E7zsPQtUjVe/IJ017LTkaePOYEm6yw5P4AO+g/g2pifyRdlcxn
	 2gM1QwQruns+l2G0Laum35lIMeyqnWj7wGFAO+M1aVAhhGslxrgvzI0xa1Mp2teQHKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249234;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UWCIZt4qaahjD1Y4aFHR35NaUAkunHopVmd0Os9Fkqw=;
	b=Vsx09ixCrOq3D+B7XPrRrHxzHrQjjXO7yfGXrTV4ct8aEU/UacCDfegWqlkVqQ0d/Uoj
	 7qV+E+67s1dMLTalEDNhD6w+EeR1es1xLHf5UogE+iUGe1zYTrZydP89hYT+knilgA28q
	 2WLBlsJc37PEvILJ59n9vE38RLVHtdz/CMMEgirvy8d+1ybJ9APZoMRoRNeg4L2o0CW7X
	 RENmBZJ71wJWJiT1KvO2sPZk/V57BaqwaN751FQxQN8dyCF1EMF3uSKCEf4d0GFUTQRc3
	 6b5UL/9QUXCLdMU3E0QgrkpV3UM3dO9rIbOExAjQbAbQ6j/ZTLULe1ZVBl9ALtK58/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9D8B01F031E4;
	Thu, 29 Oct 2026 04:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249234;
	bh=UWCIZt4qaahjD1Y4aFHR35NaUAkunHopVmd0Os9Fkqw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=R/l6h8KBpgd1twPloc1coLDBgiQPBcTAaY+th1IpoeVTpq2sLWvWCsEpxjXAR1nX2
	 Qc70s8Wrs3nwB9wYGgW4sxF/hHhiv8uLwxUR7kwVUO4ckl6U+Z6fQdnVJ67RDrQFqk
	 +gYGf/j9Pw22HH1jxaAMeWPxPJ90rxtuT/PXrENwfLq9CUp9G9JnWNBkF4YBAvFB6E
	 +h6G6nYXUnJFzx6JpvB5HfronxLjgMQ9kpSEDtRRQt1bR604Du0HvJ1nEzdLmkWc0h
	 BzcVyDHoBgDw3w6DOyKKqqgXZeS9J4MyLGvaDsraUrvArhEfKYFc3HvoW0NwSPfR74
	 VEHJU+kCbNJrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 325D14560F;
	Thu, 29 Oct 2026 04:47:13 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Wed, 28 Oct 2026 23:47:13 -0500
Subject: [PATCH net v3] net/iucv: take a private, writable frame before
 rewriting it in place
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
Message-Id: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27CbQFkS/Qjyw3QXWQyVdNCaEv
 1v1OJPM7GCSVQyu1Q5ZXmr6SAX8qYK4jGkWVC4MrnZdU7seKSCrrdgIE0UfMPQjn1sm38ULlGz
 NMun7txwgyQa3v7Qn3SVu3xkcxwdfbNRMeQAAAA==
X-Change-ID: 20261028-b4-disp-1edbbc34-48ad75db36c9
To: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 Ursula Braun <ursula.braun@de.ibm.com>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793249232; l=3123;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=JFUfhciEChw7BgSLF92o8VaqbY3+Obn41qmQCu8hTpc=;
 b=xB7V2bhn6yEiVdWWxB5Zut++I9OEjUHTLT/m685QspAXcWfHaaewSgGT5tCMdViA7k7dk9yJ7
 utyXMSZzOVrDTYPb5i/zuzqgNgCwKAWEkEBwow0HPRXlVi4uA2y/PcJ
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
header -- and can hand the same skb to dev_queue_xmit(), without making
it private first, so a packet socket that also gets the frame reads the
rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
list, walked after ptype_base[], so deliver_skb() takes a reference and
af_iucv runs on an skb that is shared but not cloned.

Unshare, then cow, in that order: skb_cow() can reach
pskb_expand_head(), which has BUG_ON(skb_shared()). skb_cow() tests
skb_cloned(), which is what a rewrite of the data needs; skb_cow_head()
tests only the header. Asking for ETH_HLEN also covers the unchecked
push in afiucv_swap_src_dest(); on the ordinary path eth_type_trans()
has already pulled that much, so it only compares.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3: skb_cow() instead of skb_cow_head(), as Paolo and the netdev AI
    review asked: the rewrite is in the data, and skb_cow_head()'s
    skb_header_cloned() test would leave it shared with a nohdr holder
    (none reaches af_iucv today; still the wrong contract). One-word
    change, rebased on net. v2 carried Alexandra's Reviewed-by; v3
    changes the helper on Paolo's point, so it is not carried. Same
    s390x QEMU A/B as v2, re-run on v3: same eight boots, same table.
    Unpatched, the tap and the ETH_P_AF_IUCV socket both read the 48
    name bytes in ASCII and a SYN with no listener never reaches the
    socket; with this version every frame arrives as sent. Drop
    skb_share_check() and the socket is broken again; drop skb_cow() and
    both are.

v2: https://lore.kernel.org/all/20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me/
v1: https://lore.kernel.org/all/20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me/
---
 net/iucv/af_iucv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 5ba875798aa4..ce13fe3c85b5 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2080,11 +2080,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	int err = NET_RX_SUCCESS;
 	char nullstring[8];
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_SUCCESS;
+
 	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
+	if (skb_cow(skb, ETH_HLEN)) {
+		kfree_skb(skb);
+		return NET_RX_SUCCESS;
+	}
+
 	trans_hdr = iucv_trans_hdr(skb);
 	EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
 	EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));

---
base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
change-id: 20261028-b4-disp-1edbbc34-48ad75db36c9

Best regards,
--  
bryamzxz <hexlabsecurity@proton.me>


