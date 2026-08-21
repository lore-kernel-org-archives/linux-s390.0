Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A448F820;
	Fri, 21 Aug 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324154; cv=none; b=PQX75L9eg4rEe4QrvpyEgOsr9hT+S6oocTQMhK9g0kN3dWgcc0cYJl7z3Ugb4LNzdcL5zBa6Ol9jTosesyWr7Vq0KD10efkLF2z/WYR7gXM0gjcLrByEiRV6ubfGIm1rjrd0OPUL3NIGQmTKxXuNh/y45+2Kwy+DCqwL64CVLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324154; c=relaxed/simple;
	bh=HvED1scbcaG8UOaxgxJzXS/KtTE4Okg9eqqVQKC+HZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=karp+uFQq3bklDAmZUvyZsFf58VYIUZcDv7x/RbxNFkvszaXTZWXvNkU2ANEFBJkZMpnrZYdgjGKfFfHemu01Bpk5TaX+i4PFo0SeMj7svIBmPqzkEBdjPRLu+tUDNuylY+b1dRGI3EF2cq0EfQy30mCm/dG6FhZzeM9Ktwaqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BkbFldyY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BkbFldyY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD2A6E1474186;
	Fri, 21 Aug 2026 14:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7GxngQ
	pMwP0Sj07k2Cc87HrtEfBFJVCG7TIP18q8fUY=; b=BkbFldyYIAXmYLSkatgicQ
	g6rIGOvyvWhYZhtCCP7RVh880e6FI8csO8bPSkGTFeuzeOrGR6WSFWHBS4kYCnwq
	RI4V9OcKe9SYGoO/zYiKRkfwRSGoQi5bXW/8UWe+N/xWpGCVSdaP87YDdgZxC5qt
	xc+o05wHBxnE1Qihq9dUczY6h54j/F1Y/XV4CYjxwUTfEiiMWZCmlUC/joZwgGvL
	8zcfhr+IuuD7MQ8Ry1/d9J1/MRuaRdHg8E/qr12ZkoEiEO0v4DGVBH8pZM5SOuLe
	tgHirA46i96vCmLG1hr2WSQrz5dBVvDgXwIqfk6LPMoSA2z53hisc7M8wJgDvGWA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4j38k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:55:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LEfIoV030689;
	Fri, 21 Aug 2026 14:55:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngw1gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:55:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LEtRoE20972230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 14:55:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD2358055;
	Fri, 21 Aug 2026 14:55:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5359F58043;
	Fri, 21 Aug 2026 14:55:22 +0000 (GMT)
Received: from [9.124.213.154] (unknown [9.124.213.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 14:55:21 +0000 (GMT)
Message-ID: <a99a04f7-c909-4a30-ac8b-8bc60aec28ba@linux.ibm.com>
Date: Fri, 21 Aug 2026 20:25:20 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/iucv: take a private, writable frame before
 rewriting it in place
To: Bryam Vargas <hexlabsecurity@proton.me>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@kernel.org>, Ursula Braun <ursula.braun@de.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
 <5f368349-a417-42b9-9ee3-d9996a949bb2@linux.ibm.com>
 <20260821114155.430473-1-hexlabsecurity@proton.me>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260821114155.430473-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX5CtP1U0JLDxk
 BhrxCqp3ZzRCQ0PUQbhq/q1aNja6o7nHdCEnzfwMINLeFi3VZHF3eNq7jWfOGvLEsrJwUoIszm3
 OJUgYRzBN1xrCc73z4A3NH1VOgnasg0=
X-Proofpoint-GUID: oBsP6-_EoAu3GJ8-SyCn1vHFvmtw1lv6
X-Proofpoint-ORIG-GUID: oU8x85zqdX6QvfTYV4oPQzpht1dXFolN
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a8866e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=OI7gpJL_KBKkOlYglzEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX4ucjWn1HbJCe
 7NZqjNKsLvXLORNfa6wpKeZFw2+BUGXWy0e/bxP3ZrEO2LdU88XQh7y1K53+YkTG7JkQroIZi+k
 FYnZ5f2eoi0PF5qD4yNvKQg0gY2aOUfSmihHRZ/iWlbazvSMAkzy9BK59ZnmUGtcTZe/PeTlgYj
 BM3iA7WKQ0wjiDqF5M0uZtgCB+IEsmBlUZHAD3J7O+RXjy5YkDM9EvhUOkgqvexbL0Xsn45jy5E
 2rWQljpbrWkU9y1CAJ5Cju05ozV6zbj/+EbVYC24goaA44MNDqikyjBwcLISxEwjKK5nVZMMuwB
 s5gThSIR6C5ieiyaU2ZkPsWMJFiteQjDv3KBqCxJ/lLVZOCopDcKmMv3UoDSo7rOeTlSOTPeD4A
 D9s1fNGMqMtddlHyDRXo4WW3wJ6gwOSr6U9pzqjOLHNfm/JWfP56+ZyfQYToRuJqCrj9cVwr517
 /RDj/Ld1HJurBdFThNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210112


On 21/08/26 5:12 pm, Bryam Vargas wrote:
> Alexandra,
>
>> Excuse my ignorance, if it is obvious to other readers, but is the worst
>> thing that the output of tcpdump is not correct?
> Not obvious, and my description is why: it led with tcpdump, which is the
> mildest end of this.
>
> The order is the other way round. __netif_receive_skb_core() walks
> ptype_base[] at net/core/dev.c:6160, before net->ptype_specific (:6169)
> and orig_dev->ptype_specific (:6173). iucv_packet_type sets no .dev and no
> .af_packet_net, so it sits in ptype_base[] while a packet socket for
> ETH_P_AF_IUCV lands in one of the later lists. af_iucv runs first, and the
> AF_PACKET reader gets the frame after EBCASC() has rewritten the four name
> fields. The capture is wrong, but it was already wrong before the reader
> was reached.
>
> That isn't what I'd defend the patch on. Because af_iucv isn't the last
> matching handler in that configuration, deliver_ptype_list_skb() hands it
> over through deliver_skb(), which does refcount_inc(&skb->users) before
> calling us (dev.c:2492, :2507). We run with users == 2, and on that skb we
> rewrite the header in place, skb_push() 14 bytes in afiucv_swap_src_dest()
> and pass the same skb to dev_queue_xmit() (af_iucv.c:1876, :1888, :1914) --
> including for a frame that matched no socket (:1872).
>
> What hides it in review is a guard asymmetry. deliver_skb() leaves
> users == 2 with skb->cloned == 0, so skb_shared() is true while
> skb_cloned() is false, and the copy-on-write guards all test skb_cloned()
> -- __pskb_pull_tail() at skbuff.c:2886 among them -- so they read the skb
> as already writable. The one that does test it is BUG_ON(skb_shared(skb))
> at the top of pskb_expand_head() (skbuff.c:2305); skb_expand_head() carries
> "/* pskb_expand_head() might crash, if skb is shared. */" (:2456) for the
> same reason.
>
> What I don't have is a panic. On the qeth geometry the first
> pskb_may_pull() finds enough tailroom in the napi_get_frags() head and
> copies out of the frags without expanding, so it doesn't reach
> pskb_expand_head that way. By inspection; not reproduced.
>
>> Is this really a problem fix then? Or should it go to net-next?
> If the bar is a failure I can show you, net-next is right. I sent it to net
> because a handler that writes a shared skb and then gives it to the
> transmit path is a rule violation with a BUG_ON behind it, not because I
> can fire that BUG_ON. Your call either way, and net-next is fine by me.
>
> Worth having in the record: reaching the shared state costs one syscall --
> socket(AF_PACKET, SOCK_RAW, htons(0xFBFB)), no bind, no ETH_P_ALL -- since
> ptype_base[] is walked before the per-namespace list.
>
> If Hidayath's version is further along, take his. I'd rather the check land
> than land mine.
Hi Bryam,

Please go ahead with your patch. I had dropped my patch and am not 
pursuing it.

Thanks,
Hidayath
>
> Thanks,
> Bryam
>
