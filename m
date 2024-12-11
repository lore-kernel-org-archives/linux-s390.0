Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DF1494CC;
	Wed, 11 Dec 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933969; cv=none; b=mPa5RLvvBgBHhY1ZcS71UvmunDo0P5EV6BMPlS/peO1urYRcVcClzYR1+8dYVnD3X+1rN+dvgZxzyFaUpnXMBxBbkJN/5nVQmLHY6nmvAhQtt26OJJKfrVVsf0zcreXEt8J+p253wXHhLO4+w4ran6hZxwGwH0NnI7HPnw0tN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933969; c=relaxed/simple;
	bh=lDhD6+tDZspQ1OCjLzfC0gYXFIjw9MVva4rDHo5opI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRQv30wJnwwAMsQSS29wqJZQ/zbWRZvj5kFbp5KjHbFVbtdIo5Mabd31wKsGomgfp+j2EgyFe9uJv397RqJ8tN7Z2pu6gjfa4xo+zYRL9H3M0bIU21jPS91HDf5V3Z+R8Q4SAkq8RvN6/YTPNz42xvi/w2ZhHfVy8hojoWL1SLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I0tQxVPw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I0tQxVPw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBC3GkQ025935;
	Wed, 11 Dec 2024 16:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3htUVI
	B/OArTLncn1KO884Dr6D0HlSVp2bxsBLN0V80=; b=I0tQxVPwgd0w2yu3ZcJKBT
	oEFIj5na/4MP4DG4AnGPVgq/cR68sS7M0xcBjKyqucm3WzqMMHccPkmoXWxC5mw4
	1JIWS7OwAp1zF7gsBsS17ajrukWtRaEGfIDLk/tfdLTnv21dPGw7epkOt0+fxwT0
	yTQdry0iqemaITrQz0GESpgFXD7O5omHG2dA12kfZqhdPi5IOPkxGEIBJvYMkrjQ
	ZxLJD72vXGydTb3D+AfMwU2S9CIuloV0D9PrEItxb8WOkXb5iik4t0t5zlueVPFA
	4TFNQdlu3E3C97thIQxBQzgQ2GfeUn0bYsqjdkLFunBloBAdsMrx4AzoIKejmOXw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqdms5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 16:19:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBFx7CY013823;
	Wed, 11 Dec 2024 16:19:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqdmrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 16:19:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFt862016919;
	Wed, 11 Dec 2024 16:19:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yamhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 16:19:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBGJAte64029050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 16:19:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E574720043;
	Wed, 11 Dec 2024 16:19:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8411020040;
	Wed, 11 Dec 2024 16:19:09 +0000 (GMT)
Received: from [9.152.224.44] (unknown [9.152.224.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 16:19:09 +0000 (GMT)
Message-ID: <54945b8c-8328-4c34-982c-9a92ebab5b1c@linux.ibm.com>
Date: Wed, 11 Dec 2024 17:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, Eric Dumazet <edumazet@google.com>
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
        Simon Horman <horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
 <b966eb7b-2acd-460d-a84c-4d2f58526f58@linux.ibm.com>
 <82c14009-da71-4c2a-920c-7d32fcb1ffcb@nvidia.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <82c14009-da71-4c2a-920c-7d32fcb1ffcb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yqdbb3MOQ2heAcNv5AyX0YV9oW-1ndzA
X-Proofpoint-GUID: 3QCj56shnCBGi3NEw4a2xKB2INHVwDV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110111



On 10.12.24 12:49, Dragos Tatulea wrote:
> 
> 
> On 06.12.24 16:25, Alexandra Winter wrote:
>>
>>
>> On 04.12.24 15:36, Eric Dumazet wrote:
>>> I would suggest the opposite : copy the headers (typically less than
>>> 128 bytes) on a piece of coherent memory.
>>>
>>> As a bonus, if skb->len is smaller than 256 bytes, copy the whole skb.
>>>
>>> include/net/tso.h and net/core/tso.c users do this.
>>>
>>> Sure, patch is going to be more invasive, but all arches will win.
>>
>>
>> Thank you very much for the examples, I think I understand what you are proposing.
>> I am not sure whether I'm able to map it to the mlx5 driver, but I could
>> try to come up with a RFC. It may take some time though.
>>
>> NVidia people, any suggesttions? Do you want to handle that yourselves?
>>
> Discussed with Saeed and he proposed another approach that is better for
> us: copy the whole skb payload inline into the WQE if it's size is below a
> threshold. This threshold can be configured through the
> tx-copybreak mechanism.
> 
> Thanks,
> Dragos


Thank you very much Dargos and Saeed.
I am not sure I understand the details of "inline into the WQE". 
The idea seems to be to use a premapped coherent array per WQ 
that is indexed by queue element index and can be used to copy headers and
maybe small messages into.
I think I see something similar to your proposal in mlx4 (?).
To me the general concept seems to be similar to what Eric is proposing.
Did I get it right?

I really like the idea to use tx-copybreak for threshold configuration.

As Eric mentioned that is not a very small patch and maybe not fit for backporting
to older distro versions.
What do you think of a two-step approach as described in the other sub-thread?
A simple patch for mitigation that can be backported, and then the improvement
as a replacement?

Thanks,
Alexandra
