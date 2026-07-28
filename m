Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6624734D3;
	Tue, 28 Jul 2026 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268682; cv=none; b=C9h/bb6x03nlBMOktqhu37RHuFEv6Dlc7bvH8mZGFnxG1YrhO+7aHeHKwrv91mB2QQSG4FlGxbyIY0UfpQMwb+PUUfJ8DqSVtV3CdMM94YiT8y+pBQbQXq5+pI+WbH8l8id3H9rZaAi/k2Kq2T5M0pi7mfgZA/8Q2UV1it+3qAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268682; c=relaxed/simple;
	bh=KkTfY/42vsrVbYxROJVVYJC9I/KPtAayGu2PUiTwD24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYmCn0Lu9B3Rfv1u9fcONy/g4BzaRh8rvT1Oibanie0Avy3KYkHYsGWYZ1HhhlDBGRzkfPJpsznPZYR3ZUYYo4U3rGdbCL4RbLnEjKK2bciZHeSru3fiL7sieTztmmdMvD8wM1ne1q4SRvtOmcXJom0iIQu1lCrYu7dwA2UTZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bCC2wm/4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bCC2wm/4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SIHiqX1927464;
	Tue, 28 Jul 2026 19:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A7mCQD
	KxUZh1dwhP+29h6eeyjx7dhm8+poSfpUgDJyg=; b=bCC2wm/4J9FlcBtaRdBVQT
	Y9iOzUNfOaGjNN2pPFvNE+1tEJWOOIjWqqyGujnWaHuloyK9ADTpKgqekoBkqHwd
	Yf0pWP6X7TYNeGcWCytM9tng5AGbOfp1eD5HE34tUgYyKFn3fACBQSaDmJhujs6g
	hf8tDFuHbFfP7FDyhnSavj5GSKinfTYjWEjU2kXHe2Dg3C1oGNdpsGsdhWbbumBD
	MxYk48X/+QL2CclZjY9eWsrtgOKRIy2ABUVLi+zgos684hWJBtra7p0zHUZN9519
	2JIipmJwuKonP3VDVtarLzyugmYWmnrxIJZJDx3+wtYP+PhoLNVjO9izI/AIu2DQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7fa5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 19:57:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SJfFGX016036;
	Tue, 28 Jul 2026 19:57:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqbv4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 19:57:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SJvpQm27656884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 19:57:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94BCB58059;
	Tue, 28 Jul 2026 19:57:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A69358043;
	Tue, 28 Jul 2026 19:57:50 +0000 (GMT)
Received: from [9.61.138.160] (unknown [9.61.138.160])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 19:57:50 +0000 (GMT)
Message-ID: <60015999-697e-495d-981d-1ac010b81367@linux.ibm.com>
Date: Tue, 28 Jul 2026 15:57:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, stable@vger.kernel.org
References: <20260728162705.2631004-1-akrowiak@linux.ibm.com>
 <20260728164105.4AAC01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260728164105.4AAC01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DH591GxPmtgzxV6ldX0JrsM-Cd0Rshk_
X-Proofpoint-ORIG-GUID: DH591GxPmtgzxV6ldX0JrsM-Cd0Rshk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE3MCBTYWx0ZWRfXww/lsYs0OthL
 m/0Adxl9tLdvB055GWVJ/OcNxPG/ZbmGX48r6CYiHaTVfook6xcBzk/NEL7kdm0V/YidzHYryF6
 TDeA4FQpHnLRS/Wa3GLMq/ZYQjVK3ZW5cDIhIoolDX3urPHLmQw+B6OsGemii2HZN+mRp1sLF8t
 1KP+kuXeiWYsKtJzgjjQwiz4F3ONKOL12czsRZM+xl60R8lWBshSFENAraLGdf0jIS0oFmAdvtX
 zo6NM8q5/8ZJmm69oivB12oGwLCi/oHmZUDyFiZjsSnk8R4grhl7dMmaYZw3pyhPwpdR/D8zD0N
 EDdtYlBUSD8RjEU+laLPjMv8EkorVn+LmMIgQxFFb0m2E9WahKNuAByvTjv8k7kS74vpFapiPK3
 TSwiRV/0Cw3zxfxKFZy745qHHX+ZCM0lchi7B/RrJaObQMFDd9bfPFs2vs11K5KIMOzOp+cjTZf
 +bvZ0yoXcPuYNBqh+vg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6909c1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SnmR3V4DJBMBAkIxd3wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE3MCBTYWx0ZWRfX6+8rNVjxaCbI
 5UBuu+zJukJIfeoZCAPXoztC9YBRFTbUr/nB+cGYuTL0D8bdM3KdJW5PqmnhYCmC3luziI1mbpm
 pp6poeB8PFRVx0/NCevUR6/lgZ2SJ/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280170



On 7/28/26 12:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `mdev_list` iteration from within the `update_locks` critical section introduces a Time-Of-Check to Time-Of-Use (TOCTOU) race condition between `vfio_ap_mdev_set_kvm()` and `vfio_ap_mdev_unset_kvm()` that silently clobbers KVM APCB masks for a newly attached mdev.
> --
>
> --- Patch [1]: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm() ---
> commit 0834fa20c3fb715cac9e1ff09376e43784d44814
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
>
> This commit changes vfio_ap_mdev_set_kvm() to use pqap_hook to detect
> conflicting assignments instead of iterating mdev_list under the update locks,
> resolving a potential stale pointer dereference.
>
> Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..b0a038faa93ac 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1821,26 +1821,25 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   				struct kvm *kvm)
>>   {
>> -	struct ap_matrix_mdev *m;
>> -
>>   	if (kvm->arch.crypto.crycbd) {
>> +		/*
>> +		 * Taking the kvm->arch.crypto.pqap_hook_rwsem lock while
>> +		 * holding the update locks (below) could result in a
>> +		 * deadlock condition, so let's hold the rwsem here while we
>> +		 * check and update the pqap_hook.
>> +		 */
>>   		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> +		if (kvm->arch.crypto.pqap_hook) {
>> +			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> +			return -EPERM;
>> +		}
>>   		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>   		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>   
>>   		get_update_locks_for_kvm(kvm);
> [Severity: High]
> Can this introduce a race with vfio_ap_mdev_unset_kvm()?
>
> By moving the conflict check outside of the update_locks critical section,
> is it possible for the following sequence to occur during concurrent
> hot-plug/unplug operations?
>
> Thread 1 (in vfio_ap_mdev_unset_kvm):
>      down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      kvm->arch.crypto.pqap_hook = NULL;
>      up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>
> Thread 2 (in vfio_ap_mdev_set_kvm):
>      down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      // Sees pqap_hook is NULL
>      kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>      up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      get_update_locks_for_kvm(kvm);
>      vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>      release_update_locks_for_kvm(kvm);
>
> Thread 1 (continuing in vfio_ap_mdev_unset_kvm):
>      get_update_locks_for_kvm(kvm);
>      kvm_arch_crypto_clear_masks(kvm);
>
> If Thread 1 interleaves after Thread 2 sets the guest masks but before Thread
> 1 clears them, would this result in Thread 1 unconditionally clearing the KVM
> APCB masks that Thread 2 just successfully configured, leaving the newly
> attached mdev with inaccessible queues?

This scenario requires Thread 1 (unset_kvm) to be tearing down the same
matrix_mdev that Thread 2 (set_kvm) is attaching. But look at the entry
conditions:

* vfio_ap_mdev_unset_kvm is called from vfio_ap_mdev_close_device
* vfio_ap_mdev_set_kvm is called from vfio_ap_mdev_open_device

open_device and close_device on the same vfio_device are serialized by the
vfio core under dev_set->lock; you cannot have both executing concurrently
for the same mdev.

Furthermore, vfio_ap_mdev_unset_kvm reads matrix_mdev->kvm which is only
set to a non-NULL value inside vfio_ap_mdev_set_kvm. For Thread 1's
unset_kvm to operate on the same kvm as Thread 2's set_kvm, Thread 1's
matrix_mdev would have to have already gone through a complete set_kvm
cycle and have ->kvm set; in other words, it is a different matrix_mdev
that previously attached to the same KVM.

This fix prevents that: the pqap_hook != NULL check blocks Thread 2 from
attaching to a KVM that already has an owner. So Thread 1 and Thread 2 can
never legitimately be racing over the same kvm in the scenario described.

>
>> -
>> -		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>> -			if (m != matrix_mdev && m->kvm == kvm) {
>> -				release_update_locks_for_kvm(kvm);
>> -				return -EPERM;
>> -			}
>> -		}
>> -
>>   		kvm_get_kvm(kvm);
>>   		matrix_mdev->kvm = kvm;
>>   		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>> -
>>   		release_update_locks_for_kvm(kvm);
>>   	}
>>

