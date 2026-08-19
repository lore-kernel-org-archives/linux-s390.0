Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB147AF43;
	Wed, 19 Aug 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151951; cv=none; b=FUsCzM6expzlWS6L4BueRCTWjJrjUDkspu+93PKWFoIDqmmgrKGt3n93dKmn8yl31RqphOp0NePneGifGvCwcwUNF7Owy1QSlDc/+7CuW3B5idAec/AIGl1s0l0HomZYwlJq4wdtXfAgRTlW9R8HvvymeSaHdc31R7i19T99XXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151951; c=relaxed/simple;
	bh=a7vCzztUD06jAj17OQikfcNDTEfwx+jXMNOgJbScjv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG4tWyn8gxGlOF2FEj2cRXsXGjf8AbGr0bBxsuIxeWf1NMDHTFpeLfI6ZbmGBSacvBZ7erPvFEBXHL7s28HebgTk0NLr4PBWCVHni0cS11XzLfPZqLmq1eN+YICNPcLB/u+CQxJwxtLhe5ga2mGuArBpTGaiXsn/P+YR5gq7EYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=St+Gzmf3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="St+Gzmf3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1X2s1934094;
	Wed, 19 Aug 2026 15:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=69oA3p
	nt4fZ+Y/UDaB52bexmusuzCxXyA/eN9rJeKkQ=; b=St+Gzmf3rZbwuyusQNv45d
	TYVco5qKBXq8byS89NZry4cLNrXSspj6YHdHhKBvzkehO+vwLSEOekmuiEQivthN
	BIfBuVH9ZsevGgPtyF44uDyV3SoQqMUzNFeb1B+pV4p9DS+qM2bIYJEZfcylBqI+
	3Crmj5GbKMaXb+YwXVdlh+4A5IlqrFrWNsNODsHEQmIu3f8uKIOSdBRFD37pTPOh
	JoprZ0qd9JO/FfzfXYIJXsmNA8LOgeKcZ7vLM2qDW1P5HONkzbJnYWOCq5KjZeIp
	N9t5ZVt5JGASyQqm/lwXAiRju3OIOsu/pymYfia0OdSuSU6+YkVSPcncjfuILzHA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu04gmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:05:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JEuGcE029219;
	Wed, 19 Aug 2026 15:05:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq9p9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:05:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JF5YVr40894916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 15:05:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C792320043;
	Wed, 19 Aug 2026 15:05:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9711D20040;
	Wed, 19 Aug 2026 15:05:34 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 15:05:34 +0000 (GMT)
Message-ID: <ac60e574-8ae0-4585-80e1-27fbfdc34e4f@linux.ibm.com>
Date: Wed, 19 Aug 2026 17:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: only deliver HiperSockets frames to
 HiperSockets sockets
To: hexlabsecurity@proton.me, "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MswOoQ96p4VHk5P7FKxma2Kx3FZQLcVG
X-Proofpoint-GUID: _hS0S0iJeFkYpGcR1YFWL7yD6Mp-Iv8n
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a85c643 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vvvX36JlOh_1kPUMCBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNyBTYWx0ZWRfX6mCsSzInBmlk
 wPGdx+cx9UbAI6mD3E3tV7vEZPL8HFsmpe1rQfBoyxKknjHVWXIjzcPHoh2lTMugqUvno/o7Hss
 Sh6YR7vL2TqZIAYdQUsJ+WPxJ9uAKiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNyBTYWx0ZWRfX6JAmYUB2b83c
 WTtfwvQ53fm3yvNRJ3iMzz3pdtKn3iwnvdRxW8G5/5F+a/KI9qW1DXos+4k8X/5bDTtTvfxB1o4
 ErhuOxx2toSCw+6JpSCBfbiLHL1DKOSbr7niLaL6HvPQqVmZuYHd7tnt5VzpdFBQ8t/A63G2K4K
 BpMph9a7W7ff7FEZwjiERVuOPrgxIYGcLHA0bMywtqwftqj7L5bnn4ox7Cu3UR0RHjZdkeuBfSP
 4SKV0WDJhvUht02WJ4EpFP/rH77yvjRBUXs6eUCnwQyTXjeiOtn6jOrWiY6LUMW0QvvFy+M030B
 QAb+KHlhctqvHfvPzUPE89tnM4yz0UnTDGjCSQDbNZRGMCoXAWu/dXY5l3foxKUGAocG1JsBzS0
 LC4WhU+aXCOGSlhcjuw0N8YONoXl19HJcbh88VpiT1LH6y1JLQye4lSze58oRaKTREdOxciVdrR
 cqqz0cME5BlqWPNS02Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190117



On 13.08.26 14:51, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() selects a socket out of iucv_sk_list by the four name
> fields alone, with no test on iucv->transport, so a frame arriving over
> HiperSockets can be delivered to a socket bound to the classic z/VM IUCV
> transport. iucv_sock_bind() makes that reachable rather than theoretical:
> a bind to the local guest userid always takes the classic path, even on a
> guest that also carries a HiperSockets device with the same identifier.
> 
> Skip sockets that are not on the HiperSockets transport. The two were
> added as alternatives for environments assumed disjoint - IUCV under
> z/VM, HiperSockets on LPAR - and this lookup still assumes a guest has
> only one of them.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> The two transports were introduced as alternatives for environments the
> 2011 series treated as disjoint. Its cover letter says so:
> 
>   "The current transport mechanism for af_iucv (iucv) is only available
>    on VM. HiperSockets provide similar capabilities as iucv and are
>    available on LPAR."
> 
>   https://lore.kernel.org/all/20110727161339.530894848@de.ibm.com/
> 
> That premise is the one to check, and it is yours to settle: on a z/VM guest
> that also has a HiperSockets device both exist at once, and iucv_sock_bind()
> resolves the local userid to the classic transport at the test against
> iucv_userid. If a guest can never reach both, this patch is unnecessary and
> I would rather know that than have it applied.
> 
> Reach is wider than the HiperSockets LAN, which is what decides how urgently
> this is worth taking: iucv_packet_type sets no .dev, afiucv_hs_rcv() ignores
> its dev argument, and nothing checks dev_net() -- net/x25/x25_dev.c and
> net/ieee802154/socket.c both do at exactly that point. An AF_PACKET frame on
> lo from any netns holding CAP_NET_RAW reaches these sockets.
> 
> Two consequences I traced on a classic socket that matches an inbound frame:
> afiucv_hs_callback_synfin() and _fin() overwrite its sk_state, and
> afiucv_hs_callback_syn() builds an accept-queue child with transport HIPER
> but hs_dev NULL, which LL_RESERVED_SPACE() dereferences unguarded on the
> first send. That read lands in mapped lowcore on a default kernel and
> afiucv_hs_send() then returns -ENODEV, so I am not claiming a panic; it
> faults with relocate_lowcore. By inspection; not reproduced. Compile-tested
> for s390x.
> 
> One case where this patch is a regression: a device whose hsuid is set to
> the same 8 characters as
> the guest's z/VM userid. iucv_sock_bind() tests siucv_user_id against
> iucv_userid before it scans for a HiperSockets device, so such a socket
> becomes classic and today receives HiperSockets frames only because this
> lookup does not filter. After this patch it stops receiving them. If that
> configuration is one you support, then this is the wrong patch and the fix
> belongs in the bind ordering.
> ---
>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7..5fb6793b9a64 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sk = NULL;
>  	read_lock(&iucv_sk_list.lock);
>  	sk_for_each(sk, &iucv_sk_list.head) {
> +		if (iucv_sk(sk)->transport != AF_IUCV_TRANS_HIPER)
> +			continue;
>  		if (trans_hdr->flags == AF_IUCV_FLAG_SYN) {
>  			if ((!memcmp(&iucv_sk(sk)->src_name,
>  				     trans_hdr->destAppName, 8)) &&
> 
> ---
> base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
> change-id: 20260813-b4-disp-60433a46-fcdca197129a
> 
> Best regards,
> --  
> Bryam Vargas <hexlabsecurity@proton.me>
> 
> 
> 

I am wondering whether a check of
+		if (iucv_sk(sk)->hs_dev != dev)
+			continue;

would cover a broader range of issues.
I'll try to send a proper patch proposal.




