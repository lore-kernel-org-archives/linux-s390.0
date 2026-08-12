Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F847DFBD;
	Wed, 12 Aug 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559142; cv=none; b=gSbJkbE3cJUsp/msBrnGyVokDZW4M3HodJjNm6EPggT0/dufaNzmlsoQj4HfgyAHfCrsMOS8iOEKsR47BChYYvcp59+l9WP+FgrE90I6UTE2epaFOD1/rEMGa5me28IEQwwGppuGcGdkS1dK97dI74SRR7Zgag2RGKFP3VMp1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559142; c=relaxed/simple;
	bh=YEceM0NXnwsyeqh95ys5QvUteQDZvCGlNtMp+wyg1Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPsqe54516kqB+KaGoLhiotwX96OVhGwtSQcsOwqe0kgS3hjjJ7AhHuAH9/cBr155NWC2ISvV02kgCHwIzljD0rLGnKxC9PPjNy6YB2rbAtGIwcXUk7omVwchNoTxWgPAeBHzh8Y6PMFT48iVVog9Tn/x3Y+jrN5dKxMSHG1oO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PgE/LNen; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PgE/LNen"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1ZcN3994359;
	Wed, 12 Aug 2026 18:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zz55Vl
	ri0YWzRXtJNGzWuVsBQyB6MzQN0lpt300T6tI=; b=PgE/LNenqyIXlT0/AZRkVP
	79Zu7P1ynhhm/6yixaB6l7U6ypHMvYeCXbTWff3yNkrXVnoH85brIxh+FoRvndHn
	3TIPArLU4KwVojDgwqkCbZLKN6seiuALgTNTv9j7VOIf7vuZJoBspcV1T8p90+jG
	U34iFBf/ZMKjmL30liJHukBmh/RKPmHiLJ8Q5mZrHvXSBwfgZLM1I6KnzgPWHEy0
	pTd6/JjI9e+W0xy8zFtvbeWtOtn6d7whF60tlB5oVQ18U6TBvsU0wPI2CI3iqWl1
	DQRsAsk+/JSp86ynF/TOShHsq3eLp8c0kN+Rs5j2wfUBCA7x7UJzFuM82J7T5PSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp335d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:25:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIBGl4002202;
	Wed, 12 Aug 2026 18:25:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy76fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:25:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CIPaTx28508712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:25:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32EA658052;
	Wed, 12 Aug 2026 18:25:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A168058056;
	Wed, 12 Aug 2026 18:25:35 +0000 (GMT)
Received: from [9.61.9.29] (unknown [9.61.9.29])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:25:35 +0000 (GMT)
Message-ID: <cb9ff85c-b7a3-4e0c-9250-60a553819c53@linux.ibm.com>
Date: Wed, 12 Aug 2026 14:25:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] s390/vfio-ap: Fix missing lock required to access
 list of ap_matrix_mdev objects
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-4-akrowiak@linux.ibm.com>
 <20260812172858.2B7241F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260812172858.2B7241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cbaa3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=St0H5_43ehi4W70VKpQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -2XwHUGdkenFV_7WXeJSFOGqLjREFAnT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfXwOYLfaEwlZ9b
 LIhNHokGROuVEDyiOkqapPjA1i/S7ByStjW4/pB4CIiu7RpC9nfmckCPyqi8uwlPi8gy+0coDV0
 A1Kd6HebiXAvKNzq++UI10tO/wcMytJNHTCNNpCuZ4hEKqqZCvyYXS8BjrwK+I9JtEx2vvrSRrv
 HP9wIbde9PqVirfrPV6KK+e9uobUPVnZZuZdnOay1k+F3j1XkvJ264xNq341KYAFzPvcfcm281n
 /EHx1pgkaIRMNZoJR+8BCm3DiG5dgBhNyFrNx7GPLaTvlymFvTUl5vWim3Lk+t6uNI1+W/WgQ3L
 1EUzMGei+SUDXsqbznOasyWhAOWZfI9qXwn50jIJaVyxrfsXZkb7ZKx4Ctp+NYfoNGGOVgd/DRN
 RqmruZytr1lTAtxD/7qEz3ojMNXWQuaI0+L7K9wZfMGhn/tKdjLwIOFsp3J8o1hcFXbZ1h7CkXN
 fgRzCSx7tL02IJAmwGg==
X-Proofpoint-ORIG-GUID: -2XwHUGdkenFV_7WXeJSFOGqLjREFAnT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX58EoG+C8XxjT
 +GEt9/QsKjqFVExIT2AeKO9mdFv5+Uo4Qq/O70Ft/BPKOCcET7oRcRGFJBA3xWN+neNEZgzNF3A
 FjQynfBkPj0DI+54nOzzSlcAGUh/k8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120145



On 8/12/26 1:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] The sysfs file 'status' is exposed to userspace before the device's driver data is fully initialized, leading to a potential NULL pointer dereference in status_show().
> - [High] A race condition in vfio_ap_mdev_probe() allows userspace to bypass the 'one mdev per KVM' isolation restriction.
> - [High] Eventfd contexts for `req_trigger` and `cfg_chg_trigger` are leaked when the mediated device is closed or removed.
> --
>
> --- Patch [3]: [PATCH v4 3/9] s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects ---
> commit b763c5c7bf7a38cb1fc2e2da2ff0df92d3ae360c
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
>
> This patch fixes list traversal synchronization for ap_matrix_mdev objects
> by adding guests_lock around mdev_list access. It also removes redundant
> zero-initialization of eventfd triggers in the probe function.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index c6bee69cc22f6..f2d662e388bdc 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -800,12 +800,17 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>>   	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
> [Severity: High]
> This isn't a bug introduced by this patch, but does exposing the VFIO
> device to userspace here create a race condition?
>
> vfio_register_emulated_iommu_dev() makes the device visible to userspace
> before it is added to matrix_dev->mdev_list under guests_lock. Could
> userspace open multiple mdevs concurrently, allowing them to bypass the 'one
> mdev per KVM' isolation restriction since vfio_ap_mdev_set_kvm() won't see
> the other devices in the list yet?
>
>>   	if (ret)
>>   		goto err_put_vdev;
>> -	matrix_mdev->req_trigger = NULL;
>> -	matrix_mdev->cfg_chg_trigger = NULL;
> [Severity: High]
> This is a pre-existing issue, but since you are touching the eventfd triggers
> here, are they properly cleaned up when the device is closed?
>
> Userspace can set IRQ triggers via VFIO_DEVICE_SET_IRQS, which calls
> eventfd_ctx_fdget() and takes a reference. If the user closes the device
> without unregistering the IRQs, shouldn't vfio_ap_mdev_close_device() or
> vfio_ap_mdev_remove() call eventfd_ctx_put() for req_trigger and
> cfg_chg_trigger to prevent a memory and file descriptor leak?

The other concerns are fixed in this series, but this concern is not. This
needs to be fixed.

>
>> +
>> +	/*
>> +	 * Take the matrix_dev->guests_lock mutex before adding the matrix_mdev
>> +	 * to the mdev_list. All functions that traverse the list must also hold
>> +	 * this lock to guard against additions to or removals from the list
>> +	 * while it is being traversed.
>> +	 */
>> +	mutex_lock(&matrix_dev->guests_lock);
>>   	dev_set_drvdata(&mdev->dev, matrix_mdev);
>> -	mutex_lock(&matrix_dev->mdevs_lock);
>>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>> -	mutex_unlock(&matrix_dev->mdevs_lock);
>> +	mutex_unlock(&matrix_dev->guests_lock);
>>   	return 0;
> [ ... ]
>
>> @@ -2316,6 +2323,7 @@ static ssize_t status_show(struct device *dev,
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   	struct ap_device *apdev = to_ap_dev(dev);
>>   
>> +	mutex_lock(&matrix_dev->guests_lock);
>>   	mutex_lock(&matrix_dev->mdevs_lock);
>>   	q = dev_get_drvdata(&apdev->device);
> [Severity: Critical]
> This is a pre-existing issue, but is it possible for dev_get_drvdata() to
> return a NULL pointer here if the status sysfs file is read concurrently
> with device probing?
>
> During vfio_ap_mdev_probe_queue(), sysfs_create_group() creates the status
> attribute before dev_set_drvdata() initializes the driver data. Can a
> concurrent read of the status file fetch a NULL pointer in status_show() and
> pass it to vfio_ap_mdev_for_queue(), causing a crash when it dereferences
> q->apqn?
>
>>   	matrix_mdev = vfio_ap_mdev_for_queue(q);
>> @@ -2343,6 +2351,7 @@ static ssize_t status_show(struct device *dev,
>>   	}
>>   
>>   	mutex_unlock(&matrix_dev->mdevs_lock);
>> +	mutex_unlock(&matrix_dev->guests_lock);
>>   
>>   	return nchars;
>>   }

