Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAC211480;
	Wed, 12 Feb 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373849; cv=none; b=hiF9ixrzmODgxtu2IDr6UCjqeBEt/kBO2GBCFvEf3rtk8vKGEpjBc3BM5c31dHoEcpeEdMZAxbNsSgfsyFRFHYeWKbglnRPb4gar3tPHRKnaWBXt4YgUHs0n5/H/o5u+idgQHDhhv4eYQsWPqihVngSnFjMFotdKzY0oEGB7w2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373849; c=relaxed/simple;
	bh=RCNasFOBWQdGcjt6I78d1HAUwbrAr0AhbWDhXUsNQLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc56fprr+5A86MuaLjQkEj30h3fhKNAuB7ZXvs54X3lsEDceSOkHMuk1C3ZW/Vh23UFf3OuYnj4HCt2+W6hgBvyzE0IPaSVZbEd2z1qf7jwRyS4YoXlrs489cwZEt1JjPh1bYAsstdrqQxaiSPfBW+/ZYObBGIJbuPX6p3sTXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WBP/b0tG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WBP/b0tG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CB5PM7012786;
	Wed, 12 Feb 2025 15:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8G1joY
	ERfx7D6bF3vPUyhFVX43JehX7/H4QKhp6aWr0=; b=WBP/b0tGOB6yvpgDM4WOPk
	/MWvq4xsI9h8QIy3g5ZrowkhgnhGlBUNIs+/H+ErfF4IrHxfG8s1g6CR+R6TZakM
	Jh2CW3E4IljWsv6Yl2qMtWg3PIkUai7Z36IJX5BzFrx4UTEHFYaNMp9auBX24zrc
	/5g66DlSwf7N820Na16143QK6DgYQS3+WfJyHExhpJvPwScVBwlcXWHyoteBnrNT
	8LHGR/GsAmXIRyFkBHV3XGxI18lBBmvAHP6ywUhLjvtaLzlEyZQkbUotCk98XDbY
	CrFwPYjUUzRwmLxsHrMkDR47WjMab/FislTNbS7DpNk60/6DOfFJiYN3oiLKOT2g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa4ct7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 15:23:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFBSXS028197;
	Wed, 12 Feb 2025 15:23:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyhmb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 15:23:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CFNq3f24445500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:23:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF1F5805E;
	Wed, 12 Feb 2025 15:23:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9562F58045;
	Wed, 12 Feb 2025 15:23:50 +0000 (GMT)
Received: from [9.61.186.234] (unknown [9.61.186.234])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 15:23:50 +0000 (GMT)
Message-ID: <52a8f09c-4a59-4439-9738-58f040fed0a5@linux.ibm.com>
Date: Wed, 12 Feb 2025 10:23:50 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] s390/pci: store DMA offset in bus_dma_region
To: Niklas Schnelle <schnelle@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
References: <20250207205335.473946-1-mjrosato@linux.ibm.com>
 <20250207205335.473946-3-mjrosato@linux.ibm.com>
 <8380fe8052c9b972a8350394cb6655f6a9683d29.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8380fe8052c9b972a8350394cb6655f6a9683d29.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g6NXWJHWIR4QEE_Sby7jnx0AU6CaX6Nn
X-Proofpoint-ORIG-GUID: g6NXWJHWIR4QEE_Sby7jnx0AU6CaX6Nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=611 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120114


>> +static void pci_dma_range_setup(struct pci_dev *pdev)
>> +{
>> +	struct zpci_dev *zdev = to_zpci(pdev);
>> +	struct bus_dma_region *map;
>> +
>> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
>> +	if (!map)
>> +		return;
>> +
>> +	map->cpu_start = 0;
>> +	map->dma_start = PAGE_ALIGN(zdev->start_dma);
>> +	map->size = max(PAGE_ALIGN_DOWN(zdev->end_dma + 1) - map->dma_start, 0);
> 
> Ugh, this is my fault as I suggested it, but this max() doesn't work
> here. The zdev->end_dma is unsigned and so is map->dma_start so if the
> former is smaller underflow will occur and the max() won't save us.
> It's largely a theoretical issue since zdev->end_dma + 1 should always
> be larger than zdev->start_dma, but now the max() looks like we thought
> of that, but then it doesn't work.
> 
> If we handle it maybe just go with:
> 
> aligned_end = PAGE_ALIGN_DOWN(zdev->end_dma + 1);
> if (aligned_end >= map->dma_start)
>      map->size = aligned_end - map->dma_start;
> else
>      map->size = 0;
> 


Given that it's not really something that's supposed to happen, would it make sense then to add a 

WARN_ON_ONCE(map->size == 0);

At the end of this?

