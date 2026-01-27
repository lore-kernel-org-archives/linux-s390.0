Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A28CF6F;
	Tue, 27 Jan 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550262; cv=none; b=KTl8SLWQ3vz2W+G0KvZe0TCgxxoBLRoztwfYw30ukCNxNCmjbV0pK6MapPO9dcM7EOjvBjiZgCnUcPDB3gg6XrusQBfOuR6C3mpFznZR3hW88Ap3dlorVP4jfLCY1+Yb39Bvg2E5XmZoVQSe/YqKzgNw+m1kffa8QI+7eQWBKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550262; c=relaxed/simple;
	bh=6l4bw1Yd2nKjt4FYBBDoW4HOZYcuu8LUi8DIaDhYbaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFPkHs/pE5zpdQJj554uhJOKIjNz9OIG5TWSrLoWffCdwS3XEUkpojcl0/wmmMQwoDspMjO8jwRZ0ri8SSavOW0+Qf114Qd7Dt0p/lTAOLp5JON4CUQqXe/Je0iY/L3cIOVRHgobr2NfFsAX/GxAGaugX+CfQf1qpwCoWmigFVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bLmWIGcQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLmWIGcQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RFbcJF000830;
	Tue, 27 Jan 2026 21:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rn+QcU
	wSICptGaK9tl4YzxIYdrdZLakI0LXwRLBdivM=; b=bLmWIGcQ4pQUlTqEndBgBb
	UW4OGds6qWBJdCxRkJsigOZ9Blm1fYf0a1tKLUdMuo1sgaO89ax/ABPEeIyWKdaY
	E0wefxCrU/4sxJruVMSHMmv1h8pRMFyNBbIxrKL4Xf+YBOkPSt9mdUddf7FejCYp
	UtHiUs70wzxe8vM3u7uXJLn/K6lT4heYkwPyO3iUWYSg+Kqb3BYLXzuJTBWgJ6wv
	JKRoFtI4HhYyL1aH4qk2JxUbqKugo2LxgSAMXTgSWwfvcsZaoklu4ppkru0NZUjg
	u9xy0I4DIZu9OD7pEC37bPudd8vTRmmEqN1gc3lUlVrIIdPbdDtNmqqTVyerdP1Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfx2ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 21:44:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RL5DOp006737;
	Tue, 27 Jan 2026 21:44:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8syanmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 21:44:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RLiCwF25231898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 21:44:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C715A58063;
	Tue, 27 Jan 2026 21:44:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B9C55804B;
	Tue, 27 Jan 2026 21:44:11 +0000 (GMT)
Received: from [9.61.255.161] (unknown [9.61.255.161])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 21:44:11 +0000 (GMT)
Message-ID: <88289f74-3d4f-4dd9-8f2a-8871d150fd50@linux.ibm.com>
Date: Tue, 27 Jan 2026 13:44:11 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] vfio-pci/zdev: Add a device feature for error
 information
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, mjrosato@linux.ibm.com, julianr@linux.ibm.com
References: <20260122194437.1903-1-alifm@linux.ibm.com>
 <20260122194437.1903-8-alifm@linux.ibm.com>
 <74ce68664925fa4cc4207c97d431b851b8ec8afc.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <74ce68664925fa4cc4207c97d431b851b8ec8afc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697931ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qNG8fd7tPmr0NF9BgyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rf2bCnUKEYgdWetLimMC-RmEyjUMLDSw
X-Proofpoint-ORIG-GUID: rf2bCnUKEYgdWetLimMC-RmEyjUMLDSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3MyBTYWx0ZWRfX2Ldxx74P60Km
 TlUUCpI9vH0oT5W1464PJ+4dr8UlLTRd1BfrK2MqAUCdKTFYwJXSCEOBXbcZLBF2MVpF0QZWHxK
 nfhA0wQku/Po/a4JlshMZtsb8+DREXvs/w4YBh1blVTZn6HXuxDXku4s/z0w2Er/7f/uhbemQMO
 IM5Ntml1iQuZTMovmbXA597VrYnvklhnNX+2yN/fawqf0z3ViYDYeEWax40lKB+ru26081YNsr+
 8iI2Xx1H2SlhHQ4HRnZlAV7lZCoXt0iWGRy9t3nqhJBeyHgi4sIHlf5aEn/pv8Az3idKziZqnSo
 Cn/KqxYX6lo1/hYpn2E41TMpRg9xXOVJCnrcNrgJ7MT9WIDkzmRcAu2YS5T8vxLbZVHGCBUNqDz
 cSDx3nn1dlc1NSALCDPCwHIYRUQzuBEnJGMJkBWYPNxBkyXBtaqJOADKuObpM/rfyYyF6EZPkG5
 nSACBR9GYZ0pElxprRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270173


On 1/27/2026 2:53 AM, Niklas Schnelle wrote:
> On Thu, 2026-01-22 at 11:44 -0800, Farhan Ali wrote:
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 35 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h        | 16 +++++++++++++++
>>   4 files changed, 62 insertions(+)
>>
> --- snip ---
>>   
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz)
>> +{
>> +	struct vfio_device_feature_zpci_err err;
>> +	struct vfio_pci_core_device *vdev;
>> +	struct zpci_dev *zdev;
>> +	int head = 0;
>> +	int ret;
>> +
>> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(err));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	mutex_lock(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.count) {
>> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +		err.pec = zdev->pending_errs.err[head].pec;
> In the previous patch you saved the entire struct zpci_ccdf_err now you
> only copy out and expose the PCI event code, though? If you do want to
> only expose that the commit message should state this and the reason
> for this restriction. Additionally I think the struct
> vfio_device_feature_zpci_err should include a mechanism (version +
> size?) to allow upgrading it to the full error information in the
> future.

I think having explicit version variable in the struct should be 
sufficient (the __pad can be replaced with version). I don't think we 
need explicit size variable? I have looked at some of the capability 
structures in vfio_zdev.h, as examples and so we could use a similar 
approach here when we need to extend the vfio_device_feature_zpci_err?

Though I don't see any other vfio device feature structure being 
explicitly versioned. I am open to any guidance/suggestions on the best 
practices on how to we version VFIO device feature structs.


>
> Then again why not just expose the entire CCDF? It's an architected
> data structure without and if you add it at the end of struct
> vfio_device_feature_zpci_err and add a size you should even be able to
> handle if it ever needs to grow. Of course you'd have to create a copy
> of the struct to use the the uAPI types so I'd probably also add a
> BUILD_BUG_ON() check on matching size. Or am I missing a reason to keep
> just the PEC?

I wanted to keep the information exposed to userspace minimal. The CCDF 
exposes far more information and may not be needed by userspace/VM. 
Today the PEC is sufficient for user space(QEMU) to take bubble up to a 
VM. I also wanted to avoid having a copy of the struct in 2 places.

Thanks

Farhan

>> +		zdev->pending_errs.head++;
>> +		zdev->pending_errs.count--;
>> +		err.pending_errors = zdev->pending_errs.count;
>> +	}
>> +	mutex_unlock(&zdev->pending_errs_lock);
>> +
>> +	if (copy_to_user(arg, &err, sizeof(err)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
