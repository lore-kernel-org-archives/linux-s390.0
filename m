Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F247D92B;
	Tue, 18 Aug 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080042; cv=none; b=g3IV+5QnXWFLkm15yv6Xrc30PAVEhcNFCn1C2a3OLLgRe1lK+lApQrwUuK/nR+ULOTw6BdiVgEhzkIjkLDZFxYEAQHglLLhaoPwzjB8z56JSGeVeAvBEwxMECM9AVFvprAV6qX6Kpzw+X/ePTL8ISH39fWtCmyHKLUAyryC9jhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080042; c=relaxed/simple;
	bh=DIC3ogbwlRw5DIplTh4dM5qo/YRRPy9RCpRbYf1ghrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtQJRJ7L/xUNKIweVXRGt7cd579pLYRbBNG+sftWLiNNFOlYhjcohHPumnZnsqX8qdawhw0yrUzpJxJmO7DXlZZ2V0o0Mm4mFTzJRJMmUXRVNe8QJZlJ7cfbxWgdxR2h6hXeC78w7wGeLp2uJVhOTNXSNpFRjnygLGKZIrqjJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XhM0sP9I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XhM0sP9I"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHWAG2933882;
	Tue, 18 Aug 2026 19:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SGNvsa
	l9Toue1p95iBIox5/cECFkuAf1F2NW5w2DLuw=; b=XhM0sP9IOpETl8k5U8vr41
	DH8ZN0gtwlhHqXonAA2EqIWT9rzP470DRfuLxPCKUxNh9G5seW73Q0vtQauAICSu
	/jcCALeq9owwjaWGgrC078T/zYQV9ilPPfUaQCPqi6GYBLRQROQ1qZlP218g2/Mc
	XWE/nVdcPCqfu+aLRpSRKhvRpqy52r9qqIMsTK9NW9CptwQZTZ3PGnziHDhbaWWP
	2Fo+kSV8P+ipfvfBrcV0n48m/wH9olMZiszanwDnYo79sdkFjechXTAFsxEWfCrn
	NSt7vu4YsnRQTNPr+mgC6oaDJEwlKTihOkZQ8uppKNrvvfPRycf4LjNfXoR14saQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3tbyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:07:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IIuKju010617;
	Tue, 18 Aug 2026 19:07:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ycqp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:07:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJ7Bhw29426318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:07:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E3D58065;
	Tue, 18 Aug 2026 19:07:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 617EE58052;
	Tue, 18 Aug 2026 19:07:10 +0000 (GMT)
Received: from [9.61.26.94] (unknown [9.61.26.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:07:10 +0000 (GMT)
Message-ID: <fb03ed1a-3da3-4d82-a8b9-92c135d747f7@linux.ibm.com>
Date: Tue, 18 Aug 2026 15:07:09 -0400
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
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ym7k2CPXtnxz_IWR8uYAxbRPAS-8bZnP
X-Proofpoint-ORIG-GUID: Ym7k2CPXtnxz_IWR8uYAxbRPAS-8bZnP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfXyp2dAcNEh2RU
 SCtUYB8q5GJgwnGyRjawB41If2njBztHfF6CgeK2GEc0lhcj+L/XWI0J9ve59E5VHFQM0usTdtJ
 bV8C3yIZiXt6ABmj7xYDNUYzAaJU2Ng=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84ad61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P5o94yUMNGGiSLQdnMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX2O8U4k3QJIyj
 4oWr0nnVKtCknVyN465AQoKbkgM5wqFly2g/50gKtP3qY4W6bZjiY98oU9+mWhJum/WXzICQANB
 FcARI3oiopdUiffHF1ymqBShq+qqybfyUJiqoPlJ/XcHnXJAqoGUTGziaLAvkaiOvUB23OFe+49
 97GTEJqhMwve28lQFILRPZUe3ZTqMJorFv67qee2IPjJDUW4IOXwodR/XlbRZT0ivbD+55tJg0T
 1DpoVf7GuJ6mU0VkbnedAz/eXVzwNjD76xanPPRajg2IbRXQAdm1TC71BUkf0okOBVly1WypOyj
 CJNOj66hxJw2wmAuoEQUKyaZknqrNH2ESA2b8xg6OAm21D1jvFI0nSIZS+0hEwM5gbZNKCHElEU
 goZwS8xOy94gNy865DIgjmmJNo3hsBo5M8uHBuXjX1a7Hon4s7ILNeODdVWx3KRsFfPvYJoBg/F
 NyIDl1E9mysjfo1d05w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180140



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

I meant to version this one, but it slipped my mind by the time I created
this patch.

>

