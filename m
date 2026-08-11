Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F253CAA2F;
	Tue, 11 Aug 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474560; cv=none; b=rgP6jEzFokTgmvQgrq1kSLvNGWU/K0xt1AdHoc6aPQn1uS14RAf08/3vm2Ou/7A6WqXZk7YkbTiX+5gZgFE/BXAl8CQHqDTkvD/od62QlkUUFtZlX2WBhDNk1g/p/C1jEQSEXP7bDgFBN7EjAjHLQOzrQT1BEYrK8KVRSHYAOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474560; c=relaxed/simple;
	bh=zOzZKpREhjCrlKz8YLR8jkmX93Q4hRmSIuzTzWtrGTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9d4bl7ecKxMssMzRZDgXIbWf7rcbvZVycIa06mH6XOjUAMOLBNQ3haukzQtodL6j39/49l1a9P1MlMsmHbQQhGcM3Kw+S882Xu84I4xTQGl+PplTtXybEKFjj/USsYmP4J8Z+1NfNxGZ7hpgSL4aV+F2wo/QiBhc4NS7vlDTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5tQWt62; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5tQWt62"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVuOK847035;
	Tue, 11 Aug 2026 18:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5i7Su0
	R8V1MMfgFOksoxNms1bgCXTmXb8K712EADKio=; b=T5tQWt623I2e4/FsYdStrO
	GgmVCwRDJhOjyphhZDUuAAS/VHKlGLOLV9ZyJ4Nmjh2I9Vxe1XT37cFndNtSLuoY
	daQXs3Gp5TZYJ6vp3/CN844xGWcoXD+Sj4QOK+lS4b/maG3wW7CnDdb4+PB9YptA
	cAzPnSjliyazg9Gc4oJHX+SPkUV31ga7XG4WsbOT24ta0rMvWoL1wUbGuNAWqzD2
	EZ1Ysj62cjGake7xwgWwUU7PzY4qKmy0sH7Wd4DwOPnD4+uNluhPgAMLfGlE6MoA
	K9bwSUmnN8CWPPIlWANztnA9OT94zHwywEVIcaw4gHRjoz6aP1PvL2nLfEvc0Pcw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2wwqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:55:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfMmS009769;
	Tue, 11 Aug 2026 18:55:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjtbnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:55:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BItnSR52494728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:55:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE6558056;
	Tue, 11 Aug 2026 18:55:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B5D5803F;
	Tue, 11 Aug 2026 18:55:48 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:55:48 +0000 (GMT)
Message-ID: <404259da-2b79-42ff-b663-fc0237cd753f@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:55:48 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
 <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
 <c3b21393-d01f-4816-90b6-4c868d4a0f9d@linux.ibm.com>
 <48f2d952-3116-4e0c-b0e6-bc6460446c08@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <48f2d952-3116-4e0c-b0e6-bc6460446c08@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b7037 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=O5esd3SUN7u3lF78KDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7nUpzAmFOgmjEP2lpusvBrybGftiSxNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXyOZuLXucRopT
 EWGLCEOUpIkqzyilYebPQVmSGQ//5Go48M0HPaMTROd70lao+/KITd09QBdNcH272XwjcN2X9Dm
 1eLYUPxzQ7a1YaG9ibaG5InECapJyb8Vsg6eRg4ER2nJD8YRuL194Xcm2HBLhr1qvSXIYau7T9Y
 JLC1IDsyC2X5I6l5CRm1PMY9IDcW5uKLB9+tjyF+jXKwW0Tm36Yldu56yu7oRzZ+GIQXiS7ysPT
 z7uVJmWhyL7AYOxWvtJnfS+uIzsbOv6ix2hNI3vqpFnwuUrKJPSXuVek/7AfsX3kXOuD0N2Kw+w
 9SMCntfJqKUL/sVROtHp0gpAR+rLjeRlzVQTWSYHX7jiZm7wipwdpdcpUqgi6Q8SJ2fa60m0tgb
 LwBFdP4JNOw3ug5muWYdKDIYg+mMrQUgqxJLKpTXPwXGbQGJpoW1UfjKZjcuqP/wXETmf+e48rb
 /JR/Y/RmMylAQIz7tLg==
X-Proofpoint-ORIG-GUID: 7nUpzAmFOgmjEP2lpusvBrybGftiSxNC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX34cPcZfzfKmS
 JIr07DrCP8iOIkdVLdbFkxLlBytPYFxXupR2PHWlVUxo2FAD0/z7MoPAU8CdqU0U/4is22WrG7g
 XMCdOhWLtzzHLfFFAVoB9xQNCUxSoLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

On 8/11/26 2:51 PM, Anthony Krowiak wrote:
> 
> 
> On 8/11/26 2:20 PM, Matthew Rosato wrote:
>> On 8/11/26 2:03 PM, Matthew Rosato wrote:
>>> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>>>> The status_show function that supports display of the status
>>>> attribute of
>>>> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
>>>> function which iterates the matrix_dev->mdev_list to find the object
>>>> representing the queue device whose status is to be displayed. In
>>>> order to
>>>> traverse this list, the matrix_dev->guests_lock mutex must be held
>>>> which is
>>>> not the case.
>>>>
>>>> To fix this, the guests_lock mutex is taken prior to taking the
>>>> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
>>>> there rather than the vfio_ap_mdev_for_queue function - where it is
>>>> needed - because it must be taken prior to the mdevs_lock mutex in
>>>> order to
>>>> adhere to the proper locking order and prevent a lockdep splat; also
>>>> because the mdevs_lock is needed there to access fields within
>>>> the matrix_mdev object in that function.
>>>>
>>>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue
>>>> device's sysfs dir")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>> Please see my comment on patch 3.
>> Also same idea here, I don't believe the pre-existing finding from
>> Sashiko against this patch is resolved by this series, so have a look
>> and consider a follow-on patch if it's a valid report.
> 
> Can you be more specific as to which Sashiko finding you are talking about?
> 
> 
It only found 1 against this patch.  Quoting:

This is a pre-existing issue, but can this sequence lead to a NULL pointer
dereference if status_show() is called during device probing?
If a userspace process reads the status sysfs attribute before
vfio_ap_mdev_probe_queue() has finished setting the device driver data:
vfio_ap_mdev_probe_queue() {
    ...
    ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
    if (ret)
        return ret;
    q = kzalloc(...);
    ...
    dev_set_drvdata(&apdev->device, q);
}
Userspace could trigger status_show() while the driver data is still NULL.
The dev_get_drvdata() call above would return NULL for q, which is then
passed to vfio_ap_mdev_for_queue() without any checks.
Inside vfio_ap_mdev_for_queue(), the uninitialized q is unconditionally
dereferenced:
vfio_ap_mdev_for_queue() {
    struct ap_matrix_mdev *matrix_mdev;
    unsigned long apid = AP_QID_CARD(q->apqn);
    ...
}
Does the sysfs group creation need to be delayed until after the driver
data is fully initialized and set, or should status_show() check if q is NULL?
