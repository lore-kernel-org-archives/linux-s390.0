Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9A4B0497;
	Mon, 17 Aug 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995731; cv=none; b=pGySoxvifv7IEu5CVvNNqMBXrS4N+rKgSo9jiDU+yEDWkoeJR86EUDtV4wcxzHAgqacucAaCKMAYN8SEWcVrclwAK9095HMq3tto+fWnxMlgHBvShruk668i6jOThPvcd8KhUWyAAKIzX/Kimn/kxLwtdFVw6a8uYWgcno33Dsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995731; c=relaxed/simple;
	bh=msaCP7P7zFsk3kOA4Xyn44FuBrLd+J03e70RcS9Yieo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdvYAqM8if8YTbr3QXHJ0Xf8oXD9l5nfwksKf4X89vmGOjSzoKO9ovNtSBPIO9pHvM+zwZN0ohqrns0PtU/rZXPVdnfWhv8MIJsw0GVssbr6ja7K13Qe08CvU9IMDi9DDPRZN1ipMwztga+uhvBL0xKvsB5kIIEPNOUEoHuMCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JV+RvCiw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JV+RvCiw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVuXH2219740;
	Mon, 17 Aug 2026 19:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zPCe7A
	2QtQt6XRLidm5ze7lmVYujpyledUoYcfOY3Bo=; b=JV+RvCiwsNmTDb5Kgq7SUk
	CmNETO4lZqkvQnxAQ+flz38dMfE7nA0V5koc4Uo34h9I4yZhG268A/wy569fBn4A
	XPVus+bUtI8mvbYdprLxq41q0PbeW3jg5oYkygy6Sj2UCK8ZycSUutRoIyboz84V
	y/KPmKRmhPfG2mE1SRHU8/L3XhvkrMrb3C/H8G+FzCxcdlu62RDLKG9R2ex2IDLi
	IszGBy0srA5Qdg4ICjdi5EGyA8kvPg3gMzX7URvKmyLAxCcD5XhGrwU3+0dGzBJG
	PZRHXWzRbzK1jBMyrgcBwOFc8QaE4Nqwj2tLByyCBvb88Il8lk8N15uaE5cRaIEw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt3kg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:41:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJfICN007910;
	Mon, 17 Aug 2026 19:41:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng78e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:41:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HJfuCn33358446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 19:41:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE5315805D;
	Mon, 17 Aug 2026 19:41:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADEB958056;
	Mon, 17 Aug 2026 19:41:55 +0000 (GMT)
Received: from [9.61.135.106] (unknown [9.61.135.106])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 19:41:55 +0000 (GMT)
Message-ID: <a60a38fa-8aad-4cb6-ad42-5bdf8d9c132f@linux.ibm.com>
Date: Mon, 17 Aug 2026 15:41:55 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-10-akrowiak@linux.ibm.com>
 <3f1e1e96-fa32-407a-816a-d884b97b9961@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <3f1e1e96-fa32-407a-816a-d884b97b9961@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a836407 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-hAh2JgC421wSWjpc-oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfX76DGHc03uf81
 BmhJaxfYiaMhUA0ev+zWw1mbcT5YrAeeF9kvbVyBvxKBHEWZAJdAu2757tch6PeqF9pFFQLG7IH
 vhohP8heBUkkCe/S9IX1uW8PFwChDG0=
X-Proofpoint-GUID: aHroIs7fNnMxXA1q6k9Sm_SqqTDBotVM
X-Proofpoint-ORIG-GUID: aHroIs7fNnMxXA1q6k9Sm_SqqTDBotVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfX6KGbx+yULaKd
 +J0PGQANLdpKv/m/M3OdZzMANT+cR9HnIyb+vAZVoBLeAfuUCNx1DoHVrfi8eMt9oRMlG6XISTq
 D1jLEUxGfw9NV+YPOMlmc9KaTTCRDGPsVi5S8AOyd+H8ns9hYGh0pd8Dp3a7UdIprS/8Gd52f+G
 VdNdlgllh+C1KwIZYR+dSgA7D8cU9KLxW6LzYvpJmpuitcb/TPr+sQRUt4ojRkv1rLdFWgYWSFo
 7OoSpagC2j2PXtU27ohVzDgwu8Ghm0nYizRgFpHNbeeSyyTsdXrpTU+3BNLiCpMucwrkPpPzk+G
 KJKjY+NlGzZAYy3xAUBV6oWO4YxAgFbj8RrJII3sjjsbjRph22NdFSAwaJWXC52Gi07Z7o06HGn
 XNL7TzYbG+YVQiJUs+xsvQmnICB+W00abHd4CIRKYUlBxfD2tT9D6YvtqDBZup1L5c86xKQaqE8
 ykNncqftrOsQTG0ylbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170149



On 8/12/26 5:12 PM, Matthew Rosato wrote:
> On 8/12/26 4:02 PM, Anthony Krowiak wrote:
>> When an adapter or domain is removed from the host's AP configuration, the
>> AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
>> driver. For each ap_matrix_mdev object to which the adapter or domain
>> is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
>> adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
>> configuration) and hot unplugs it if a guest is using it. The new host
>> AP configuration (sans adapter or domain) is then stored in
>> matrix_dev->info.
>>
>> When the AP bus subsequently unbinds the physical queue devices associated
>> with the adapter or domain that has been removed, it invokes
>> vfio_ap_mdev_remove_queue() for each queue removed. At this point, the
>> adapter or domain will no longer be assigned to the
>> matrix_mdev->shadow_apcb or the matrix_dev->info object because they would
>> have been removed by vfio_ap_on_cfg_changed(). Consequently,
>> vfio_ap_mdev_reset_queue(q) is bypassed and kfree(q) is called
>> without executing vfio_ap_free_aqic_resources(). This indefinitely pins
>> guest memory (q->saved_iova) and leaks KVM GISC resources (q->saved_isc).
>>
>> Note that resetting the queue would fail with an invalid APQN error due to
>> the fact the queue is not longer in the host's AP configuration; however,
>> it is still necessary to free the AQIC resources. The fix here is to call
>> vfio_ap_free_aqic_resources if the adapter or domain is neither in
>> matrix_mdev->shadow_apcb or matrix_dev->info.
>>
>> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 1edd0b7a3cce..bd9d239caeba 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2533,12 +2533,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>>   	/*
>>   	 * If the queue is not in the host's AP configuration, then resetting
>>   	 * it will fail with response code 01, (APQN not valid); so, let's make
>> -	 * sure it is in the host's config.
>> +	 * sure it is in the host's config. If it is not, then free the KVM GISC
>> +	 * resources.
>>   	 */
>>   	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
>>   	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
>>   		vfio_ap_mdev_reset_queue(q);
>>   		flush_work(&q->reset_work);
>> +	} else {
>> +		vfio_ap_free_aqic_resources(q);
> Re: the Sashiko finding for this one:
>
> [Severity: High]
> Can this still trigger a WARN_ON and leak KVM GISC and pinned memory if
> a guest shuts down or the mdev is removed before the physical queue is
> unbound?
>
> I think Sashiko has a point here...  At first I thought it was a
> pre-existing issue (just another path that fails to free resources) but
> I think this patch actually makes the described thread of execution a
> bit worse:
>
> Before this patch you would leak resources on the described path.
>
> After this patch, you will leak the resources on that path, then reach
> this new else statement and could potentially now WARN about the null
> pointer(s) in vfio_ap_free_aqic_resources() and still not unregister the
> gisc and/or unpin the saved_iova due to the null pointers.

This is a legitimate concern. I will fix this via an individual patch since
this 9/9 patch will not be included in the series for the pull request.

>
>

