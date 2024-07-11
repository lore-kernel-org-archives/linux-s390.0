Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6A16C870;
	Thu, 11 Jul 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713495; cv=none; b=Beqb4J7xjB0yafVGJYnZYE2/yLJ9W/TDQ9M6IHP/4Me8oOTRpD+spYFqazcZ0NPeriw8mOeo+rITfXdI4MiLrfPL6+bky+92JxI+WQIc9XWRTGwLphAFSd2jyagukuORuA0rtsflUMOQK7dYne7vRJqM3C7SBbVOilDKKNqSfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713495; c=relaxed/simple;
	bh=rG+rhFqRp+IXWkMK/whHaioY+dau+YVIg0mAS0SkFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mg8rrXQ6LBE7/Ss+LisSIwpLAU8/nIW3eDuzXec0ICF1hn42DzHfNA8d//sjWnlFEQVfRPtmGA2ayncRam8vLVxm31zOQ7pEFywv19tSID/5GyzXZZDnKz5ry5VJWa9CQbmsIakb8T86AdEB0rv0UXIGrZa291nUjRZhs/Fyw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hfU2yAWd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hfU2yAWd"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFSF2L000723;
	Thu, 11 Jul 2024 15:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	rw9iKFj3XZzXf9us0yVA0qIGq9Hz+UF1sQHulaTChM=; b=hfU2yAWdOEm1ZA3Yp
	EstnV6q+S01JuBTKtmTaBuHgkwz4ojN6k3L/UUHASAaWI4wyP4Xtww0SZTUc8uIp
	sNpQi494Nj6XBcas+EOJp8Kgcf+Gsv3oTVcxd7X7CscAdXqC8NDLfje5W7sZREFQ
	/2D6DLyy7olZdMZXS4YSBaSCrB2X5gVcZK5WxY+CwiF5pLU0W+9Q04cawgc8yXa/
	scliWSe0nCXv8jhlp4PF+t3IZV3hdkp2nNkeOyUovj1a026PqTYUL4eM9Kj8ZxWc
	8lQRnenPXbeZoJlzsaNecyXmHkXBb69sAtmnodcfhZcFBDuJvvOs/WylzLE6nJv/
	6nMVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aj2hr2vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 15:58:07 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BFw6jr014949;
	Thu, 11 Jul 2024 15:58:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aj2hr2v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 15:58:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BDi8HU013992;
	Thu, 11 Jul 2024 15:58:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy3h86m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 15:58:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BFw3WR26477138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:58:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0941158054;
	Thu, 11 Jul 2024 15:58:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6220D58062;
	Thu, 11 Jul 2024 15:58:00 +0000 (GMT)
Received: from [9.171.21.149] (unknown [9.171.21.149])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jul 2024 15:58:00 +0000 (GMT)
Message-ID: <cf07ec76-9d48-4bff-99f6-0842b5127c81@linux.ibm.com>
Date: Thu, 11 Jul 2024 17:57:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: introduce autosplit for smc
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709160551.40595-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240709160551.40595-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vQpjI97_zB7F7tl5rsq4ti1R3Ve61A55
X-Proofpoint-ORIG-GUID: ubPATLYJIH5QSrZKPaZiKGKNCXWhVyUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=996
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110111



On 09.07.24 18:05, Guangguan Wang wrote:
> When sending large size data in TCP, the data will be split into
> several segments(packets) to transfer due to MTU config. And in
> the receive side, application can be woken up to recv data every
> packet arrived, the data transmission and data recv copy are
> pipelined.
> 
> But for SMC-R, it will transmit as many data as possible in one
> RDMA WRITE and a CDC msg follows the RDMA WRITE, in the receive
> size, the application only be woken up to recv data when all RDMA
> WRITE data and the followed CDC msg arrived. The data transmission
> and data recv copy are sequential.
> 
> This patch introduce autosplit for SMC, which can automatic split
> data into several segments and every segment transmitted by one RDMA
> WRITE when sending large size data in SMC. Because of the split, the
> data transmission and data send copy can be pipelined in the send side,
> and the data transmission and data recv copy can be pipelined in the
> receive side. Thus autosplit helps improving latency performance when
> sending large size data. The autosplit also works for SMC-D.
> 
> This patch also introduce a sysctl names autosplit_size for configure
> the max size of the split segment, whose default value is 128KiB
> (128KiB perform best in my environment).
> 
> The sockperf benchmark shows 17%-28% latency improvement when msgsize
>> = 256KB for SMC-R, 15%-32% latency improvement when msgsize >= 256KB
> for SMC-D with smc-loopback.
> 
> Test command:
> sockperf sr --tcp -m 1048575
> sockperf pp --tcp -i <server ip> -m <msgsize> -t 20
> 
> Test config:
> sysctl -w net.smc.wmem=524288
> sysctl -w net.smc.rmem=524288
> 
> Test results:
> SMC-R
> msgsize   noautosplit    autosplit
> 128KB       55.546 us     55.763 us
> 256KB       83.537 us     69.743 us (17% improve)
> 512KB      138.306 us    100.313 us (28% improve)
> 1MB        273.702 us    197.222 us (28% improve)
> 
> SMC-D with smc-loopback
> msgsize   noautosplit    autosplit
> 128KB       14.672 us     14.690 us
> 256KB       28.277 us     23.958 us (15% improve)
> 512KB       63.047 us     45.339 us (28% improve)
> 1MB        129.306 us     87.278 us (32% improve)
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>   Documentation/networking/smc-sysctl.rst | 11 +++++++++++
>   include/net/netns/smc.h                 |  1 +
>   net/smc/smc_sysctl.c                    | 12 ++++++++++++
>   net/smc/smc_tx.c                        | 19 ++++++++++++++++++-
>   4 files changed, 42 insertions(+), 1 deletion(-)
> 

Hi Guangguan,

If I remember correctly, the intention to use one RDMA-write for a 
possible large data is to reduce possible many partial stores. Since 
many year has gone, I'm not that sure if it would still be an issue. I 
need some time to check on it.

BTW, I don't really like the idea to use sysctl to set the 
autosplit_size in any value at will. That makes no sense to improve the 
performance.

Thanks,
Wenjia
