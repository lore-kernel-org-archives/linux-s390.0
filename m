Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639A32AABA;
	Fri,  7 Aug 2026 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141461; cv=none; b=UhgZadB+sO3VoueR3poKiy556z3BAHjs69uClmXUL/zSESXL/rpnYAVVmj5fLCE4EjHnPRvpXySlE/maPir4GMauk/fPIO6J40cG43flMM0wrmMXb/QVMrWZxdYniS8TVRzoTrRqG8tZE3KaCp5UCG85op4bm4ZY6Zj/afDiEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141461; c=relaxed/simple;
	bh=qMApf8/r8k+9I6U3KMeL9wpTmrNmqsHA9aMcFtc9c24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuGPm2j4cMnvC5UKxTaPmVor5Dr0Q4yyHvlAWeczB8u5HPatOAXRrAHpkn4SR6HQCN36sUZ3tMdS9zYmY0R1OOusPGYsJA1d7MU2QbTM0vevTlx9+5hDHlaZmOY94A4GT0J14EQUigdCs9KtBVCP4LLRwP+9/BZhxPtNAAWvx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sjyfqrTk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sjyfqrTk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lm3sP2720883;
	Fri, 7 Aug 2026 22:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3eCGCC
	sE1S6A4vPFlYqOq5/QfSipUS+9aoDyPIprE9k=; b=sjyfqrTkPmr+oXOW9rTmEd
	r/j0JPO7512wJfO7KaHlcdTxx7kP090jXRwHknFQfO7ptyc3dDijvkbE0rhozz5w
	yfSdzjVYiQRIpONPakJ5Umy6d1HB8w9sDJRmZTcrz9gegWmyCLEt/wtEOmVp0C7d
	EcSxlDXO6O42dXbd13v1jEuw136sQFx1DSGiYaV4jp4mawAkLHHSgy0zgir6hIw0
	HIN7fVrOb4mjkBrQXOZDELW1WrmN3ggXpYpj6Bix6NzLlAbFYU380+5AOG5Hnc09
	Pt1wvly0cbQ8Xl8UcqnFbZBghAk21pAuBnQ2tGM4WWEWh6fTqwprvk697mH3lHCQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00e1fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:24:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBYPL020039;
	Fri, 7 Aug 2026 22:24:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu01fav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:24:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MNcn162259494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:23:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF7F658051;
	Fri,  7 Aug 2026 22:24:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 311DD5805A;
	Fri,  7 Aug 2026 22:24:15 +0000 (GMT)
Received: from [9.61.52.19] (unknown [9.61.52.19])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:24:15 +0000 (GMT)
Message-ID: <3a7b85c4-60d5-40d4-ac86-0fc52a06fe47@linux.ibm.com>
Date: Fri, 7 Aug 2026 18:24:14 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Fix dereference matrix_mdev->kvm without
 checking for NULL
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260807145416.322916-1-akrowiak@linux.ibm.com>
 <20260807151809.CEF971F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807151809.CEF971F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX96/7AXBCbR5W
 2l0yTkfqwstZWjJpgTJrGSsAdJBPzo9ZTvMq9B9JgotTYDYP3LTTbc84xiXBAxDIEATfOBHkcyW
 67iulp4r0FjmPOl389IC98Ez+1eCOzM=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a765b12 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JT0hu9nXDTssBxdbNd0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pxOBdcaa7_ROJkLt9ijH9GjJ4pDgyPm-
X-Proofpoint-GUID: pxOBdcaa7_ROJkLt9ijH9GjJ4pDgyPm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX2CutxFaHABi+
 qCO0M5WML0BggbTgslL/qEGlY15a6+LD0dilkGnNaCRRCJ5BryiwpwpwqcML8bGsQgZAiPBNWFt
 87laXBXVGfkksJwlOrAmsr7F4VUQdj6VyFDbopgRKj8B7btg6B30xV2MynJNYshqaQ3oREPL+pY
 1sxVGeFCH3asnb0L/cLMTOMMCk5fz43VftCCcioRds8WQbkL34Z3ryyaX7+bQd7YrsXTLn7+tAL
 sF4qsbjzYGuurDYey3Qj+Pr7bY9yLWdLTKyA1KLNBvmthAm7pgh8m1pZdZX7hC1ppnGXO5eOwpe
 BUQEoG4YjNYckM+IL1wSH4Hks15Gtg3Se0VuL0mC0tTb/2CzrKiZhuM2AFDC+ExD+leQ68LhTsZ
 EDx9wNbdTANZrFQ+6YpoVrcOMByjDEjIckn6N3odnkHfjV8CdgdnD+JQ+R/dHSlUg0XEbNznHsc
 ryhTDB+YbSyrBET2AcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175



On 8/7/26 11:18 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incorrect bitwise operation `bitmap_andnot` used instead of `bitmap_and` for control domains in `vfio_ap_mdev_cfg_remove`, preventing removal of unplugged domains.
> --
>
> --- Patch [1]: [PATCH] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL ---
> commit 7ae73def648a068715a8cdb4bf574ac5755f8e77
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
>
> This commit adds NULL pointer checks for matrix_mdev->kvm prior to taking
> the kvm->lock mutex in the configuration change and scan complete callbacks.
> This prevents a NULL pointer dereference when the matrix mdev has no
> associated KVM instance.
>
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..a0b7c37fee281 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2606,7 +2606,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
>>   	int do_remove = 0;
>>   
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
>> -		mutex_lock(&matrix_mdev->kvm->lock);
>> +		/*
>> +		 * If the mdev is attached to a KVM guest, we will need to
>> +		 * hold the KVM lock in order to update the guest's AP
>> +		 * configuration if any adapters, domains or control domains
>> +		 * have been removed.
>> +		 */
>> +		if (matrix_mdev->kvm)
>> +			mutex_lock(&matrix_mdev->kvm->lock);
>> +
>>   		mutex_lock(&matrix_dev->mdevs_lock);
>>   
>>   		do_remove |= bitmap_and(aprem, ap_remove,
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential logic flaw just
> below this context in vfio_ap_mdev_cfg_remove() within
> drivers/s390/crypto/vfio_ap_ops.c.
>
> Does the control domain removal incorrectly use bitmap_andnot() instead of
> bitmap_and()?
>
> When a host administrator or hypervisor unplugs a control domain, the code
> evaluates the removed domains using:
>
> 	do_remove |= bitmap_andnot(cdrem, cd_remove,
> 				   matrix_mdev->matrix.adm,
> 				   AP_DOMAINS);
>
> Since this evaluates to cd_remove & ~matrix_mdev->matrix.adm, doesn't this
> mean assigned domains that were removed from the host will resolve to 0?
>
> Could this prevent explicitly unplugged control domains from being removed
> from the KVM guest, allowing it to retain access to hardware it shouldn't
> have?

This looks like a cut and paste error from long ago. bitmap_and should have
been used as it was for the other bitmaps instead of bitmap_andnot.

>
> [ ... ]
>

