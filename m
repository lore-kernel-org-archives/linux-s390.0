Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FD48A2D1;
	Thu,  6 Aug 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039999; cv=none; b=kidCh7rta/ZRvValePFVrm+R46jp54nwh9SSPliNEPUOU6pUap3Wk3GaJ3hAQS32NS7JljngGFHWqY7C5+LYdi1gpmGtQWy3fb+RNjFyN3rW8W2sD/AWdIBxyExDnbhEBJhXPC6jN9mJFHitK0FGUEZ6MmCOcEOZ91UDyUEf3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039999; c=relaxed/simple;
	bh=9rflwFr12ji5NL/eJWL41DKynWRoCK70js2s0jo+6fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaFtZxsAwmvUOTrzum8WAY1+pV2l4D9zHz/wxn+iN+44EAYuZqrzr0cE86NuHo0tlvKJ3pclEI6pY+fJr7TVlhUYzMVEJzIPBnk1WUEOIBIxe+gYBwW/OACYyprN9wAGYr3r7Kn0Su9wdyzpVH8w76RcCocHDo5PJyv206bufDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUpXU2e6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUpXU2e6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Hm07c3256392;
	Thu, 6 Aug 2026 18:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e65Hji
	c0nlapQAN/iXgJdb2VfsQ6Qv+GkLki5TthQFs=; b=WUpXU2e6ADOCGXimQB1zVV
	Gw2pPIphiWueTxorY1MTdulXoJGvCp5ldtFOpFMiiwDRLexzdN6RgzSIuxMaxdMi
	ko06ARxrhqCyHAv9K7rxZa6clhX7L18/eArCp6rVPLJO3vU8hM2j2BmAnN5FTkZs
	ggTTtgxNlzlxPE3PT17BgNS+Nt9SO8W4W+KrYzfTvQnPjUBYcjn/L4ws8bYaLj8/
	LQ1we6zWwWki0cnAFk0AQF17mMnesrqjg+3rr42y78D5CqFT7EpUbsRk5uGLCi2Y
	Quw7wb/3lX9zktM4KCWKUUsqallCwPjKTa8lBZPtDwKqF0N1BGcSOT/qh8/Sw7yQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0283ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:13:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HuUrx027655;
	Thu, 6 Aug 2026 18:13:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhma1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:13:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676IDEZX31720002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:13:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 718515805A;
	Thu,  6 Aug 2026 18:13:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6BE258051;
	Thu,  6 Aug 2026 18:13:13 +0000 (GMT)
Received: from [9.61.80.66] (unknown [9.61.80.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 18:13:13 +0000 (GMT)
Message-ID: <705034db-69a7-4e61-ab43-978f2dcb66f1@linux.ibm.com>
Date: Thu, 6 Aug 2026 14:13:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260806140342.611294-1-akrowiak@linux.ibm.com>
 <20260806141848.4F3061F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260806141848.4F3061F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a74cebc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DXWA_wIhCYkHbeNkIZAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfXy413zPoWnMme
 Q3dyEvPSkfY6sehxnTGih3ETr/9+OHoNZQYeXk9c29npKlowW24qnFlIqnNFld2Pf8Ok/EGnas3
 NBvgsgwTDF/u0V9OJqt+u99LC8V9tukBI312JS0XsigzlzjJuCcmxck6oLikbDzRpzHnpXFCdnP
 9kcjAYOqKiVhpWRrveFI6RAPi37Zk+yUSng1Yd9bPAy5yJEsCLSwVdTcSPfK7iFPdY7L1cNenBq
 JiK+DCQOYOV7b8ZhKVHVKcTFB0D82NJAk25rLh4n/x+Fdbl4TdJ6OTUtnSuNesDJiG4Dp424TDL
 qPpdGCssKuZ40kioQOL7oF2WXQYoNv9vwl7LhxwWjkhb8kSmJ8TK+yzyKUZjeLWpd+aHta/gXo1
 4Ra9rUGTUpi9pfx23vyC37r6xlLTAoOCYzmD3GIqJd4ivqhyRoJm102y3kbL1nAR/bpapaOsuPV
 K9v8P9o78uVuhoUJ/JQ==
X-Proofpoint-ORIG-GUID: Z3q0P1RiZDPYxLNWCutT1-eKKOphI_43
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzOSBTYWx0ZWRfX8CrrEeof46jv
 75y9B6/vlRBFV3+BYWv/W024IB1qVEC4+NUomfRdkj3MFqJGVGcqWQ/BickKuD8/LMEeM5EFzCx
 VqviGMA+99XDkTb2mv1uecLTx13BsLc=
X-Proofpoint-GUID: Z3q0P1RiZDPYxLNWCutT1-eKKOphI_43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060139



On 8/6/26 10:18 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Host AP configuration changes trigger a NULL pointer dereference when accessing unassigned matrix mediated devices.
> --
>
> --- Patch [1]: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm() ---
> commit aef5cc63216cb49a3fd8ebd1da1a8d39b4fabb7b
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
>      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
>
> In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
> &matrix_mdev->pqap_hook before the update locks are acquired and the
> mdev list is checked for a conflicting assignment. If another mdev is
> already attached to the same KVM instance, the function returns -EPERM
> without restoring the hook pointer. This patch rearranges lock acquisition
> to prevent this stale pointer issue and potential deadlocks.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..99a0efd999ef9 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   	struct kvm *kvm = matrix_mdev->kvm;
>>   
>>   	if (kvm && kvm->arch.crypto.crycbd) {
>> -		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> -		kvm->arch.crypto.pqap_hook = NULL;
>> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> -
>>   		get_update_locks_for_kvm(kvm);
>> +		kvm->arch.crypto.pqap_hook = NULL;
>>   
>>   		kvm_arch_crypto_clear_masks(kvm);
>>   		vfio_ap_mdev_reset_queues(matrix_mdev);
>> -		kvm_put_kvm(kvm);
>>   		matrix_mdev->kvm = NULL;
>>   
>>   		release_update_locks_for_kvm(kvm);
>> +		kvm_put_kvm(kvm);
>>   	}
>>   }
> While reviewing this file, I noticed a couple of related issues.
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
> 	...
> 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> 		mutex_lock(&matrix_mdev->kvm->lock);
> 		mutex_lock(&matrix_dev->mdevs_lock);
> 	...
> }
>
> [Severity: High]
> This is a pre-existing issue, but if a mediated device is unassigned
> (matrix_mdev->kvm is NULL) when the host AP configuration is modified,
> will this unconditional lock of matrix_mdev->kvm->lock trigger a NULL pointer
> dereference?
>
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_plug_cfg() {
> 	...
> 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
> 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
>
> 	mutex_lock(&matrix_mdev->kvm->lock);
> 	mutex_lock(&matrix_dev->mdevs_lock);
> 	...
> }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but similar to the above, does this
> function also dereference matrix_mdev->kvm without checking if it's NULL,
> potentially leading to a crash when unassigned matrix mediated devices are
> accessed during host AP configuration changes?

Both of the above the concerns above are legitimate for the case whereby
the matrix_mdev->kvm was never set via the vfio_ap_mdev_set_kvm()
function which is called only when a guest is started with the mdev attached
and the mdev fd is opened. If the mdev is not attached to a guest, then
matrix_mdev->kvm will be NULL.

The matrix_mdev->kvm pointer is set to NULL
in the vfio_ap_mdev_unset_kvm; however, all three functions (the unset_kvm
and the two above) all take the matrix_dev->guests_lock before proceeding,
so the matrix_dev->kvm pointer is guaranteed to not be NULL due to a
race condition.

Having said that, it is clear that a check must be introduced to verify that
matrix_mdev->kvm is not NULL before taking the matrix_mdev->kvm->lock
in the two functions above.

>

