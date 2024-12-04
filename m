Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6E1B4157;
	Wed,  4 Dec 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322972; cv=none; b=DWWSVgCGv5jsiC2MDMQ7tljP/5gOQyeUPO+SrSKP+oRz1joLIvJ4GADh0GUZ5YEhVBjK3vDtdenKJddg8XLp9zUBNosWf7iu1RPNACPNoOv8c6sKYKItIQ97RT/oIL7nJNHkLGv1Njhig+gOj0ohEfiBK/JXsZxHBKIcjgGBQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322972; c=relaxed/simple;
	bh=d3Ybl+4JRFJo/qSqSOV8Vfacbb0/9YOqhmMPa+w3Ny4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5n/C3Jt69c9pmOfBgB9fBWbVCYufTZIurjQJWd3BqIRXu1BIzuiU8JUX4A631xUfaT3PFHQG51/8MvCsrfNI1e5tyBO7JxrKW8aEmxWRrcYP2KOIv720Xmr0/JfS70zbUNByfrlhpQp2G8gVlUpoVsZkTb/UIDBi/DPfh+eM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JAEsalhY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JAEsalhY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47JGW0014551;
	Wed, 4 Dec 2024 14:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kWKmVk
	pn9dsIpKUTg9GEBYZZ8bylZlf2JofZkEPwfA8=; b=JAEsalhYJOYcrFbQiWJbVQ
	eS1lwjAUpMHicsq11kG3AC4KnqfKCFx4vpprFxuYBzl2LifY5uZaK3IuDgYXGuXb
	eX9ws9cpvpnegoAnpnVYv6/M0hJxN1qkJVSX+i5ytM7KrtfG/zfQxOEA9YG3eKKp
	zZmq0Lzdgk72byXcwqrEd8lcgFBXISBOaOHkVcNZrEsO0skfYiJEMCww6zRkH1kq
	D8jzB2NHt07r1T1vWbV2iF/jVAothZvU2GTq7Ssg+Fl8X0wAn4CKJCztVhC41yt+
	VbQbPGYKwiyiPXc2v8xPTnjq9rKl9GGSlz93EqfM8QeZHJE8msTGtBXRgRb238ag
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbxqy99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:36:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B4Ea06v019114;
	Wed, 4 Dec 2024 14:36:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbxqy97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:36:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Cmrdu020564;
	Wed, 4 Dec 2024 14:35:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1sdb45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:35:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4EZufe54919608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 14:35:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 570A220040;
	Wed,  4 Dec 2024 14:35:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF74120043;
	Wed,  4 Dec 2024 14:35:55 +0000 (GMT)
Received: from [9.152.224.44] (unknown [9.152.224.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 14:35:55 +0000 (GMT)
Message-ID: <eb29649e-836e-44b8-b364-2ed736bad3ee@linux.ibm.com>
Date: Wed, 4 Dec 2024 15:35:55 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Eric Dumazet <edumazet@google.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e30OMQwLtXMFbu8-rabShM7QgoEo7-O-
X-Proofpoint-GUID: ZDK2tRl4_Y2hy2-s_vuTKD_ROHFCqmph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040111



On 04.12.24 15:16, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 3:02 PM Alexandra Winter <wintera@linux.ibm.com> wrote:
>>
>> Linearize the skb if the device uses IOMMU and the data buffer can fit
>> into one page. So messages can be transferred in one transfer to the card
>> instead of two.
>>
>> Performance issue:
>> ------------------
>> Since commit 472c2e07eef0 ("tcp: add one skb cache for tx")
>> tcp skbs are always non-linear. Especially on platforms with IOMMU,
>> mapping and unmapping two pages instead of one per transfer can make a
>> noticeable difference. On s390 we saw a 13% degradation in throughput,
>> when running uperf with a request-response pattern with 1k payload and
>> 250 connections parallel. See [0] for a discussion.
>>
>> This patch mitigates these effects using a work-around in the mlx5 driver.
>>
>> Notes on implementation:
>> ------------------------
>> TCP skbs never contain any tailroom, so skb_linearize() will allocate a
>> new data buffer.
>> No need to handle rc of skb_linearize(). If it fails, we continue with the
>> unchanged skb.
>>
>> As mentioned in the discussion, an alternative, but more invasive approach
>> would be: premapping a coherent piece of memory in which you can copy
>> small skbs.
>>
>> Measurement results:
>> --------------------
>> We see an improvement in throughput of up to 16% compared to kernel v6.12.
>> We measured throughput and CPU consumption of uperf benchmarks with
>> ConnectX-6 cards on s390 architecture and compared results of kernel v6.12
>> with and without this patch.
>>
>> +------------------------------------------+
>> | Transactions per Second - Deviation in % |
>> +-------------------+----------------------+
>> | Workload          |                      |
>> |  rr1c-1x1--50     |          4.75        |
>> |  rr1c-1x1-250     |         14.53        |
>> | rr1c-200x1000--50 |          2.22        |
>> | rr1c-200x1000-250 |         12.24        |
>> +-------------------+----------------------+
>> | Server CPU Consumption - Deviation in %  |
>> +-------------------+----------------------+
>> | Workload          |                      |
>> |  rr1c-1x1--50     |         -1.66        |
>> |  rr1c-1x1-250     |        -10.00        |
>> | rr1c-200x1000--50 |         -0.83        |
>> | rr1c-200x1000-250 |         -8.71        |
>> +-------------------+----------------------+
>>
>> Note:
>> - CPU consumption: less is better
>> - Client CPU consumption is similar
>> - Workload:
>>   rr1c-<bytes send>x<bytes received>-<parallel connections>
>>
>>   Highly transactional small data sizes (rr1c-1x1)
>>     This is a Request & Response (RR) test that sends a 1-byte request
>>     from the client and receives a 1-byte response from the server. This
>>     is the smallest possible transactional workload test and is smaller
>>     than most customer workloads. This test represents the RR overhead
>>     costs.
>>   Highly transactional medium data sizes (rr1c-200x1000)
>>     Request & Response (RR) test that sends a 200-byte request from the
>>     client and receives a 1000-byte response from the server. This test
>>     should be representative of a typical user's interaction with a remote
>>     web site.
>>
>> Link: https://lore.kernel.org/netdev/20220907122505.26953-1-wintera@linux.ibm.com/#t [0]
>> Suggested-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>> Co-developed-by: Nils Hoppmann <niho@linux.ibm.com>
>> Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> index f8c7912abe0e..421ba6798ca7 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> @@ -32,6 +32,7 @@
>>
>>  #include <linux/tcp.h>
>>  #include <linux/if_vlan.h>
>> +#include <linux/iommu-dma.h>
>>  #include <net/geneve.h>
>>  #include <net/dsfield.h>
>>  #include "en.h"
>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>  {
>>         struct mlx5e_sq_stats *stats = sq->stats;
>>
>> +       /* Don't require 2 IOMMU TLB entries, if one is sufficient */
>> +       if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>> +               skb_linearize(skb);
>> +
>>         if (skb_is_gso(skb)) {
>>                 int hopbyhop;
>>                 u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);
>> --
>> 2.45.2
> 
> 
> Was this tested on x86_64 or any other arch than s390, especially ones
> with PAGE_SIZE = 65536 ?
> 

No, I don't have a mlx5 card in an x86_64.
Rahul, could you test this patch?
