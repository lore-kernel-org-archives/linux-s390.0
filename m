Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214B337BA4;
	Wed, 19 Aug 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144412; cv=none; b=Xn+636CAkE+psEOAAo5RQtvUXR09gcUSGKjBXJpWyw+AXp5myXlv5ugNit9TJWriohhJp1fVqsiq+PePIHM7fNZBDrHJfZ0W3gfo/yUhyULFZze5PPPuJC7IJ+vd4zmy/RjJLfoRc8Ib41GxWKSElAD2DNy3D4Zab686U7xJQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144412; c=relaxed/simple;
	bh=aYlkVRPCilvPCuY4Bv/YkUHeNjUWb2kK1BT1pZH+P4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgld7j3FZxWmt8j+v/3lSx3ujMj+u0ZGNm/rvaCJfOXXn4xQnwM70KSLLdqo47YYMFcdjF1nKhielGEtvvT+iWxgh6TeIy27IRX1rBHa9/x26QpE++bluMJYvAkGRDAIoEB5kdelCSR79mGr0UDbn+963xNx85TJh0PtmLfhznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6BJyW69; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6BJyW69"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAViEC3085597;
	Wed, 19 Aug 2026 13:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MvbE2i
	lmO2j95849Uz9dV/kEVwiKmVCUEjwCg0QHoPc=; b=p6BJyW69IujAcf45B47q3F
	GxZS6GpvDsQEtepx6qr5IVJEZfaFmBbW2PZ5a623+L21OtytQmQ9DpmkpoFAGhl4
	TvRzWBN2LVvf+JQubV0NI8UxqJn7aU6VMZX4vhf5q8dT7dIkKf5EiWG5A7HCyBKi
	wF/pDexz2yppUWhicmxU/2kE3lkKPYimRib+fF7CaGM0qjjnXwrhdS4vHnou6RrV
	EVjMSrwFdXziiT59gkA7uPl/AviZjgmXFWs86YJ9WBplCR3EcFHPJUyeDqlI1exl
	Ik0d9zSxAtcGjRU+MirmRygpW/tkxZKsW+yop+EEV+KJVPEzcpfUjzY4xrUSYUlg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu43q6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:00:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JCuuHr024651;
	Wed, 19 Aug 2026 13:00:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw92t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:00:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JD06gt43319694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 13:00:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F2758062;
	Wed, 19 Aug 2026 13:00:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5E0C5805E;
	Wed, 19 Aug 2026 13:00:05 +0000 (GMT)
Received: from [9.61.25.66] (unknown [9.61.25.66])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 13:00:05 +0000 (GMT)
Message-ID: <5db518eb-8bde-4a04-b552-80bd444037c9@linux.ibm.com>
Date: Wed, 19 Aug 2026 09:00:05 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-5-akrowiak@linux.ibm.com>
 <20260812201845.076301F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260812201845.076301F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfX3WZyQRgJuR5A
 QuYfxpkX95oCIMgldgdXPb7SU4192BuJe2ScsA539GrQqWWG03fOoUgAOMhRrnnLoRHUfPxPbIB
 EIMsFwlTVgGEujOG896U0epBd1SLeuw=
X-Proofpoint-GUID: A0Cl-UMp0qwalz2pbq-1n8ZXNrvXJY7M
X-Proofpoint-ORIG-GUID: A0Cl-UMp0qwalz2pbq-1n8ZXNrvXJY7M
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85a8d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JEP08AD3klR8GEedPp0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfX05L5s3d6Ffk+
 MkrpnvIdPd2fB+GLmjpu36gRzh0eowJfk6Q4arA5EmwlqZNLIQjuNYLm6fHdJP2RtidtHBkT8KG
 MF6HXQfHgvfWRoAQp7Y8e3RhXXhNopawnX0oOuXX4vyv8yatM/e2/oFyuH1c6TYvQLEQuNcXJhc
 x/mU8coY5bN0rDJt9pmw7o58RannU9SOkG/Vydc/e5PaMHt9liYEGAb1Eja1xs5WvvGzvqsDXEF
 nPIbKYRmmex+p6do6vAFT5FGf4562Fux7yvmdAJoQC2Po++X4wWJ+CmLz6yMbp0wSqW5xeP3G+W
 9zleDo0EWo/szbJvvWipEwCuOTS86CITbu3QzDjmufZQaaWZzi+V1CxclXK1UBGh+eTF88j9tna
 7x80SNe1GZ/GB2sjSOnGVaZ0Hd/RyzFJpr1G871bIYekFfx9L6dZge8LnRx/D9OFBROyn22eCBc
 lRt/qt2uYz5lanX7TOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190097



On 8/12/26 4:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Hot-plug add state is overwritten instead of accumulated, potentially dropping hot-plug events.
> - [High] Pinned page and GISC registration leak in vfio_ap_irq_enable() when ap_aqic() returns a default error code.
> --
>
> --- Patch [4]: [PATCH v5 4/9] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object ---
> commit 65680656f25b3ea60807c838ba28f8d65cca5a45
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
>
> This commit adds the missing matrix_dev->mdevs_lock in vfio_ap_mdev_cfg_add()
> to guard against race conditions when modifying the ap_matrix_mdev object's
> fields.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index f2d662e388bdc..21c502598f8ca 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2777,12 +2777,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
>>   	 * called.
>>   	 */
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
>> +		/*
>> +		 * The mdevs_lock must be held in order to access fields
>> +		 * within matrix_mdev
>> +		 */
>> +		mutex_lock(&matrix_dev->mdevs_lock);
>> +
>>   		bitmap_and(matrix_mdev->apm_add,
>>   			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
>>   		bitmap_and(matrix_mdev->aqm_add,
>>   			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
>>   		bitmap_and(matrix_mdev->adm_add,
>>   			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
> [Severity: High]
> This isn't a bug introduced by this patch, but does this overwrite the
> hot-plug addition state instead of accumulating it?
>
> If multiple AP configuration change events occur before the AP bus scan
> completes, it appears that vfio_ap_mdev_cfg_add() unconditionally overwrites
> the deferred hot-plug bitmaps with the delta of the most recent event.
>
> Should this logic use a temporary intersection followed by bitmap_or() to
> accumulate the pending additions so that hot-plug events aren't dropped?

Looking at ap_scan_bus(), the entire execution is strictly sequential and
single-threaded under ap_scan_bus_mutex:

1. ap_get_configuration() is called once — a single PQAP(QCI)
    captures the snapshot of the configuration delta for the entire scan.

2. If config_changed, notify_config_changed() is called once — this
     fires vfio_ap_on_cfg_changed -> vfio_ap_mdev_cfg_add exactly once 
per scan.

3. The adapter loop runs.

4. If config_changed, notify_scan_complete() is called once — this
     fires vfio_ap_on_scan_complete exactly once per scan.

Both notify_config_changed and notify_scan_complete are also guarded by
ap_scan_bus_mutex which ensures the entire callback pair is an
atomic unit from the perspective of any concurrent scan attempt.
The mutex_trylock(ap_scan_bus_mutex) is used, so a concurrent scan
request is simply dropped if one is already in progress, not queued 
behind it.

So the scenario the that two on_cfg_changed firings accumulating
in the bitmaps before on_scan_complete clears them is structurally 
impossible.
Each scan atomically fires on_cfg_changed (at most once) and 
on_scan_complete
(at most once) as an inseparable pair, with no mechanism for a second 
scan to
interleave. The comment is not valid.

>
>> +
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>>   	}
>>   }
> While reviewing the file, I noticed a pre-existing issue in
> vfio_ap_irq_enable():
>
>> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_enable() {
>> 	...
>> 	default:
>> 		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> 			status.response_code);
>> 		vfio_ap_irq_disable(q);
>> 		break;
>> 	}
>> 	...
>> }
> [Severity: High]
> This is a pre-existing issue, but does this default error path leak the
> newly pinned nib and registered nisc?
>
> When ap_aqic() returns an unexpected error falling into the default case,
> vfio_ap_irq_disable() is called. However, it seems vfio_ap_irq_disable()
> only cleans up the previously successfully saved configuration, bypassing
> the newly pinned nib and isc held in local variables.
>
> Can a malicious KVM guest repeatedly issue the PQAP(AQIC) instruction with
> configurations that trigger this error path, causing unbounded memory pinning
> on the host?

This one is a real pre-existing bug. By the time the default case is
reached:

1. The nib has been pinned
2. The nisc has been registered

Neither has been saved to q->saved_iova / q->saved_isc yet, so when
vfio_ap_irq_disable(q) calls vfio_ap_free_aqic_resources(q), it releases
whatever is in q->saved_iova and q->saved_isc; the old resources from a
prior call. The newly pinned nib page and newly registered nisc are never
freed.

A fix patch is forthcoming.

>

