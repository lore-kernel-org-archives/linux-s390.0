Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0F294A0A;
	Thu, 26 Jun 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926872; cv=none; b=qc4TBlen43LrOn60pO0QXZeWqwPzb3QabPcQHponyFd6K0c8XeAIh/RYtHPNfP1j5JBzOoCg50bJwnc2GA+85rZAtOBLocCTybSEhgnFhkFTsSyr8hkromfEn9x2tz6eqGZLlYHNoURSGDt4Lz2i1FzwTKLzbhEiDtchtWkvIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926872; c=relaxed/simple;
	bh=k9kLg0my+SBsSInDXplaBISLqMsAK7HUk3GpJuDl9K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tq+PuT2FVmXXRnureGkcYkVYy1R23MX355ecOSNiaN5raYF3juBo9QZ8WZvkBm78/OkVF/JmTU+Ic0KYxdv/n53WrUudfvQGd/2S04Y/ATO0pHxoj+0sjYxwr23hlJjuNcyNgPPlgYccSKPe/7YTiRRNtyNp7/16H7eiMhivl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UO5XhiNE; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UO5XhiNE"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3t-00GFj2-OC; Thu, 26 Jun 2025 10:34:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=SCfBbusasJKzDLebDsTeT38r5oZHC/MzfWn9UUtl8yU=; b=UO5XhiNEgg+aosti5hbqtkXzXJ
	6y6vRo19fKIpEbfQffGTuwXurrKbk/9VjIOIPEJnhHddahpT2fAPtatd+jPdKanx/kpACB5gie+Hv
	2as5aq/uCbQndjiQtmxPq19FGUnJm4R/c+VcQljooyR7ApxO/9DfuVZqk7vPNCuqZ6hqR8+AjIoBz
	VYfMhaAvufjnn8qGJEcPV33BeCJtYVqxXqyJNGLO40hcIm54YSiI5CwIFQJmJeEXlzqh3+qENU++I
	s/Gc9B8J7znk20ipsnEzim9aIgI8bRIxPkzebqyYX3REVSTZvX0bXcs5AsfRXHa6ABUz0OU1Gax9O
	piKRICjQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3t-0002I1-9K; Thu, 26 Jun 2025 10:34:25 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3N-009Fh5-9S; Thu, 26 Jun 2025 10:33:53 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:36 +0200
Subject: [PATCH net-next v2 3/9] tcp: Drop tcp_splice_state::flags
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-3-3268fac1af89@rbox.co>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
In-Reply-To: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since skb_splice_bits() does not accept @flags anymore, struct's field
became unused. Remove it.

No functional change indented.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 46997793d87ab40dcd1e1dd041e4641e287e1b7e..b6285fb1369d32541b9f7d660ca33389b7e4da61 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -324,7 +324,6 @@ EXPORT_IPV6_MOD(tcp_sockets_allocated);
 struct tcp_splice_state {
 	struct pipe_inode_info *pipe;
 	size_t len;
-	unsigned int flags;
 };
 
 /*
@@ -803,7 +802,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	struct tcp_splice_state tss = {
 		.pipe = pipe,
 		.len = len,
-		.flags = flags,
 	};
 	long timeo;
 	ssize_t spliced;

-- 
2.49.0

