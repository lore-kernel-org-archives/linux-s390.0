Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B61DF72D;
	Mon, 10 Mar 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639261; cv=none; b=lyX4QspjP1/zwrCp9moTVvE+snxbgyAhrq6bVgejAdYVVsAGVuP/jG4g3vYgOYfCwYHxmJCg3t9u6Bd8B+brNs8DEupO+l6oGIidqFza+rsoDEpk1ibfR9wmUPNkOXZpDCJZ1Dvauhp/XLj/tHtV83tnMxEg4Oq3zKtEHn5TRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639261; c=relaxed/simple;
	bh=p7FT2wD3WZKNMVQnP49Wzu1EdaqUzeZXhk1DDsgTN+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9ORLF+rvyU/gp0B94HWYAqW3kSCsPnaetl8ooUgMAZo357LKg3xHPvule/nJdYLG0o1ncC5MA3lgtlndYL+FLbxSauMNoyaWrmunA0c+Z4DPt6JgMI2U88NvdRgJRG4Pv9LoNgMQyAmlYk7ROsJ6pRqromRESVPjNMjP1hjO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KLSBTZ4K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KLSBTZ4K"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFZbd012622;
	Mon, 10 Mar 2025 20:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W9YuYK
	qO6w28khy+jb3BDttjVL1yDkzw2RZ/N4axoRo=; b=KLSBTZ4Kd0n2+aXrsgXbOJ
	xPicY7lYsjGAsY6LMaVj09lNRZUOGpGI0sTby/ypWJYxvcoIuonqgZZlFYVj/i45
	rpflT//Z0+G61ZRIUgqtxuIIn0xG+i6teLC3DWxTMiRb3W4O3Es62k0AzjHeORxY
	xJa2Htatu2N/uw+8DgfXEyZK1GT2XM1FAoiiAee79ISuRsfmO2etz97y0QP80oRh
	woqJq70wcn2B3bfYYImFaJrcqLebHOgqQ7SUkl+dwHjptqExj4L9m6IHjm5ViuAA
	YAGL+gBjOkVe+sl3pn0zyaZfK+yoKF8vKDTRSlSyMJ2wnS7Mbn6sC4jJ5XKwIDKA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf94y47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 20:40:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIj3Dc014921;
	Mon, 10 Mar 2025 20:40:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek8anm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 20:40:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AKeogr30671556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:40:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABE8E58052;
	Mon, 10 Mar 2025 20:40:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF8D558056;
	Mon, 10 Mar 2025 20:40:49 +0000 (GMT)
Received: from [9.61.55.227] (unknown [9.61.55.227])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 20:40:49 +0000 (GMT)
Message-ID: <4a32f00e-a79b-457d-8789-597b9a0e6c9b@linux.ibm.com>
Date: Mon, 10 Mar 2025 16:40:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pci: Fix dev.dma_range_map missing sentinel element
To: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H3MptcF8lDlYcW0Cz2Rw9oJlNh-9qJ5V
X-Proofpoint-GUID: H3MptcF8lDlYcW0Cz2Rw9oJlNh-9qJ5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100158

On 3/6/25 10:25 AM, Niklas Schnelle wrote:
> The fixed commit sets up dev.dma_range_map but missed that this is
> supposed to be an array of struct bus_dma_region with a sentinel element
> with the size field set to 0 at the end. This would lead to overruns in
> e.g. dma_range_map_min(). It could also result in wrong translations
> instead of DMA_MAPPIN_ERROR in translate_phys_to_dma() if the paddr were

Typo, DMA_MAPPING_ERROR

> to not fit in the aperture. Fix this by using the dma_direct_set_offset()
> helper which creates a sentinel for us.
> 
> Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for looking into this while I was out.  I confirmed that I can reproduce the potential issue by forcing codepaths - and that your proposed fix also resolves it (by forcing a DMA mapping error instead of using random values for a bus_dma_region).

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


> ---
> This is based on iommu/next which contains the fixed commit
> ---
>  arch/s390/pci/pci_bus.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 0e725039861f92925a38f7ff7cb6de6b0d965ac3..14310c3b48860a16de13536adf95ef99e6af21cc 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -287,23 +287,21 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
>  static void pci_dma_range_setup(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(pdev);
> -	struct bus_dma_region *map;
> -	u64 aligned_end;
> +	u64 aligned_end, size;
> +	dma_addr_t dma_start;
> +	int ret;
>  
> -	map = kzalloc(sizeof(*map), GFP_KERNEL);
> -	if (!map)
> -		return;
> -
> -	map->cpu_start = 0;
> -	map->dma_start = PAGE_ALIGN(zdev->start_dma);
> +	dma_start = PAGE_ALIGN(zdev->start_dma);
>  	aligned_end = PAGE_ALIGN_DOWN(zdev->end_dma + 1);
> -	if (aligned_end >= map->dma_start)
> -		map->size = aligned_end - map->dma_start;
> +	if (aligned_end >= dma_start)
> +		size = aligned_end - dma_start;
>  	else
> -		map->size = 0;
> -	WARN_ON_ONCE(map->size == 0);
> +		size = 0;
> +	WARN_ON_ONCE(size == 0);
>  
> -	pdev->dev.dma_range_map = map;
> +	ret = dma_direct_set_offset(&pdev->dev, 0, dma_start, size);
> +	if (ret)
> +		pr_err("Failed to allocate DMA range map for %s\n", pci_name(pdev));
>  }
>  
>  void pcibios_bus_add_device(struct pci_dev *pdev)
> 
> ---
> base-commit: e840414e5a73ac02ffba6299b46f535a0b7cba98
> change-id: 20250306-fix_dma_map_alloc-b3b05903dcfb
> 
> Best regards,

