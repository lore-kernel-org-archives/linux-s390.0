Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683423BCD13;
	Mon, 20 Jul 2026 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588170; cv=none; b=pjKP4sxFTTxfWn5xvo4E2vRtGiEXr8ZeoU1yFOPsPO/PrW1XKHeLLEOcGkpPl98nTS7urW36i0HQK8KYxgnWm1+9C8tYuDIfDcPLK1nVP6+OV8JUKOaOPnXXlP2s6vwqhReDssZCqehKYugZFYM5aALSRlaTKwAC31oQiyvZouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588170; c=relaxed/simple;
	bh=KZey004bi9dov+6lPhZISa/rIxnNleFPuf7zmuZIRrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnycPpr+eVJitSW9Cp6q3UHdRH5MAgGimBL6OXJu62jfvt1RPVtFE90acNNKqzzic1koFV8K8qPVqH65vqFhfsWqYM5D+eWxH3YDJxeLS+NprhdnLD7x3nLlhkrbEkU3bPPMUolqeOfJ54O+NvZydJ+Dk2XsF0/SG2we5Lj9iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBc5AE51; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBc5AE51"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfxBT3129549;
	Mon, 20 Jul 2026 22:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9TtCkv
	e46GSSKx5KRTyrQT1jmuasQZQwRdZxwVI9UcY=; b=DBc5AE518kGnP6yWgIePE8
	hjZ12XHpK2QOybDcKRUGECoYzYxUTry7D35N69dRNtDQhcw7HKxyfYgxAlYz0Lcq
	xu+tdIYl7GKwzFDDgz5bKSD9OoNbXlnrQC6o69pEU/a25vAtDf6CMcTOL8AG60D6
	e8jRH6rS3oSRUel8fYzWlbv2fmyrfFwNX45S0IaMUuxNK03pBNc0mxBtumBLVWc/
	dOg6grOBQ1lIXH7Yz2sQBljfnfgbnQWjZ5FcjBJ09IVP/4yhWNNkLxl/D2WMt407
	gRvjmahH5eE5N4+xpaF/EwheTb0jX/dnqBCgF0Ajtw2CAP30lU6AR1LAMbrVE+BA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah1fsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 22:55:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KMnhAj018626;
	Mon, 20 Jul 2026 22:55:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjqnnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 22:55:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KMts5e1770128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 22:55:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 956FC5805A;
	Mon, 20 Jul 2026 22:55:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA6658051;
	Mon, 20 Jul 2026 22:55:53 +0000 (GMT)
Received: from [9.61.240.94] (unknown [9.61.240.94])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 22:55:53 +0000 (GMT)
Message-ID: <9eb92918-ec25-4918-a89e-7209ba9d783b@linux.ibm.com>
Date: Mon, 20 Jul 2026 18:55:53 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Jaehoon Kim <jhkim@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720222238.1576-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <20260720222238.1576-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UXyQmO4lfZ0YwaKQgdPAawC4FQQNbDbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0NiBTYWx0ZWRfX46y4gH8uY1jU
 lR+7zaT21/NHobn2kxJXKxXHk37eO/LhuarwbMzAO6Ti/3oTWCpKA4IknXvT7kIAgwOWzLx2Dpo
 W1xo9KuhRpSV8F6Wju6jwWrZko6gY05bVLfaoQzKHrCTLNRC/ckJhd/Din6mSaWCpwZZ8bqfNX4
 3Kmv250viRsvg6+1tcsKXAs2ISU57AOg/ZpTXAZl20pfd74rxZiuQiC6mUZBExZrpidzNy6RWAx
 tugRfzqvJ4q0AjifYihmtRPI5IczfFJ3aTDElpq/6PgCqF/oJ2EqBM0oq4BfRidFXq+W3yBR+2M
 AVzvij00eXUgrlzDBylNB9WiRyKK3499h8rDcTXctfPpWy1eVbNSPg+SVSiZEJQ1G52dlyTz6Wd
 GxpyNiJgenj2qV2PDxtxlBAy3zZMj30k3Qzhs8iDJOwxhPPT6AveiBnItF1f907uKGOLsk4JhDe
 oRFuprEzkeDayYGHubQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0NiBTYWx0ZWRfXxxMT0OF5iT4O
 JE1l9UtCWvWqiuGnCQSVDwkCMem7vvYuMrN4xTCkumzHEHT6YxoTA0cGdu/a+7s5yLiS+DI/s5Y
 fnU4umPyHSLjXGlMel6TO/wAICpjxCU=
X-Proofpoint-GUID: UXyQmO4lfZ0YwaKQgdPAawC4FQQNbDbK
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5ea77c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ccGYm0h6Pc7MciaZ97sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200246



On 7/20/26 6:22 PM, Jaehoon Kim wrote:
> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
> irqfd adapter registration fails even though interrupt delivery could
> still work via the existing non-atomic path.
> 
> When FOLL_LONGTERM pinning fails, verify that the page is accessible
> using a short-term pin instead. If the short-term pin succeeds,
> immediately unpin the page and return success. The non-atomic irqfd
> path already performs short-term pinning for interrupt delivery, so
> this restores the previous behavior for memory that cannot be pinned
> long-term.
> 
> Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad..4b68e0cb51f6 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>   	map->addr = host_addr;
>   	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>   	if (!map->page) {
> -		ret = -EINVAL;
> -		goto out;
> +		/*
> +		 * Long-term pinning may fail for memory types such as file-backed
> +		 * memory. Check whether short-term pinning is possible so that the
> +		 * non-atomic irqfd path can handle interrupt injection.
> +		 */
> +		map->page = pin_map_page(kvm, host_addr, 0);
> +		if (!map->page) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		unpin_user_page(map->page);
> +		kfree(map);
> +		return 0;
>   	}
>   	spin_lock_irqsave(&adapter->maps_lock, flags);
>   	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {

Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>


