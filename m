Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC63A71AD;
	Tue,  4 Aug 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863987; cv=none; b=r1D4ecJEinWKLJ2LwMrk6G2Ny2WMe59nWKLBgbWAZMpplBPxBVPAbd3sGdt7KiUNyuM6fR9JRykKj1LnKWSlH2qx+jHfnv4WrxU5LrRpSonriA7/OFNPo7+1nQqQVUKgqmwdR76TMLMTaXebkgTK3qs1NtcSks9sRww8JnRAzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863987; c=relaxed/simple;
	bh=6Z+2I8XC/eso/JaL/01IHThkOWRBkHPuPXjzToiGxbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU7JziiE+LuCVK22E4JXdfqL/Ys+eWJrnz0RzkqX9v1RdNZTGNYwyXDrsJthhwvn7pEbk3uRSLZdUJWnTV0RLR39tkOKvvO06y3M/uTiJIfNIlyz/p72IP6++ABkNbWM9re/Nu+/HxWThJZsfZj7GW6TxQl6Bcv7TyELXu0BuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lgLpwX2K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lgLpwX2K"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlvaS1194041;
	Tue, 4 Aug 2026 17:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9mYZ8Y
	Es5r9wCQSlhuvIzJK1jsHcLg4ZUIyRg6N2+mA=; b=lgLpwX2KAEzZpFlG38jac1
	9hque3iyLINBBjVt+0IghVBl132R/GZFcQ3tVmI12ni37VGg8cCQCuOIJA9Fgx+u
	BrLLTmW3gPOdVbBfUOntPXtA8luUgwwb+2WKq3EaM4vQzchteGOU6v4GmsZ5y0TW
	ef+F7nvoATSCss1wqjwKWZsjzYyQQ2o2kx1z9Iw534tQPCULJehKlIWEgzV+DETh
	jf8q/TmId6xzSURoGYaDkqym9fniMC+Lc5ZOc61Yz+fXRQkW30Bpe30mBwkvvgYi
	Z0U+S//70KRkNPf050TRIPnpDLyKTtLQlclZlnJ24FKDsKaVOFzTCqRKloObrRNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g6rwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:19:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HBSk8002792;
	Tue, 4 Aug 2026 17:19:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhavjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:19:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674HJWUT21627616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 17:19:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F386C58043;
	Tue,  4 Aug 2026 17:19:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19BF258053;
	Tue,  4 Aug 2026 17:19:30 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 17:19:29 +0000 (GMT)
Message-ID: <a38a5883-5115-4170-b88f-57c4d6a48878@linux.ibm.com>
Date: Tue, 4 Aug 2026 13:19:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] KVM: s390: Fix old_data leak in guest debug error
 path
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
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-6-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260804162435.28617-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0MCBTYWx0ZWRfX4rpMTS11RsPl
 +4e7+rrji9xYhIVeEgiis7LS6AhqUSMU0zMEWTZ1oXCNejZOVWbugRXeaq8LLI3EQTjX94DGNj4
 PJcVCLBDU4h6Wh5g+7OTFlgtAVfxEmzV2lTFJogXpcw2+33LVeKR3FdHVV7wd96YPluZb2ao8uI
 d7Z4OOL23j8V0RFa8aIfodwATeGKnWGYBUUtMi9vGXgMKHawrvI8QHlo7kWTrVSq1JipfN3Vrn1
 YzeSSci5C7i6UN2itBfeAMj8vwtL9y8rpf2f148ewizmt8jTXBxQJN/w9sn/y2FJGIj8QmzGC+T
 uGAePRjofT4J7Y+2Cpf8SeYBTLJpyUC0cZNh6Bv7HI/96nPDogmHG3EtkiTxA6YdDWSEdem7Lc4
 mGaI29NgPr0L/Xbh2LeO9mBbj0z4HmUd7F90vRyqITqtqnhhMmgzU4LsNSdN8NMMDV6QjbdI1mU
 v+xUUtUmAiXyVUK3Dwg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a721f26 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=E40_yC0fcIR57zUHXlQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p2liktxqoHo3VrA5_rVj571c4emKmdIM
X-Proofpoint-ORIG-GUID: p2liktxqoHo3VrA5_rVj571c4emKmdIM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0MCBTYWx0ZWRfX1IdepmyL8yNe
 uFOljU5rhdHbxBnh6ImzvsaUk7NeqUQdcsX6SqPi5vFZ68lqLGGXtbEFAPbwA9UGVCVCliZoUQs
 V/WiPkjDxbLhECfHSosGALlmwCDwwR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040140

On 8/4/26 12:24 PM, Christian Borntraeger wrote:
> __import_wp_info() allocates a per-watchpoint old_data buffer to back up
> the original guest memory contents. If a later watchpoint of the same
> KVM_SET_GUEST_DEBUG request fails to import, kvm_s390_import_bp_data()
> jumps to the error label, which frees the wp_info array but not the
> old_data buffers of the entries that were imported successfully. Up to
> MAX_BP_COUNT - 1 buffers of up to MAX_WP_SIZE bytes are leaked per failed
> request, and the request can be repeated.
> 
> Create error handling for cleaning up all created old_data memory
> areas.
> 
> Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/guestdbg.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 4c02dbebb2eb..f7c94d54efbe 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -252,7 +252,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  			ret = __import_wp_info(vcpu, &bp_data[i],
>  					       &wp_info[nr_wp]);
>  			if (ret)
> -				goto error;
> +				goto error_wp;
>  			nr_wp++;
>  			break;
>  		case KVM_HW_BP:
> @@ -269,6 +269,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
>  	kfree(bp_data);
>  	return 0;
> +
> +error_wp:
> +	while (nr_wp--)
> +		kfree(wp_info[nr_wp].old_data);
>  error:
>  	kfree(bp_data);
>  	kfree(wp_info);

