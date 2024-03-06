Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD77604CC;
	Wed,  6 Mar 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721427; cv=none; b=XWhihBEVbHGW7KtMFjPxPfjUa/WTOYnKZfzfU+h9R24Ab79jjU2/HeJsXOaeUfNBvSMZcjs5SlkwohBq2ugg4qVgIEACnCztQp76Y8QknVYW/Rs8kmz9BT1fsRfH4hKQsZSUs/VMfJHnN7m2zcz7KlAlIkNM5qDf3GM0eUPqClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721427; c=relaxed/simple;
	bh=S01ZBei+cawFkz5JBTYeF61wwHi1sHF4HbqNfCDPJgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdkpJIIWwi9K8p+AfEuhJZUHd6pTJoS4P358wJdhl3MFZclmGb9Z+/LuCruaNF8/qcHu6a9LoTJt41FKmCLca5ZacW8CquCfsFDiLgWVTPIXpT0T2O3qfUoISjotD1/XwQ2MrGlcerl0Z1LpCH83+FRfwYi414y7vNIKxP2nhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKxzToTw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKxzToTw"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426AR8uF031727;
	Wed, 6 Mar 2024 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mvBIkPpH9v1Gw+Z4ISdOCwN5YxdTddTY0SOBLqqsoVY=;
 b=FKxzToTwQAolBV6Kz3oen1iP6XS6jqCM5S4IMATqdjQGhnK7+mJdPzzEE/1RVgbBWO3v
 MkVZJefVt1EjIPaOF2ELdHebCVkc/EEvtJKmatYUv6he63bUGRKMhxmz6sMBVN+JV9oj
 vwNDXTc7D8gwNho7TBIoqfH89qu5L8shHYtzNS79D2NCqU31bmJUiHpSx4wUGhkaczVJ
 6mMLretsliFj1yB2y3DzNMw09bMsL7MkOVul5eRvRGtzQK6bw6cE0IsSZfck1aIDDu7F
 iLGV2pTlHAIvThHt+Nfn+wVfAldyJNQeXXqUQnoChcgbtLFUnEQHzPHP3vR8Sd0CdqgC wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpprd8brm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:37:03 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426ARfFF000568;
	Wed, 6 Mar 2024 10:37:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpprd8brb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:37:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4269MFNv010913;
	Wed, 6 Mar 2024 10:37:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52dkrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:37:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426Aawku14877394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 10:37:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280CA2004B;
	Wed,  6 Mar 2024 10:36:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07342004F;
	Wed,  6 Mar 2024 10:36:57 +0000 (GMT)
Received: from [9.171.72.167] (unknown [9.171.72.167])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 10:36:57 +0000 (GMT)
Message-ID: <a53bfd1b-c54d-49de-96fb-b687e6e97533@linux.ibm.com>
Date: Wed, 6 Mar 2024 11:36:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Reaching official SMC maintainers
To: Dmitry Antipov <dmantipov@yandex.ru>, Wen Gu <guwen@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, lvc-project@linuxtesting.org
References: <dacadaef-4fec-4d5e-8b91-1a292ab43b37@yandex.ru>
 <cff8e035-b70a-4910-9af6-e62000c0b87e@linux.alibaba.com>
 <625c9519-7ae6-43a3-a5d0-81164ad7fd0e@yandex.ru>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <625c9519-7ae6-43a3-a5d0-81164ad7fd0e@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lh40yiJR4LJVrylj-ZL9GrtPYosyfwuH
X-Proofpoint-ORIG-GUID: EhjZU14Ci2ml6Bm7rBm1UFc_IvlOuRrL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=968
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060083



On 05/03/2024 17:39, Dmitry Antipov wrote:
> On 3/4/24 13:51, Wen Gu wrote:
> 
>> IMHO, if we want to address the problem of fasync_struct entries being
>> incorrectly inserted to old socket, we may have to change the general 
>> code.
> 
> BTW what about using shared wait queue? Just to illustrate an idea:

I'm sorry but could we please clean up the e-mail threads?
This one here is a question if we are still alive: Yes, we are.

The other one i currently treat as an RFC and gracefully ignore the 
PATCH tag. If you want to post it as an patch please come up with a 
solution, clean it up and re-post it.
See patchwork errors for example: 
https://patchwork.kernel.org/project/netdevbpf/patch/20240221051608.43241-1-dmantipov@yandex.ru/

For the general RFC discussion we are going to comment on it as soon as 
we have something to say about it.
Feel free to re-post your idea regarding a shared wait queue there.

Thank you for your interest in smc and the ideas!
- Jan

> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index c9b4a63791a4..02df64747db7 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -126,6 +126,7 @@ struct socket {
>       const struct proto_ops    *ops; /* Might change with IPV6_ADDRFORM 
> or MPTCP. */
> 
>       struct socket_wq    wq;
> +    struct socket_wq    *shared_wq;
>   };
> 
>   /*
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0f53a5c6fd9d..f04d61e316b2 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3360,6 +3360,9 @@ static int __smc_create(struct net *net, struct 
> socket *sock, int protocol,
>           smc->clcsock = clcsock;
>       }
> 
> +    sock->shared_wq = &smc->shared_wq;
> +    smc->clcsock->shared_wq = &smc->shared_wq;
> +
>   out:
>       return rc;
>   }
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index df64efd2dee8..26e66c289d4f 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -287,6 +287,7 @@ struct smc_sock {                /* smc sock 
> container */
>                           /* protects clcsock of a listen
>                            * socket
>                            * */
> +    struct socket_wq    shared_wq;
>   };
> 
>   #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> diff --git a/net/socket.c b/net/socket.c
> index ed3df2f749bf..9b9e6932906f 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1437,7 +1437,8 @@ static int sock_fasync(int fd, struct file *filp, 
> int on)
>   {
>       struct socket *sock = filp->private_data;
>       struct sock *sk = sock->sk;
> -    struct socket_wq *wq = &sock->wq;
> +    struct socket_wq *wq = (unlikely(sock->shared_wq) ?
> +                sock->shared_wq : &sock->wq);
> 
>       if (sk == NULL)
>           return -EINVAL;
> 
> Dmitry
> 
