Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0E3E0C4C;
	Mon, 10 Aug 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372680; cv=none; b=WTAuVrKMf88IvurKLKVxkWCpBT09Tc7dHGLq4tY7pdWJNhUPU/Su0xHFjdVRZRYE9mKONQi7ECY0r80mCA2a4//oHepnsfxmBylXKrnDye5mI5C4A4MULUEWzSHj5v8yppTC1Idm0EX2UgQlxhuv4iw5DpfRSPWPkhAsAitgdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372680; c=relaxed/simple;
	bh=0DFjAsfT3BhVZ0HPTS9i8nfIoTLYaEntffNCMTIj48g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=me9O1TlMyy7j68q+9xE5WBTQ424tMufXgxLB2ki5FB0bgfyMFwVyNjf/eDGbhcnQN9XT1VhDLJCZWkK2NxNi+i5KLa59AXKkqRP70KruPqrLgEosY2gqZXLoG25ZBDl/X/30XI2ReYbo5KyBq1sP1vD6Ow/3SqbM17xz6celnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o5AUslen; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o5AUslen"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1YdW1611618;
	Mon, 10 Aug 2026 14:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6214LO
	BROlGTNdhBlEoVB1kNzk+cxgu9DMeLEJ3uPrI=; b=o5AUslen94tIi/cb5AOADp
	cOtu0s62FuTws4G4AAEwHGzLzQ5ek+23Ihc2s/NX/0twZvxgWeBwzRQK5+ONrrA6
	dX+/JQ0hOAOHdHkZyDQzVB0VPGj/HFPqVW4EIWauVGiXPOj7hLjTPVOMqe/REVUX
	XcCru83c4B+GRVsqK3cMYW5STIyHlMvHn3suB+YBuF3MJAafPm4BfFZKtTcL3gT6
	6Ul0jePT6fgNqnjqyk3MEWktlBqFb9vJUQXhSqT/qYrtjUQY3Ep3QNzkUXMwEhU8
	TVH/6I9I3rFthHqvySKQZfiBt11CoDyVstY7cmuj7P39zheZxoH9t8s4A2rSQvLg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2r38k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 14:37:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AEQWkO001011;
	Mon, 10 Aug 2026 14:37:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespwawv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 14:37:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AEbtIW31064702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 14:37:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0FE658061;
	Mon, 10 Aug 2026 14:37:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A3F5805A;
	Mon, 10 Aug 2026 14:37:55 +0000 (GMT)
Received: from [9.61.71.153] (unknown [9.61.71.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 14:37:55 +0000 (GMT)
Message-ID: <33385dd9-483f-4f50-a486-94b3e0513a5c@linux.ibm.com>
Date: Mon, 10 Aug 2026 10:37:54 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>, kvm@vger.kernel.org
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-3-akrowiak@linux.ibm.com>
 <20260808173625.599D41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260808173625.599D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79e245 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=D19gQVrFAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=sW9sOQtXqBq0zZzEPnAA:9 a=QEXdDO2ut3YA:10
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: DJf5QWtElitn1GOR4UVTfondm6meZNwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyNSBTYWx0ZWRfXwSJ6NuhTRLCz
 UEMkqK75pQj3DfWceSPoaz8XebeiC2WlYKc1It3VSXVt8DdGxJTjzIfjtPJTo/nBIXc4Hpjq4cY
 8yJJ6ICX9l18UYgpNSrY7dmiEhVztY2bjbYLl2mjuveLXE33ijCyLIaca8wlQB4F00weu8MC1Ah
 KPlCDvtKgEaYEhRLWlHjcoupOR/8h0VukKzCH7LRV9Rcs4c4n8qKfp4SVTGW4nH0LR8nhy9FpTY
 AhmWi7dRngTFV2d+U+hau+RN//nm3p/LAFIhpe6oCmradoiKMl2GPXK2GZAO4ASio+9EU4vqeFB
 Z+JvkQPq4kkvF9hEb5qzj9QRlDlRDZiPf4v28vVAJPiVpiBGHoQEuXZ3yCoL88Mz53hq9/rkXjx
 6xQDabikfd1/xTQlrh5lPRSv6Mj5Mzw+qlmVnWL91Gd2GNc6dAjFHHGga8dRoklRxuXr9GbMGk+
 nVZo1w/bPBS6XhAGsgg==
X-Proofpoint-ORIG-GUID: DJf5QWtElitn1GOR4UVTfondm6meZNwU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyNSBTYWx0ZWRfX45xJ9xLjOaa1
 1DuRMNUOUsV0GA20oMAd0udq7QY2oCpMypag3dJloINoZCYexljcwlAEhmOf28J9Gqyl5MnG9UN
 lSskMNc6PnHYqRGo7tQBidjNa2eU7KU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100125



On 8/8/26 1:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Uninitialized Memory Usage in `vfio_ap_mdev_hot_plug_cfg` leads to random hardware queue resets.
> - [High] Use-After-Free in KVM's `pqap_hook` due to improper error rollback in `vfio_ap_mdev_set_kvm`.
> - [High] Unsafe concurrent modification and iteration of `matrix_dev->mdev_list` leading to Data Race / UAF.
> --
>
> --- Patch [2]: [PATCH 2/5] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL ---
> commit 9e16afa935b6610f6431f2a073e3d436ec0b7f7d
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
>
> This commit resolves a potential NULL pointer dereference in the AP bus scan
> callbacks by explicitly checking if matrix_mdev->kvm is set before acquiring
> its lock. It also adjusts the lock acquisition order in these callbacks.
>
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 845c86ba8bc30..e382e5a1cb996 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -2821,9 +2828,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
>>   	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>>   	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
>>   
>> -	mutex_lock(&matrix_mdev->kvm->lock);
>> -	mutex_lock(&matrix_dev->mdevs_lock);
>> -
>>   	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
>>   					    matrix_mdev->apm_add, AP_DEVICES);
>>   	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
>> @@ -2841,9 +2845,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
>>   		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>>   
>>   	reset_queues_for_apids(matrix_mdev, apm_filtered);
>> https://lkml.org/lkml/2026/8/6/1775
> [Severity: High]
> This is a pre-existing issue, but does this function pass an uninitialized
> bitmap to reset_queues_for_apids()?
>
> If the AP configuration only adds control domains, filter_cdoms is true, but
> both filter_adapters and filter_domains are false. This skips the call to
> vfio_ap_mdev_filter_matrix() which initializes apm_filtered:
>
>      if (filter_adapters || filter_domains)
>          do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
>
> If this initialization path is bypassed, is it possible for apm_filtered to
> retain stack garbage when it is subsequently passed to
> reset_queues_for_apids(), potentially causing unintended guest hardware
> queues to be reset?

Yes, because if no adapters or domains need to be filtered, the call to
vfio_ap_mdev_filter_matrix - which zeros all bits to apm_filtered - will 
be bypassed.
The apm_filtered bitmap needs to be zeroed before the check for 
filter_adapters
and filter_domains.

>
>> -
>> -	mutex_unlock(&matrix_dev->mdevs_lock);
>> -	mutex_unlock(&matrix_mdev->kvm->lock);
>>   }
>>   
>>   void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>> @@ -2854,15 +2855,29 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>>   	mutex_lock(&matrix_dev->guests_lock);
>>   
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> [Severity: High]
> This is a pre-existing issue, but could this list iteration race with
> concurrent list modifications?
>
> It appears this list traversal in vfio_ap_on_scan_complete() occurs while
> holding only matrix_dev->guests_lock at the list level. However, list
> mutations such as the one in vfio_ap_mdev_probe():
>
> vfio_ap_mdev_probe() {
>      ...
>      mutex_lock(&matrix_dev->mdevs_lock);
>      list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>      mutex_unlock(&matrix_dev->mdevs_lock);
>      ...
> }
>
> are protected only by matrix_dev->mdevs_lock. Since the internal iteration
> step happens outside of matrix_dev->mdevs_lock, can this expose the reader to
> torn or stale pointers, potentially leading to a use-after-free or infinite
> loop if an administrator concurrently creates a new mdev?

This is fixed via patch 3/5 of the series in which this patch is included.

>
>> +		/*
>> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
>> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
>> +		 * ordering requirement and prevent a lockdep splat.
>> +		 */
> [ ... ]
>
> While reviewing this file, I also noticed another potential issue outside the
> immediate diff in vfio_ap_mdev_set_kvm():
>
>>        kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>        ...
>>        if (m != matrix_mdev && m->kvm == kvm) {
>>                release_update_locks_for_kvm(kvm);
>>                return -EPERM;
>>        }
> [Severity: High]
> This is a pre-existing issue, but is it possible for KVM's pqap_hook to be
> left pointing to freed memory upon an error?
>
> The KVM hook is unconditionally updated to point to the incoming matrix_mdev.
> However, if another mdev is already attached to this KVM instance, the
> function bails out with -EPERM.
>
> If the rejected mdev is subsequently freed by userspace, would KVM retain a
> dangling pointer? Could this cause a use-after-free when a guest later
> issues a PQAP instruction and handle_pqap() dereferences the hook?

A fix for this has already been submitted to the kernel mailing list:
https://lkml.org/lkml/2026/8/6/1775

>

