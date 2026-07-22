Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9E471CFB;
	Wed, 22 Jul 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735487; cv=none; b=qayZCpn8uP8ipnR1lYv4yNtLmMJO7MIdg68vtwl2hGC5G+Zu3DEDTJXn9CJjFdQ7nOJiGt6KoEZOmi4oPef5fn3r+59GKwLQh2sTXjqMLKWkICOVx4hez+jQ0ZCEx1HHeLmzFwqFao1axHa3qpiohuOsXEGu5eoIaktZWGe6Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735487; c=relaxed/simple;
	bh=qcF0YqHiRDgM09qGBYiVhPpHnpKmMfpjP80YUdirsa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6dZXAbjNClp3/fuaT1OYWsaQJJOqdmdIcqUfDWrGBVaL0nncgxo9tY0xQ2Qr8fwaMZLnZWFPojplXyJ28uZdBhLcPvjyzMx4TUywXdY3U0SM+UFlt0Wx5BtTv7L4xnXCN1I2jRTXRBml1GP9gigIq3HsdXVn4Lb5f+vwxZoXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i6D4WYvY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i6D4WYvY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfoE0382911;
	Wed, 22 Jul 2026 15:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xeiw/b
	PsnVGurN/POeVK/yb8+har/fSycGypWtG604s=; b=i6D4WYvYZuP6r8B5TZQ8jW
	5eo3cTm2f8YqrjFCkFgX7Q90bZMmSRE/q+ocDDQYOdqj80v4QuQgwr+goWJLl6U+
	EyI6fUS/ZSsjd0zIR66RQH95F4I3e0slmxX4UB5/sLrwkxGgQRhR8VaK//7ZrIRx
	C/JeAKUxIo+WUTR6GAlOO0xkfPkWorH2XTtKUH+lSzJwtULa0QQO4uXmuxuWfDqN
	hAYVnlj4yYcQn12MiCxSExCTC0km9xo26UlaObycKMEPpuZgb+jUi2LsjEW+JOjG
	mNLgxTZmkt2IJUj6rtXJzEUQGM6TCFs+DudMPahcVF1C36GUM4J+ZU8XgbdqbYEw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg79131cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:51:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFnbfI025416;
	Wed, 22 Jul 2026 15:51:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w82rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:51:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFpLGd60752226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:51:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46FB5804E;
	Wed, 22 Jul 2026 15:51:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7C65803F;
	Wed, 22 Jul 2026 15:51:20 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:51:20 +0000 (GMT)
Message-ID: <1f64ec8b-2e22-42c7-b823-74d2bc30f3aa@linux.ibm.com>
Date: Wed, 22 Jul 2026 11:51:19 -0400
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
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720222238.1576-1-jhkim@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260720222238.1576-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R3xbM5RIPeq4mNg6fGus8t10C5cFyS4L
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a60e6fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=LBtEKoR7VHDbdQP3JW4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1NCBTYWx0ZWRfX+HDqYSUUHbOL
 iPvVUsqBFUsfCHXYIIL1tZhLeL6UCu2dovHLfVcgJaPYdyYZmqkMnSfa4Sln6MowJkN1np1w7NB
 SIkwGy/VnPLhdNQhow4036lA0M4byp8=
X-Proofpoint-GUID: R3xbM5RIPeq4mNg6fGus8t10C5cFyS4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1NCBTYWx0ZWRfX2XTREPKad3o2
 a1hbg2Lp7xT3oiltVwKWiNpN8gcBrAq/OXgKzAhELr0L5QDJRzglslyGJ5dhR3Ds4lkt2ECY7Y0
 VOHJ2b0NRkGcsSfVsKo5+naTC+4XHbGgQZFDQfCmfzIrXLWLjGe68qo3YfnMCulBHyVB2BdwxRV
 FVsShHsggY4RjucQtC7LTQzHSMS/Y4eh9hKmAnWg7JXy/lZ5WDAnogQDpjEnRcxvR1R/e7ej4FJ
 yoeaSOx4yN5UXmlw0FOSuW9sYrUpv1vwMvwqod/vHtF5wA3zjxxSYQaGtDugDsd/qTWwTJaoyIk
 D4ywiF8QeSzm2nlxCwXvo7r4RWrrSYf7fbDxk1sPUPaS2MJeVzj9FjrlTfz/E3we3brKgTwn0Ms
 Tido7P0EKZLkWpiaOiuIj/S77v3Q+IXWHwtUjZH/gl2mF3InlzbxbwHM8axxjFIPvKuF6AgMGWR
 5QxuUpqRQBS1Eq/s8rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220154

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
>  arch/s390/kvm/interrupt.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad..4b68e0cb51f6 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>  	map->addr = host_addr;
>  	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>  	if (!map->page) {
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

This makes sense, but what happens later on the kvm_s390_adapter_unmap?

Won't we return -ENOENT because nothing was in the list?

Is it worth detecting/recognizing this case?  I could think of 2 ways...

1) re-doing the above test during unmap

2) stashing an entry in adapter->maps but with a new flag that indicates
it was approved for short-term pinning only (e.g. return NULL
immediately if a match is found during get_map_info() with this flag
set), and during kvm_s390_adapter_unmap() and
kvm_s390_unmap_all_adapters() just remove it from the list without doing
any unpin/page dirtying.

#2 might be a little more code but sounds cleaner?

