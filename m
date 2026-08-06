Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E064CA27C;
	Thu,  6 Aug 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043901; cv=none; b=bjNiV5MifAapwk4DPRG2OxJkSur/ow8gxGlJ9TkzdhPXquiAsQY4jfTnEsu12aJiT62e89x2HSWnJiJ/hhBEK13dAUh0a60wq6qjUuAN5xfPqtdepHmEycnGUTVtP8nnaUsioUzgWkh6+4PeStvkS41pqJkmrDa5CsOGIR6UObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043901; c=relaxed/simple;
	bh=uR2aLL4cdM/7jO9WlJ2TM1dvL4U9A4Fc8CEuqOWehR8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hZTkQqIGoT2skglhmtcyad0I3uoD6By9nstaBalzIQ4obi5JmosTtevUekhJ17FPAYbcYIbSObR+IxgUVwpE5REU5yT+KS9GIO7IVltGxHgg+HdoxxBk5Oz8aXq9MOGGHNjaY7e802WdJ1OjOy1sfFPoc/sK2FcNlDVnLHtA8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVjZqTbO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVjZqTbO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676II6Zj3322849;
	Thu, 6 Aug 2026 19:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JaQBqx
	8qh+fa5LZ3Uub8Ung51pwfZ0vHV2/PGNaDaAE=; b=dVjZqTbOFhWSFNacy2YqWF
	QtxYUD1q4jikadW9Geywa9QDyvANiXaVkcYMAXT95SlHs5SgI5cb0dixK/YP098g
	z/lcFjIU7BEy4uQDXP0NIj3xubM7V7e607a+FRnMbVWpf5Fc8frFSyUmHhdqgF7A
	4pnWqM0QEXBRucn+j7PvrCQuXxCPZmVPhnF7e/R04cjSdqsdP6eYNHhIe0EUhne9
	j1viGvU/G21Bi/G7xO7THxsKsBBgn5aK/rZYZORAmHbBa3KQ6JX72KCIvBSlOa58
	UhREy5wYl06B+gkiOgLI+uC3d33TKcOP808xuRr4oRR1VVEQCTNBzWjODGYnuF5w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy028cr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:18:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676JBHok013555;
	Thu, 6 Aug 2026 19:18:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwcqdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:18:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676JIG7328443370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 19:18:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E206D58051;
	Thu,  6 Aug 2026 19:18:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09A055805C;
	Thu,  6 Aug 2026 19:18:16 +0000 (GMT)
Received: from [9.61.80.66] (unknown [9.61.80.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 19:18:15 +0000 (GMT)
Message-ID: <f8034239-55de-453b-813e-abc582cbb1b2@linux.ibm.com>
Date: Thu, 6 Aug 2026 15:18:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260806140342.611294-1-akrowiak@linux.ibm.com>
 <20260806141848.4F3061F000E9@smtp.kernel.org>
 <705034db-69a7-4e61-ab43-978f2dcb66f1@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <705034db-69a7-4e61-ab43-978f2dcb66f1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a74ddfb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gRCtSY3o5l3VFvqAjWcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1MSBTYWx0ZWRfX+/cESKY6rydy
 K1JiytHjYDfT9VIEmtNaAbJQCAw6BT8ndgARFFe9vqtJw5zInkC8vo/w3vzsOnYsMW+dIKgSzrT
 lFsv8/lF4u4eu+UPKpXN8eNHLeTeqAUnVChMzf8V++IdVTzW5EGYTr+0K0BXpWEiGJnXEYRM8nF
 yEpAB5p4dJApMniZahjPmL3cCTp9x+5Yb4cv1Hk2ugQmTESDXNk2f4ewQED2xSdBC4hvtqzhC0G
 EihImwUqHkrvl2pDUTDH8JqBl3DlY/1CER2ynTTbA4SxxqE+4E5zNbjicSd9koaAUR0Z2kqvpM1
 3Jk0aExeI55+wMNToQRYVYRS6vZtrDVNXOsScLMGmA66fUIZmJlcA2K2z9WCIAScazQibLKIyCQ
 EKfhWEDpO9Ig4szdg+kFE18cgj8PvvAXiNIGXyNhEpuK9zQ+NjhocRdEDAnV3Je70ngoR0gPZ3g
 ralNxBIVqGoA0NWtCDA==
X-Proofpoint-ORIG-GUID: WGzfnOo2dbQ0nhE8960YbLOmxYO_q10o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1MSBTYWx0ZWRfX3kKK99gG+6PV
 ZB3XeV4+gcppKb7LH3+CLqx3ZDJjSsTyvXPadOZeB1tAMSPO2jI8s3xuzbSE2n5B8lZ0lCar9ly
 wUnoH0i4CKp6Vr7vT/6VxpAa+jDuacs=
X-Proofpoint-GUID: WGzfnOo2dbQ0nhE8960YbLOmxYO_q10o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060151



On 8/6/26 2:13 PM, Anthony Krowiak wrote:
>
>
> On 8/6/26 10:18 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Host AP configuration changes trigger a NULL pointer 
>> dereference when accessing unassigned matrix mediated devices.
>> -- 
>>
>> --- Patch [1]: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer 
>> on error in vfio_ap_mdev_set_kvm() ---
>> commit aef5cc63216cb49a3fd8ebd1da1a8d39b4fabb7b
>> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>>
>>      s390/vfio-ap: fix stale pqap_hook pointer on error in 
>> vfio_ap_mdev_set_kvm()
>>
>> In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
>> &matrix_mdev->pqap_hook before the update locks are acquired and the
>> mdev list is checked for a conflicting assignment. If another mdev is
>> already attached to the same KVM instance, the function returns -EPERM
>> without restoring the hook pointer. This patch rearranges lock 
>> acquisition
>> to prevent this stale pointer issue and potential deadlocks.
>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 44b3a1dcc1b36..99a0efd999ef9 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> [ ... ]
>>
>>> @@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct 
>>> ap_matrix_mdev *matrix_mdev)
>>>       struct kvm *kvm = matrix_mdev->kvm;
>>>         if (kvm && kvm->arch.crypto.crycbd) {
>>> -        down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>> -        kvm->arch.crypto.pqap_hook = NULL;
>>> -        up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>> -
>>>           get_update_locks_for_kvm(kvm);
>>> +        kvm->arch.crypto.pqap_hook = NULL;
>>>             kvm_arch_crypto_clear_masks(kvm);
>>>           vfio_ap_mdev_reset_queues(matrix_mdev);
>>> -        kvm_put_kvm(kvm);
>>>           matrix_mdev->kvm = NULL;
>>>             release_update_locks_for_kvm(kvm);
>>> +        kvm_put_kvm(kvm);
>>>       }
>>>   }
>> While reviewing this file, I noticed a couple of related issues.
>>
>> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
>>     ...
>>     list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
>>         mutex_lock(&matrix_mdev->kvm->lock);
>>         mutex_lock(&matrix_dev->mdevs_lock);
>>     ...
>> }
>>
>> [Severity: High]
>> This is a pre-existing issue, but if a mediated device is unassigned
>> (matrix_mdev->kvm is NULL) when the host AP configuration is modified,
>> will this unconditional lock of matrix_mdev->kvm->lock trigger a NULL 
>> pointer
>> dereference?
>>
>>
>> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_plug_cfg() {
>>     ...
>>     DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>>     bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = 
>> false;
>>
>>     mutex_lock(&matrix_mdev->kvm->lock);
>>     mutex_lock(&matrix_dev->mdevs_lock);
>>     ...
>> }
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but similar to the above, 
>> does this
>> function also dereference matrix_mdev->kvm without checking if it's 
>> NULL,
>> potentially leading to a crash when unassigned matrix mediated 
>> devices are
>> accessed during host AP configuration changes?
>
> Both of the above the concerns above are legitimate for the case whereby
> the matrix_mdev->kvm was never set via the vfio_ap_mdev_set_kvm()
> function which is called only when a guest is started with the mdev 
> attached
> and the mdev fd is opened. If the mdev is not attached to a guest, then
> matrix_mdev->kvm will be NULL.
>
> The matrix_mdev->kvm pointer is set to NULL
> in the vfio_ap_mdev_unset_kvm; however, all three functions (the 
> unset_kvm
> and the two above) all take the matrix_dev->guests_lock before 
> proceeding,
> so the matrix_dev->kvm pointer is guaranteed to not be NULL due to a
> race condition.
>
> Having said that, it is clear that a check must be introduced to 
> verify that
> matrix_mdev->kvm is not NULL before taking the matrix_mdev->kvm->lock
> in the two functions above.

The fix for this bug will be posted via a separate patch.

>
>>
>
>

