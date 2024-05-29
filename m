Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6CE576;
	Wed, 29 May 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000128; cv=none; b=HtzlopFbDGcX9AbU88Vttq7emUyq2v1VKvFkNbOoSpfDu15y/Z7wmO7p4VZ0dSUIGBnNOjPEmOVH+PD2ujKeh2hZAJTU/lLIdaBXnlpezQQUWkZuSQAnM9/hhVMHRLXmXqRzioJSBTP1Cprgb6WG3oe/L6JlAjFEpMTkdhbull8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000128; c=relaxed/simple;
	bh=V0TviS2uKrn6p35TGcOJVKCpDa1dWM+F7HNcsMWP0aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htGTnLFouDdvyEvNVAdu36OgtT6oxV3wqstQzTi4w6CXV56GKmPeaB7pUpvu4nm/s5xs8goT+B2tc7OZGpXRg0vo042vvxdq3EB1aC2FTdD3mJYDs5G5Nr91WiRHjerej4mJI8iiSw6dHW5tsyuOyHUQbtBZgLrj+iLDDoTKg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V6Ylf2dN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V6Ylf2dN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TGNjhv018657;
	Wed, 29 May 2024 16:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=hBAJKWqg1ls0OvvDemuQQUNTL6+Fe6WvQdUTJBH9uEQ=;
 b=V6Ylf2dNBz8/RRNVRv7n63LsnIr61drpMV7sy1/xnFF1LQFVGlXvjIop4KEIdBMtVG4M
 WTg+rLj5e8B+YXJ7Gj0eqqTKRaZlOcu7HZmtHcUrpOorOk+LVhd018DsrJ5ljhX0foJd
 A0tnCpWZdJ36YflElbD+ymCoTEZT0Mu1Gq9dQXQ7e3/nGW1onjxiq510QNRP5HMifXmy
 T33l92ZWbADq10iRE9AtakZjwzMMqbMoWKQJkm/Wm9lgOXW33lMko6EzXNi9J5oUTPYO
 MUksKSPpEzj8IcBhcWRa3ky+1KE/mQIvZNLIpYNYboParzU3uN8nIP0aeGNxR4asx1eu 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye7ty00ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:28:42 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TGSf0V025394;
	Wed, 29 May 2024 16:28:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye7ty00e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:28:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44TF8V2L006891;
	Wed, 29 May 2024 16:28:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpebcrgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 16:28:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44TGSaaN27525784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 16:28:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A26AE58064;
	Wed, 29 May 2024 16:28:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D1C758062;
	Wed, 29 May 2024 16:28:34 +0000 (GMT)
Received: from [9.171.1.223] (unknown [9.171.1.223])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2024 16:28:34 +0000 (GMT)
Message-ID: <328ea674-0904-4c81-a6e2-7be3420ad578@linux.ibm.com>
Date: Wed, 29 May 2024 18:28:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Change the upper boundary of SMC-R's snd_buf
 and rcv_buf to 512MB
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JeTtFwYsY_9fneFcNcZ7aLcr7wLvRjAJ
X-Proofpoint-GUID: gFS97OqS68VpR5rQwnyIkS6y9ZsYqGYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405290114



On 28.05.24 15:51, Guangguan Wang wrote:
> SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
> The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
> RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
> TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
> whose defalut value is 4MB or 6MB, is much larger than SMC-R's upper
> boundary.
> 
> In some scenarios, such as Recommendation System, the communication
> pattern is mainly large size send/recv, where the size of snd_buf and
> rcv_buf greatly affects performance. Due to the upper boundary
> disadvantage, SMC-R performs poor than TCP in those scenarios. So it
> is time to enlarge the upper boundary size of SMC-R's snd_buf and rcv_buf,
> so that the SMC-R's snd_buf and rcv_buf can be configured to larger size
> for performance gain in such scenarios.
> 
> The SMC-R rcv_buf's size will be transferred to peer by the field
> rmbe_size in clc accept and confirm message. The length of the field
> rmbe_size is four bits, which means the maximum value of SMCR_RMBE_SIZES
> is 15. In case of frequently adjusting the value of SMCR_RMBE_SIZES
> in different scenarios, set the value of SMCR_RMBE_SIZES to the maximum
> value 15, which means the upper boundary of SMC-R's snd_buf and rcv_buf
> is 512MB. As the real memory usage is determined by the value of
> net.smc.w/rmem, not by the upper boundary, set the value of SMCR_RMBE_SIZES
> to the maximum value has no side affects.
> 
Hi Guangguan,

That is correct that the maximum buffer(snd_buf and rcv_buf) size of 
SMCR is much smaller than TCP's. If I remember correctly, that was 
because the 512KB was enough for the traffic and did not waist memory 
space after some experiment. Sure, that was years ago, and it could be 
very different nowadays. But I'm still curious if you have any concrete 
scenario with performance benchmark which shows the distinguish 
disadvantage of the current maximum buffer size.

Thanks,
Wenjia

> Guangguan Wang (2):
>    net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when
>      CONFIG_ARCH_NO_SG_CHAIN is defined
>    net/smc: change SMCR_RMBE_SIZES from 5 to 15
> 
>   net/smc/smc_core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
