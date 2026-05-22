Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAF33ADA9;
	Fri, 22 May 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471830; cv=none; b=XDC7IpbhwgoI48V5XrId1mct+1I248UJhaH5V5+iuIaa36Ug9nEURBf5MoRt5hBqWaKHMaBHGVV4idngGxeX9UUAGsz3ppgai2w0Zck26+mfL8DGz7z0vaRNuLdlADCGjP1DuoT7PLfK0+Gm/P4qVfhhmbTdNCXxMkqqv03vUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471830; c=relaxed/simple;
	bh=kutAf6WGEdz7SXFBTSOjuvGhz1P//X/ci2i05QqirRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t2XzIMV8HJ6JPda/5CtwV2K833LdMlcJrfjLcH4R3j3lblgKSQLC0tAPx0N0venPKnsOcHME/aD5orCEQ1U0NAyMMHU4Kdq3z7bCKa4NVfHQDpv+ZM1gtRuINpGQGzray7A6VeTVvf8gU0L5mGBr+ccPTAznRqqUEs+ZNOSKqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lGvxp7ho; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lGvxp7ho"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M5KB6f2907049;
	Fri, 22 May 2026 17:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CaHtze
	NCTpdtpdd6etSXgZxvZOMCBE4VZjzEg3zGrdI=; b=lGvxp7ho2yAS//cBQmhJpu
	cUu/OSxpe8RCU4+/tK7iIjf9QLHqX1wm2fJhiPPUAsn6rcZUlHyxvNO8mrAfQhsj
	tNSiLdIySHAagHwjyUYlbwzEQxt+M5DpuzBmNxU/Kd5M6Fnxsc8DBoGfu/Sm0GgS
	UUOPpbbDCsU0eHV43xgTkyisG7UBSvp4ubBUOAN+5vE0Em7D1nQlvnN9gQftV215
	PtL4wfH13Hbee1JEOfZsvf9WU7ychJMrY6qzRLD+1l52zBvMzOmyHWLz6NVrc/Ey
	ftGxf1a/QUR6IeMW+gfMvYtqWhRqlbSv3ngap7KvXZAlc01xrdEUCge9ykeGSYVg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n54pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:43:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MHd6G0030412;
	Fri, 22 May 2026 17:43:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj1vw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:43:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MHhitx28639948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 17:43:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A11A58043;
	Fri, 22 May 2026 17:43:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7E3D58059;
	Fri, 22 May 2026 17:43:42 +0000 (GMT)
Received: from [9.61.48.218] (unknown [9.61.48.218])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 17:43:42 +0000 (GMT)
Message-ID: <a89924a4-a31c-470e-b35f-9a0a9c89701d@linux.ibm.com>
Date: Fri, 22 May 2026 13:43:42 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260520160442.1051999-1-freimuth@linux.ibm.com>
 <20260520160442.1051999-2-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260520160442.1051999-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h08GYdI-A9PnoI8FVS17IgobOsL1J3DH
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a1095d2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Fq1GgztE50DjSatICvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h08GYdI-A9PnoI8FVS17IgobOsL1J3DH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NiBTYWx0ZWRfX3Mylnd7K+zjE
 hwToFyvr2eaePyHlrdZhkA/IkY/by9hozLkPWoNMQxibVfMRC9N/6bo5dJ4BMeiS7l5uAAjGD4Z
 EpcP504U3V6CudJXA3U8HWfvMkQH4x5bPKyd9XYQsjVdivld+xgI0GukI9Jf4P59IJcj+7IXfwl
 t5WQFFh9YGNSfLRyFK+4VSbsPEvFKaWnjNwWydYiITKsjmAycqDEzvjr01vQLn3+1Bpe8AWFYy0
 ndn+ZU7hVYKWHP7+QzkccyF2bTItCQoe4HGFJ9lVDEgfZrtBnAHYDSlNUJlx7B1eQttp+tGtTM4
 e3tkqOzwuRyxa7jeLvd5uRu/brjuzX9VEOcNKlEB8OPWJBfe5R/uej6EWuN9n5T3L4OMiLAleJP
 pYpaHLEX1wQaVsSlHA4PCRPB0dkWype1xFVnbvDy1MhEUQMZ/JvDoHBziFNtN4O6v43hksgQUy0
 KH2aaRXQeHzX715IX4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220176

On 5/20/26 12:04 PM, Douglas Freimuth wrote:
> s390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> pin_user_pages_remote is used for both the ioctl as well
> as the pin-on-demand logic in adapter_indicators_set().
> 
> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
> in Secure Execution environments. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> will not be incremented as the adapter indicator pages are not mapped.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |   5 +
>  arch/s390/kvm/interrupt.c        | 194 ++++++++++++++++++++++++++-----
>  arch/s390/kvm/kvm-s390.c         |   3 +
>  arch/s390/kvm/kvm-s390.h         |   2 +
>  4 files changed, 174 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8a4f4a39f7a2..0056cc9414a0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -448,6 +448,8 @@ struct kvm_vcpu_arch {
>  struct kvm_vm_stat {
>  	struct kvm_vm_stat_generic generic;
>  	u64 inject_io;
> +	u64 io_390_adapter_map;
> +	u64 io_390_adapter_unmap;
>  	u64 inject_float_mchk;
>  	u64 inject_pfault_done;
>  	u64 inject_service_signal;
> @@ -479,6 +481,9 @@ struct s390_io_adapter {
>  	bool masked;
>  	bool swap;
>  	bool suppressible;
> +	spinlock_t maps_lock;
> +	struct list_head maps;
> +	unsigned int nr_maps;
>  };
>  
>  #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3bcdbbbb6891..654c37e5e898 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2429,6 +2429,10 @@ static int register_io_adapter(struct kvm_device *dev,
>  	if (!adapter)
>  		return -ENOMEM;
>  
> +	mutex_lock(&dev->kvm->lock);

Sashiko mentions, and I agree, that you should get this lock a bit
earlier so that you protect the reference to kvm->arch.adapters[]

With that change:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


