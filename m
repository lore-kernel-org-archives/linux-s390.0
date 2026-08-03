Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D926384CE8;
	Mon,  3 Aug 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775168; cv=none; b=BddFrH/SlEiJ5/AmtsFh4IhdPpbedOWbh01x9/e5oSh76LJcFHaaid8evJqrKSSCA7sGbDZsltByQsulLDxzR2Y+MCvkAlNecGSmm/+5OUa6+W7Z+PnnBYHwJhYGS3/0IQmXKHLKnjyia5xje75X+5xMh4ED2otKZHpxcZwEmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775168; c=relaxed/simple;
	bh=RAbCEjg+DiJkIV2QudEY1shfV7HQCukJVuQ//eO2OAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC+FvSXHCgHTJMJXqq1jXtT2aNdApjqh1s680sokXEbcJH7rHKmn5XQhVe9NM0bCrav6kK6XZeMtOeqLMQ+zdsTtdZ51/c18NY9m6oqZUYq29GjaHpO9yk3kWwBOtLyVSRjyhUxX7pQ+rt7F1VBF8G/Wr6+g7LOjNV7XzZr77xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GXXtbApU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GXXtbApU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIMB92203559;
	Mon, 3 Aug 2026 16:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3pZI0V
	Lx4Q9pGVwfQ8dJX1d9nTq6d7Ui0R7lWd4UrXo=; b=GXXtbApUsmt3ch79irKbmM
	LGbeOlwc+RtQmoDX0dEQcBt8Ra62UI5hu5chqeqJ9TZQrx5fhDJO5nF+bvj/UwYV
	aOkF87w2raMisDSSt9uLYtWUXWhZD/a09BPWMMtGoYXx2LWF7UwUOiPZBtlyJocw
	V4rb73j1vUxpVPyYMTGnI+5ftAqTnIxe5SqnwXjQBUCFsC5jRKO/NUiqjlh0rdns
	l950+Y+gUF23562ag+o/8QUy2P6BbZiPCdcXL/oo/IPY4K68X2ra8UJxsCbClD7Z
	iiYc4m4otbNG2z9GiMEXWHHvJBvZHui3fbWj0FHrxw+VH30un0Q9I2JMjr6z1z7Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhsy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:39:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GQHK5006505;
	Mon, 3 Aug 2026 16:39:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvxck8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:39:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GdKPo31261432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:39:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A33B58056;
	Mon,  3 Aug 2026 16:39:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B1C58052;
	Mon,  3 Aug 2026 16:39:19 +0000 (GMT)
Received: from [9.61.246.17] (unknown [9.61.246.17])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:39:19 +0000 (GMT)
Message-ID: <c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Alex Williamson <alex@shazbot.org>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@linux.ibm.com, mattev@meta.com, schnelle@linux.ibm.com
References: <20260729181116.1373-1-alifm@linux.ibm.com>
 <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
 <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
 <20260729143603.175f60a7@shazbot.org>
 <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
 <20260729155021.64f7e1ba@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260729155021.64f7e1ba@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0NiBTYWx0ZWRfXwCZdwPCXq/0y
 G+50Vj4Yt/+Ai7J3YOXClKs62GffSr5946q+SLxxplg8S0cdpU4brfLKwsDtGs26cC56dn38SCO
 M2v0uaJ/aftM4miUd4aUWkGq+ZyxnME=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70c43a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=XnJmXvh4KQp14z-JlSQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0NiBTYWx0ZWRfX1z3j7YZqowSr
 xiOBH9XrxT9wJDyLxZYX6pHIlrnUy9h09jU1iT+2giPwYfa0KynIYoGrd2KoeKq573M+n4XcwOi
 +izpFH17Hwiae3qzU5F9cenrb0wbFWgEY4tNSIcz274VgBarqIhT0c1eIBzFw/Q5HqCuaiwPC9f
 HVDz+lAc7bR8dM7FsETJfNpapLvCwYb9lJmBb+bJtYRmwweWJn254BuNBW5W4n29jjgMD6jmO47
 TyVNXDWF5MUqqGOcLuNgbpVOQYMXS4h9QS6/Nmk9KnQX5TsZTzTkoRf7lLZ2NLM4EXgJj/6TcrH
 dp5xDvJPHUJuz9A7LJtNFF7l+C5sBY7E8egjQCRSdb9wduVNG+EQfofHIdetNnpHewD5lh1yvvV
 VtZfJ6mJ1mDJFCGQ7eo0u+L9q1fvZ8RgyjSNOrQYHgzikw8GupqFre+zgRtlmh1f3dEO8nY5sOM
 SM1wcIDNAyuAiRo3yGw==
X-Proofpoint-ORIG-GUID: ewPa9Umx2uUOxLKALDOoBpH4ydTpwb8o
X-Proofpoint-GUID: ewPa9Umx2uUOxLKALDOoBpH4ydTpwb8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030146


On 7/29/2026 2:50 PM, Alex Williamson wrote:
> On Wed, 29 Jul 2026 14:32:45 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 7/29/2026 1:36 PM, Alex Williamson wrote:
>>> On Wed, 29 Jul 2026 13:28:46 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>   
>>>> On 7/29/2026 12:41 PM, Matthew Rosato wrote:
>>>>> On 7/29/26 2:11 PM, Farhan Ali wrote:
>>>>>> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
>>>>>> all devices support having their BARs mapped by the CPU. The
>>>>>> non_mappable_bars flag indicates that a PCI device's BARs cannot be
>>>>>> accessed by the CPU. The ISM device on s390 is one such device. The BAR
>>>>>> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
>>>>>> to warnings:
>>>>>>
>>>>>> vmalloc_node_range for size 281474976714752 failed: Address range
>>>>>> restricted to 0x2110bab00000 - 0x21903ab00000
>>>>>>
>>>>>> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
>>>>>> is set by the PCI core at enumeration time and already serves the same
>>>>>> purpose in vfio_pci_probe_mmaps().
>>>>>>
>>>>>> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
>>>>>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>>> ---
>>>>>>     drivers/vfio/pci/vfio_pci_core.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>>>>> index 3f11a9624b9c..6a184588ff23 100644
>>>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>>>>> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>>>>>>     
>>>>>>     		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>>>>>>     
>>>>>> +		if (pdev->non_mappable_bars)
>>>>>> +			continue;
>>>>>> +
>>>>> This would work for the ISM case at least, but I wonder: should we check
>>>>> vdev->bar_mmap_supported[bar] instead?
>>>>>
>>>>> My question boils down to: do we still want messages for some of the
>>>>> cases where we set vdev->bar_mmap_supported[bar] = false in
>>>>> vfio_pci_probe_mmaps()?
>>>> AFAIU vfio_pci_probe_mmaps() is only called in
>>>> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called
>>>> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(),
>>>> bar_mmap_supported would be false here for all devices. So I don't think
>>>> it would work here, unless I missed something?
>>> Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,
>> Just to clarify, are you suggesting we expand this check to also avoid
>> mapping IO port and sub-page MMIO BARs?
> Sorry, no, I'm not.  I think we're conflating that the barmap is
> related to mmap access.  The barmap itself is holding the iomap of the
> BAR, used for read/write.  The only real relation to the mmap is that
> we request the resource via this path as well.
>
> Therefore not only is the ordering of setting up bar_mmap_supported
> wrong, it's flagging entirely the wrong thing here and keying on it
> would entirely break IO port and sub-page MMIO BAR access.  Thanks,
>
> Alex

Hi Alex,

I wanted some guidance on how we should proceed with this patch? The 
warning messages are a regression on s390 for ISM devices, so we would 
like to fix it.

Thanks

Farhan


