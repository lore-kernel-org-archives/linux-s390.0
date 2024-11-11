Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C319E97A;
	Mon, 11 Nov 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334330; cv=none; b=diI/u2rbd7J1sqnNI+XOPSOZ/a0Vbvz8LNwQf+fQvjuyEK8Yu3NLH6zjJlO425yJzPlgYzFuzYpdRR4x/Zqgc1e0qfaA3B4oXG/SuZvPL2cQjAAsWK3a44XyxuBZ0EdaeqHg6JzAQCx/Y0GiWnyZJ4dSXthOSC2gxeApVVEyUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334330; c=relaxed/simple;
	bh=7R447KrACOYn/wDV6Nkji9SncyMQTorTnGt2p9OKqvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXj7MwhBnRdNtSImYyI4b76JknDBzu4JTRA3aMFpiH8vuWMEXr/bR/xRvUjJoA+xd7mlnGfyJJgHRzgo1VCOCjcprMUDmq6RNLPFYVeP5dgLzlb/e++rLJN5KFyn/yhWqzpiDz/EA8xgSKmfN2CNo/wkiGilL80ysLz/di0wUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pRJhStbg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pRJhStbg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABDeNi8025828;
	Mon, 11 Nov 2024 14:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VRiEJt
	BoUewLxXPVxIHiLo0HWiLCzYbuVCpo6iunYBU=; b=pRJhStbgtjeb10SGXVT501
	g/2bpjcnZ45DiJPtZ1QeEgc9WN43fyno7wgsPur3ZPks/iska965sWmcLMyavlm0
	LsFF+Ju6dn/jot5Q/ohrKHCPmBAN1hrgs0zhqDaSsgmM07jrWOqBzgWXW06gRNE5
	szqNeEY/xhmqSetgiWNadbNrQH0kWhkI1zgSbXh8eF4LKwCdtabF3gdm7WldGMId
	skDi5ZMekaHklYl2IbGoC7hrW5xC0OoiYZ2hpubIckot47s4VEEkSvYBbWpBVRL8
	7xnwjMxv6hvSYzYLV3egWnBx6N/rdvjWZ3nrcLpkzNzR/GsqO+gN2Fu7HE35/4eg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uk0rg45m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 14:11:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ABEBnOS025233;
	Mon, 11 Nov 2024 14:11:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uk0rg45h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 14:11:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB897Ri006603;
	Mon, 11 Nov 2024 14:11:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9ja92a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 14:11:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ABEBmTP54198612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:11:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72CE58060;
	Mon, 11 Nov 2024 14:11:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E9758056;
	Mon, 11 Nov 2024 14:11:45 +0000 (GMT)
Received: from [9.179.23.76] (unknown [9.179.23.76])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Nov 2024 14:11:45 +0000 (GMT)
Message-ID: <ae8e61c6-e407-4303-aece-b7ce4060d73e@linux.ibm.com>
Date: Mon, 11 Nov 2024 15:11:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
To: manas18244@iiitd.ac.in, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4C5mASve2whXvM_WL953xWdc_KxJU8lX
X-Proofpoint-ORIG-GUID: Qxm2kzobVISdmhXTG2g3pw-7R_eySd5-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110116



On 09.11.24 07:28, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Though, the compiler (gcc) optimizes it. Looking at the object dump of
> vmlinux (via `objdump -D vmlinux`), a new function clone
> (__smc_diag_dump.constprop.0) is added which removes this parameter from
> calling convention altogether.
> 
> ffffffff8a701770 <__smc_diag_dump.constprop.0>:
> ffffffff8a701770:       41 57                   push   %r15
> ffffffff8a701772:       41 56                   push   %r14
> ffffffff8a701774:       41 55                   push   %r13
> ffffffff8a701776:       41 54                   push   %r12
> 
> There are 5 parameters in original function, but in the cloned function
> only 4.
> 
> I believe this patch also fixes this oops bug[1], which arises in the
> same function __smc_diag_dump. But I couldn't verify it further. Can
> someone please test this?
> 
> [1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
> ---
>   net/smc/smc_diag.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>   
>   static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>   			   struct netlink_callback *cb,
> -			   const struct smc_diag_req *req,
> -			   struct nlattr *bc)
> +			   const struct smc_diag_req *req)
>   {
>   	struct smc_sock *smc = smc_sk(sk);
>   	struct smc_diag_fallback fallback;
> @@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>   	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>   	struct net *net = sock_net(skb->sk);
>   	int snum = cb_ctx->pos[p_type];
> -	struct nlattr *bc = NULL;
>   	struct hlist_head *head;
>   	int rc = 0, num = 0;
>   	struct sock *sk;
> @@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>   			continue;
>   		if (num < snum)
>   			goto next;
> -		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
> +		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
>   		if (rc < 0)
>   			goto out;
>   next:
> 
> ---
> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
> 
> Best regards,

That's true that the last parameter is not used. And the patch you 
suggested as a cleanup patch looks good to me. However, it should not 
fix the bug[1], because it does not match what the bug[1] described. 
Thank you, Jeongjun, for testing it! That verified that it indeed didn't 
fix the issue. I think the root cause is on handling idiag_sport. I'll 
look into it.

[1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

Thanks,
Wenjia
