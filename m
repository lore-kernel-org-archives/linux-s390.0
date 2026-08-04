Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D973DB30A;
	Tue,  4 Aug 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865655; cv=none; b=QdAbtgSp9OXKwKcz1X9H786TGB+b+ZzzewJjhvLg+EHaOoQK25y78gkyDK6k3vQHJjiAy+XN4wGWm4vmgSyzkzx0kgatrF7O7WoNbPummaF+3uN74Q+547YftYm0jJ0IwLR7bVXIO1htYQouzQXVCq71jsWuamoXJCK3Nf8Yc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865655; c=relaxed/simple;
	bh=KEboBocFGJLWhF73s7/eQBszdI/Cw3RE/+InTgCc3go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+IE6T6IqZdADty8yidG7Wc3XJzjjijzZBCMzczGJ3HtMkNf1YZmXWdXwe5HnR6ZG1pnMIN/B5DSZb4DyKtZSwUhlrUGnBiTMjCTTYcocm/xjUf6sEC3Y5sX4USFyf0n7FB/g1oFz4gAoUvFBCDlIUdrN1qf+11Rx4Qg5FJ3oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CDhI0FRr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CDhI0FRr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fm4I91192996;
	Tue, 4 Aug 2026 17:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q/aDTE
	/uVvHJLvHR9IX8Xx829AxLEbc8PRDacv72dQQ=; b=CDhI0FRrZ71Le2ZWEp0qqH
	PMTP47aDcStKJ0WQAmyyK8WWJnMp9ie/+vUlWmwhl0YzXOq1CbPgoeOBiu/QH9NZ
	pKAOhhvjOCj9qofcFaGR6Uyt5MRvr75PwPa01azj177Y/uRMu3fHaMoGXcScHh9M
	Qs9JyMHlR6rmNO8PIrearCCTdtiF8HtY5f9ucFrPA+gDGC7I5X/L0C1JbVig0xBu
	QsskSFdedCbpROvUOb5a5c8ZJ4DFKZlb/M+M40SfDn29VlNm4OM7CBa8bwPHkSSR
	Ij5ZOicCSID34268rq3mAPS6TKmggNiAkL/B0zF70u4xnBFG+Y8V7D+NMKIX4WCA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hq1d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:47:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HfF8R014405;
	Tue, 4 Aug 2026 17:47:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgauue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:47:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674HlTCt64618966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 17:47:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C06058051;
	Tue,  4 Aug 2026 17:47:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CAD15805A;
	Tue,  4 Aug 2026 17:47:28 +0000 (GMT)
Received: from [9.12.72.253] (unknown [9.12.72.253])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 17:47:28 +0000 (GMT)
Message-ID: <71d59418-23ea-475c-9d25-150bf737b6b3@linux.ibm.com>
Date: Tue, 4 Aug 2026 13:47:27 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] KVM: s390: Remove user triggerable WARN_ON
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-2-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <20260804162435.28617-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX1JLCZ5c5dxcz
 xnk95eAndnjoEncJGD391brnjQztS8r/mfzBBV/FcqXLB3NpWF/ZNSmjtLNcb2SCwTvnjLbeGsL
 s07A95gOUzmp2t2yPm366MPHg8nVD8s=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7225b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=tgHNGyS2YRxZX3HSAT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX0ZnxNq56c/ui
 s/zyImxFxu9a7tJMQuE/dqWDUaAO7hAQuvoIYgEUdVAcIiN10LvUuj0HGWRea3ER1jdDr2HzkGb
 qVRBvHstZngRLRUPmOl/jU8OuRECJQ8ECHEzufPjMpyIXJyh8vaPH3/vTUa38Lc/fFbgSc3438H
 H7mKk9/nv/zwToJrg6KF58/QDT8yO/1eRQBdnsfNkPny73L/OM9qB9dCb0pUcZerFA2A8zi7B9P
 7nVJsyLrYCNur9sMZM6h17r0oHcvn3uTLJDNcDMJYCXkSVMFrC3n39NdPes6ubOYoH7dfUDrJrj
 QpEQypE13ViJmcbWHhAMV5IdDkk2FJzZ0z/xSVQo5XlJlRUwaxBASRwCg7g0ScnX2zmRJze9H24
 9ZZXZqoZqMtRdoyobYzNANjHUv67wKRHQLzgfpLzMUgD9jI9NQoSiCAkFL09Uf37t4uhN+vi81n
 DUlYySH0HspuNJM8NcQ==
X-Proofpoint-ORIG-GUID: wlDti07Mqe5xbcnZtw2n5WV8ozlJeVnM
X-Proofpoint-GUID: wlDti07Mqe5xbcnZtw2n5WV8ozlJeVnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040144



On 8/4/26 12:24 PM, Christian Borntraeger wrote:
> pin_map_page() fails legitimately whenever the userspace mapping behind
> the adapter route has gone away, e.g. when the VMM unmaps that memory.
> As this can happen without a kernel programming error, remove the
> WARN_ON.
> 
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
> Cc: Douglas Freimuth <freimuth@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>

> ---
>   arch/s390/kvm/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8f24bcd1a6d3..23f0e0821474 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3013,7 +3013,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>   	if (!summary_info) {
>   		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>   		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
> -		if (WARN_ON_ONCE(!summary_page))
> +		if (!summary_page)
>   			return -1;
>   		idx = srcu_read_lock(&kvm->srcu);
>   		map = page_address(summary_page);

