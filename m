Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35041258CE5;
	Fri,  1 May 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666633; cv=none; b=p+jU5H4lDda+CsSUCIGS0xumwlT5uA9xX58o1nXZS81bepzgJGfbRErgLgGtnBB5BzhSjFULsyT5FZX6aKRwV/Rny92DfFv8XV0bKJU/2mzpDuhGJQ7WAxvbq7uTSH5hSel7LBGKit45UTQHtwglU8n0XbIk+RqPkk6ynFmDT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666633; c=relaxed/simple;
	bh=f6BySBYCG48HtX+ue5z34ZGtskkO5AibDdH3iIbfRNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFzt/WbFnyEg2bqy2/ZVFYODEEsIwsR53p3aHFK/Zn+Kn9Blo9Wo+c6+eOLOAAfGokhkBLvcJwo/Udpq0u+BErZTmeXQGlt4XLbNawiMex9cs4WPr7bRQPRznYm2gSChf8OTiFDiMCtnGQvGXrb5UxE4APrqFXVkLCRhkRzbGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snrqGpbL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snrqGpbL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641B1cUK1815471;
	Fri, 1 May 2026 20:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G+rXSW
	diJS922j5LVZR4XUPUK/2iZy2QkSLUYLCMtQk=; b=snrqGpbLjqRPhnzWUSGTaG
	UXlhpAA1UCgqMfEqbCUl32WZDB1ApmvDBieDh+r5CCbdNa30yB/FP1JDTzhsNmnn
	GADiMyhF6rBFIeBKUMhiC/GXKHSHd+U71iOdnvXAzx0iDIr8xIoL8iArHl6ipKck
	dhp3xzDbNvj9ZE4nHpjmTcrov2Y3ukxsAw/g7IoAxhBozlskdm5BsrDA8NHulUb6
	3L1UJHNT7TZdugALouxa0oPBS8cALohI2HBwJxd6O4NEsHUIHST+86ITYpF8+Ah9
	Fo8keYqXo50p/DJxeONhZFRvHSgd6eIQ8urAM+qcWfOSzE00cQ+cbROJ8Pff0niw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn456cuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 20:17:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641K8lAv001846;
	Fri, 1 May 2026 20:17:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw92uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 20:17:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641KH5Cn25953014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 20:17:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93D465805D;
	Fri,  1 May 2026 20:17:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D40A58056;
	Fri,  1 May 2026 20:17:04 +0000 (GMT)
Received: from [9.61.247.25] (unknown [9.61.247.25])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 May 2026 20:17:04 +0000 (GMT)
Message-ID: <6dc1702c-331e-4180-b904-9e7da95306de@linux.ibm.com>
Date: Fri, 1 May 2026 16:17:03 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] vfio-pci/zdev: Improved zPCI Function Measurement
 Support
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, alex@shazbot.org, oelghoul@linux.ibm.com
References: <20260501192530.9429-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260501192530.9429-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ihFdwf1eLaED_0ZBnIofPLQtKHsXp2ao
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f50a45 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=m7zeSVnScndjdKiXyGcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ihFdwf1eLaED_0ZBnIofPLQtKHsXp2ao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfX9Hss7ZPBjb27
 c1aHkAgInuovaR0GDYkKnYXd8K58i7BrQFymWy+s83srMaf8HDQnqDqcvoDMd3QYQqsAGqwtaSB
 su7IQByomZ9jla/6XOyuB4tikePnjPEhvY9g+RYxSIGO8Dd3/SOgnd4XFK+5Wb2OfVG2ie6xAo4
 GXwmxsPHgjoGeTnRxMRTbYmnsAlcMtleNM/7BmhhzhyCNZTDwmcfG5HxV6WUGXSWS0wZ4xRf9sP
 TcmLJ82D9rNnhsKH1H1J2QNBTnPIkDa0/qUyVJ9ayB+V5qmcbXmBO1VhO1z/qmH+iijuPGK8Ome
 CDEdNoLl3fj4Q6yOgZChYKpbnMMgog5X6WTQudbVauNhtJCPqAB1A2oXphXvsQPYfo4O+ArH74q
 SfQIfTKNiIL/lzVDrUFaK3BqJTjx2jy0AkWpV2t/zgf1X1CXlnPMQKIUtSZ4Ynro4P379u4CJrd
 fZI81fH5bb05t+stYuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010195

For illustration of example usage, linked below is the QEMU RFC that
proposes using the feature introduced in this patch series.

https://lore.kernel.org/all/20260501200026.22784-1-oelghoul@linux.ibm.com/

On 5/1/26 3:25 PM, Omar Elghoul wrote:
> Hi,
>
> This patch series improves support for function measurement for zPCI
> passthrough devices on s390x.
>
> Motivation
> ==========
> The firmware on s390x machines allows for tracking a variety of statistics
> relating to zPCI devices in a function measurement block (FMB). However,
> the kernel currently lacks a structured mechanism of sharing this
> information with userspace, beyond /sys/kernel/debug/pci/ID/statistics.
> This can lead to shortcomings when running a guest on KVM with PCI
> passthrough devices, as QEMU is unable to provide an accurate FMB snapshot
> to the guest.
>
> Proposal
> ========
> We propose adding a new VFIO device feature to zPCI passthrough devices,
> allowing userspace programs to read the latest FMB snapshot as it is
> written by the firmware. We ensure that function measurement enablement is
> preserved across device resets on the host. Furthermore, we guard against
> host tampering with the FMB via sysfs when the zPCI device is in
> passthrough to protect the VM's state.
>
> I'd appreciate some feedback on these patches.
>
> Thanks in advance.
>
> Omar Elghoul (3):
>    s390/pci: Preserve FMB state in device re-enablement
>    vfio-pci/zdev: Add VFIO FMB device feature
>    s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
>
>   arch/s390/include/asm/pci.h      |  1 +
>   arch/s390/pci/pci.c              | 71 +++++++++++++++++++++++------
>   arch/s390/pci/pci_debug.c        |  3 ++
>   drivers/vfio/pci/vfio_pci_core.c |  2 +
>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++
>   drivers/vfio/pci/vfio_pci_zdev.c | 77 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/vfio.h        | 43 ++++++++++++++++++
>   7 files changed, 193 insertions(+), 13 deletions(-)
>
