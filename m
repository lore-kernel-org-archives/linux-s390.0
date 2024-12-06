Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30E209F53;
	Fri,  6 Dec 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498472; cv=none; b=bSYc2uPNOVEQYP2sOnNpFTbxOZ6+RwQvuU9GTyjoAB4oa/vzS3V7gHeuvsguwXNw7Mr1Yw1kCwyoizjSNK8MUSxPjtRFYbXJih1hpfH7FEzwvHWXwQUUPXh9gWrc6kNg/af5nH3zVh4VXYyi325rPjzEvylSnbZDdGwDusHe+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498472; c=relaxed/simple;
	bh=Kr+MAOK28ADUaLgTXLilWUzbX5ty3Lhy72VH3S8siM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/Zux8V4TSGcJFPsOBQvqcp/3ppsD1RIxPPvXeTsHprZvRsRY9tGfimueVDi7FS2nYncjG1SZI140tu4C/+uhmbzoEgU+afJJ90L+6LlSoaYaXWRPI+8mcN+6izNC4hwSqLs8zKeoP+qipiGAn2VjhxGmu8wW8I7iRCUVMDnel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KDy8hKgu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KDy8hKgu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67URkb000602;
	Fri, 6 Dec 2024 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mO+VJr
	+maE/mb/snReBVYCvHVKfou4liBvMuZo9GmYo=; b=KDy8hKguZCaESXlThzI7qw
	U8x2ZlvDarpoC2md/0UI4cJiQWyNh1ierwpy4hI+/bhnrHGlCfmoHXO9t0PrJKKg
	ogkcKetGpwN69KBHy/1ztvhI5kjdD8j0vcjH3iOEvSLVMO8pQsjWYCkVz7zJYQjb
	4AKm/Q0My16kyfCtCW8u8oJG/ZQ7C5dU1HKFjLp0saJBP1g+BDmqfDfnSygG5ERU
	yi4yFNSq5ueWLCKTVB93z6qySc1IH/XsPXZCX71PhxaTvoizQcgDmgANMN2DAbDP
	K82MykX24Ga814Nz4WTeRh1ApD4DXbPUYJOrlfgDgME1HVMCth/cY0PCQV9Lq5yQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxksw1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:20:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6FKVeG023598;
	Fri, 6 Dec 2024 15:20:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxksw18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:20:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6EeVsa005273;
	Fri, 6 Dec 2024 15:20:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1y6ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:20:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6FKqXN31064432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 15:20:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01ED32004B;
	Fri,  6 Dec 2024 15:20:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0617820040;
	Fri,  6 Dec 2024 15:20:51 +0000 (GMT)
Received: from [9.179.9.40] (unknown [9.179.9.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 15:20:50 +0000 (GMT)
Message-ID: <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
Date: Fri, 6 Dec 2024 16:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
        Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w7PWeg2-DsBijpPSROoWwQfR6ORmVj7F
X-Proofpoint-ORIG-GUID: O9m8JQeOSvyPJWytUlQbTlKPTewWTjZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=894 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060113



On 04.12.24 15:32, Alexander Lobakin wrote:
>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>  {
>>  	struct mlx5e_sq_stats *stats = sq->stats;
>>  
>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
   +		skb_linearize(skb);
> 1. What's with the direct DMA? I believe it would benefit, too?


Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
Any opinions from the NVidia people?


> 2. Why truesize, not something like
> 
> 	if (skb->len <= some_sane_value_maybe_1k)


With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
When we set the threshhold at a smaller value, skb->len makes more sense


> 
> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>    it's a good idea to rely on this.
>    Some test-based hardcode would be enough (i.e. threshold on which
>    DMA mapping starts performing better).


A threshhold of 4k is absolutely fine with us (s390). 
A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.


NVidia people do you have any opinion on a good threshhold?
