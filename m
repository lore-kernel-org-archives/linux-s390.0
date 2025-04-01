Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAD203705;
	Tue,  1 Apr 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516518; cv=none; b=dRv8J+ppT3zdRatWLQqjel/BDVK1SRjOVR9JDRUX6U5v0iwkkZzFtDDopvtwOUXsgbnlxuVFogR83TEWfC67iL7sIKY+4zAygT8KXew6AIkaQOiwf7z7rg65RSq+YlbHTwZGv2gZblN7ZVubavJG8SQ8KirjFMwjvj/U7c6Oz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516518; c=relaxed/simple;
	bh=yf4KBftqQerIboSU0GfiOAbRx4eHXYrBGOKXO9nthgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8/NoAlDVLyAOb8Tuq/wlxoGR9MCGNMyZ+69znLVYF+6nBhj08OiogpVztg0qKMHns94Iwmcl7YWi9LqKLRNBXiTmXEzZAVQWhO10YXSLz5B1KAhoJBB64zzEWmOY6x3rJgpKZWXzmH7T2SOUSoJxsWzjjsvZIlW3/8ZkfMUDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ITF7mbJE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ITF7mbJE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531CSTj3027584;
	Tue, 1 Apr 2025 14:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oGt+tA
	tfr79sFy0I5kEWXLud0pHCnJJIOKb8lUEjpbc=; b=ITF7mbJES6NF98Se0R4KCt
	DqbebGgnsjkPiBTnyTR1Z0qvJdI2/dkv2jhtwc9IcnH2p3Inv8d9NoKeDd+IQfEe
	eQPr/ifdQCdzWrwK7UXdoJRyjTjcWnGH1ra9SSZ8/lR98UNd51jwpV8uHkuvrPbo
	Ie4OpLZrNXsqoEOYcD3fl8lMdaBOf1n+4DYSk9KXE6sMiDdaSQCEPC1ah2zdbagS
	43U8H1NjXvSPFFmInoNczltK8YYd+UgckaVanIbrvBkdf+OcZa3X823A4ytwUows
	A8l+qomjs6DbjhqasUz5a9bg82oOJwJhmbu04Tt8yrPoOGjvMXYQzM4V7hocKYTQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rg67ghke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 14:08:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531BPTtm019742;
	Tue, 1 Apr 2025 14:08:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t32ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 14:08:25 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531E8NOo28181184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 14:08:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC5135805C;
	Tue,  1 Apr 2025 14:08:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8541F5805A;
	Tue,  1 Apr 2025 14:08:21 +0000 (GMT)
Received: from [9.61.39.63] (unknown [9.61.39.63])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 14:08:21 +0000 (GMT)
Message-ID: <12f7109f-5375-4301-ac69-077761a0106f@linux.ibm.com>
Date: Tue, 1 Apr 2025 10:08:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iommu/s390: allow larger region tables
To: Heiko Carstens <hca@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, clg@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250331202159.85956-1-mjrosato@linux.ibm.com>
 <20250331202159.85956-6-mjrosato@linux.ibm.com>
 <20250401091115.7691Bd6-hca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250401091115.7691Bd6-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KOR8mZZQCGdo7POxOoXPcIwEYjRsXCa
X-Proofpoint-GUID: 1KOR8mZZQCGdo7POxOoXPcIwEYjRsXCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=823
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010086

On 4/1/25 5:11 AM, Heiko Carstens wrote:
> On Mon, Mar 31, 2025 at 04:21:59PM -0400, Matthew Rosato wrote:
>> Extend the aperture calculation to consider sizes beyond the maximum
>> size of a region third table.  Attempt to always use the smallest
>> table size possible to avoid unnecessary extra steps during translation.
>> Update reserved region calculations to use the appropriate table size.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/pci_dma.h |  1 +
>>  drivers/iommu/s390-iommu.c      | 71 ++++++++++++++++++++++++---------
>>  2 files changed, 53 insertions(+), 19 deletions(-)
> 
> ...
> 
>> +	spin_lock_irqsave(&zdev->dom_lock, flags);
>> +	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
>> +	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +		goto out;
>> +
>> +	s390_domain = to_s390_domain(zdev->s390_domain);
>> +	if (zdev->end_dma < max_tbl_size(s390_domain)) {
>> +		end_resv = max_tbl_size(s390_domain) - zdev->end_dma;
>> +		region = iommu_alloc_resv_region(zdev->end_dma + 1, end_resv,
>> +						 0, IOMMU_RESV_RESERVED,
>> +						 GFP_KERNEL);
> 
> GFP_KERNEL allocation while holding a spinlock is not correct.

Looks like I broke this in v3 -- Thanks for catching it.  There's no need to hold this spinlock for as long as we do here, including over the allocation itself; I will re-arrange so we can safely use GFP_KERNEL here.  

