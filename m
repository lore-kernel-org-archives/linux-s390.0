Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237195;
	b=i4JyAHepg4Mxkqz9KYaUiuQcrq0hLeiqSJ6is8pwXYH6o+mU2x9EL35uLh50JazZCdMh
	 hJ+VoswHxypgugQ8Vt3uZ6ljEXLLyLKKdP+ktZEjd/gXEdz+hoC9ZX/VeRST23FwNkPg/
	 6z/fZNna2DQtVjyB4euEDY0w1lA6oxlz5orFKIKG+ukhOc9zjpYowgTOxhjuIkDUTNut+
	 VGzCtJFKkp/E2zYQCYB4ckcs+nwt6TcGswbhC7Nj6QJfxclXYhK4kzapgWlwUoefTUmca
	 BkZZEjgFqepw+/2fCnXUbi+GD3XRXu9itCRwJajlXJ4v7/CNAo/JB53hQdv2735JpQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237195;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uguu7OFGDKQr/xJZuDZyDNIysLeQcBy4oeL+3TVlIbQ=;
	b=lkze8OveMzG/+yE6KKJmKeCPIc1oaITS22AWXOeXJgkiLH2ZMQY6tCntav5YZQsousDm
	 dXGFghwsIsL/VIZeLoUKNDMiLYikZKUKSwn13jhkCpoRubeRgbK/GdnznZu7LDEUFdwNp
	 5p882c3LFoMiSxmRtEku2lRmawG6nqi0YCeOy2IoKZE8U0xr9rE+6FSRhkk9rAhw3gzhP
	 ot+ss5d01x0/rSXCzZ7D5Xo0S7p3+BSOOU/2RBLlgZH++wUEhACZiszqkTL2jmWvsWiih
	 iC9oaG1nYydeIe9VuvHyiGevugMw+VlAlaVnyi5lg0vPOboeV4lX/bM3qPxZ6Bl7dlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XbXxil33;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE026606A321;
	Mon,  9 Nov 2026 15:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE026606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XbXxil33
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEbuj3497682;
	Mon, 9 Nov 2026 15:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uguu7O
	FGDKQr/xJZuDZyDNIysLeQcBy4oeL+3TVlIbQ=; b=XbXxil333RLm9bZYwkQvof
	8ijj1hhWWxClJ248yrXNnu7lTipIK/mWmK1koz2MXYXJuC0QAJ450LcG9rpXStfe
	5cde7w5MBO+wO56YK7524fJfHMyDgeyJIxgDsDIx8X17tNbs6uD9NrVFB5/E3hrw
	JM06rdHZ1KTSZsusCCM3YpIKzfFmf0vYMSWtocfEGTgt1HuAUr+fZNFiz+bFXzGm
	/6mbyMnwN6fpkad/edVfFnH8bAZ3CK0+6fN/Lpbi0dLR7u9sU/+tOS8tSbZHKHUm
	R5G65QaqfQMZP6UHOsY+rBJpwqWygt2hpOXH/4nsVE5/J9w4dXaYTTMCduHcfDTg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6p6p3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 15:12:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DK0kh079642;
	Mon, 9 Nov 2026 15:12:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq0v46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 15:12:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9FCquG49283538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 15:12:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B1420040;
	Mon,  9 Nov 2026 15:12:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7403E20043;
	Mon,  9 Nov 2026 15:12:52 +0000 (GMT)
Received: from [9.68.31.53] (unknown [9.68.31.53])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 15:12:52 +0000 (GMT)
Message-ID: <2886dcb1-2741-4b29-86e6-dba3ccf2125a@linux.ibm.com>
Date: Mon, 9 Nov 2026 16:12:52 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH RFC net-next v2 1/2] net/iucv: serialize HiperSockets
 receive with the socket lock
To: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc: Nagamani PV <nagamani@linux.ibm.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>
References: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me>
 <20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me>
Content-Language: en-US
In-Reply-To: <20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX4zo8KmxG4EBr
 HBbo7aOLuTVmg3Dxht8FabP/97Oo91n5zvJ6useA/kos/wuEGGpd5P9iilVilzQdfobnz1A6U+9
 Kpqp1FmN3KUj1jBBD1ugLsxzghNBcAs=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af1e2f9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-0RwHnLpWcbM-uQh9isA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: dWAWnK3sRYYJcvcJagyXF1NO102YaPsW
X-Proofpoint-GUID: dWAWnK3sRYYJcvcJagyXF1NO102YaPsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX7ZOKujpyb6ui
 I6Bq/NEXZFZ6qA4dy/wYfBaI1FCtIn3i88Qty2Nb0bKQtzlT23LHVR5syipGHCoKG3C9S+sAfpm
 4PY1c3MARGOoPCo8lHsI/pI4vEwK38dVwdWSeEQ3mQ8xqidf2T2lcGj9z5VcLei/73EVWfgT6Jk
 jIxAD8L0I4l/4+7hfz6A13U1373agdtbswDZ6G5sQhbFHL2xIsQNscAzDuroGoZLNhaj3dC4M48
 ar56mu0une9M4NE1T4SByBSnKDCV9siEU+SjuRAe2mDIG1ydAdSGst1Y4EptuFdIOBcLrDckGHJ
 4wGyVIieOuaWTdLYsQcskCWvx1yvBb0EqzWPT3SQXis7cWSxzSjybCV6fwggoiAK332jT8KF/7i
 2f8mSuSJ2UNmUsK398Slts9BJjlvxhtz1cwNC59Oi91M0nKWtJeemf6jSJA3nxjaoxvDBs+EFqE
 BvKNNMniltXMNatTCtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090058



On 23.10.26 05:00, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 

Hi Bryam,
thank you very much for this.
To me this is the most urgent of the open fixes. I'd like to focus on
getting this upstream. My hope is that the other open issues can then be
more easily be written on top of this one. Also it should then be easier
to clarify the impact of the remeining issues, right now many of them
suffer from the incomplete socket lock.
I may be wrong with this assesment.

To me this patch looks very good right now.
Can we reduce the scope even more?
Can you polish the style (comments, commit message) some more? The
design is not trivial, so future readers, editors and debuggers will be
thankful for the effort.

For stable team to evaluate, the commit message should include symptoms,
conditions and consequences.

Let us know, if you want Hidayath or myself to take on any of this.


> The HiperSockets receive callbacks change sk_state under bh_lock_sock()
> without checking sock_owned_by_user(), 

what follows is alist of 3(?) problems in current code, may
format it as a list?

> so a FIN or SYN|ACK is applied
> while a task owns the socket and acts on the state it read. 

What are possible consequences? UAF? Can you give 1 example, maybe even
with
KASAN(?) output?

> recvmsg()
> takes no socket lock and sends a due window update in any state, even
> after the FIN;

Is that a problem? Or only bad style?

> one that fails keeps its credit.
> 

You mean, when sending out a WIN fails?
What are the consequences? Overrun scenario? But isn't that covered
by your other patch [1] ?


> Take bh_lock_sock() once in afiucv_hs_rcv(). While a task owns the
> socket, a SYN|ACK, SYN|FIN or FIN is recorded in the socket and applied
> by the owner from proto->release_cb: nothing resends a control frame,
> so none may be dropped, as the socket backlog drops a pfmemalloc skb.

It took me a while to understand this.
I guess you are saying: Don't queue the SYN|ACK, SYN|FIN or FIN,
because they must not be dropped, not even unde rmemory pressure?

> Data, SHT and WIN frames do not change sk_state, so they go through
> under sk_lock.slock, reading a state the owner may be changing: a data
> frame queues or is dropped, a WIN credits the sender, and
> iucv_sock_destruct() now purges backlog_skb_q for one that queued after
> close(). They wait in the socket backlog while the reply to our SYN is
> pending, and behind frames already waiting, counted in frames rather
> than bytes, up to the window we gave the peer plus one, which a
> conforming peer does not exceed; the reply is applied before them. A
> listener's SYNs wait the same way, cut to their header, up to its
> accept queue plus one; past that, or when the backlog cannot take the
> skb, they are refused at once, without a child, and so is one the
> listener cannot take when it is applied: closed, or its accept queue
> full, meanwhile. A SYN|ACK or SYN|FIN no socket state can use is freed
> in afiucv_hs_rcv(), a SYN for a socket that does not listen refused
> there.
> 
> The window given to the peer is kept in msglimit_adv: the SYN carries
> msglimit, and SO_MSGLIMIT may lower msglimit while the reply is
> awaited. The backlog budget, the receive check in recvmsg() and the
> window-update threshold read the window advertised, which a conforming
> peer keeps to. recvmsg() runs under lock_sock() on both transports and
> sleeps without it; a reader parked when the connection goes sees EOF
> once nothing is left, as a fresh call does. A due window update goes
> out only while connected, else the credit is dropped. shutdown() sets
> RCV_SHUTDOWN and purges under the socket spinlock, where the data path
> tests it. sendmsg() waits for memory without the lock and fails with
> EPIPE once sending is shut down. Control frames go out after
> shutdown(SHUT_WR) without clearing SEND_SHUTDOWN around their
> allocation; the FIN and the first SHT go out past sk_sndbuf, as qeth
> keeps sent skbs charged until TX completion.

I wonder, if you can split the msglimit_adv vs msglimit into a separate
patch?


> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@proton.me/
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---

> ---
>  include/net/iucv/af_iucv.h |   5 +
>  net/iucv/af_iucv.c         | 560 +++++++++++++++++++++++++++++++++++----------
>  2 files changed, 440 insertions(+), 125 deletions(-)
> 
> diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
> index df85d19fbf84..85b35cc88f0b 100644
> --- a/include/net/iucv/af_iucv.h
> +++ b/include/net/iucv/af_iucv.h
> @@ -130,11 +130,16 @@ struct iucv_sock {
>  	u8			flags;
>  	u16			msglimit;
>  	u16			msglimit_peer;
> +	u16			msglimit_adv;	/* the window given to the peer */

^ Can the msglimit_adv be in a separate patch?

> +	u8			hs_pending;	/* control frames recorded for the owner */
> +	u16			hs_pending_window;
>  	atomic_t		skbs_in_xmit;
>  	atomic_t		msg_sent;
>  	atomic_t		msg_recv;
>  	atomic_t		pendings;
>  	int			transport;
> +	unsigned int		hs_backlog_data;	/* frames waiting in sk_backlog */
> +	unsigned int		hs_backlog_syn;
>  	void			(*sk_txnotify)(struct sock *sk,
>  					       enum iucv_tx_notify n);
>  };
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 794a3cc8b79f..15ce99e90c5b 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -39,12 +39,6 @@
>  
[...]
> @@ -374,26 +389,28 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
>  static int iucv_send_ctrl(struct sock *sk, u8 flags)
>  {
>  	struct iucv_sock *iucv = iucv_sk(sk);
> -	int err = 0;
>  	int blen;
>  	struct sk_buff *skb;
> -	u8 shutdown = 0;
> +	bool force;
>  
>  	blen = sizeof(struct af_iucv_trans_hdr) +
>  	       LL_RESERVED_SPACE(iucv->hs_dev);
> -	if (sk->sk_shutdown & SEND_SHUTDOWN) {
> -		/* controlling flags should be sent anyway */
> -		shutdown = sk->sk_shutdown;
> -		sk->sk_shutdown &= RCV_SHUTDOWN;
> -	}
> -	skb = sock_alloc_send_skb(sk, blen, 1, &err);
> -	if (skb) {
> -		skb_reserve(skb, blen);
> -		err = afiucv_hs_send(NULL, sk, skb, flags);
> +	/* Control frames go out after a shutdown too. The FIN and the first SHT
> +	 * end the stream and may exceed sk_sndbuf, like TCP's FIN; at sk_sndbuf
> +	 * the others get -EAGAIN and arm SIGIO, as sock_alloc_send_skb() does.
> +	 */
> +	force = flags == AF_IUCV_FLAG_FIN ||
> +		(flags == AF_IUCV_FLAG_SHT &&
> +		 !(sk->sk_shutdown & SEND_SHUTDOWN));
> +	if (!force && sk_wmem_alloc_get(sk) >= sk->sk_sndbuf) {
> +		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
> +		return -EAGAIN;
>  	}
> -	if (shutdown)
> -		sk->sk_shutdown = shutdown;
> -	return err;
> +	skb = sock_wmalloc(sk, blen, 1, sk->sk_allocation);
> +	if (!skb)
> +		return -ENOBUFS;
> +	skb_reserve(skb, blen);
> +	return afiucv_hs_send(NULL, sk, skb, flags);
>  }
>  

I wonder whether this should be in a seperate patch.
Is it really related to 'HiperSockets receive with the socket lock'?
You already have another patch that is about fixing shutdown [1], maybe
add this there?



>  /**
> @@ -514,6 +531,8 @@ static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
>  		iucv->transport = AF_IUCV_TRANS_HIPER;
>  
>  	sk->sk_destruct = iucv_sock_destruct;
> +	/* not from iucv_proto: sk_alloc() does not copy proto->backlog_rcv */
> +	sk->sk_backlog_rcv = afiucv_hs_backlog_rcv;
>  	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
>  
>  	sock_reset_flag(sk, SOCK_ZAPPED);
> @@ -819,7 +838,7 @@ static int iucv_sock_listen(struct socket *sock, int backlog)
>  	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
>  		goto done;
>  
> -	sk->sk_max_ack_backlog = backlog;
> +	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
>  	sk->sk_ack_backlog = 0;
>  	sk->sk_state = IUCV_LISTEN;
>  	err = 0;
> @@ -1031,7 +1050,16 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  	}
>  	skb = sock_alloc_send_pskb(sk, headroom + linear, len - linear,
> -				   noblock, &err, 0);
> +				   1, &err, 0);
> +	if (!skb && err == -EAGAIN && !noblock) {
> +		/* unlocked: over z/VM the room comes back only when the peer
> +		 * receives, and that may wait for our own recvmsg()
> +		 */
> +		release_sock(sk);
> +		skb = sock_alloc_send_pskb(sk, headroom + linear,
> +					   len - linear, 0, &err, 0);
> +		lock_sock(sk);
> +	}
>  	if (!skb)
>  		goto out;
>  	if (headroom)
> @@ -1045,10 +1073,16 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>  
>  	/* wait if outstanding messages for iucv path has reached */
>  	timeo = sock_sndtimeo(sk, noblock);
> -	err = iucv_sock_wait(sk, iucv_below_msglim(sk), timeo);
> +	err = iucv_sock_wait(sk, iucv_below_msglim(sk) ||
> +			     (sk->sk_shutdown & SEND_SHUTDOWN), timeo);
>  	if (err)
>  		goto fail;
>  
> +	/* return -EPIPE if sending has been shut down meanwhile */
> +	if (sk->sk_shutdown & SEND_SHUTDOWN) {
> +		err = -EPIPE;
> +		goto fail;
> +	}
>  	/* return -ECONNRESET if the socket is no longer connected */
>  	if (sk->sk_state != IUCV_CONNECTED) {
>  		err = -ECONNRESET;
> @@ -1252,6 +1286,56 @@ static void iucv_process_message_q(struct sock *sk)
>  	}
>  }
>  
> +/*
> + * Like skb_recv_datagram(), but sleep with the socket lock released, so that
> + * release_sock() runs the backlog and a deferred FIN reaches the reader.
> + */

I'd prefer kernel-doc comments and network style (without the first line
/*  [2])
But no strong feeling.


> +static struct sk_buff *iucv_sock_recv_skb(struct sock *sk, int flags, int *err)
> +{
> +	long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	struct sk_buff *skb;
> +
> +	add_wait_queue(sk_sleep(sk), &wait);
> +	for (;;) {
> +		/* receive/dequeue next skb:
> +		 * the function understands MSG_PEEK and, thus, does not
> +		 * dequeue skb, only refcount is increased.
> +		 */
> +		skb = skb_recv_datagram(sk, flags | MSG_DONTWAIT, err);
> +		if (skb || *err != -EAGAIN)
> +			break;
> +		if (sk->sk_shutdown & RCV_SHUTDOWN)
> +			break;
> +		if (!timeo)
> +			break;
> +		if (sk->sk_state != IUCV_CONNECTED) {
> +			/* the connection is gone and nothing is left to read:
> +			 * EOF, as a fresh call gets at the top of
> +			 * iucv_sock_recvmsg()
> +			 */
> +			if (sk->sk_state == IUCV_DISCONN &&
> +			    skb_queue_empty(&iucv_sk(sk)->backlog_skb_q) &&
> +			    list_empty(&iucv_sk(sk)->message_q.list))
> +				*err = 0;
> +			else
> +				*err = -ENOTCONN;
> +			break;
> +		}
> +		if (signal_pending(current)) {
> +			*err = sock_intr_errno(timeo);
> +			break;
> +		}
> +		sk_wait_event(sk, &timeo,
> +			      !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
> +			      READ_ONCE(sk->sk_err) ||
> +			      (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
> +			      sk->sk_state != IUCV_CONNECTED, &wait);
> +	}
> +	remove_wait_queue(sk_sleep(sk), &wait);
> +	return skb;
> +}
> +
>  static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  			     size_t len, int flags)
>  {
> @@ -1263,31 +1347,32 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  	int err = 0;
>  	u32 offset;
>  
> +	lock_sock(sk);
>  	if ((sk->sk_state == IUCV_DISCONN) &&
>  	    skb_queue_empty(&iucv->backlog_skb_q) &&
>  	    skb_queue_empty(&sk->sk_receive_queue) &&
> -	    list_empty(&iucv->message_q.list))
> -		return 0;
> +	    list_empty(&iucv->message_q.list)) {
> +		copied = 0;
> +		goto out;
> +	}
>  
> -	if (flags & (MSG_OOB))
> -		return -EOPNOTSUPP;
> +	if (flags & (MSG_OOB)) {
> +		err = -EOPNOTSUPP;
> +		goto out_err;
> +	}
>  
> -	/* receive/dequeue next skb:
> -	 * the function understands MSG_PEEK and, thus, does not dequeue skb
> -	 * only refcount is increased.
> -	 */
> -	skb = skb_recv_datagram(sk, flags, &err);
> +	skb = iucv_sock_recv_skb(sk, flags, &err);
>  	if (!skb) {
>  		if (sk->sk_shutdown & RCV_SHUTDOWN)
> -			return 0;
> -		return err;
> +			err = 0;
> +		goto out_err;
>  	}
>  
>  	offset = IUCV_SKB_CB(skb)->offset;
>  	rlen   = skb->len - offset;		/* real length of skb */
>  	copied = min_t(unsigned int, rlen, len);
>  	if (!rlen)
> -		sk->sk_shutdown = sk->sk_shutdown | RCV_SHUTDOWN;
> +		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
>  
>  	cskb = skb;
>  	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
> @@ -1331,9 +1416,10 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		 */
>  		if (iucv->transport == AF_IUCV_TRANS_HIPER && rlen) {

This applies only on top of [1]
Can we do this one first? i.e. independently and based on upstream net?

Ah, now I see that you mentioned that in the cover letter.
Probably ok, as this is an RFC.



>  			atomic_inc(&iucv->msg_recv);
> -			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
> -				iucv_sock_close(sk);
> -				return -EFAULT;
> +			if (atomic_read(&iucv->msg_recv) > iucv->msglimit_adv) {
> +				__iucv_sock_close(sk);
> +				err = -EFAULT;
> +				goto out_err;
>  			}
>  		}
>  
> @@ -1355,18 +1441,23 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  				iucv_process_message_q(sk);
>  			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
>  			    atomic_read(&iucv->msg_recv) >=
> -							iucv->msglimit / 2)
> +							iucv->msglimit_adv / 2)
>  				send_win = true;
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
>  
> -		if (send_win) {
> +		if (send_win && sk->sk_state == IUCV_CONNECTED) {
>  			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
>  			if (err) {
>  				sk->sk_state = IUCV_DISCONN;
>  				sk->sk_state_change(sk);
>  			}
>  		}
> +		/* no window update went out: the peer, gone or going, takes
> +		 * no credit. Drop it.
> +		 */
> +		if (send_win && sk->sk_state != IUCV_CONNECTED)
> +			atomic_set(&iucv->msg_recv, 0);

I wonder whether this should be in a seperate patch.
Is it really related to 'HiperSockets receive with the socket lock'?

>  	}
>  
>  done:
> @@ -1375,7 +1466,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		copied = rlen;
>  	if (flags & MSG_PEEK)
>  		skb_unref(skb);
> -
> +out:
> +	release_sock(sk);
>  	return copied;
>  
>  err_out:
> @@ -1383,7 +1475,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		skb_queue_head(&sk->sk_receive_queue, skb);
>  	else
>  		skb_unref(skb);
> -
> +out_err:
> +	release_sock(sk);
>  	return err;
>  }
>  

done,out,err_out,out_err: Not very descriptive label names. Do you have
a better idea?

[...]

For these critical, non-trivial functions below, I think kernel-doc
comments and network style (without the first line /*  [2]) would be
even more helpful.
Describe what is context and what is happeing inside the function.
Your comments are already really helpful, but to readers new to the
subject, they may still be a bit ambiguous.
I am not an expert on comments, nor  in socket handling, so take my
comments and proposals below with a grain of salt.


> +/*
> + * A frame that changes sk_state waits while a task owns the socket. Data, SHT
> + * and WIN frames do not change it, so they go through: a reader holding the
> + * lock would otherwise wait for its own window. They wait while the reply to our
> + * SYN is pending, to be received connected, and never past frames already
> + * waiting: sk_backlog.len stays set until __release_sock() has run them all.
> + */

^^ This comment sounds important, but I don't get what it is trying to
point out. (After reading the code changes, I think I have an idea what
it is referring to)

> +static bool afiucv_hs_defer(struct sock *sk)
> +{
> +	return (iucv_sk(sk)->hs_pending & AF_IUCV_PEND_SYNREPLY) ||
> +	       sk->sk_backlog.len != 0;
> +}
> +
> +/*
> + * A SYN|ACK, SYN|FIN or FIN that arrives while a task owns the socket is
> + * recorded, not queued: nothing resends one, and the backlog may not keep an
> + * skb from the pfmemalloc reserves (see sk_add_backlog()). The first reply to
> + * our SYN decides, as on arrival; a FIN applies after it. Under sk_lock.slock.
> + */
> +static void afiucv_hs_record(struct sock *sk, struct sk_buff *skb, u8 flags)
> +{
> +	struct iucv_sock *iucv = iucv_sk(sk);
> +
> +	switch (flags) {
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY)) {
> +			iucv->hs_pending_window = iucv_trans_hdr(skb)->window;
> +			iucv->hs_pending |= AF_IUCV_PEND_SYNACK;
> +		}
> +		break;
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY))
> +			iucv->hs_pending |= AF_IUCV_PEND_SYNFIN;
> +		break;
> +	case AF_IUCV_FLAG_FIN:
> +		iucv->hs_pending |= AF_IUCV_PEND_FIN;
> +		break;
> +	}
> +	consume_skb(skb);
> +}
> +
> +/* the owner applies what afiucv_hs_record() kept, under sk_lock.slock */
> +static void afiucv_hs_apply(struct sock *sk, u8 mask)
> +{
> +	struct iucv_sock *iucv = iucv_sk(sk);
> +	u8 pending = iucv->hs_pending & mask;
> +
> +	iucv->hs_pending &= ~pending;
> +	/* closed meanwhile: __iucv_sock_close() leaves IUCV_BOUND as it is */
> +	if (sock_flag(sk, SOCK_ZAPPED))
> +		return;
> +	if ((pending & AF_IUCV_PEND_SYNACK) && sk->sk_state == IUCV_BOUND)
> +		afiucv_hs_synack(sk, iucv->hs_pending_window);
> +	if ((pending & AF_IUCV_PEND_SYNFIN) && sk->sk_state == IUCV_BOUND)
> +		afiucv_hs_synfin(sk);
> +	if ((pending & AF_IUCV_PEND_FIN) && sk->sk_state == IUCV_CONNECTED)
> +		afiucv_hs_fin(sk);
> +}
> +
> +/* release_sock(), after the backlog: still the owner, under sk_lock.slock */
> +static void afiucv_hs_release_cb(struct sock *sk)
> +{
> +	if (iucv_sk(sk)->hs_pending)
> +		afiucv_hs_apply(sk, AF_IUCV_PEND_ALL);
> +}
> +
> +/*
> + * Not sk_add_backlog(): its limit is in bytes, and nothing resends a frame it
> + * drops. 

A full sentence may be even clearer:
"Don't use sk_add_backlog() here, because its limit is in bytes..." (?)

> Count frames instead. 

It ma ybe helpful to mention why we need to count frames: Because
msglimit for iucv is defined in frames (?).

Data, SHT and WIN frames get the window we gave
> + * the peer plus one: before the reply to our SYN, a peer that keeps to it has
> + * at most that many data frames and one SHT waiting, and no WIN to send us. A
> + * listener's SYNs get its accept queue plus the one sk_acceptq_is_full()
> + * admits past it. Both counts restart only once __release_sock() has run
> + * every frame: a flood cannot keep the owner draining. A SYN the backlog does
> + * not take is refused at once; one that waits is cut to its header, which the
> + * reply reuses, and holds its device for it, as the listener may close, or
> + * fill its accept queue, meanwhile.
> + */
> +static void afiucv_hs_backlog_add(struct sock *sk, struct sk_buff *skb,
> +				  u8 flags)
> +{
> +	struct iucv_sock *iucv = iucv_sk(sk);
> +	unsigned int *count, limit;
> +
> +	if (!sk->sk_backlog.len) {
> +		iucv->hs_backlog_data = 0;
> +		iucv->hs_backlog_syn = 0;
> +	}
> +	if (flags == AF_IUCV_FLAG_SYN) {
> +		count = &iucv->hs_backlog_syn;
> +		limit = READ_ONCE(sk->sk_max_ack_backlog) + 1;
> +	} else {
> +		count = &iucv->hs_backlog_data;
> +		limit = iucv->msglimit_adv + 1;
> +	}
> +	if (*count >= limit ||
> +	    (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)))
> +		goto refuse;
> +	if (flags == AF_IUCV_FLAG_SYN) {
> +		if (pskb_trim(skb, sizeof(struct af_iucv_trans_hdr)))
> +			goto refuse;
> +		dev_hold(skb->dev);
> +	}
> +	__sk_add_backlog(sk, skb);
> +	/* msglimit 65535 x 64K frames would wrap the int */
> +	sk->sk_backlog.len = min_t(u32, sk->sk_backlog.len + skb->truesize,
> +				   INT_MAX);
> +	(*count)++;
> +	return;
> +
> +refuse:
> +	if (flags == AF_IUCV_FLAG_SYN) {
> +		afiucv_hs_callback_syn(NULL, skb);
> +	} else {
> +		sk_drops_inc(sk);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG);
> +	}
> +}
> +
> +/*
> + * Frames the dispatcher would only free, and a SYN it would only refuse, do
> + * not wait for the owner.
> + */
> +static bool afiucv_hs_stray(struct sock *sk, u8 flags)
> +{
> +	switch (flags) {
> +	case 0:
> +	case AF_IUCV_FLAG_SHT:
> +	case AF_IUCV_FLAG_WIN:
> +	case AF_IUCV_FLAG_FIN:
> +		return false;
> +	case AF_IUCV_FLAG_SYN:
> +		return sk->sk_state != IUCV_LISTEN;
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +		return sk->sk_state != IUCV_BOUND;
> +	}
> +	return true;
> +}
> +
> +/*
> + * @sk is NULL, or locked by the caller: bh_lock_sock() in afiucv_hs_rcv(),
> + * where the user may own it too, or user-owned in afiucv_hs_backlog_rcv().
> + */
> +static int afiucv_hs_dispatch(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct af_iucv_trans_hdr *trans_hdr = iucv_trans_hdr(skb);
> +	int err = NET_RX_SUCCESS;
> +
> +	switch (trans_hdr->flags) {
> +	case AF_IUCV_FLAG_SYN:
> +		/* connect request */
> +		err = afiucv_hs_callback_syn(sk, skb);
> +		break;
> +	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK):
> +		/* connect request confirmed */
> +		err = afiucv_hs_callback_synack(sk, skb);
> +		break;
> +	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN):
> +		/* connect request refused */
> +		err = afiucv_hs_callback_synfin(sk, skb);
> +		break;
> +	case (AF_IUCV_FLAG_FIN):
> +		/* close request */
> +		err = afiucv_hs_callback_fin(sk, skb);
> +		break;
> +	case (AF_IUCV_FLAG_WIN):
> +		err = afiucv_hs_callback_win(sk, skb);
> +		if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
> +			consume_skb(skb);
> +			break;
> +		}
> +		fallthrough;	/* and receive non-zero length data */
> +	case (AF_IUCV_FLAG_SHT):
> +		/* shutdown request */
> +		fallthrough;	/* and receive zero length data */
> +	case 0:
> +		/* plain data frame */
> +		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
> +		err = afiucv_hs_callback_rx(sk, skb);
> +		break;
> +	default:
> +		kfree_skb(skb);
> +	}
> +	return err;
> +}
> +
> +/* run by __release_sock() for each frame that waited; @sk is still owned */
> +static int afiucv_hs_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct net_device *dev = NULL;
> +
> +	/* the reply to our SYN came before any frame that waited */
> +	spin_lock_bh(&sk->sk_lock.slock);
> +	afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY);
> +	spin_unlock_bh(&sk->sk_lock.slock);
> +	if (iucv_trans_hdr(skb)->flags == AF_IUCV_FLAG_SYN) {
> +		dev = skb->dev;		/* held by afiucv_hs_backlog_add() */
> +		if (sk->sk_state != IUCV_LISTEN || sk_acceptq_is_full(sk)) {
> +			/* closed, or its accept queue filled, while the SYN
> +			 * waited: refused as a stray is, without a child
> +			 */
> +			afiucv_hs_callback_syn(NULL, skb);
> +			dev_put(dev);
> +			return 0;
> +		}
> +	}
> +	/* BH off: the callbacks take message_q.lock with spin_lock() */
> +	local_bh_disable();
> +	afiucv_hs_dispatch(sk, skb);
> +	local_bh_enable();
> +	dev_put(dev);
> +	return 0;
> +}
> +
> +/* a task owns @sk, under bh_lock_sock(): what each frame does meanwhile */
> +static int afiucv_hs_rcv_owned(struct sock *sk, struct sk_buff *skb, u8 flags)
> +{
> +	switch (flags) {
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +	case AF_IUCV_FLAG_FIN:
> +		afiucv_hs_record(sk, skb, flags);
> +		return NET_RX_SUCCESS;
> +	case AF_IUCV_FLAG_SYN:
> +		break;
> +	default:
> +		if (!afiucv_hs_defer(sk))
> +			return afiucv_hs_dispatch(sk, skb);
> +	}
> +	afiucv_hs_backlog_add(sk, skb, flags);
> +	return NET_RX_SUCCESS;
> +}
> +



>  /*
>   * afiucv_hs_rcv() - base function for arriving data through HiperSockets
>   *                   transport
> @@ -2147,53 +2488,22 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!iucv)
>  		sk = NULL;
>  
> -	/* no sock
> -	how should we send with no sock
> -	1) send without sock no send rc checking?
> -	2) introduce default sock to handle this cases
> -
> -	 SYN -> send SYN|ACK in good case, send SYN|FIN in bad case
> -	 data -> send FIN
> -	 SYN|ACK, SYN|FIN, FIN -> no action? */
> +	if (!sk)
> +		return afiucv_hs_dispatch(NULL, skb);
>  
> -	switch (trans_hdr->flags) {
> -	case AF_IUCV_FLAG_SYN:
> -		/* connect request */
> -		err = afiucv_hs_callback_syn(sk, skb);
> -		break;
> -	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK):
> -		/* connect request confirmed */
> -		err = afiucv_hs_callback_synack(sk, skb);
> -		break;
> -	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN):
> -		/* connect request refused */
> -		err = afiucv_hs_callback_synfin(sk, skb);
> -		break;
> -	case (AF_IUCV_FLAG_FIN):
> -		/* close request */
> -		err = afiucv_hs_callback_fin(sk, skb);
> -		break;
> -	case (AF_IUCV_FLAG_WIN):
> -		err = afiucv_hs_callback_win(sk, skb);
> -		if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
> -			consume_skb(skb);
> -			break;
> -		}
> -		fallthrough;	/* and receive non-zero length data */
> -	case (AF_IUCV_FLAG_SHT):
> -		/* shutdown request */
> -		fallthrough;	/* and receive zero length data */
> -	case 0:
> -		/* plain data frame */
> -		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
> -		err = afiucv_hs_callback_rx(sk, skb);
> -		break;
> -	default:
> -		kfree_skb(skb);
> +	bh_lock_sock(sk);
> +	if (afiucv_hs_stray(sk, trans_hdr->flags)) {
> +		if (trans_hdr->flags == AF_IUCV_FLAG_SYN)
> +			afiucv_hs_callback_syn(NULL, skb);
> +		else
> +			kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
> +	} else if (sock_owned_by_user(sk)) {
> +		err = afiucv_hs_rcv_owned(sk, skb, trans_hdr->flags);
> +	} else {
> +		err = afiucv_hs_dispatch(sk, skb);
>  	}
> -
> -	if (sk)
> -		sock_put(sk);
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
>  	return err;
>  }
>  
> 

I like the new afiucv_hs_rcv() a lot.



[1] [PATCH net v2 2/2] net/iucv: do not count the SHT frame against the
receive window

[2] https://docs.kernel.org/doc-guide/kernel-doc.html
