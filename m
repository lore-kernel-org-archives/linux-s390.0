Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4322B59D;
	Tue, 10 Dec 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868387; cv=none; b=V8M4F9ONsic8G3WxapDhB8g3NNP7ysRkJbw4P7ufQSL+NUMyGSxMQym7UrVtzDWekm9eq9j5wWbqhUeF5hcb04e+KxPalEms6g+Rs8k4e/D1Y5YCJ0DsKXQzJA2FAr9Uqz9BZyW/vqetKoU7unoPE/ifw/3imJpa6+GEcyoxk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868387; c=relaxed/simple;
	bh=RMklrb3Xczq1CnNyAWx0NuwO3BYGmvSOBxinCLw9Ln0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4niLxcLrSzIjxPa3VBhZLuH/eg2VqXNzztlsoD4b3mfv14AiKfHrti7PUNNohCpiVe/L5FimC2EyUs6pvzUSQol7a4O8JomNcBcLMjO5BMScurIfvu435m8C9afzwqWbXXTzhOJ67ko0RvF/sbnfdJpy2FQ4BmmxKDbapSCTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gP23HQ+O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gP23HQ+O"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrZwF006007;
	Tue, 10 Dec 2024 22:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7aJ4Q1
	LeVYT6SUkuvf2t47oeSOSvzYlJohh+0tAsRBE=; b=gP23HQ+OA648vtg7AeUxS4
	UJUMebi0pMhwyUTstbZqnwhvKCkXkqCOQoG766ylIoUIlrYxzXNpzUOm6MNpusht
	xu4Nj5mbc/heGfcX72NIBfhxxpaNilwqdfdjjCeRi5CuZm9ZkvWKez4KX5GK6r/K
	p2Jag0XhJjiXEQFb9SG2uKF9JVlkjj9BTwBx05dJYw9d++a/821p2PXbCaF4qFbw
	KyIZAjBHfzKAtGV7SlaxezkbWogvCCs0NU+X3wPJ5SEi5R0pPjsI6nU4BUoopi4w
	OAHIRlqoYPIrkgKd7YCfdt6JrOT92/HXCMBW7S8u5RV8M/9Ldh89jPN5GIwobcbw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vsptu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:06:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJr0KH018608;
	Tue, 10 Dec 2024 22:06:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kdqw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:06:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAM6BXB22282976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 22:06:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 392CA5805B;
	Tue, 10 Dec 2024 22:06:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7796458055;
	Tue, 10 Dec 2024 22:06:09 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 22:06:09 +0000 (GMT)
Message-ID: <b6edaea3-3ccb-424b-bd84-762936b7448e@linux.ibm.com>
Date: Tue, 10 Dec 2024 17:06:08 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iommu: document missing def_domain_type return
To: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
        joro@8bytes.org, will@kernel.org, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-6-mjrosato@linux.ibm.com>
 <3db6f346-0cb4-41f7-b532-91bcb0265849@linux.intel.com>
 <0e80948b-7593-4b59-bb77-2f78f00ad2c3@linux.ibm.com>
 <e2c80012-bf7a-4420-a478-482aac4903b8@arm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <e2c80012-bf7a-4420-a478-482aac4903b8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LidFcGQV5J-w-U6jy9QUJ9Kyla0jOSbp
X-Proofpoint-ORIG-GUID: LidFcGQV5J-w-U6jy9QUJ9Kyla0jOSbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100157

On 12/10/24 1:42 PM, Robin Murphy wrote:
> On 10/12/2024 4:26 pm, Matthew Rosato wrote:
>> On 12/9/24 9:57 PM, Baolu Lu wrote:
>>> On 12/10/24 03:24, Matthew Rosato wrote:
>>>> In addition to IOMMU_DOMAIN_DMA, def_domain_type can also return
>>>> IOMMU_DOMAIN_DMA_FQ when applicable, else flush queues will never be
>>>> used.
>>>>
>>>> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
>>>> ---
>>>>    include/linux/iommu.h | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index 05279109c732..d0da1918d2de 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -585,6 +585,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>>>>     * @def_domain_type: device default domain type, return value:
>>>>     *        - IOMMU_DOMAIN_IDENTITY: must use an identity domain
>>>>     *        - IOMMU_DOMAIN_DMA: must use a dma domain
>>>> + *              - IOMMU_DOMAIN_DMA_FQ: dma domain with batch invalidation
>>>
>>> In which case must an iommu driver return IOMMU_DOMAIN_DMA_FQ?
>>>
>>> The flush queue is a policy of "when and how to synchronize the IOTLB"
>>> in dma-iommu.c. The iommu driver actually has no need to understand such
>>> policy.
>>
>> If you look ahead to the next patch where I implement def_domain_type for s390, I found that if I only ever return IOMMU_DOMAIN_DMA from ops->def_domain_type then when go through iommu_dma_init_domain() we will never call iommu_dma_init_fq() regardless of IOMMU_CAP_DEFERRED_FLUSH because of the if (domain->type == IOMMU_DOMAIN_DMA_FQ) check.  So something isn't right here.
> 
> Conceptually I don't think it ever makes sense for a driver to *require* a device to use deferred invalidation. Furthermore it's been the whole design for a while now that drivers should never see nor have to acknowledge IOMMU_DOMAIN_DMA_FQ, it's now just an internal type which exists largely for the sake of making the sysfs interface work really neatly. Also beware that a major reason for overriding iommu_def_domain_type with a paging domain is for untrusted devices, so massaging the result based on iommu_dma_strict is still not necessarily appropriate anyway.
> 
> It appears the real underlying issue is that, like everyone else in the same situation, you're doing def_domain_type wrong. If and when you can't support IOMMU_DOMAIN_IDENTITY, the expectation is that you make __iommu_alloc_identity_domain() fail, such that if iommu_def_domain_type is then ever set to passthrough, iommu_group_alloc_default_domain() falls back to IOMMU_DOMAIN_DMA by itself, and the user gets told they did a silly thing.

OK, I almost see where this all fits to throw out def_domain_type for this series...  but looking at __iommu_alloc_identity_domain, the preferred approach is using a static identity domain which turns __iommu_alloc_identity_domain into a nofail case once you define the identity_domain:
 
if (ops->identity_domain)
	return ops->identity_domain;

So it seems to me to be an all-or-nothing thing, whereas what I'm trying to achieve is a device-based decision on whether the group is allowed to use that identity domain.  Which reminds me that this is ultimately why I ended up looking into def_domain_type in the first place.

If I need __iommu_alloc_identity_domain to fail, I guess what I'm looking to do boils down to something like...

if (ops->identity_domain) { 
	if (!ops->allow_identity || ops->allow_identity(dev))
		return ops->identity_domain;
	else
		return ERR_PTR(-EOPNOTSUPP);
}






