Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF14968F3;
	Tue, 29 Sep 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674588; cv=none; b=RBTlwIB0C9YwfJIYFsLKy1+QyX1j/qaKQlTzZCiEM56pwpglfpuC6kS3hfVyMZ+BJyARhR+FDJWA6o51gcIJ/SRkz3AFPDZNvSEKkQQyxAcQwc1pOOmdD1NWDDrBjk97MLP5CKl8jNcxA8bKy+gWadlXvuBjzr3ovTTXGkHNv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674588; c=relaxed/simple;
	bh=pFM70FbyR1JknXLq7uZwl6YV5EpPi9DGj3f51A1Qqbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP7GhMTDqMLCjeNcGqNzP8EdurYbtiKfnFE3W2rgoHUPGWiL8c8GPJJyW1MyPMEY9bbwu78M1xPsZoxaj3p0Q8WWaUFKDs/BnIxcn4arQmyw0B/rhL/9xrgCHRKQrSxRCVBsO7QtjNYzGJrNfES/laIy8VhyclJCKPCSH4gV+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sxD/SrnW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sxD/SrnW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7aDwY3536158;
	Tue, 29 Sep 2026 09:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KVpDbV
	bfbiJtmrjCjI3Y+IC3oKR47tlBG6IjlgbdpyY=; b=sxD/SrnWKX1fJNH6dyLVer
	AANxPC2zM2TWQ8Y7n0fJS+CTPxw552lfOeNZa1b4q1Jkzdx/W2QJfzkqXrhtFNPJ
	PqMuNHuDNPHwtVd+cjhWUGK3XtRcGp5iJrSl0wU44eh1FCq81GS7zZ/iEai5JS8v
	TBeinZwD62rZiDKNdmVRDyRxiMKCA0VCjE5Yq1FdlffsAwRHTOT+J/kjo0cf79uJ
	Npl1/3wC3wyGGS1zERyoFOpqFXxCkBimZC4NA5ARsAgJzc1kvmi/6WAIUdt/cZx2
	IxduQtwq+JE3Lsb6TtAgub8zby1yelEZOWG8CR2/ijbrIWEledErBF1eDS2EHoXA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5688g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:36:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7Wccj092052;
	Tue, 29 Sep 2026 09:36:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg8xp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:36:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T9aNEX49217812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 09:36:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C293358054;
	Tue, 29 Sep 2026 09:36:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99CC58052;
	Tue, 29 Sep 2026 09:36:22 +0000 (GMT)
Received: from [9.61.24.130] (unknown [9.61.24.130])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 09:36:22 +0000 (GMT)
Message-ID: <dbeb1586-52e7-4ff0-884c-7cbdf3242904@linux.ibm.com>
Date: Tue, 29 Sep 2026 05:36:22 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-2-akrowiak@linux.ibm.com>
 <20260925125721.5C29C1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260925125721.5C29C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfXzYLJbo5INnVj
 syjCP568XS5CGLaeZVwpPpDW9bhfUjPTWjDJT1aDfu0U+A5rTsdnm8LqFeA8YH8RGuFsxxQF8uJ
 IUw2TCyPyYfFtUPbz4VS5qh2G9kzLxs=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abb869a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=V9ano03wmCg1Q3s48aMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r-QIiHrIuGcOxYSM9Iz-Xt2-yMfqdqno
X-Proofpoint-ORIG-GUID: r-QIiHrIuGcOxYSM9Iz-Xt2-yMfqdqno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX3fbh/wkYx+xI
 MfQc2Hg2R34i5QaMnGvP8oq4MBJNXlDGSiWlhempwLXEAWkcIJlZHzExcKS4qxAFrq28ycnIZkQ
 0VUjQ1iI5F8azV1SUb0BryolwkdsdrYjg4PX/AEgFeLEd4v+fJvndB0C3A0dIkLnbuQR6yCNJpR
 PHpzQGl3S0UNHfTX1Tb4AFEk+1Pf6ZSg6jqEw3pY/riUb0EX4dzqohPFtvXdSo1rf9rVqBCOI8A
 A+Fy2ySiDU32LE14gbTck9Mb5RAVeZumQRBqwSIQJYaPVXLnob7p8rZcClrXmTCon+zlG7Ycios
 mWmFkggQ71g92oAOfKSlCyIwqkO+raybHdNf1VcvFtvXlnJvF6KSXyq73o7/j3MVhhY7N1LA35J
 KLIeDHUZExZIdojK/sLt78NzwdaI/OC/OsXzi3bD0doAFXmXRCz3vYL2pqQoUvXlhHz6jX/Frfk
 xVbiACv6aYAhUoWSKKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290038



On 9/25/26 8:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] s390/vfio-ap: wild DMA write due to unconditional NIB unpin in unmap_iova
> --
>
> commit f138c70af93258555b6e1c1c1233b5d5dc8b82da
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
>
> This commit addresses resource leaks of pinned NIB pages and registered
> GISCs across several paths. It introduces intentional leaks for cases where
> hardware might still be able to write to the NIB, while freeing resources
> when queues become unavailable.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1857,8 +2006,28 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
>>   	int loop_cursor;
>>   
>>   	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
>> -		if (q->saved_iova >= iova && q->saved_iova < iova + length)
>> +		if (q->saved_iova >= iova && q->saved_iova < iova + length) {
>>   			vfio_ap_irq_disable(q);
>> +			/*
>> +			 * If IRQ disable failed or IR=0 could not be confirmed,
>> +			 * vfio_ap_irq_disable() intentionally leaks the NIB to
>> +			 * prevent a wild DMA write. But vfio core requires the
>> +			 * page to be unpinned before dma_unmap returns, or it
>> +			 * will BUG_ON after 10 re-notification rounds.
>> +			 *
>> +			 * Fall back to a bounded queue reset. The ZAPQ zeroizes
>> +			 * the NIB pointer in hardware, eliminating the DMA risk
>> +			 * that justified the leak. Once the worker finishes (or
>> +			 * times out with a reset confirmed in-progress), the
>> +			 * hardware no longer holds a reference to saved_iova and
>> +			 * it is safe to unpin unconditionally.
>> +			 */
>> +			if (q->saved_iova) {
>> +				vfio_ap_mdev_reset_queue(q);
>> +				flush_work(&q->reset_work);
>> +				vfio_ap_free_aqic_resources(q);
> [Severity: High]
> Does this unconditional call to vfio_ap_free_aqic_resources() risk allowing
> a wild DMA write into host memory?
>
> If vfio_ap_mdev_reset_queue() encounters a hardware fault and TAPQ returns
> an invalid response code, it intentionally leaves the NIB pinned. The
> comment in vfio_ap_mdev_reset_queue() notes:
>
> "An invalid response code indicates a hardware or firmware bug. Since we
> cannot determine whether the queue can still DMA-write to the NIB, the AQIC
> resources are intentionally leaked lest the NIB page is reallocated to a new
> owner."
>
> However, calling vfio_ap_free_aqic_resources() in unmap_iova() forces the
> NIB page to be unpinned regardless of the reset result. If the ZAPQ failed
> to zeroize the NIB, unpinning it here overrides the intentional safety leak
> and could expose the host to memory corruption.

vfio_ap_reset_queue() along with the apq_reset_check() work queue function
frees the AQIC resources only if reset completion is verified; so, the
freeing of resources should be delegated to vfio_ap_reset_queue()
and not unconditionally.

>
>> +			}
>> +		}
>>   	}
>>   }

