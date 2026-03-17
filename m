Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB63AB273;
	Tue, 17 Mar 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773050; cv=none; b=HwwspDQaCvctgSusR8rr6oVYZTgASFcopaWLSh9X7HcOx1AZDjDbW58+ueAUfA1lmCsRT3W9JbHRMxhBJL88NtPE98015s02ZNXZyT6sdMc4iYij6DWdlh2BI8wlDn94XFG91goo1R3GpyCfy3WmTk3GIdY8hz6kgynhs5v5qcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773050; c=relaxed/simple;
	bh=yDYSTByf7Z1g7UFORat5zgI3Mb31ixncksNPyoVYJzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAKSRAStXr/gOKZtis/Qap03cStXMPRRqIA2J7G+pPQmauijdPBoFkezNlMuMLATtKjW/x3WxVO9N4u1/IZlGvTbBZIg+XLhBgkhnXFIbQBWdluwKFJ+ujCc1Se1hyCW/xkND4SFVp/DyycXToCSmm3NddKjXgYajgtGDaubC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tXtemIJ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tXtemIJ1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8GYUJ967663;
	Tue, 17 Mar 2026 18:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xkyBIE
	bZBT5QNshO/7aW8Q8QYRH5BFpUDVMWdTScJsE=; b=tXtemIJ1ssN9Ayp0JRZaYR
	WKf+om84xZ+9+IaW9bfDo0XGRDIVaYJKTp1ZCSpxTjV9El66YKPX94N4d6q7k5y8
	nAKsqcbGDND+y8yAOjGf/cJlbaik/GHP1a3JrWTl8t88F+l0E8BPSZYu6DWJBuX+
	E3+xOtI1/W9LlMoUf1tMU5ZeraRRxj+baLtxYoLESZx01VYOFifriSg/agWpWLGi
	KB7LSH7WGmuVrhamIZLifjAA7dBMM/N72jmjkpo5v4Mk2+GQnYk1pbeoZX4yixBT
	jb20tZrqslKWZepESCqHrQvEJQ18qSRUmBCBk408IwbbQ2PiLwEpM1YgOrjjI0qA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cwubu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 18:44:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HF7jgQ015746;
	Tue, 17 Mar 2026 18:44:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nah3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 18:44:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HIi2Lt3539884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 18:44:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271FE58054;
	Tue, 17 Mar 2026 18:44:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2814058045;
	Tue, 17 Mar 2026 18:44:00 +0000 (GMT)
Received: from [9.61.251.215] (unknown [9.61.251.215])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 18:44:00 +0000 (GMT)
Message-ID: <de08911a-8bcc-4983-9ad2-b20467ebbb7f@linux.ibm.com>
Date: Tue, 17 Mar 2026 11:43:59 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
 <20260317-vfio_pci_ism-v5-2-b73248b4e576@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260317-vfio_pci_ism-v5-2-b73248b4e576@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b9a0f4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rwOevmhlYjJUsVWJuvMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2NSBTYWx0ZWRfX3w4qjyw3UAG+
 VW/lewhlLSOeGXyZ6/WrJmzMOWj5WxS0+Np3/LwNsfm8rLL4u96saEil8a4iB4kO/e5uK35lmkY
 6q4E6QDjav3mtTtIzDWUH4duNfbd+duU4HBWKyMGd9E0qETv4lCw5TGFnyNNl5eKq9YJE9ypquy
 XrMFQRsg3CjEoZy3Ibh1bqYbQW/n8D2fwX/1vhslZJzV1RQ7CTmW9dZp/xiEeEywO4scl2cKN/G
 /UUiCtPU5mWfmD/8W1Ntg3xu4FzRpMtKcDKAvz7rCGFsVw6aVki22nd9lH+nvbJaxwA9EtkmbV1
 khU3W0UvU07rWpHCBeHsrWfUcY5NueRnpWrZwCVx2nfH2TxufZ8vX1tfQ2HHNzFb2Gv6rLrHqiS
 YTXIniBseHTy3clpc5vECBuTY5kmAIRPxVtNf1z7UgCtC+VU1/LbsKnTCG4uNUF5HOs6wMhtkJW
 TFpsXsswvt+Njn9KE4w==
X-Proofpoint-GUID: WzQZGFPoUx8-RknGgY_659nyqAenE0tV
X-Proofpoint-ORIG-GUID: WzQZGFPoUx8-RknGgY_659nyqAenE0tV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170165

<..snip..>

On 3/17/2026 5:58 AM, Julian Ruess wrote:
> static int ism_vfio_pci_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *id)
> +{
> +	struct ism_vfio_pci_core_device *ivpcd;
> +	struct zpci_dev *zdev = to_zpci(pdev);
> +	char cache_name[20];
> +	int ret;
> +
> +	ivpcd = vfio_alloc_device(ism_vfio_pci_core_device, core_device.vdev,
> +				  &pdev->dev, &ism_pci_ops);
> +	if (IS_ERR(ivpcd))
> +		return PTR_ERR(ivpcd);
> +
> +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid);
> +	ivpcd->store_block_cache =
> +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
> +	if (!ivpcd->store_block_cache) {
> +		vfio_put_device(&ivpcd->core_device.vdev);
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
> +	ret = vfio_pci_core_register_device(&ivpcd->core_device);
> +	if (ret) {
> +		kmem_cache_destroy(ivpcd->store_block_cache);
> +		vfio_put_device(&ivpcd->core_device.vdev);
> +	}
> +
> +	return ret;
> +}
> +
> +static void ism_vfio_pci_remove(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *core_device;
> +	struct ism_vfio_pci_core_device *ivpcd;
> +
> +	core_device = dev_get_drvdata(&pdev->dev);
> +	ivpcd = container_of(core_device, struct ism_vfio_pci_core_device,
> +			     core_device);
> +
> +	vfio_pci_core_unregister_device(&ivpcd->core_device);
> +	vfio_put_device(&ivpcd->core_device.vdev);
> +
> +	kmem_cache_destroy(ivpcd->store_block_cache);

I think the kmem_cache_destroy() should be done before we do 
vfio_put_device() (or maybe even before 
vfio_pci_core_unregister_device()) to avoid use after free similar to 
ism_vfio_pci_probe(). Sorry I missed this earlier.

Thanks

Farhan



> +}
