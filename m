Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209A274FC2;
	Wed, 11 Mar 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260658; cv=none; b=kW7Nvl5Ie6WbjDTrNz5+a/7/7yb7YkXLtz3JfJj4GvvhG2PUpH/tL/CuBGJRI8j/pU9kQl0p8h8qhcgMIRGr/N219LlOW2mVua8xSJiSxaozuFrXp8bk1eEQod/+EdJZAH46LJoghK+ku53pCGpy5HMYbx0Kj2wWeY9fU3o9IpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260658; c=relaxed/simple;
	bh=ztV2/40loRxqZ6d6XM392T8BcyEynwsv8HUGI6yGNh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S48ruA61Zukd0xPmAIbCVg5J3CoG8Y9hWKTIKe7X/9kMyotS7Eu4lXKkHsP2GYA6dKFZ6/M5GQSfp3/NL0OxXmYAwqI/ybFUl3m9B0dWkka3Xobc5eJmN+gzkQ0e7J4M3FQmyK09EoQGn3GqD9/V++91O9/A6LJ+lSIKEQ8s4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BH6LiLKO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BH6LiLKO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BEHPSe1365092;
	Wed, 11 Mar 2026 20:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nLEyJh
	toHKBpjqcR8KMxHzx//aKC6UxRxI1fsF8NyTQ=; b=BH6LiLKOCw5R6chl+o2N08
	1NivAhuaB5Yndvs+gElj4h8sBUqMsKWvNqkItv/folP/1s2QUjajJLST93kD8abZ
	5yc8k1sn8o4dmppK64yUGXWj7JXlteo+xhcoSBwlU3AXxOHsi2biYVYorQvx3gir
	xBSHOQQp3uk0iT/jVQ7nA7pklYyuBFgW6Scg9zsPseJP/JupxebVzBM4x6cwLK+9
	FwlcKE8GHifZsINuDbZM+88ikuZGEtlJ0Lu27W9No2UUDHrheJkUKFjB/c+a18/+
	1JefslBEianOiZrIqG6By3cBuvmp+d4Ic+oxA2aH6l3PrY1LSqmp6iqh63b8Vjxw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunhaeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BHe32q025052;
	Wed, 11 Mar 2026 20:24:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk6uav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BKOCPp29164212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 20:24:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2453D58063;
	Wed, 11 Mar 2026 20:24:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9274E5804B;
	Wed, 11 Mar 2026 20:24:10 +0000 (GMT)
Received: from [9.61.81.79] (unknown [9.61.81.79])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 20:24:10 +0000 (GMT)
Message-ID: <7a3c2e0e-7e5c-479b-8c92-12e16f27f452@linux.ibm.com>
Date: Wed, 11 Mar 2026 16:24:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] Add map/unmap ioctl and clean mappings post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260308030438.88580-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HahdpdxlOhyA5sOv7LTq8rKxI4tYcg1y
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b1cf6e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=eotjit3zeauIBaePo5EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3MCBTYWx0ZWRfX79UXng7ngDuA
 GcxhPibrNeThOTadPFS5gzkb2Mye6TVn48lZkwBL4szgz5GesLbLQlewnvriKT0teQm14lPfiNt
 eUOlMmMafEkxj383F0bg4x1kYF7uob6zPjFFxJEj0QwGUptkdy3UyDSfEZ8jW6KERrb8QcGbRPq
 3dGklqpwLvBdYXMozrlaZVMJmLL2VHkAMzUcKaUB/Q+/prvMCn28/H7rYeaGkgnhaI6AdS3YrEn
 YhiyE9Dxz/hNkWhIWjhT4dYF0AzabXxK/RW6llWVr92dDr5oTkRctjGVeM2pnnILIGvBphpWbLF
 RCcKbaqcG0kRktH9s3G1BoqDVcxGAeF36cmkn4kagvwtGTFDPoFTsZqnQBjHdjkt6Alximt9+XP
 VYWJKEpQtDGcDdYsn0uxCkLInEDYjwyoinTOim4mSvkTFBnZ6+tvDDDxtUlBIMvoMGqCHCTb+MI
 hDJ6z6hgnvAH/XlBgYQ==
X-Proofpoint-ORIG-GUID: HahdpdxlOhyA5sOv7LTq8rKxI4tYcg1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110170

On 3/7/26 10:04 PM, Douglas Freimuth wrote:
> Patch 1: This patch adds map/unmap ioctls which map the adapter set

This comment applies to all patches in the series:

Drop the Patch #: intro, it would otherwise end up in git history.

Also remove phrases like 'this patch' and switch to imperative phrasing
ref: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Also +1 to what Sean said, "KVM: s390: Add map..."

> indicator pages so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> 
> Fencing of Fast Inject in Secure Execution environments is enabled in
This is a bit misleading.  You haven't implemented kvm_ach_set_irq_inatomic at this point, so this patch can't be fencing it yet.

What you are doing is fencing the map/unmap ioctls so that you avoid the longterm pin in SE.  I'd focus on that part here.

And then in patch 3, when you enable the feature, you can point out that it is fenced in SE because the mappings will never be available.

> this patch by not mapping adapter indicator pages. In Secure Execution
> environments the path of execution available before this patch is followed.
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added in this patch. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> should not be incremented as the adapter indicator pages are not mapped.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>


> @@ -2477,14 +2572,28 @@ static int modify_io_adapter(struct kvm_device *dev,
>  		if (ret > 0)
>  			ret = 0;
>  		break;
> -	/*
> -	 * The following operations are no longer needed and therefore no-ops.
> -	 * The gpa to hva translation is done when an IRQ route is set up. The
> -	 * set_irq code uses get_user_pages_remote() to do the actual write.
> -	 */
>  	case KVM_S390_IO_ADAPTER_MAP:
>  	case KVM_S390_IO_ADAPTER_UNMAP:
> -		ret = 0;
> +		mutex_lock(&dev->kvm->lock);
> +		if (kvm_s390_pv_is_protected(dev->kvm)) {
> +			mutex_unlock(&dev->kvm->lock);
> +			break;

Was mentioned by the kernel bot also -- because you removed the initialization of ret above you will now return something uninitialized if you take this if statement.

Either initialize ret above or return the intended value (0?) here.

Also I think this is worth a comment block above this check stating why you are doing it (e.g. avoid long-term pin for secure exeuction guest)


