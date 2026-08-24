Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312613E1201;
	Mon, 24 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560464; cv=none; b=qAbpZupSXP4p9QPlW7+AqwJKtnDQLzPgLA55BtgHjU9BsfW3LJ9R9KHGmMkKjKKLdtzAfOE2d13SruL+01+kmXW1Z9WmXqv8GgaxBdaUSjUK50Y6oDDBf8RX6uDqGxOlNtCIF/3rakZnzYpJoHE7cmMttBZsc/LqousbkV+Lpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560464; c=relaxed/simple;
	bh=JN6ixBSrDVob3BXoPcmcEgO9otPxExjN6IMuh2+F+Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBv95N+qkhgtkKxjWUQxa3NkbKrqiXqGQgFJIsYDXFVlMw/MZoJcvqxRflRYlE/P9qSxMpISwfKa3xrrZSYhmvVC16r5WERmC02iiSF4JGfgh/AYX8e57kbGoGxx009ZWlnyjgMSZ0acTCFwAACKvKD8l5ZIxF56hlFz+pQkaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qYkwjfuy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qYkwjfuy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VXoR965832;
	Mon, 24 Aug 2026 08:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GRIob2
	7FJN2kMH/s9+nXk5nKefLAlwUl3ScnocVraX8=; b=qYkwjfuypZ6zxHsjcqIXlD
	KFfhaIxNugcKZZmmKkoHeiaFUU1GkbKQhTApeGc2GapZD0R2CGN8Ldo/PI06DjKN
	trTqaKhDj7PXHHsKzbZu6JcFd4yodT2T7fdu1VlinMaQg5/YBHQAogRJ6gN5VK6T
	+GS0Yl/l4//Trye1cu0JzoMSkHm+C9n13NZHuh7XV7wlRnbjPU/ke6eKJpC6trd8
	Puvn3aieR+ZbgSUhCXky2v9yvMP4fy4L/9H47BA56w7IwWFAeVEZR7jO/pIj3t1l
	kiIzkuTC1EPAYIq7f+5dxxrZlD1SC2OaJLJVl1OT06z0O5cCyf1ZZXiSIzE+nsSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4g2d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:34:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QLBe028826;
	Mon, 24 Aug 2026 08:34:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxvjyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:34:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8Xwhi27132632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:33:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA0FD2004B;
	Mon, 24 Aug 2026 08:33:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982ED20040;
	Mon, 24 Aug 2026 08:33:58 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:33:58 +0000 (GMT)
Message-ID: <ca9c364b-ff49-4eae-b727-531552bf22d2@linux.ibm.com>
Date: Mon, 24 Aug 2026 10:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/iucv: take a private, writable frame before
 rewriting it in place
To: Hidayath Khan <hidayath@linux.ibm.com>,
        Bryam Vargas <hexlabsecurity@proton.me>,
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
 <a99a04f7-c909-4a30-ac8b-8bc60aec28ba@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <a99a04f7-c909-4a30-ac8b-8bc60aec28ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jc1zh5JEkVBjD9yaxABepOZWk_8eECLL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX9EVewubTVRVh
 X2JG17wsLTvYGpRafG9JBpDefm5I7fx9/MsGIViFDO0p3qGS3YHfQnd/OypfPY7T7DoRPo4vP8g
 PUA2GvyAnj5zLOuhHBqnqela4aEA/C0=
X-Proofpoint-GUID: DhVW_eJ6hqm9i8nHlWtYl5Rs90yw_RJh
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c01fc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EUfjCc4KrGFp4Znb_H4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfXz2HNJaCf4fEg
 7FZZ0r00uBL8sF3HIz4zqvcBPqFtDLCcOZwBdeSdRLQK8dxz/y8Viw2ZgnVg+jETYe9G1j+Zwnp
 kTREczrdiofJNHo5YZ6glX1cQVwMqYSLsTBfQipaFZniNGs2Q7PWoikxB1zM/TwfVGr/Erablzv
 t0yDjYD+ViNx5Okc944wHFtgEFFJRk/uJWBXq1oq9clYKZJJnl4rp8JpXpiEZBtuU1yUpKF5OFS
 zuJfDA8L+JZz+HGht1Nco6pmXNvE/78AVxRY2gBHGMuwdJbsTnfYmNrAPHreoAnq25PbGclKBmi
 K54DBN0KRMTm/9dsx0mdukGEpvQmcUK43pjEr+Cs0zkOjKMG4PqFd7FidWasu3FAsK+n1ZPoqpc
 HCeDvo+UwEjQ7+GykWcKdNrSsRR3/8K2tY/kSph6b3uC3axFTALupdo6eXHxGuEblW/TpwkubdN
 3+b0mLZNHyRdopSw6JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074



On 21.08.26 16:55, Hidayath Khan wrote:
> 
> On 21/08/26 5:12 pm, Bryam Vargas wrote:
>> Alexandra,
>>
>>> Excuse my ignorance, if it is obvious to other readers, but is the worst
>>> thing that the output of tcpdump is not correct?
>> Not obvious, and my description is why: it led with tcpdump, which is the
>> mildest end of this.
>>
>> The order is the other way round. __netif_receive_skb_core() walks
>> ptype_base[] at net/core/dev.c:6160, before net->ptype_specific (:6169)
>> and orig_dev->ptype_specific (:6173). iucv_packet_type sets no .dev and no
>> .af_packet_net, so it sits in ptype_base[] while a packet socket for
>> ETH_P_AF_IUCV lands in one of the later lists. af_iucv runs first, and the
>> AF_PACKET reader gets the frame after EBCASC() has rewritten the four name
>> fields. The capture is wrong, but it was already wrong before the reader
>> was reached.
>>
>> That isn't what I'd defend the patch on. Because af_iucv isn't the last
>> matching handler in that configuration, deliver_ptype_list_skb() hands it
>> over through deliver_skb(), which does refcount_inc(&skb->users) before
>> calling us (dev.c:2492, :2507). We run with users == 2, and on that skb we
>> rewrite the header in place, skb_push() 14 bytes in afiucv_swap_src_dest()
>> and pass the same skb to dev_queue_xmit() (af_iucv.c:1876, :1888, :1914) --
>> including for a frame that matched no socket (:1872).
>>
>> What hides it in review is a guard asymmetry. deliver_skb() leaves
>> users == 2 with skb->cloned == 0, so skb_shared() is true while
>> skb_cloned() is false, and the copy-on-write guards all test skb_cloned()
>> -- __pskb_pull_tail() at skbuff.c:2886 among them -- so they read the skb
>> as already writable. The one that does test it is BUG_ON(skb_shared(skb))
>> at the top of pskb_expand_head() (skbuff.c:2305); skb_expand_head() carries
>> "/* pskb_expand_head() might crash, if skb is shared. */" (:2456) for the
>> same reason.
>>
>> What I don't have is a panic. On the qeth geometry the first
>> pskb_may_pull() finds enough tailroom in the napi_get_frags() head and
>> copies out of the frags without expanding, so it doesn't reach
>> pskb_expand_head that way. By inspection; not reproduced.
>>
>>> Is this really a problem fix then? Or should it go to net-next?
>> If the bar is a failure I can show you, net-next is right. I sent it to net
>> because a handler that writes a shared skb and then gives it to the
>> transmit path is a rule violation with a BUG_ON behind it, not because I
>> can fire that BUG_ON. Your call either way, and net-next is fine by me.
>>
>> Worth having in the record: reaching the shared state costs one syscall --
>> socket(AF_PACKET, SOCK_RAW, htons(0xFBFB)), no bind, no ETH_P_ALL -- since
>> ptype_base[] is walked before the per-namespace list.
>>
>> If Hidayath's version is further along, take his. I'd rather the check land
>> than land mine.
> Hi Bryam,
> 
> Please go ahead with your patch. I had dropped my patch and am not pursuing it.
> 
> Thanks,
> Hidayath
>>
>> Thanks,
>> Bryam

Thank you for your explanations, Bryam.
I agree it makes sense to treat this as a fix.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>






