Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2933A9FC;
	Thu, 26 Mar 2026 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551938; cv=none; b=BEJE5aAYbaXoDnbuacPoOGCStm66R7vMGa+hfzqJxNffaeDsCR/swapgjHiml0VmarXU4ZlNugZTbh1lySkpCFtwdfbJwwXpyq2NJepvLR5jPCHbrvnXfwVhs5SrEI0bYoeu1UfmVmGXWRCeDHi68Pd2XOk4H6EoF6FE2eK8fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551938; c=relaxed/simple;
	bh=dwdYpT7gHFwLIVM/vV2jTq1BZSxOXfyEuivKQvtyja8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oi7g3tRHizAhRO4IHm+w47ULpMAsL40w1pCqUGST/FHdKhbwdHsURiIDhq7KlIsjaXDfiPA60PGi73FXRszdLh4MCld7yQi8XondvbqJiYCEthrQ+9ZhxtXPOSQfEllG9o30qxGfOU6bszuTwIwLFauWCK0iFep/X5tLe40hQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zv6Xlvpf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zv6Xlvpf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q89MDS3011996;
	Thu, 26 Mar 2026 19:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RegP/k
	Y2TA8NJMDdQN28ncPjNidJcrgVawfmnm71jZU=; b=Zv6Xlvpfg/Tu4plMqfbnpC
	++rpcOEK/pc2V/A9J6Cf8QaaKr5lZFmYIacouUquLJkOXhuL/6Wst/ceeVJXGeSp
	6GtY58QPhttJL7NetqB/fICoLT7uUBX5eNBn8zTeOKxvaFrPv/OpKQDG+xApv+Gm
	wGYRtWMDByu2F3YTiWo20Z6heMDsjFAvWqRAZyqmxlgQSZj3PdP7KHjLrTJLjjtB
	sVT1Bn4h6ER8sRZO96WfLu6k0V4yTaB6JkdchYrI1InPgng0KSez9SYqYXr1/7gW
	zXhgjNevIQQq1sDrUCgb2466hGwYpQzPZzMHGCRXXlyHwABjZ4FaWG0AQjdZ5PFA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqpujh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 19:05:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFtHua011824;
	Thu, 26 Mar 2026 19:05:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkc4wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 19:05:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QJ550C5046990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 19:05:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA3F58055;
	Thu, 26 Mar 2026 19:05:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E5C958059;
	Thu, 26 Mar 2026 19:05:27 +0000 (GMT)
Received: from [9.61.247.58] (unknown [9.61.247.58])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 19:05:27 +0000 (GMT)
Message-ID: <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
Date: Thu, 26 Mar 2026 12:05:27 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum
 <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iofcWBWmC3FuwplsueNdk_00KF2trhKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNSBTYWx0ZWRfX5LTuzM/ZXY4X
 EMGzXi5f7nmgqxCJ7TH8cXKx37peozQHxaD3eGvDD+Nd6fe70w5S2no1MONLmQvRolWyREHg+yv
 KcfRpKD7/9NCtiV4OtQUJCD0KRjIlS8An3j409/BR0aVxiTrX0w7yWvUmHQfRmZ+wZins5wyThX
 VOobPuHybaWjjJSI8u+1CdhIAN6dBGVnst2SCvQF/p5NdT2JEMswXBaTRvhVLXfH9gInYhAK8+m
 JXpa/MC5I+EWQgHbDFuTyqaoG9Fjp4ZTxqOZMgt6aT3cE6vOAGNWdlo74Ki5JZ2O8CxDJv2CaCw
 XH6l0M4VHU+0+EyGtzs0ekbYl1cgs8Y1cMgI0DpkMLUL9nV+hIgo95oMVYz5e06v4R5f0U3Lii4
 ac238bQaLVq4zKlGGDK4ciB0mKNu1OyZoc7qnglc0R6D2pSZFKFX1GYVtJbsYMmJ2HXchYh7mcy
 WxM53sZR8y8y2H0ZP+A==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c5837c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=8knF3OVK0f20Sk4uvPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iofcWBWmC3FuwplsueNdk_00KF2trhKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260135


On 3/26/2026 6:03 AM, Niklas Schnelle wrote:
> On Wed, 2026-03-25 at 14:31 +0100, Julian Ruess wrote:
>> Add a vfio_pci variant driver for the s390-specific Internal Shared
>> Memory (ISM) devices used for inter-VM communication.
>>
>> This enables the development of vfio-pci-based user space drivers for
>> ISM devices.
>>
>> On s390, kernel primitives such as ioread() and iowrite() are switched
>> over from function-handle-based PCI load/stores instructions to PCI
>> memory-I/O (MIO) loads/stores when these are available and not
>> explicitly disabled. Since these instructions cannot be used with ISM
>> devices, ensure that classic function-handle-based PCI instructions are
>> used instead.
>>
>> The driver is still required even when MIO instructions are disabled, as
>> the ISM device relies on the PCI store block (PCISTB) instruction to
>> perform write operations.
>>
>> Stores are not fragmented, therefore one ioctl corresponds to exactly
>> one PCISTB instruction. User space must ensure to not write more than
>> 4096 bytes at once to an ISM BAR which is the maximum payload of the
>> PCISTB instruction.
>>
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/Kconfig      |   2 +
>>   drivers/vfio/pci/Makefile     |   2 +
>>   drivers/vfio/pci/ism/Kconfig  |  10 ++
>>   drivers/vfio/pci/ism/Makefile |   3 +
>>   drivers/vfio/pci/ism/main.c   | 408 ++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 425 insertions(+)
>>
> --- snip ---
>> +
>> +static int ism_vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>> +					      struct vfio_region_info *info,
>> +					      struct vfio_info_cap *caps)
>> +{
>> +	struct vfio_pci_core_device *vdev =
>> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>> +	struct pci_dev *pdev = vdev->pdev;
>> +
>> +	switch (info->index) {
>> +	case VFIO_PCI_CONFIG_REGION_INDEX:
>> +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
>> +		info->size = pdev->cfg_size;
>> +		info->flags = VFIO_REGION_INFO_FLAG_READ |
>> +			      VFIO_REGION_INFO_FLAG_WRITE;
>> +		break;
>> +	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
>> +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
>> +		info->size = pci_resource_len(pdev, info->index);
>> +		if (!info->size) {
>> +			info->flags = 0;
>> +			break;
>> +		}
>> +		info->flags = VFIO_REGION_INFO_FLAG_READ |
>> +			      VFIO_REGION_INFO_FLAG_WRITE;
>> +		break;
>> +	default:
>> +		info->offset = 0;
>> +		info->size = 0;
>> +		info->flags = 0;
>> +		return -EINVAL;
> Thinking more about this, the above default handling actually breaks
> additional regions such as the one added by Farhan for the error
> events. I think this needs to instead call the generic
> vfio_pci_ioctl_get_region_info() for other regions.

Note for error events we are using a VFIO device feature and not a 
region. At this point we actually don't have additional regions. I do 
agree that if we were to add a zpci specific region we would need to 
update here and ism_vfio_pci_rw() to allow region read/write ops. This 
ISM driver would also need to support all the possible callbacks in 
struct vfio_pci_regops.

Given that we don't have any additional regions yet, I am conflicted if 
it makes sense to add all the code to support additional regions without 
a good way to test it. Maybe its something we can defer when if we add 
additional regions? Thanks

Farhan


>> +	}
>> +	return 0;
>> +}
> --- snip ---
