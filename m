Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BC3115AC;
	Tue, 18 Aug 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080601; cv=none; b=DFRVX8igCqGQ6eU+2rF4XfaJf+ng/90FdLcgMpLmrjRIsJN7TAZVRo9mt9TzrVxFKLG0XWQpdjycqutiBnHyB7vzvAcQAFa4NyNIPfTTF/x36GuSb3eisgvqISj1ny/2HxBwO2kiuTBrhHivpJTg36iTPNNAie158SkMinRTmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080601; c=relaxed/simple;
	bh=gDFH+XjE5QIm5tvxucY09olIi5Bp4gHBeLUG/M/MycA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCnAFS6t3b8c3ZzgNQB4uQpdxw9nmpnro0aADFfujyxMFSZW8GmaGGDMs+38j36vHbS3yFeG7Bx8+EU9gEAEXrlKfgGlN/kdCeEeuwPON24Bio4Ep7dWYo/9DEh4QAhUKM3M4D5pTeTI2OCE5lkIaiQcn0IUeAO2Rd5v0LHFkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b3Ej5yOf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b3Ej5yOf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVjB33307195;
	Tue, 18 Aug 2026 19:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J0CX+p
	kzPUoaXlRK/iseroW2RKfpri41KVBpIYDYSTY=; b=b3Ej5yOfnmATr2KhP/saRl
	TdXsIM7YtMbHCA7IKYSZVOc9eBrVX1wfNjnbZ/lbsv8EIDyeTMseSybCaq2D+0x8
	RtHolFi6bGrQDw/PJnUIbtXzOMY+5LLKBaFAYCFKTZmcNBu5XanaGpVgVH4i5knV
	G5e8bDi9it+s0Tt2l/wxyLVOuN4ioBQS4f+SJAd3zFjSc0aJh/a1JaLYC1jdpvvT
	1ZgECM+6Sf2oUjTzxElFYfK8yP2pThOU1vtXVB3GNEdPQDuilt49N14Edi1Ke9X3
	BU1IH9xIK1xbrTvJP9RA1KEsa3OjXPiu035fVwSICQbPmVzQkaxI0hDwpk3NZ27Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtctb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:16:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJBJ3f029774;
	Tue, 18 Aug 2026 19:16:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngctt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:16:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJGVP230147112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:16:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7594A58069;
	Tue, 18 Aug 2026 19:16:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA7858052;
	Tue, 18 Aug 2026 19:16:30 +0000 (GMT)
Received: from [9.61.26.94] (unknown [9.61.26.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:16:30 +0000 (GMT)
Message-ID: <2404fd93-9b70-4ef7-8967-6006a5d98b8a@linux.ibm.com>
Date: Tue, 18 Aug 2026 15:16:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260818115819.1656595-1-akrowiak@linux.ibm.com>
 <a45d4bbe-21d3-43c3-9618-bea56667ca17@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <a45d4bbe-21d3-43c3-9618-bea56667ca17@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX2PbvHfIibCZU
 hyvVTTaCPnaOvnjz9OLBwArPtRgc5jZmroMDbsjlTvpqAd7wxAlgxgNRK5bftPrDZzg8R+JYPWN
 k7U2LnqC7fXSQodnieSip6ZQ5PtxuuzxoA8i9lb8w4Vy+BkhyLZNaX9SwkAnQ/pyuMNKKV1gJ+T
 VbkjD9lo8SWRgIAnpRdxDtcVauv536ckOZq9SQE/LwvwrkTiXNufF3MQfcqIN5NiKNTVetkBad5
 fAUq+ur610U5AOONB/leMsWlw2p4E6RlqCpew7HMH0VKIeMR3YVZZeUvQYVGvgtVKOTgrdpB25l
 gLs2BgeU0LcZ6Hkv3zBwU/Y2PI16vw0suIixTQ67z6ILr2WgO7INXiob8AloMKoo0Mri4LRvdmF
 6HO8ltQuwjsX7vCJD5nF8JFwlyk/7h1/rxp+8bUfF2RUq8POwa1gIk99Lzm5VRbWk5ngttgatOU
 zb4GQ1l0aOHWNztDp3g==
X-Proofpoint-ORIG-GUID: WI3RAu-8sZn6rqexXyA0oCX33nn5EHz7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX6luzpBt+j2Ej
 4+gtNh5o1qKjpEtBBZhcqNWFfi6VENHM4l1jsDZ8IDg6OS4/EUdN7GdCDQdLO27o/IDwnrF/ImV
 9RtHeZTn/wv3oRbx92eYjnbudjW5IlQ=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84af91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P5o94yUMNGGiSLQdnMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WI3RAu-8sZn6rqexXyA0oCX33nn5EHz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140



On 8/18/26 1:32 PM, Matthew Rosato wrote:
> On 8/18/26 7:58 AM, Anthony Krowiak wrote:
>> s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config
>>
>> Two related problems exist in the handling of KVM interrupt and page
>> resources when a queue is removed from the host's AP configuration
>> while assigned to a mediated device (mdev).
>>
>> Problem 1: AP_RESPONSE_Q_NOT_AVAIL not handled in
>> vfio_ap_mdev_reset_queue()
>>
>> When the AP bus removes a queue device whose adapter or domain has
>> been removed from the host's AP configuration,
>> vfio_ap_mdev_remove_queue() is called. If the queue is still in the
>> host's AP configuration at that point, it calls
>> vfio_ap_mdev_reset_queue(), which issues a PQAP(ZAPQ). Since the
>> adapter is already gone from the host configuration, ap_zapq() returns
>> AP_RESPONSE_Q_NOT_AVAIL (0x01). This response code is not handled in
>> vfio_ap_mdev_reset_queue()'s switch statement and falls through to
>> the default case, which issues a WARN but does not call
>> vfio_ap_free_aqic_resources(). As a result, if IRQ handling was
>> enabled for the queue by the guest, the KVM GISC registration and
>> the pinned guest page holding the notification indicator byte (NIB)
>> are both leaked.
>>
>> This is fixed by adding AP_RESPONSE_Q_NOT_AVAIL to the same case as
>> AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED in
>> vfio_ap_mdev_reset_queue(). Like those response codes, Q_NOT_AVAIL
>> indicates the queue is not operational and no further reset attempts
>> are possible; the correct action is to free the IRQ resources
>> immediately.
>>
>> Problem 2: vfio_ap_free_aqic_resources() leaks saved_isc when
>> kvm is NULL
>>
>> vfio_ap_free_aqic_resources() guards the call to
>> kvm_s390_gisc_unregister() with:
>>
>>      if (q->saved_isc != VFIO_AP_ISC_INVALID &&
>>          !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm)))
>>
>> If matrix_mdev->kvm is NULL -- which can happen when
>> vfio_ap_mdev_unset_kvm() has already run and cleared kvm before a
>> subsequent cleanup path reaches this function -- the WARN_ON fires
>> and the entire block is skipped. This leaves q->saved_isc set to a
>> non-invalid value, creating a potential double-free on any subsequent
>> call to this function.
>>
>> When kvm is NULL the KVM guest is already torn down, so
>> kvm_s390_gisc_unregister() need not and cannot be called; however,
>> q->saved_isc must always be cleared. Fix this by separating the
>> kvm_s390_gisc_unregister() call from the q->saved_isc reset. The
>> WARN_ON now guards only the genuinely impossible case of matrix_mdev
>> being NULL. A NULL kvm is handled gracefully by skipping only the
>> unregister call, and q->saved_isc = VFIO_AP_ISC_INVALID is set
>> unconditionally whenever saved_isc was not already invalid.
>>
>> Additionally, add an else clause to the host-config check in
>> vfio_ap_mdev_remove_queue() to call vfio_ap_free_aqic_resources()
>> directly when the queue is not in the host's AP configuration. This
>> serves as a backstop: when the AP bus fires the driver .remove
>> callback after an adapter is removed from the host config, the queue
>> is by definition no longer addressable, so vfio_ap_mdev_reset_queue()
>> would always return Q_NOT_AVAIL. The else clause handles this case
>> directly without the unnecessary ap_zapq() call, and ensures cleanup
>> occurs even if kvm has already been set to NULL by a prior call to
>> vfio_ap_mdev_unset_kvm().
>>
>> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
> For archive purposes, this is a continuation of
>
> [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed from host AP config
>
> https://lore.kernel.org/linux-s390/20260812200240.818004-10-akrowiak@linux.ibm.com/

I just noticed that I had a commit editor open for this patch when I got 
back
from an appointment for which I had to run out the door. I added a case for
the AP_RESPONSE_Q_NOT_AVAIL  to apq_reset_check() for the same reason
a case was added to vfio_ap_mdev_reset_queue(). When 
vfio_ap_mdev_reset_queue()
has to wait for an asynch reset to complete, it queues the 
apq_status_check()
function to a work queue. That function calls apq_reset_check() to check 
the
status response code which also did not check for AP_RESPONSE_Q_NOT_AVAIL
and leaked AQIC resources. That patch is forthcoming today.

>

