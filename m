Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031A481672
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664919; cv=none; b=bC784DLEaWLjrvOaKKl+8fZKVG0ZBfkxTJ5kEpF2yfvS62bzqxMh7Nlv3yAorroVEFi0JJiuQmYJNjoTN761oL05JqZgJYd1gx17itfuQFZnScrncq5LVOpse/a5FaBTZiuZeC2hn68ky8w/6jsiZx7dVkRlWlULR+ltJcmtPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664919; c=relaxed/simple;
	bh=U8NKMFpLlOLNgOmXbq2qpOMg7etd6z9KoUoj+I5q8bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2V0PWoh0mTyXbBDIHQ0z+Aqz6709E7rnCnoi7kHSo0UzYZYj1MV4Ny6Dy7+X4gC1zECGfxc5uMy3d5DWpt4fMBnI2zHN72efS3r2nXZ8R3oJa/psmosqeYxeyYpzJ0nkr3RtwBHPtz937aT5PXdVj0TqcVvJtuObMsLxa23jt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VBmpLO/t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VBmpLO/t"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PB1tH2543207
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NXkCCm2y3zgzEOTFpWAfxnzn/y8kT2
	D4FJja+hXt/6w=; b=VBmpLO/tZ8rW5Wvv/O6tcXmI08yGaEH29mVZqrzx7Se0YQ
	QNAL3siTQlKt9FP6viUzbU/kk/B+O+eWn4opdxEoTx1GdJhK1H+tN4y+Oy8b2R8C
	LPHuMjfbfN6gdr9i/8jmZq5bWCZ/4dd3Gw/w7XWkBOfJfK2ZwCwmcpQFDpYxmSGU
	bROPIOQ4l+e+9eu+23LuWaaWScgd6jUgwJ4EKkIzsyGVF1FGnRwHq1b3xXLpEd94
	clAKNKA0IoIPMiPgR1jz653tJJUhMZLU+awmHd37bIDhemPxVYNnb2U7uIH5MPtU
	SIQPCwSQ3mEVc+dU1ZQedju9k/ZjKlZGPmbT9bkw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hrjau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:35:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PDQOZS011473
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:35:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw4k8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:35:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PDZBp642205584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 13:35:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8EDE2004D;
	Tue, 25 Aug 2026 13:35:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9735E20043;
	Tue, 25 Aug 2026 13:35:11 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Aug 2026 13:35:11 +0000 (GMT)
Date: Tue, 25 Aug 2026 15:35:10 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/topology: Switch to common cpu capacity code
Message-ID: <20260825133510.12095D6d-hca@linux.ibm.com>
References: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNSBTYWx0ZWRfX3Z4GpVD0xF9/
 +UXpg1oBblgKihDN4429Khv8ba9PcfD3BXHSmHV+gFTXkXdiZtY5AUdh8kLhYy5p+b+r9F7mqoM
 PQKBlPXgPung389ECpXlYEUo1UpFvy8=
X-Proofpoint-GUID: m-LfyQMKAMOqLXjKHVomJ8YsHhz77EDH
X-Proofpoint-ORIG-GUID: m-LfyQMKAMOqLXjKHVomJ8YsHhz77EDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNSBTYWx0ZWRfXyZ//HNf4fjPV
 iYtHHj7wEyASMtVnK/iCO+UjdAO+myihHGNeD3f4mXOAYbx+iVxQYeZl9V7gVK2KY+oEAV/wKOp
 O0cxU4AfTVCFkBHFM37xkb5s2GW0gneZ0VaZ/gQxMk7uFG8XkguWV9iXlgpvBF1k9vN0BdepBiC
 TaVa0P/qEOyN5RVv5Xc/IxvrocHml/L3CS2sJxIkv/nz7vXP/ST+Eoe76EjSOyiKQyiJB7CA7E6
 KBEXRnBIhmbbO0e9sNL4xVSxTqq1E4ccOGCmyPzJcg09ZCf0m9mEFc1/SvldGm4wkP2pTaR6/8f
 RW14liqWIeZLWNPLE+M9XiKiP+Pm+fMLZBllCMDqpeNsdveNiWD6S7G6S78rB7b2FRlbVPjsR93
 df8deHvypGTx1u6LinVuqzQCQM7ddyIQG7WGDMTZ2Fga7JYpENM2Sb9iHLS2yvhwOIeXD1J+s4X
 8H71eJl5vOjyY3kbKlg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8d9a14 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Puiun7Du49nS_SMLvowA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250115

On Tue, Aug 25, 2026 at 02:58:20PM +0200, Mete Durlu wrote:
> s390 implementation of cpu capacity management infrastructure code does
> not do anything different than its common code counterpart. Switch to
> common code functions and remove the smp_cpu_*_capacity() functions.
> Make s390 code better align with other architectures which utilize
> cpu_capacity. No functional changes.
> 
> Allow cpu_capacity attributes inside sysfs to accurately reflect cpu
> capacity.
> ex:
> 
> $ cat /sys/devices/system/cpu/cpu0/polarization
> vertical:high
> $ cat /sys/devices/system/cpu/cpu0/cpu_capacity
> 1024
> 
> $ cat /sys/devices/system/cpu/cpu40/polarization
> vertical:low
> $ cat /sys/devices/system/cpu/cpu40/cpu_capacity
> 128
> 
> Prior to commit 6bceea7a1e07 ("arch_topology: Relocate cpu_scale to
> topology.[h|c]") cpu_capacity attribute was only available to the common
> arch_topology driver's users. Reflect the correct values to the newly
> made available attributes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/include/asm/processor.h |  1 -
>  arch/s390/include/asm/smp.h       |  4 +---
>  arch/s390/kernel/smp.c            | 16 +++-------------
>  arch/s390/kernel/topology.c       |  2 +-
>  4 files changed, 5 insertions(+), 18 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
