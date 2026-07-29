Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84285309F08;
	Wed, 29 Jul 2026 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354122; cv=none; b=Nl4Dwr27nevKuws7bHsJ0xBjHyJrbunqgQtgoWwT5HiFZU+pQzYXVH2FLegWGPRnVZppYK2J07ge6tCXuhPydhwcifU7JuftzHNmP7IeWXoQaB1HLO+35Vi9jqvRdN1wj32l8rQrXOJrH1UyKWkoXjmCCBdsIVeFtZili3kN87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354122; c=relaxed/simple;
	bh=QsC1ptgpaZpG9JDWc8YYDC4Mf5RW1oaCP4IVCv5Itq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pds9PuX9X7c3yvoE1zYOoxnc8O2pvtCnJJRLA6kFodnWNnIclDFEKaEkqOIIjawILEZ1Kr/rg9WL7M6O9A3IW0qyAQOaOUrve65z7PK4yvgeId3QzEKwklf0MYuNrjzNDdZn0WgbQVttDTRJYE0I6/B8VeMdtxBykm1lvrAjdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VUzqyUTn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VUzqyUTn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIloLd3134617;
	Wed, 29 Jul 2026 19:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JPmkeK
	jSOKEHT8nbXYdZ6sckZ31Nep0hkDQoBRfCDL8=; b=VUzqyUTn9AaPvg+AXJkyrb
	Jxv2aVWz+xLSXU1jDPods4lhkpiGyNqpt4uQjjVFEH0DU5HRLrSveo+aDqSVPOKK
	ZpkuStliZuNiTvT61OlDdKCiWg0N9pCb+D8qXoa7igq/ajVa1J5NzEEnwFdbVRyh
	WlOkyugFazvmN0ZiZOPoEqa9r3T5xQIsvIUO1cd6yPeKOIAOvuN5iCEJX/ROiLFw
	/5ogYHvDlwbDvz/WSn9+TiN0/5NmQPn2UzCbUFWKRjKJ7q0nMEIsw16x/mWMClsy
	zu/Popb6lgpjOI4or6i5qL+ST2/kLyvDVzX3Ds7s4CpDrXynjS0afhatvQGTp9vg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycmcm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 19:41:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TJfM7Y013820;
	Wed, 29 Jul 2026 19:41:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhg416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 19:41:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TJfsY325690694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 19:41:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 620B058052;
	Wed, 29 Jul 2026 19:41:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C05325805D;
	Wed, 29 Jul 2026 19:41:53 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 19:41:53 +0000 (GMT)
Message-ID: <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
Date: Wed, 29 Jul 2026 15:41:53 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, alex@shazbot.org, mattev@meta.com,
        schnelle@linux.ibm.com
References: <20260729181116.1373-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260729181116.1373-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ZzjL39YJbDflQlcuWOjsp-JnyiRkA7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0OCBTYWx0ZWRfXyQzQ+gUbVO39
 WCHJw5yiWI4+rBdCkYOSGeuYVOEgyf8x+PHd8/WmmP+PmHpQhKAF6B//XY3zl6qGxiwxro6PG4X
 SDSJaWtRTvdZN004uvpMsmimdEJYDJqPnF6wfvKSVhrFuoqdGfWh+cBh7wAc2ebowVjGoKICzsx
 6VdauovVS74e5/7PG+SN3enTsdjBfAJ3Avo/o8kqWgatIgik7pHzpILtHjY00aAlujI1PBxE/2a
 /O9245Kr3qVyOTvKQUPx4SDaYpuiN7qv+psnBI2SqU+jlsYh4RGkD7vhLhZaDnLZn2016o14jKS
 Qt67TZszFo9yc9TasvERF+RcxM4cK/Yuzc6QO/P9GN/aNeutGzpLN9hAgDAP8uuQJlYnNROZFv7
 612y3I2OEBLHA3pD2E5soucSVzyU5vg7JwXZeOJsvmy0EEHOBj2jKT0uJ0R3Hozim7irH41eOan
 zoRIbSFU3Ju/FclnmLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0OCBTYWx0ZWRfX9DnO4G9/6SEQ
 qSpgQF3GQOG0329ZfTlUGjv0lBt/2dgIpaM7OCFEtKjVM17W6cDx7SJzo8tib+J0SpoKC4Ogvkd
 KcfW5J1J8t1rPHsvT4Z6LY6En5vfZRs=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a5785 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_ECcvfVe4KUISC0xvV0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9ZzjL39YJbDflQlcuWOjsp-JnyiRkA7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290148

On 7/29/26 2:11 PM, Farhan Ali wrote:
> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
> all devices support having their BARs mapped by the CPU. The
> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> to warnings:
> 
> vmalloc_node_range for size 281474976714752 failed: Address range
> restricted to 0x2110bab00000 - 0x21903ab00000
> 
> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
> is set by the PCI core at enumeration time and already serves the same
> purpose in vfio_pci_probe_mmaps().
> 
> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f11a9624b9c..6a184588ff23 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>  
>  		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>  
> +		if (pdev->non_mappable_bars)
> +			continue;
> +

This would work for the ISM case at least, but I wonder: should we check
vdev->bar_mmap_supported[bar] instead?

My question boils down to: do we still want messages for some of the
cases where we set vdev->bar_mmap_supported[bar] = false in
vfio_pci_probe_mmaps()?

Or should the messages only print when we probed, thought the bar could
be mmap'd (vdev->bar_mmap_supported[bar] == true), and now hit a failure?

Thanks,
Matt

>  		if (!pci_resource_len(pdev, i))
>  			continue;
>  

