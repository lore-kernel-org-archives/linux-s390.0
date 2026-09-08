Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B14370D5E;
	Tue,  8 Sep 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861335; cv=none; b=UmdE2NpUXPkcPVDTOscN41iho0nz9tJkhnOgBLkVlWjNbeff4Fuaa/xR2S0AkXuzbpYM1IsXxc8u/DMDxkECRwNpMqkqVvviWYjqnw8miqfXiYESVdheX5r57sH05yWEgjCi2VTsMRvd0cM5Tr0NTvC43b9XB11cbQ6g1JGOKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861335; c=relaxed/simple;
	bh=PpKCHQoXKpSSVOUpixxLPFIyLKOS3EYHDjdmed8wkgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWaXjgm1DjKLoTKPCZPKlw3obltEY+jhvFcQbHWNlVB7I+fx31cL7CFJJ9f46S/2gFvekr5DraFhgsNIWjxePquJLmlPcKPTAHXmTs2+skZdCyPNYHfvtl6l2TFtlfR7bI46+31vRBCVaYd26y1wX7fqtsVKdWM0X5N4ZKfO7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BDErKtEz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BDErKtEz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VdWq3106959;
	Tue, 8 Sep 2026 09:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=baT/JA
	p1qxMUqvmGzbKbvZXunkw9x6D7ifyB1Xiaoj4=; b=BDErKtEzRh0k3jHI0bcBJ1
	aIf3CxvclbKP0MWwm7eMFyxJc9fmk9FvKg8WotGPPXhbabN1KVispXMFEitjZ6aO
	nRuc7yvfCTE7sFEOngNhs6exlo7b0RxN3HgSIQGsG4/MBzvlV49GiQPMoRnwmReM
	0lQOx15Rb6PEkL4cS7JFRzgnyrX1T4Y1iUVng3e4uUt3yxiGksnkdXHFwpJnh0/c
	0Y4FFIbcFvFhWUgNOCLeZI2FwVtFOvEX+jEihSIt6+9ph0567/CXrZKyWu/Z2HmV
	cOtdGKuiyXKauEpWsA4CEBrrqGMCRy1JH9blzgbWUHPuFYvA/mPaya5lM75rZdzg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrnt3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 09:55:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6889fGcX009706;
	Tue, 8 Sep 2026 09:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdju271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 09:55:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6889tR7J52036034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 09:55:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40B220049;
	Tue,  8 Sep 2026 09:55:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BACC20040;
	Tue,  8 Sep 2026 09:55:27 +0000 (GMT)
Received: from [9.111.137.185] (unknown [9.111.137.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 09:55:27 +0000 (GMT)
Message-ID: <490a5c66-c415-42c6-883e-1927d9517322@linux.ibm.com>
Date: Tue, 8 Sep 2026 11:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
 <20260905094515.D65911F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260905094515.D65911F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9fdb94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2redr1V9L8-sxEALg8QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwMCBTYWx0ZWRfX57JHqg8KiJkB
 wsY0ZbumEaKLudN8V2/gWIMkWHG81fINvHqTcmNvT1YXBG1mWzMiqYZoyN5Ps6C19rf4WUzDY4X
 22WVCDeMmBT23aLDaIc9kd4PhjPihOk=
X-Proofpoint-ORIG-GUID: NhOc5yEyrGyUcU_j9nSM_6d52_3XYdA1
X-Proofpoint-GUID: NhOc5yEyrGyUcU_j9nSM_6d52_3XYdA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwMCBTYWx0ZWRfX403J6N2YHWTz
 puhEAwJ3RKAYvcsKTH7BmSnrausFzYDvYkF65N5P14oVsd54Y0PVgF7xUW5kS4KBA6zO6297uYQ
 kjFoYLWCzdptpekeqdJo7gDjLe/4Cx/FJYvweRAopLWB8D6TQSpCvHZGvNkPBRV+ZnlcHYuaeEe
 L0CQZd8j+Yvw0fBs77sZ1vhXTHAxZA3KbJrvISj5cr08kZN4ZsZb6TEUcUud/Xsq5D55FLW8m4X
 5JvCwzn37Idz3osvnFR7iH6/NpXX1+/cHCQLxP6mwAhtQXQFH5+AAq+uCEz4lvNpQokjUmBWlx2
 5p4PmQYDbiiHh7IpJFW6RZRjwOfjSiRRjnJVE/nhqufsN2Qr4jbfFTpCKUrKP5giDOWWAH36fF6
 QR5ctVeeoaZPRwr/Owq3CBWTzF4qLoZccD0MOWA3eFD8Al38CmmsGAI+2b0RQLdTPYRFiqyQYsb
 pEFsX9OAMo+Nxw7418A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080100



On 05.09.26 11:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe error path calling kfree() on memory allocated via folio_alloc().
> --
> 
> commit 71f881ca9b5f87a2235598ada197106f8482dccb
> Author: Alexandra Winter <wintera@linux.ibm.com>
> 
>     dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
>     
>     dibs->lock is acquired in process context and interrupt context
>     (ism_handle_irq()). So always use spin_lock_irqsave() in process context.
>     
>     Note that this is not a real deadlock, as dibs_lo devices don't have
>     any interrupt context.
> 
> [ ... ]
> 
>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>> index 649e4e375be33..44a2e74c2efcb 100644
>> --- a/drivers/dibs/dibs_loopback.c
>> +++ b/drivers/dibs/dibs_loopback.c
> 
> [ ... ]
> 
> While reviewing this commit, I noticed a pre-existing issue in the related
> ism_alloc_dmb() function:
> 
> drivers/s390/net/ism_drv.c:ism_alloc_dmb() {
> [ ... ]
> 	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
> 			    __GFP_NORETRY, get_order(dmb->dmb_len));
> 
> 	if (!folio) {
> 		rc = -ENOMEM;
> 		goto out_bit;
> 	}
> 
> 	dmb->cpu_addr = folio_address(folio);
> 	dmb->dma_addr = dma_map_page(&ism->pdev->dev,
> 				     virt_to_page(dmb->cpu_addr), 0,
> 				     dmb->dmb_len, DMA_FROM_DEVICE);
> 	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
> 		rc = -ENOMEM;
> 		goto out_free;
> 	}
> 
> 	return 0;
> 
> out_free:
> 	kfree(dmb->cpu_addr);
> [ ... ]
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does calling kfree() on memory directly
> allocated by folio_alloc() cause a kernel panic due to invalid slab metadata?
> 
> When dma_map_page() fails, the execution jumps to the out_free label, which
> incorrectly calls kfree(dmb->cpu_addr) instead of using folio_put() as seen
> in ism_free_dmb().
> 
> If a user exhausts DMA mapping space (e.g., filling up the IOMMU or exhausting
> bounce buffers), could this error path be triggered resulting in a denial of
> service?
> 

Fix for this is is already in netdev:
 https://git.kernel.org/netdev/net/c/907a56ab3eb8




