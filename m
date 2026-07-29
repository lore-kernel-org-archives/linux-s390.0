Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434C3AA50A;
	Wed, 29 Jul 2026 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356936; cv=none; b=KUzJlDMX6D9mCp92ihqNsToX5ziTwzgmXE1eMAwpCWUu8hVhoQrg052cKlJAMPXz4SKXcxhmpXm3wPbr8scFbIzIBxt+1q9C9ZV5BNsWItE5dhIBw2db4cyGSGSwoFD4BbrGMwaARfKHd0JDKM/fdbUJWlmwLcXHgTO41cXobL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356936; c=relaxed/simple;
	bh=dGZSMBxJlfqWpyXlFnSv3Xk9F4i1FRpj9Sit6xPIKIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMqAlPIW6FS2fFnVnBsVhXSkZ0YZJ9FEGtemNyjanK5MlPgJ0TlsEG1K542GDFHuY5rOhgCK1kFJT1dDNnlt4mX06Tc6KUYGWS00k9H7dREqNQtxjtuE8KElbtX+ZjFnf5vf68AKg9GQoedDToOe93kZixIBBLHwJZQKfb2tggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=URksRucZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="URksRucZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIlg3A806313;
	Wed, 29 Jul 2026 20:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WGR75Z
	I5i+kOMJCyd6zHSScMo94tYsHQlT6JQjWn4Ko=; b=URksRucZPnqMZJMubm/Ons
	UAn8wwDNUPdedeix8QY/lv8oFCjJ5ZtaLkI4PMD2SBFuzw7/+J+zgsp18RyaBZ0U
	1nu1xmWhQUnTzvIS/oEVB5gb5kWjHsmnG1r5zq4UsnGCRzUhBPCvVZB2RT6tAM3p
	JXpTM2ZzofEaZI1zlexSeJh9SOv5GlAXlafwTrdIfJw1q1arI737IMGvJNq2xH8r
	eo4M43hrO2oc+SOkprnacNsBQIDrgWAFAfIJl/vtsg5bT3YiBsBImH03ibHY9CVZ
	9DnBPNYQeucCwDa8Czwz1FndoHNdWccye/Se9EYwZ8FqBsfeNk8Bxyv/S3x0GohQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7mmdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 20:28:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TKQL32009124;
	Wed, 29 Jul 2026 20:28:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqgjhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 20:28:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TKSl1t32244310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 20:28:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 582975805A;
	Wed, 29 Jul 2026 20:28:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B65D55803F;
	Wed, 29 Jul 2026 20:28:46 +0000 (GMT)
Received: from [9.61.253.71] (unknown [9.61.253.71])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 20:28:46 +0000 (GMT)
Message-ID: <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, alex@shazbot.org, mattev@meta.com,
        schnelle@linux.ibm.com
References: <20260729181116.1373-1-alifm@linux.ibm.com>
 <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOUj0GzmSEQ1dc8vP6e6KdR-Dx1lQvDa
X-Proofpoint-ORIG-GUID: lOUj0GzmSEQ1dc8vP6e6KdR-Dx1lQvDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1NSBTYWx0ZWRfX5gIBPt2RmCpK
 p9hv2LzASoJP7aAljtccigFkYPck5m+ul+EsFUpxX00OxGR8xDQex7YgNkiiuXbMDB2dc3UU1kd
 K0KcKXGb3xk7/IX3VQ33t/SleorWCzd6MJUuRtvsxQNjLB7LMtorGIb6kLmT3kiYDzah4kcFCUq
 RQoIskjljAp2H5SN3tj26jaEnvfdmSWa8OeV/f6OdR+ztFgJbrOQCJ9DakBAvBIBRr4rKoXOrNC
 5Ts1idwce9jMhQQ9UpFhSfT9KMeg7vLelPhrKxt0khlMzzEZ+6Bh87XNlVDsV2ny20/OJwcbUvm
 N19/69j6+N8UDsIpf+rqulUu75meVxDegm4SIjKCMM1Bnv8HsW3070CRZ6SAuLs9xWOmn/kAHmV
 d5i16i8poRd5eOIIMzbDmNHoHjM0KtsJ25wXvevAorDkkqMIGSparpGzGdBvt8weo2bTXbU1O1C
 7Y7utuhIy8fHtfdrMdQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a6281 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=v9EabsQgdZcjpZ5jZmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1NSBTYWx0ZWRfX1reYxllMHmjx
 iMzBYiythzpY5ELjdij5w9wPEN2L9rWgoBRuQBjeYktWX8h7IVRgZjABV63ZOlWs7peeCncirfZ
 RJsiJ70Ismhq7wYOkpDIasJp85JZQVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290155


On 7/29/2026 12:41 PM, Matthew Rosato wrote:
> On 7/29/26 2:11 PM, Farhan Ali wrote:
>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
>> all devices support having their BARs mapped by the CPU. The
>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
>> to warnings:
>>
>> vmalloc_node_range for size 281474976714752 failed: Address range
>> restricted to 0x2110bab00000 - 0x21903ab00000
>>
>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
>> is set by the PCI core at enumeration time and already serves the same
>> purpose in vfio_pci_probe_mmaps().
>>
>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f11a9624b9c..6a184588ff23 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>>   
>>   		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>>   
>> +		if (pdev->non_mappable_bars)
>> +			continue;
>> +
> This would work for the ISM case at least, but I wonder: should we check
> vdev->bar_mmap_supported[bar] instead?
>
> My question boils down to: do we still want messages for some of the
> cases where we set vdev->bar_mmap_supported[bar] = false in
> vfio_pci_probe_mmaps()?

AFAIU vfio_pci_probe_mmaps() is only called in 
vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called 
in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(), 
bar_mmap_supported would be false here for all devices. So I don't think 
it would work here, unless I missed something?

Thanks

Farhan

>
> Or should the messages only print when we probed, thought the bar could
> be mmap'd (vdev->bar_mmap_supported[bar] == true), and now hit a failure?
>
> Thanks,
> Matt
>
>>   		if (!pci_resource_len(pdev, i))
>>   			continue;
>>   
