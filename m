Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549333EC82B;
	Mon, 10 Aug 2026 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370506; cv=none; b=mkU2X7gRzv8TcMDeryp4kRr3BWSwU1u/pKkxSbgsHYGBlAjwANcEuZZE91O1ErXpmHvSVkiz/G3nlv6/ZsYWswQL1+O687QMIfa3PsTEid07g6mJ7yIsZNtHJTsSOfzB0/IIbS6i4zh0Am6GtyR8owpeANHPkBQ51F/8MUyhois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370506; c=relaxed/simple;
	bh=peW8pM+WMoaY7r9LbwEzr3HRwt8R7QPFvzc2a6qwE7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/klh0NFV6q2LbSzHrIkwaQN2VyiMA/0RbJh4NE6FsubtYX0jEjud4Hhz/1Ek7k2BRtqYWIyZ+Ya0FhqEWV/db7IfHCKzPoXqxV6z9B5CNbM3wGJFnun3bcdWWrW2iMqWPooX3a+pQCjbt0/HXS+b0US5VtBqV/fvQjTTHTvGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obiJ+oq4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obiJ+oq4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1U5K1651670;
	Mon, 10 Aug 2026 14:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SAs1F9
	tLzoANym2ZxobCsecZP4fv35MXPDcTK3UqS3Y=; b=obiJ+oq4UJfMTsjp+uo7g2
	5HJt5ulFBm61KorCDAWAtIIgXe4ruxspFr3DpROdoHyrKHKKn9spzk6DfYk2AdFN
	4/ZNQsJ6gFzH/2HqxUBG04zJM6+SplGjhFugmS7MIvJnBx7LuPRMYeczLI12lgec
	dL9qIUfGTCZlTiPC8w9sHdajFz/y3O6pSNH3ulgT76ym9fdVeivL2mAwHMRJ5Wvc
	YvOw18oPR7M+qNEieOZlbwIigXN6ZsmhDQemeEqg8K3xJS79OwLJ8CxmIQU8wNJ+
	C2upuHGZObdVJwqdfWf8CIjCG4C8DnOjkfXb6h+XDJu9bx3qQ5wGlccHUXiT+dqQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq98936-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 14:01:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADuJZO018132;
	Mon, 10 Aug 2026 14:01:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vw506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 14:01:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AE1WDE13894326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 14:01:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2A658056;
	Mon, 10 Aug 2026 14:01:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9728758064;
	Mon, 10 Aug 2026 14:01:31 +0000 (GMT)
Received: from [9.61.71.153] (unknown [9.61.71.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 14:01:31 +0000 (GMT)
Message-ID: <d557661d-089e-42e0-acc1-dccf78cfdee4@linux.ibm.com>
Date: Mon, 10 Aug 2026 10:01:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-2-akrowiak@linux.ibm.com>
 <20260808174955.163381F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260808174955.163381F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a79d9be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WTSKiRRyFRq7Fope1AMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMSBTYWx0ZWRfXxQ0JgNyptqBb
 Kw6FgGhb3NpOJj2lx2PoCk4xyDCoL4N5MLqMW192+NHNjQJwkxxgDurPsf5tFLbsrd92YnbYrfh
 6G2DbhaWf/OvAXp4TN0iL6DHv8qgfFqO2Nl9pohzuay5RF2wKpCoLQGiXMWB4NEkrim5tfDya8c
 E7uf97kCfN7BjNSM3ocPydGJtr0fORD21+UD9sYOb3Yjk9j/7W7T+gEmTBaulmGNJ0zE8kgp3Az
 w0tYiWZZH2Bvn5yGdZcdiC6Rq4r+NuOntnEsADNGnt6RRSmmWhg+4xqKseeTwJ8LjQ16X8NO1db
 pFXGP7OX2VRcirzA8HVfQpHeikMnCWiWAjnaGrcS14pteAW6oc+A3d3H37LL5sE4AVq3VcBwKHU
 bo5VumBqSW8nfUHEqii+gYyI6Fi9WA==
X-Proofpoint-GUID: 6-Ui0QcGPoKZVUadnzG_noJe627_wLOE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMSBTYWx0ZWRfX5M4Jqxoo8wzm
 wnuIVD5y9Y9wOrNkN5jJAlN7ExSiKXYzbi+XNN3bmGNtL4XODJBMZx3y1tAT0gR/UVG3mXJyLgl
 8vnlkqxqMyMOtIlwLOgfs1U3QIqZVYk=
X-Proofpoint-ORIG-GUID: 6-Ui0QcGPoKZVUadnzG_noJe627_wLOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608100121



On 8/8/26 1:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Unconditional dereference of `matrix_mdev->kvm` pointer leading to host kernel panic.
> - [High] Concurrent modification and traversal of `matrix_dev->mdev_list` without consistent locking.
> - [High] Assigned control domains removed from the host are not unplugged from the KVM guest due to incorrect bitmap calculation.
> - [High] Unplugging the last assigned AP resource from an mdev fails to update the KVM guest configuration.
> --
>
> --- Patch [1]: [PATCH 1/5] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove ---
> commit bb84df1768da7fbde04fb6494c22c41ed756bd46
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
>
> This commit fixes an issue in vfio_ap_mdev_cfg_remove() where the do_remove
> flag is incorrectly accumulated across iterations. It ensures the flag is
> properly assigned on the first bitmap operation for each mdev.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..845c86ba8bc30 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
>>   	DECLARE_BITMAP(aprem, AP_DEVICES);
>>   	DECLARE_BITMAP(aqrem, AP_DOMAINS);
>>   	DECLARE_BITMAP(cdrem, AP_DOMAINS);
>> -	int do_remove = 0;
>> +	int do_remove;
>>   
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> [Severity: High]
> This isn't a bug introduced by this patch, but does this code risk list
> corruption or following invalid pointers?
>
> The list is being iterated without holding mdevs_lock across the entire loop
> (the lock is acquired and released inside the loop). Concurrently,
> vfio_ap_mdev_probe() adds new mdevs to the list while holding only mdevs_lock:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe() {
>      ...
>      list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>      ...
> }
>
> Could this concurrent modification and traversal crash the host kernel?

No. The call stack for this function is:
vfio_ap_on_cfg_changed -> vfio_ap_mdev_on_cfg_remove -> 
vfio_ap_mdev_config_remove

In vfio_ap_cfg_changed, the matrix_dev->guests_lock mutex is taken and 
held for the duration
of the function. The guests_lock guards access to the 
matrix_dev->mdev_list. All functions
that add or remove ap_matrix_mdev objects also take this mutex, so there 
should never be
concurrent modification of the list.

>
>>   		mutex_lock(&matrix_mdev->kvm->lock);
> [Severity: Critical]
> This is a pre-existing issue, but can this unconditionally dereference a null
> pointer?

It can; however, the problem is fixed with patch 02/05 in the patch 
series in which this patch is
included.

>
> When an mdev is created, its kvm pointer is null until it is attached to a
> guest. If a host AP configuration change occurs while an unattached mdev
> exists, this unconditionally executes mutex_lock(&matrix_mdev->kvm->lock),
> which dereferences the null kvm pointer.
>
> Could this lead to a host kernel panic?
>
>>   		mutex_lock(&matrix_dev->mdevs_lock);
>>   
>> -		do_remove |= bitmap_and(aprem, ap_remove,
>> -					  matrix_mdev->matrix.apm,
>> -					  AP_DEVICES);
>> +		do_remove = bitmap_and(aprem, ap_remove,
>> +				       matrix_mdev->matrix.apm,
>> +				       AP_DEVICES);
>>   		do_remove |= bitmap_and(aqrem, aq_remove,
>>   					  matrix_mdev->matrix.aqm,
>>   					  AP_DOMAINS);
> [Severity: High]
> This is a pre-existing issue in vfio_ap_mdev_cfg_remove(), but is this bitmap
> calculation correct?
>
> Right below the quoted code, cdrem is calculated:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
>      ...
> 		do_remove |= bitmap_andnot(cdrem, cd_remove,
> 					     matrix_mdev->matrix.adm,
> 					     AP_DOMAINS);
>      ...
> }
>
> This evaluates to cd_remove & ~(matrix.adm), which yields domains removed from
> the host that are explicitly not assigned to the mdev. Assigned domains that
> are removed from the host are omitted and therefore not hot-unplugged.
>
> Could this allow a control domain removed from the host AP configuration to
> remain improperly assigned and accessible to the KVM guest?

This problem is fixed with patch 5/5 in the patch series in which this 
patch is
included.

>
> [Severity: High]
> This is another pre-existing issue, but does unplugging the last assigned
> AP resource from an mdev fail to update the KVM guest configuration?
>
> In vfio_ap_mdev_hot_unplug_cfg(), do_hotplug is determined using bitmap_andnot:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
>      ...
> 	if (!bitmap_empty(aprem, AP_DEVICES)) {
> 		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.apm,
> 					    matrix_mdev->shadow_apcb.apm,
> 					    aprem, AP_DEVICES);
> 	}
>      ...
> }
>
> bitmap_andnot returns true only if the resulting destination bitmap is
> non-empty. If the last adapter or domain is removed, the resulting mask is
> empty, bitmap_andnot returns false, and do_hotplug remains false.
>
> Would this skip the APCB update, leaving the KVM guest with its old KVM CRYCBD
> configuration and retaining access to an AP resource that was successfully
> removed from the host?

The logic here is correct. aprem is a bitmap specifying the adapters 
that have
been removed from the host's AP configuration. The bitmap_andnot will return
true only if the matrix_mdev->shadow_apcb and aprem and therefore the
intersecting bits have been removed from shadow_apcb. If there is not
intersection, then no bits will have been removed and the bitmap_andnot
will return 0, in which case there is no need to make changes on the guest.

>

