Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6A355F46;
	Thu, 23 Jul 2026 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792065; cv=none; b=a9U8PbccZ7xeefXMDorxcyBm/A54Hou8116VMojy9+9Z/ZpWe4vNN2YoYUzpP9248ybfzQ8vjINskLcMkjmxhlKV+OIuockwdh70+3PbnZUsYPGFGh33AMOBPolHxjwz4r0woZQoSlnoZGk0uQkAZIwpJlzpjkETi8m7qhYgW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792065; c=relaxed/simple;
	bh=RqEOYvOZJ6RNuORK5PKhO5mff86XkQ6tTlYe75iv+m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWXVjo5Yv+S1ThflY/5QHz4TiWlf5R5xXo6sGlF5q522pUB3YcorC61zRCVk6AGliMueL3Cic8J8wFDYe0GdXFCvRqv6/haNxNHXyaFjWANwnmgpkymxR6weHwr9wijFDad0OJe7vRaSIPs8nNin+tdOj9oOG0BDN+H7+Ta9ZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fBhLQmMh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fBhLQmMh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5CEUC2000108;
	Thu, 23 Jul 2026 07:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bUGJar
	zH91fLJRaYXDhzA161X7iu5vC4FYApbpnRtN4=; b=fBhLQmMhSnouKnXK6roXRD
	EzRqcjUss9fMr7l9Udl6UFRImdlDfvlCk/9qXAg7s0V7JPCccQGb0ez9nIBTMwko
	gmMgMxGopeLec9sYOaQesLUmXfqteRyE7VwZXYnv7R27WPJdEIKHJZqLtDXkGyxg
	9+yR0sDydAhRj3U4I1+V/iUeem4Ce88PQ3om71+a4lIAa+0tEsL0Y+9FIrcmWLgD
	FMR1aYxPwf5MZ6O1LMsTKnHBym/RQCOAhKygSI37YLYQA7t+fhYWRqcDJ6jiXV/t
	qh9X0qB60KGNr67a70xISA37Ga3fvDgKSCKIoaxk0C4Ypra1Gi62hzepS9RAxXCA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kdt8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 07:34:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N7JjRj030786;
	Thu, 23 Jul 2026 07:34:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk33rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 07:34:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N7YIRY61473122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 07:34:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C5220136;
	Thu, 23 Jul 2026 07:34:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2D82012E;
	Thu, 23 Jul 2026 07:34:18 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 07:34:18 +0000 (GMT)
Message-ID: <ecada619-8e43-4847-8001-afcf2be7d4fe@linux.ibm.com>
Date: Thu, 23 Jul 2026 09:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] KVM: s390: pci: Fix missing error codes and memory
 unaccounting
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-4-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a61c3ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=AJ4VnbqJACYr0d-LWtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MSBTYWx0ZWRfX+8lpMJq4iy+2
 dHT8oSa9vefWapt0o/t4+qYPYKMBlp5L2SlOczHbjBJ6+qlpJQEmOF1kLlfXLpE4q060oFNGzYT
 ldXbmZ6etlOq5vqqFcOiZYQ4pgdjDy7aHaIEa7DRn3XjJ+YQMMJPz6Rnv+JYnzuvgTTLhwJUijr
 SxiNBzjfkDg7JLijkYqNRfPIgk3ziHTEKNkCw1bFY8/BnIZ/E0u/5h2Osory6PSDLQstGQN9aK6
 P/28EXtfQWNeFXpq/HNfu+gkZeyuna61oNOriMZ9gTWrJiXIKEmL5zmdWZLnFq9+RDXjp/neazv
 NvaQQLSUveBmi50fQFf+W4ew9YqAQbypr35uXfdjeEf5lmy1nkrF+CIFxHktoimVHzbJaneqDZZ
 ZhD/2u5AmppuOQAAxK3996FXhgw1g53f/AYR12uOMWaI4fFTgquijJ7njMYN3XwPxn9CLF0E0Fx
 itwkEYSpcQQb7jwiXBQ==
X-Proofpoint-ORIG-GUID: YoVF_erpkz8WepC6LJ_P5MUsYCd5s_HQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MSBTYWx0ZWRfXywT3yVDAWFrg
 iVF9LZL7HJANXgrcAYSJ/I3RkYsFxvZ6tcGkcCkIDqWYPM7NP/VUcsF4RZPmMmzDh4y68hw5ylL
 kZSonjqIU2L+lNnWN3XbSDdP80hQWJw=
X-Proofpoint-GUID: YoVF_erpkz8WepC6LJ_P5MUsYCd5s_HQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230071



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> In kvm_s390_pci_aif_enable() two error paths failed to set error code,
> causing the function to return 0 on failure. It also failed to rollback
> memory accounting on failure. Fix both by propagating error code on
> failure and calling unaccount_mem() in the cleanup path.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/pci.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 1b3114c7cfbb..33abc15aa685 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -297,14 +297,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	}
>   
>   	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(zdev->kzdev, pcount))
> +	rc = account_mem(zdev->kzdev, pcount);
> +	if (rc)
>   		goto unpin2;
>   
>   	/* AISB must be allocated before we can fill in GAITE */
>   	mutex_lock(&aift->aift_lock);
>   	bit = airq_iv_alloc_bit(aift->sbv);
> -	if (bit == -1UL)
> +	if (bit == -1UL) {
> +		rc = -ENOMEM;
>   		goto unlock;
> +	}
>   	zdev->aisb = bit; /* store the summary bit number */
>   	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
>   				    AIRQ_IV_BITLOCK |
> @@ -348,6 +351,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	return rc;
>   
>   unlock:
> +	if (pcount > 0)
> +		unaccount_mem(zdev->kzdev, pcount);
>   	mutex_unlock(&aift->aift_lock);
>   unpin2:
>   	if (fib->fmt0.sum == 1)

