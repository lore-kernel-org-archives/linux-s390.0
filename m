Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794977547;
	b=DC6xnjalTnP68456FIa0/LprKYitz3ZpVjzs/8va59QspUINDUc4gC/WH9T4eNO5v180
	 zMl9HebbQ+Na028zLlPU+JJq7Zi+sOMJsob0I9gJeD1A1QFzN/KP1ZAenVtF1q+4AdbOW
	 UMA12PesOlj1c2JwsUAvi5VTgS/GKelMXVt244CbRu2O4TzMBfG8VW38Po4UBenb8DP0f
	 CWOIRyNYfc6edT6SxHvXI/ZLtqWjBBSs8kfvtMxWIZit3mcvnHFV/CgFWywC4ryS6bP0U
	 danfcqO9jUiuigboURwG+OKfLrk5upTDZn5x37NITlmRymQkT7IiD/HjynnOtgGcHBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794977547;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=owJsBBfTcY32+grwyBsW4Ys1YOwRE9098kbEal4OQ/o=;
	b=bznnoMvUJjfRRHjIizx2CJvG+SSG83PRRVi8d3Fsr9MTewTcabyTZemg8QlheSrJrhR5
	 GvLyVjzo3n0MFHsXO4vPs0LimwYUSfLmVKEnpQGWpcxfw3ecquV41HdV0OkseZcNlJtRB
	 ptPOKaFkirJaHnFDpX6MyK1+6AVPf75OkwORtrcZhn9D7b/u/6fzQWMZFwiUhdaiIK43Q
	 iYDoS1hf1j+4z+xXth4UyLwfRpsblUYwu3DvblrtknG7QBOJBfyFU1RfCmDdYDeT7zgo2
	 k7hD5iwlDaVCtmFeaurGTNv9ohb4kFIHmi4Q+i/zMXAbxV6nmXpDR1A35BFyKMG0mBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PSXEZ5qh;
	arc=none smtp.remote-ip=91.218.175.81
Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BC606A32F
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 04:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PSXEZ5qh
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CxsJqg6NZ0rJSY+q+jjFAXoCxrwiTWX2Qt+1al6xkL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794977545; v=1; x=1795582345;
 b=PSXEZ5qh2CPt4jhX1cxa2kYflDj2botNZiqNxXY6aXPyNo8bzvDmeyQUqLLHeNKt4kpaeTL9
 7y6TeWyWkIzfDSS5Ntd18oDxwK4V6DkstAYP6ZX3rtumx6bXj11z/QU1dBhGhLQ+FDlkcFBcXKz
 sWsBznP/18kQbXLMe7L6PIFA=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 77474746f915bd0c;
	Wed, 18 Nov 2026 04:52:25 +0000
X-Mizu-Trace-ID: 77474746f915bd0c
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v2 2/5] ipv6: annotate data-races around icmpv6 reply sysctls
Date: Wed, 18 Nov 2026 12:51:17 +0800
Message-ID: <20261118045137.174026-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118045137.174026-1-jiayuan.chen@linux.dev>
References: <20261118045137.174026-1-jiayuan.chen@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

icmpv6_echo_ignore_all, icmpv6_echo_ignore_multicast,
icmpv6_echo_ignore_anycast, anycast_src_echo_reply and fwmark_reflect are
read without any lock while their sysctl handlers update them with
WRITE_ONCE(). Add READ_ONCE() to the readers.

KCSAN reports it when net.ipv6.icmp.echo_ignore_all is changed while
ICMPv6 echo requests are received:

  BUG: KCSAN: data-race in icmpv6_rcv / proc_dou8vec_minmax

  write (marked) to 0xffffffff8ee2940d of 1 bytes by task 504 on cpu 0:
   proc_dou8vec_minmax+0x1ab/0x1f0
   proc_sys_call_handler+0x282/0x3a0
   proc_sys_write+0x13/0x20
   ...

  read to 0xffffffff8ee2940d of 1 bytes by interrupt on cpu 3:
   icmpv6_rcv+0x99d/0xd40
   ip6_protocol_deliver_rcu+0x787/0x9a0
   ip6_input_finish+0xb0/0x1b0
   ip6_input+0xa8/0x250
   ipv6_rcv+0x14b/0x1c0
   __netif_receive_skb_one_core+0x8f/0xe0
   ...

  value changed: 0x01 -> 0x00

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/ipv6.h |  2 +-
 net/ipv6/icmp.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 579df1516d251..b77dc5c3ea268 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -199,7 +199,7 @@ struct sk_buff *ip6_frag_next(struct sk_buff *skb,
 			      struct ip6_frag_state *state);
 
 #define IP6_REPLY_MARK(net, mark) \
-	((net)->ipv6.sysctl.fwmark_reflect ? (mark) : 0)
+	(READ_ONCE((net)->ipv6.sysctl.fwmark_reflect) ? (mark) : 0)
 
 #include <net/sock.h>
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 4122ce3055e49..abfe2893c18f4 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -946,17 +946,17 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	u8 type;
 
 	if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) &&
-	    net->ipv6.sysctl.icmpv6_echo_ignore_multicast)
+	    READ_ONCE(net->ipv6.sysctl.icmpv6_echo_ignore_multicast))
 		return reason;
 
 	saddr = &ipv6_hdr(skb)->daddr;
 
 	acast = ipv6_anycast_destination(skb_dst(skb), saddr);
-	if (acast && net->ipv6.sysctl.icmpv6_echo_ignore_anycast)
+	if (acast && READ_ONCE(net->ipv6.sysctl.icmpv6_echo_ignore_anycast))
 		return reason;
 
 	if (!ipv6_unicast_destination(skb) &&
-	    !(net->ipv6.sysctl.anycast_src_echo_reply && acast))
+	    !(READ_ONCE(net->ipv6.sysctl.anycast_src_echo_reply) && acast))
 		saddr = NULL;
 
 	if (icmph->icmp6_type == ICMPV6_EXT_ECHO_REQUEST)
@@ -1160,11 +1160,11 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
-		if (!net->ipv6.sysctl.icmpv6_echo_ignore_all)
+		if (!READ_ONCE(net->ipv6.sysctl.icmpv6_echo_ignore_all))
 			reason = icmpv6_echo_reply(skb);
 		break;
 	case ICMPV6_EXT_ECHO_REQUEST:
-		if (!net->ipv6.sysctl.icmpv6_echo_ignore_all &&
+		if (!READ_ONCE(net->ipv6.sysctl.icmpv6_echo_ignore_all) &&
 		    READ_ONCE(net->ipv4.sysctl_icmp_echo_enable_probe))
 			reason = icmpv6_echo_reply(skb);
 		break;
-- 
2.43.0

