Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD70233687;
	Wed, 11 Dec 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924167; cv=none; b=aySCjTonL0Px+limW/cOG75N3IDhFOMKuBUu80n1KL9QMnZKvK11jLml5IyudenOdKhwdxClLeVi6Sq2xoxvhhu5vxcI7JHbNJrhfR1GTJH3uv7imBa7iOlSgtl8++Ail4G32oFY9baK//7dPNkjprkXEfC9BzPofQcFWpoz3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924167; c=relaxed/simple;
	bh=Nx2OtLznPMrYylAFzfby0Fi4vm/scTkyO7y2Bx9GMp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dy5+JT6np6cZ+HK7/Oyvye3KZCQ2kd/AXL3FZEBoTXwOfl6SHLQkqnmDWn2XkbKQHKB3eqs3kJbl6mdFbJTfL/W7x/jHJE1o/RMxM4ictDKxLCcUAqKUh0FTYIjLH6lMAE6sQWJkJjlo0TMAaw9b3nguQrq/56sB+TbaTfq2rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uuy6mqcM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uuy6mqcM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBAbVJ8026694;
	Wed, 11 Dec 2024 13:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=83Mm14
	vPTCxgTAsRML9zi54L/sMJzjl1PVd6kBYPl0g=; b=Uuy6mqcMmlKkni9mu9IkIT
	pZubqxO+NamKv/6XTMFzT418bh3/K17nb7Wjha7yo7gsRjHfldogRx4eVszsIr97
	qnsXbAevt5B0yV48Nut+9JmXftiRLL5ISH+ZOREl0qNgcZ7FxnmS3EKfSPqSmro5
	WkOOECI8ZqPwymdt7Kmkd5NwYybb4ZhBDG50tboXZIBP49ZnRtC8C9WakCO7ggx4
	GoTAY1Pk0ankqcCTVCI+BciyrRYZtFr8ybuQtnJni3V1OjW69Cm33yalh8aQSvNn
	hA8tInjSMHgW0N7CX9/tj2S2kUhBeLr/RC+MMDiNbEnBdEsVkH4Vl9PuLu6O90Xg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqcpup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 13:35:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBDX6fC029033;
	Wed, 11 Dec 2024 13:35:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqcpug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 13:35:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBD6rIY000572;
	Wed, 11 Dec 2024 13:35:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn9n7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 13:35:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBDZmMR48103920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 13:35:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BD662004B;
	Wed, 11 Dec 2024 13:35:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEDEC20040;
	Wed, 11 Dec 2024 13:35:47 +0000 (GMT)
Received: from [9.152.224.44] (unknown [9.152.224.44])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 13:35:47 +0000 (GMT)
Message-ID: <54738182-3438-4a58-8c33-27dc20a4b3fe@linux.ibm.com>
Date: Wed, 11 Dec 2024 14:35:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
 <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2w-Kl8r3XbVrtkmVuh3bDXP2BaosYrL1
X-Proofpoint-GUID: -Ph2-HwnIgstGyLMG9Mj4OlSGqU9Shto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110099



On 10.12.24 14:54, Alexander Lobakin wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> Date: Tue, 10 Dec 2024 12:44:04 +0100
> 
>>
>>
>> On 06.12.24 16:20, Alexandra Winter wrote:
>>>
>>>
>>> On 04.12.24 15:32, Alexander Lobakin wrote:
>>>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>>>>  {
>>>>>  	struct mlx5e_sq_stats *stats = sq->stats;
>>>>>  
>>>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>>>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>>>    +		skb_linearize(skb);
>>>> 1. What's with the direct DMA? I believe it would benefit, too?
>>>
>>>
>>> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
>>> Any opinions from the NVidia people?
>>>
>> Agreed.
>>
>>>
>>>> 2. Why truesize, not something like
>>>>
>>>> 	if (skb->len <= some_sane_value_maybe_1k)
>>>
>>>
>>> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
>>> When we set the threshhold at a smaller value, skb->len makes more sense
>>>
>>>
>>>>
>>>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>>>>    it's a good idea to rely on this.
>>>>    Some test-based hardcode would be enough (i.e. threshold on which
>>>>    DMA mapping starts performing better).
>>>
>>>
>>> A threshhold of 4k is absolutely fine with us (s390). 
>>> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
>>>
>>>
>>> NVidia people do you have any opinion on a good threshhold?
>>>

On 09.12.24 12:36, Tariq Toukan wrote:
> Hi,
> 
> Many approaches in the past few years are going the opposite direction, trying to avoid copies ("zero-copy").
> 
> In many cases, copy up to PAGE_SIZE means copy everything.
> For high NIC speeds this is not realistic.
> 
> Anyway, based on past experience, threshold should not exceed "max header size" (128/256b).

>> 1KB is still to large. As Tariq mentioned, the threshold should not
>> exceed 128/256B. I am currently testing this with 256B on x86. So far no
>> regressions but I need to play with it more.
> 
> On different setups, usually the copybreak of 192 or 256 bytes was the
> most efficient as well.
> 
>>


Thank you very much, everybody for looking into this.

Unfortunately we are seeing these performance regressions with ConnectX-6 cards on s390
and with this patch we get up to 12% more transactions/sec even for 1k messages.

As we're always using an IOMMU and are operating with large multi socket systems,
DMA costs far outweigh the costs of small to medium memcpy()s on our system.
We realize that the recommendation is to just run without IOMMU when performance is important,
but this is not an option in our environment.

I understand that the simple patch of calling skb_linearize() in mlx5 for small messages is not a
strategic direction, it is more a simple mitigation of our problem.

Whether it should be restricted to use_dma_iommu() or not is up to you and your measurements.
We could even restrict it to S390 arch, if you want.

A threshold of 256b would cover some amount of our typical request-response workloads
(think database queries/updates), but we would prefer a higher number (e.g. 1k or 2k).
Could we maybe define an architecture dependent threshold?

My preferred scenario for the next steps would be the following:
1) It would be great if we could get a simple mitigation patch upstream, that the distros could
easily backport. This would avoid our customers experiencing performance regression when they
upgrade their distro versions. (e.g. from RHEL8 to RHEL9 or RHEL10 just as an example)

2) Then we could work on a more invasive solution. (see proposals by Eric, Dragos/Saeed).
This would then replace the simple mitigation patch upstream, and future releases would contain 
that solution. If somebody else wants to work on this improved version, fine with me, otherwise
I could give it a try.

What do you think of this approach?


