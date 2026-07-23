Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE534B410;
	Thu, 23 Jul 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836233; cv=none; b=KxEuizhYYtiWfeOeeDHS3OgeuATkoK/hGBlpCVsraiwaZbMEzDfu0R6QlXr75ljwVVkRaCJhW4YFnrod65fytpe4rLoUnqa/yQX4vSuR/i4VypG7jQIDG+bKgmxzwg8V8N6oRqqPm9u6GxzXGw/1l3q2tygLBXucLMk1w8XyqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836233; c=relaxed/simple;
	bh=Y2uot6CJk1WvV252Kyy4J7sqeksu9fOoTj0jdsX4Nso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vzx1Q+Vyv8jmsJmcIcOex1b7FttEIvTuP82bo3DN+Y4uorWBYqhbb6n48j0jh6waqd/k3rcGFo1ZjquZF5kF8IvT131BNIQwar6Al1n+THasRI73HzmN01a1eymAfVhS3uEebfFCd4EL3vpgSGl5EvSoWUcrpYDF5OPOQGOc7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RmF3HoEW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RmF3HoEW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NJBqAD1995855;
	Thu, 23 Jul 2026 19:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dvZv4g
	q6C0nFsME3mn4rWjBqDYgI9lS+w4BHlzVEmr8=; b=RmF3HoEWZjMVhhC1/91Vta
	oEX0255KNco0kGQfr1dV8UEA6surfVapacKph27dIf6KCjETACTSG7V/iEjt6rdt
	+XNgSMWrMbnJxC1WXhth1kRQAHiCMW6w5vKwhvFlhamRsgMxmYITIkObQzqTM8DG
	NzWtLnVpZVLxX9h2R7lc5RThEEEUtEYDch+01QhfEEQKv7jFQ6y6s+G2xV5rED4s
	JdTeYhhCNA7x88Z9bDihryz0Ia7dWjY2zx1ofPGpypnwcvanCOGZ1krw6WJUghZx
	WmyXApVpi7CBGh8NClBUuUztecm0MlxuifM3DVbOykWFJ2k8mGmX5oCeYNzYgpwg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77asc3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 19:50:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NJniwe032665;
	Thu, 23 Jul 2026 19:50:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wdwag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 19:50:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NJoRZj32965230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 19:50:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D91458059;
	Thu, 23 Jul 2026 19:50:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 444EF58055;
	Thu, 23 Jul 2026 19:50:26 +0000 (GMT)
Received: from [9.61.254.118] (unknown [9.61.254.118])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 19:50:26 +0000 (GMT)
Message-ID: <fea9882a-b41f-42a3-b30b-37d6a40af127@linux.ibm.com>
Date: Thu, 23 Jul 2026 12:50:25 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-7-alifm@linux.ibm.com>
 <20260723184802.816BE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260723184802.816BE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T1YNLgV9L7G0gd4l5jtSotfHqmxLo1lL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MiBTYWx0ZWRfX2HIemSeNM/Ru
 e3zthaXKKQFajYFLVkUneqte44CsvvYyzPvNlkfGtKPVGePVsLKfWEvp6ACIuHfAXLu/Zfnpc8m
 JB5MFkDOq8BVQ8CuM/T9a4BcTIyodqI=
X-Proofpoint-GUID: T1YNLgV9L7G0gd4l5jtSotfHqmxLo1lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MiBTYWx0ZWRfX0usog0E77wSM
 VtrWbe+aMYnbcLoMIglWuqHZ8DoPOs8uMr6uxKw6FClmf4ULoq3Gi78KPKnK0bfCzB264NyWWsg
 /S/6J5+/fwAjsM9nx66z5V+HzwAHk+gEXfs47RNR+36OTfGJZ5XIrLGc4pzr1kfUpr2IYfL63PI
 S+MuE6wL4FYkyxy3v5FabSIiaE8Pb01CArKKfBlm4VvcWcpAshhMKgPVVedkwAYeMxqEXtZfq9q
 MRvyjmY3NFXcq1MVsdHDcrDzteMpJfFy9lxtcU8bMm19GiEGF8DlhuEOIv/C2abXcLq4luMWNIg
 dwdYDwHT17LqHmwesCBf+Kx4ncPNy14fgcA4nPuBMmFFEGOLhj6/3Cifj9X7xGKM/7gLqwRm7Rg
 YcM/ZpDYpNRiRoX+pG3h+2AhG50BWsfAeaPZqxGgGOpwWO8Or7e2zlfXcUKgsUhBWnCkQr5Ce7j
 5zm7pTYUndh6aX9LWWg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a627085 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zMSjS1MdtTf2WqKHX4gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230192


On 7/23/2026 11:48 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Critical] The AIBV size calculation underestimates the required memory footprint when the bit vector has a non-zero bit offset, allowing an unaligned AIBV to silently cross a page boundary and cause host memory corruption via hardware DMA.
>
> Pre-existing issues:
> - [High] Guest AIBV and AISB pages are unpinned without being marked dirty, leading to potential silent data loss of hardware DMA writes.
> --
>
> --- Patch [6]: [PATCH v5 6/6] KVM: s390: pci: Validate AIBV and AISB before pinning guest pages ---
> commit ce58b81776049069915a6d5914d02bc982861691
> Author: Farhan Ali <alifm@linux.ibm.com>
>
> KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
>
> The AIBV holds one bit per MSI-X vector for a given function. If the size
> of the AIBV exceeds a single page boundary, or if the AISB address is not
> 8-byte aligned, the request is rejected to prevent unsafe pinning of the
> guest pages.
>
>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>> index ca8ef76bcf6b3..25185d04ca28e 100644
>> --- a/arch/s390/kvm/pci.c
>> +++ b/arch/s390/kvm/pci.c
> [ ... ]
>
>> @@ -271,6 +271,15 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>>   		return gisc;
>>   
>>   	/* Replace AIBV address */
>> +	size = BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
>> +	size += (fib->fmt0.aibvo / 8);
>> +	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
> [Severity: Critical]
> Does this calculation underestimate the true byte footprint of the bit vector
> when aibvo is non-zero?
>
> If a guest provides msi_vecs = 64, aibvo = 63, and an aibv GPA with a page
> offset of 4081, the calculated size is 15 bytes instead of 16. The npages
> calculation yields DIV_ROUND_UP(4081 + 15, 4096) = 1, which incorrectly
> passes the npages > 1 boundary check.
>
> This would result in KVM pinning only one page, but the hardware could access
> the 16th byte, writing to the first byte of the next unpinned host physical
> page, which could lead to host memory corruption.

I think Sashiko does have a valid point here (sigh...). The right fix 
would be to correctly round up both msi_vecs and aibvo bits so:

size = BITS_TO_LONGS(msi_vecs + fib->fmt0.aibvo) * sizeof(unsigned long);

and remove size += (fib->fmt0.aibvo / 8);

Thanks

Farhan

