Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FB352C54;
	Thu, 23 Jul 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789834; cv=none; b=KPKS9wJqNVZXgYSNkA1pFdfR+xZ0cQjVWGYCuopha6vAc9KKu3i9/qsoqY2tRW7PlzUltJ50lOzZNsAybITdCOlmWbtO2Gq410gkXWdBZQOw3cbMFtJs/G0U4LTqSpwAURsU2MNFUqLHqvcCwIhM/oKFXoPGnLImWiOb42y+DDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789834; c=relaxed/simple;
	bh=ma1xMwS61hAfFTuKqTX9HZR3LWPR32KLhXSfXiVkxAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZifTRGDwX0M6eygFi5H9/n4TKL9jSWhnWwiC4Pk46pGhR6MZZehRuj2fQtpIjwPGZ8/dH05lsTsPD/XhVCWUMg4WUssFZX5wP7YsWgtAY9ulZwehelvsysQdSVLo3khmkfdSn3rdasKAvaDa32HVBCwISNysqIi2dsrfwpeZKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ETdvE1Yf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETdvE1Yf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5Cgnm2080020;
	Thu, 23 Jul 2026 06:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jl1qpW
	Sk2ajutbteAJGpVt5I/Zd4q9TwWLwfFuHVTzI=; b=ETdvE1Yf+Frm3ZlonhyvwR
	hgMQR8QZ9kXW5ZS5BllH2kUU/uroXMy6k+fc9imnTgtVwf5ukaQp+KId9IAEwzkt
	Kn/aBL7qaHKnUaCVymzYiR+cfsIYgeRapU8ECwvyimPSHaMQGEdQDFfVL+J2LL1S
	kTPJM2W5DPtw1bhkvBGiXrlo30L/0JVvkw6KNGVDYqYlp+kNiIrtC9Bo4KjlygEV
	43DNisLxA1f/6xb0RYBcbiROooB3X3k8axU/1oYOJlDSzfhuA3tU93htDt37DanB
	PYJVdWrzUCMgV5RplbANNcJAhwD9amnRlGwvLQfzOJbE/3GrTNmsWbNoGs58kF4g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahdm6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:57:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N6nbMW031508;
	Thu, 23 Jul 2026 06:57:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyjpq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:57:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N6v7sL44826908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 06:57:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0828D200BE;
	Thu, 23 Jul 2026 06:57:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C184C200BC;
	Thu, 23 Jul 2026 06:57:03 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 06:57:03 +0000 (GMT)
Message-ID: <09975eaa-6ce9-4e42-a53d-186eec4b400e@linux.ibm.com>
Date: Thu, 23 Jul 2026 08:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dgUeE00CoIuUsxYjchh-cldGa9-LIOAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NiBTYWx0ZWRfX4oBZHnUXNoN/
 xkoWhiNJ6LH5OlN6OIV64mgYbdkEcw9JG6mPD+AiDeXUKpvRSfX3XdcP8MPaIRIumbnEk68RmCz
 lS/kRoUpebAbWZZ0yxh+zG/5cwsAmrSguJo8058OnS19cIQOwG6pPGcCufyGMl1pTyuOQV6WG6T
 sOqH8wCMPydjKT5Uj8cUW/LWos4vstA/FUUiB5j/PF7B6J8uJqE+FupV+ZWl/MXlGwrgwBEkuey
 r4XpSTX2pFslKX49rIFweVphQtTz1O4UffEm5J+uCCabSGltqFvt2cK4maoc9Ea9Vgyt1GrBFRd
 LVHknRt3AFcaB3RKB2XX4cmRntpBbYQhBBODEQNYuUsHS6VCBIONDjoxUjdGyIAd9F52sio9own
 XUv6sqUdrd73ovsxIbzquezokLbExIh8jjsP8b9QybbQIMrWM71U7FrSIqA3hhO89oNSe0Q4cPD
 qn6KwAj2IUpNw8/yfeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NiBTYWx0ZWRfX6wHYotmR/ytD
 o47xEaaL4YSznRc4RX8AQ+sbk9VxNdGII3vzNLKYtCGsbIaxGHkwi2IdSLuk3nU1iQsSPcQ+HuU
 EAgE8kUuCboHJEwbvN129zITRg9Tlgk=
X-Proofpoint-GUID: dgUeE00CoIuUsxYjchh-cldGa9-LIOAl
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a61bb47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=qxKs3NzHoDzKXk5AtTMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230066



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> The MPCIFC instruction doesn't allow registering adapter interrupts without
> first unregistering. So reject any request to enable interrupt forwarding
> if its already enabled for the zPCI device. This also fixes overwriting and
> thus leaking resources when the ioctl is called multiple times for the same
> device.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   arch/s390/kvm/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2..d2a11cdf6941 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	if (zdev->gisa == 0)
>   		return -EINVAL;
>   
> +	/* AIF already enabled for the device */
> +	if (zdev->kzdev->fib.fmt0.aibv != 0)
> +		return -EINVAL;
> +
>   	kvm = zdev->kzdev->kvm;
>   	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
>   

