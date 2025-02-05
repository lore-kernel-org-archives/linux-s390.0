Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0E207DE0;
	Wed,  5 Feb 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785364; cv=none; b=NuzJSdX3JCaRPOXhMm4OpgE5fvl3YuFtUwgO930vy4YUcxb14p5/ody2s3QZqH7IS60t7CeG7FvzvSvcEegCq0gC31D2iPMISWaz4mM+9FS95x5BfU7lx8A9IFn+fVH4Qw00xOnD0slme/hJPQvqHBTuE2kToHF3Rj/hwSGYddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785364; c=relaxed/simple;
	bh=iPFum/ooN80cOPMsh94P49PMd9sImNoX5r665M1PBEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJB6jpvInQoqJwQxE6TqZXQzcit1w2Cp0jP2ytiMOY9GOP3yqf54puusL515FZkiHXIYWkOz3E4MHoPQJfxW3GELUQBoRJEBldmwhkjxGjoO0Lqhu7t8t7u8t/LzJCh4p+f1z2q2p62CobODocBDm3jEagNSlAF7Uc9sf/bvBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fs1//zAe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fs1//zAe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515EtBre000663;
	Wed, 5 Feb 2025 19:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NsNoTA
	zBIrSlGCv20i9hObAFmMvUHA4jpdgPNAIpdWo=; b=Fs1//zAeAtUSdbAsmkoaxG
	Wuk/KfT0vD3Knm9Nu1MlnkKTfY659XvN7HUNDTRLjGE5+fteWi1/tFPu3MmDaOMW
	PYuuXpXbNOqV2xz9i9tSUYqkYjGHbqQSb9QMdklKAKJ9/eFL49y/eey2qZBY5hZ5
	rkhqQm93gQAvPy1tyKfpBMre3906X/ZV2yWJZkQPcS2fmQyt7JdKwbC79bwc7GD0
	PnTyTRvvf/yqgPCKh1qtBRkQ+25dmaW9TzroR7Ortjtt+8phMgIeIg4DzmfRUqZw
	Kq/pfcP2AizXMP6ujS+QlKiRHAHyU4fA730tiifHt4zS/lO4vzHc45QQBVBO+8fg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m1t84c49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 19:55:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515JU3h8006535;
	Wed, 5 Feb 2025 19:55:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekjg0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 19:55:48 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515JtlUM29688426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 19:55:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A81658055;
	Wed,  5 Feb 2025 19:55:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58A85804B;
	Wed,  5 Feb 2025 19:55:45 +0000 (GMT)
Received: from [9.61.30.101] (unknown [9.61.30.101])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 19:55:45 +0000 (GMT)
Message-ID: <c0c82eb4-3849-4127-b6bf-bee329653a24@linux.ibm.com>
Date: Wed, 5 Feb 2025 14:55:45 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/s390: implement iommu passthrough via
 identity domain
To: Niklas Schnelle <schnelle@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250124201717.348736-1-mjrosato@linux.ibm.com>
 <20250124201717.348736-4-mjrosato@linux.ibm.com>
 <53c930df7058288776392073964a70025ca62d19.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <53c930df7058288776392073964a70025ca62d19.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C5Ly6ffk3UkHDhTlnvilvDtqF16XvjFp
X-Proofpoint-ORIG-GUID: C5Ly6ffk3UkHDhTlnvilvDtqF16XvjFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050148

On 1/30/25 2:43 AM, Niklas Schnelle wrote:
> On Fri, 2025-01-24 at 15:17 -0500, Matthew Rosato wrote:
>> Enabled via the kernel command-line 'iommu.passthrough=1' option.
>>
>> Introduce the concept of identity domains to s390-iommu, which relies on
>> the bus_dma_region to offset identity mappings to the start of the DMA
>> aperture advertized by CLP.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  arch/s390/pci/pci.c        |  6 ++-
>>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>>  2 files changed, 76 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 88f72745fa59..758b23331754 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -124,14 +124,16 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
>>  	struct zpci_fib fib = {0};
>>  	u8 cc;
>>  
>> -	WARN_ON_ONCE(iota & 0x3fff);
>>  	fib.pba = base;
>>  	/* Work around off by one in ISM virt device */
>>  	if (zdev->pft == PCI_FUNC_TYPE_ISM && limit > base)
>>  		fib.pal = limit + (1 << 12);
>>  	else
>>  		fib.pal = limit;
>> -	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
>> +	if (iota == 0)
>> +		fib.iota = iota;
> 
> Taking another look, I think there is a small problem with the logic of
> passing iota == 0 to indicate direct mapping. In
> zpci_hot_reset_device() we call zpci_register_ioat() with iota set to
> virt_to_phys(zdev->dma_table) and while zdev->dma_table is NULL for the
> identity domain we can't rely on virt_to_phys(NULL) == NULL.

Thanks for pointing this out.  We discussed this a fair bit off-list, but to summarize here: I'll include an additional patch in the next version that will drive IOAT registration code through s390-iommu, since really this owns the dma_table and knows when it does (not) make sense to register it.  Places in s390 code that need to perform IOAT re-registration (such as zpci_hot_reset_device) will call into this routine and let s390-iommu determine the correct action based upon the type of domain in use.  

I'll set that patch before this one, so then this patch remains unchanged except to replace the zpci_register_ioat call added by this patch in s390_attach_dev_identity with the new routine.

> 
>> +	else
>> +		fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
>>  	fib.gd = zdev->gisa;
>>  	cc = zpci_mod_fc(req, &fib, status);
>>  	if (cc)

