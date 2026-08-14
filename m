Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086A42BC23;
	Fri, 14 Aug 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727046; cv=none; b=H1qMJBQB+h9sE2Wq6iFnT8kIAep7YKJ36pjtTol2xh62/dAjapcf7B2AZcw5fl8HgEpmnZvh1pPW5Zytwnivc5Q7bHotrqU3yhUWCXZDhc1w8F5mJWhNCrcTurJIikUK8A6ZzV0m2iPG9zSc8fQFtcCi5qH6umHD0EyP/VVVi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727046; c=relaxed/simple;
	bh=iOBUzIEVRjCS+26iaiIH80pmWAbjx0NfMI/Jlko6CkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJsNdzvqrAY+xG21UzeC9JZlYjE6+yVwXNRZ97T90iIV/Z6JX5oBkTC3hJ/O//wQJ+LBIAXkiAmfMoVcLa6sbw+q84p46dZ61GtMrHay5vAalww8/vhDBw0zmczJ1ZZXahQh7/Y0eSF52/FhPj52v23nM7VKtNL6q3Vx0NGVits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bTAEqvK1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bTAEqvK1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EH1bCP1669334;
	Fri, 14 Aug 2026 17:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gYLfP/
	PRhG6aqeOHMFaP75LombQI/IVWfRjC4JjwMMg=; b=bTAEqvK1h3OC6PCYTWv/wq
	gEyXkknrBG+5PE4V/SP80myBAmdLjU/oPpBsVA1yW97wfCGls+g5lnkxDH01asGT
	RnXbtI2a8ys94HREe0JxSYVWM9/uLxebbW6hNyuHSHsdRBH0L9F2T290Ee8t0l0N
	w9PueY7IdpP6j0bwHCTGU4u7zeE6jRBAgF/IRwVSZAgZ3s7d/uZ9+HUVPat9OseJ
	aR15KCuneG1jbAH+TEXKak/oJA1hzRmR3fwgf1WtgaCzQWE8RhxDe0QpR50a0tMD
	OVzTzkMHEKBzv7TPxjQgmNtQpFdo9D+FxUp8owNSiS23Zl2KBqgV1yUeH9Fg2Qeg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9wts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 17:03:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGuhZQ019283;
	Fri, 14 Aug 2026 17:03:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk854n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 17:03:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EH3XjC51839358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 17:03:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E314B20065;
	Fri, 14 Aug 2026 17:03:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A352005A;
	Fri, 14 Aug 2026 17:03:33 +0000 (GMT)
Received: from [9.111.161.149] (unknown [9.111.161.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 17:03:33 +0000 (GMT)
Message-ID: <5e38d51c-07bb-45f6-8f41-7ab9fca5eede@linux.ibm.com>
Date: Fri, 14 Aug 2026 19:03:33 +0200
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
X-Proofpoint-GUID: 2jTEM7fBMJAor1LcVeQv0G5-9z3vo_ll
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f4a6b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vvvX36JlOh_1kPUMCBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzMCBTYWx0ZWRfX5aPuo47bsNn3
 bx/pViUA7eizUqzWKEJDDXppgvNXWshY2hNcxyWIJavct9bsr/4dI0iVOZzdpDtSYHGRwHqkHvt
 beW81OT9n8ufVbvwbsm8dtpgILu7Ap3H8a9MA+FQtdeCbJt/yMVLPu2mWqjL1nrstNDcYBJeX8x
 xOfhlQ2IvCRXkWB9b2Vay9YKUF2BN62HJXszoLfsILdu2jhxIVZA1aunfEt2A8NAly6Ba3CEiS+
 x6GqhzVrOoWsaGi/dWbD0ngWirlHw1CiKHaeMhkWdRtVfVUexy5D7yCbrd8ShYXKsKOBsJLPr+K
 jPlQq3xayd/O7Pppj54QxFy9eNyj6QqssCrocxL53iojG9PH1y3YqHWocZX/RJTIf+aZZGnsY+Q
 RFv+1bfPKPzIvXkDF9qcYUWyBB533tJvXP4fJ87HcMXZFC6WNVnjSBQsYq8nev/LQohzKioabox
 1WSM7d1L94XcLlPF1bg==
X-Proofpoint-ORIG-GUID: h7XnI_buJIoGpzcSUOJCQE8iPXYT55Uo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzMCBTYWx0ZWRfX+tPoo+dU/ZpD
 nWWwI8RmtFy2jSEfOLOMLMfzAYQNIoTEjExZsD0eEqrwOHahYZn7RWxSXnOZ8OdVqqt0UF3c/Oi
 1/pKN7pfa5XJEBnR9PLrjy2QrBrG01E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140130



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

Hello Bryam,
I agree with your analysis and I welcome your patch, thank you.

As you rightly point out the two transports were introduced as alternatives,
and AF_IUCV over HiperSockets is not intended to work between z/VM guests.

Actually we should prevent setting hsuid in z/VM guests, altogether. That
would also be a good point in time to indicate to the user that they are
doing something meaningless. We'll work on such a fix.

You patch is still good as a protection against malformed packets arriving
at a HiperSockets L3 interface.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

