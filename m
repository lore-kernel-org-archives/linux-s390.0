Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E040360EDC;
	Thu,  6 Aug 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033945; cv=none; b=A/KPCwnXZvx83MtRcbv9f0CEHM4ae1qpXoQU0PuYe9jZ1YJ6Bgz/A0GAWKs3wxnAIno6oB1a4aW27ujREYTXEnRVs6sALuWM9E7vqpIGJ6C4ViaWI55M9ZH7Zzl1e1GZ0nY9br9BeTjrlr3lnMAEcidL3HuBKJ78xIjOs8TcCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033945; c=relaxed/simple;
	bh=oo10YSZIbprm1f8L26ZBH2+/pgRT7GT8GoGLewyerP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WavY8jkAbZBwAnIUlusrSglnWcnZtWVZX/VqAWd3yPFbhb61JgZQ4WipAzV1znQ0sYPH8Dc7DfMtlHiZnnFUCnros/gRV0rd8o9F48kjpBdk1GWnWkzok2GzUnrUrVrozj3DxXz/OK6PMlHaHbfq/Zfb1vyAryvI93HHDvpuVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LqPtKJMW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LqPtKJMW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676En6q91079189;
	Thu, 6 Aug 2026 16:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i0jWAC
	ZMswT+94xJuSlaloHzd/qCpWpnH1sLn5Bk6NY=; b=LqPtKJMWLWVz3xXDRLFFIK
	1840kWIJeYusuzkUY0AqfngjiGamd+HkYFue+3ftjeA3BQUMlHJ4BKR6S4zAvUgS
	N7tE96BukmHPWz6yAiMsl+DZFvZ5oawakGXQejmzOR/OX5FkOxZB7WZmgSmQhOj/
	mvVWCb7bYlMeWYgrMsJ54LpPSZimGov1XirxEEyoEkVhEMGzQkkcna5PFZNVJeDe
	3lFxTef6t3le4gTYCQicu6EhhIgwommpXZO4ieWMc/c2NxUgjCioJKtxTG41fACP
	dFM+piy4N4Whagt9QtWLV2AqGbrPLOxM/7KlGN7/1G24Y99lTLOXzvYGoc5oDa9w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr17tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:32:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GQHup014396;
	Thu, 6 Aug 2026 16:32:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkw6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:32:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676GWIwq32178564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:32:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A3720040;
	Thu,  6 Aug 2026 16:32:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC9420043;
	Thu,  6 Aug 2026 16:32:18 +0000 (GMT)
Received: from [9.224.91.49] (unknown [9.224.91.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 16:32:18 +0000 (GMT)
Message-ID: <466273ca-fdfc-4bde-b5c0-371ccef6718a@linux.ibm.com>
Date: Thu, 6 Aug 2026 18:32:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/ism: Fix UAF of sba and ieq during
 ism_dev_exit()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260805131043.954639-1-wintera@linux.ibm.com>
 <20260806131106.077EC1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260806131106.077EC1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GJeMeBNUXXx7LtZPPkZKHseXuw4Av0EH
X-Proofpoint-ORIG-GUID: GJeMeBNUXXx7LtZPPkZKHseXuw4Av0EH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX9FDRV4seJuXI
 OibgKNtcQ+XRWGQRz3MC56y1OzG6JHpbFsQ/E8miWlWNXwgLO4KfZmHZ9OWcGBpiFikpgLSfBrd
 +SKcMrY+oA1gsdVpA4RFMdR9MffUU3g=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a74b717 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qp7DbmYNCsbC3tJPkv8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX+GuTCmqrxJe6
 kB2OSoBNYGGBJjVJrYJnNu9uIn4MeLOm9GbKiI3m4TtNvDaoHpFj0QOdbK6bwnIFU0C5lCWfpZt
 KFrXSdbH96U8+ODGpBOesYNTBqRklvPTXgenaRMQiaPOocwzAsnDCIrtYUBe71enlmM5klt4aVQ
 rlL7w5KVLVsO0uUs/Xox1JYCH1WqDM5BUwLoQ2ZLoHMOJzKkHyNlgPvNkcpL518v+Umv1x5kjqE
 IgcdLn/PLozJjVI/96JNgU7EHqiu4Ngwq43iX1x1jpUKvVs61RwtkMTiGd7BTEAk8hIQxk8uzJ9
 Z6zdPN1vhmCLBydQKSPi5f4bZb78Y49q23gZ8g6ukWUP6Pis60d5fv+UYMYTwNUKJhw2XErLgyO
 cNPBTeugZMRGh+X4l9bWGc+VQNT3ke7+GDipSoEJdiV5aNT0zw5KKdrQccMbaU834oWZc2RH+4P
 a/U6b8llJqfU6UzM8bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060127



On 06.08.26 15:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Critical] The patch unconditionally frees DMA memory even if the firmware command to unregister the structures fails, potentially causing the hardware to perform DMA into freed pages.
> 
> Pre-existing issues:
> - [High] Incomplete fix: The `ism_dev_init()` error path frees the SBA data structure before unregistering the interrupt handler, preserving the Use-After-Free/NULL pointer dereference race condition.
> - [High] The interrupt handler is registered before the DMA structures it depends on are fully initialized, leading to a possible NULL pointer dereference on early/spurious interrupts.
> --
> 
> --- Patch [1]: [PATCH net] s390/ism: Fix UAF of sba and ieq during ism_dev_exit() ---
> commit b7d428b60205e305c1f2fbb4f8ba1ff2da436f6f
> Author: Alexandra Winter <wintera@linux.ibm.com>
> 
> s390/ism: Fix UAF of sba and ieq during ism_dev_exit()
> 
> This commit fixes a use-after-free race condition in the device teardown
> path by draining ongoing interrupt handlers before freeing the internal
> shared memory data structures.
> 
>> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>> --- a/drivers/s390/net/ism_drv.c
>> +++ b/drivers/s390/net/ism_drv.c
>> @@ -148,13 +148,16 @@ static int unregister_sba(struct ism_dev *ism)
>>  	if (ret && ret != ISM_ERROR)
>>  		return -EIO;
>>  
>> +	return 0;
>> +}
>> +
>> +static void ism_free_sba(struct ism_dev *ism)
>> +{
>>  	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
>>  			  ism->sba, ism->sba_dma_addr);
>>  
>>  	ism->sba = NULL;
>>  	ism->sba_dma_addr = 0;
>> -
>> -	return 0;
>>  }
> 
> [ ... ]
> 
>> @@ -585,9 +592,13 @@ static void ism_dev_exit(struct ism_dev *ism)
>>  {
>>  	struct pci_dev *pdev = ism->pdev;
>>  
>> +	/* ism will only generate new IRQs while ieq & sba are registered */
>>  	unregister_ieq(ism);
>>  	unregister_sba(ism);
> 
> [Severity: Critical]
> If unregister_ieq() or unregister_sba() fails (returning -EIO) due to a
> hardware or firmware error, the device may still be active and performing
> DMA to the SBA or IEQ memory regions.
> 
> By separating the free operations and calling them unconditionally here,
> could we be returning active DMA pages to the kernel allocator, leading to
> memory corruption?
> 


Cases where a bad return code from HW/FW can happen:
- Device is configured off or unplugged -> ISM_ERROR -> ok to free
- Still DMBs registered -> does not happen with today's kernel code, afaict
  I plan to make this more robust for future dibs clients.
- Broken FW

=> We cannot create a scenario today where -EIO will be returned.



>> +	/* drain ongoing irpt handlers */
>>  	free_irq(pci_irq_vector(pdev, 0), ism);
>> +	ism_free_ieq(ism);
>> +	ism_free_sba(ism);
>>  	pci_free_irq_vectors(pdev);
>>  }
> 
> [ ... ]
> 
>> @@ -573,6 +579,7 @@ static int ism_dev_init(struct ism_dev *ism)
>>  
>>  unreg_sba:
>>  	unregister_sba(ism);
>> +	ism_free_sba(ism);
>>  free_irq:
>>  	free_irq(pci_irq_vector(pdev, 0), ism);
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed the error path here frees the
> SBA data structure before calling free_irq().
> 
> If register_ieq() fails during initialization, could a concurrent interrupt
> fire after ism_free_sba() but before free_irq(), causing ism_handle_irq()
> to dereference a NULL ism->sba pointer?


No interrupts are generated before SBA AND IEQ are successfully registered.
So this scenario is not possible for this error path.


> 
> Additionally, this is another pre-existing issue, but looking earlier in
> ism_dev_init():
> 
> ism_dev_init() {
>     ...
>     ret = request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
>                       pci_name(pdev), ism);
>     if (ret)
>         goto free_vectors;
> 
>     ret = register_sba(ism);
>     ...
> }
> 
> [Severity: High]
> Since request_irq() enables the interrupt handler before register_sba()
> allocates and assigns the data structures, what happens if an early or
> spurious MSI interrupt fires during this window?
> 
> Will ism_handle_irq() unconditionally dereference the uninitialized
> ism->sba pointer upon entry?
> 

No interrupts are generated before SBA AND IEQ are successfully registered.

I will add comments in a cleanup patch.




