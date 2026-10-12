Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CE3B4EBC;
	Mon, 12 Oct 2026 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843436; cv=none; b=TMEYufjdgXxnxZOTFXtmMeeCvtoKQvHu9mYee5LayvHQXSEi1M2e02XnEDFA9lE8HeWRm5UadSB3ved7Ohi9ImWFUR0svLZ9vEycpptYJIin16HhXppFIT042pgFmflxRyiY3BfHmm2Rg0oM4GBdBi6JDExpwCmY7P532DWKaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843436; c=relaxed/simple;
	bh=4k++ZqYbmzGqUPJa/luIJHebzSfaEw5Li2kkNbpyAOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2FOxUU1GlDW6984Snyg32JuLvSvn+/QlnezUgYGMqWbv0UFg4qNUnuMzAUady04RAvCNgcUfM/J69nZRyJGMOoCAFaHl/TOhyyqyW0x6tarDNePLtavPpPnYxJVGG7dRP1/5MB/NUWRO8ojldHJPDrFlhSl+1oy5ZsidICkO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkfMRjQk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkfMRjQk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJiJwB3560113;
	Mon, 12 Oct 2026 22:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xllOav
	8W2X9EPNglab9Mg+xrzszV6p27Nq/zLg7L+Ig=; b=qkfMRjQkcWT4YVYtK8+24I
	F1OkxmdY1RPTOBE5b3IJkIDbkOuO78O8ZocsxGFzeESUlYVxz6r3ixQV/Y+ybF5x
	bs1/i0gH0fms1vXAyP5pJiJ/9pNRq3YX8d6iiSf02BySM0HB4KNeJKHYOs+x7Vci
	wokEbJjG6HUOd5JNCezeGoTJJXTBdXav3tBQOL4KnkqfJg/DDhQ/AUKwVr5QvBta
	fEPmV+v6zSZqxDUy0oK6nIcdEBEtM+VCfToO0BOfNFkMJn7Sgs5j9TRMPIY6pG+e
	sRPRi9r/5JQzkWRsotQdtypF3t9YxZhYl3LU5aMqLwcWLP1OVp5OMWyt4aVcK62w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhb32a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 22:17:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJOSIT587027;
	Mon, 12 Oct 2026 22:17:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfxxne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 22:17:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CMHBV726608332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 22:17:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D375803F;
	Mon, 12 Oct 2026 22:17:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9085958068;
	Mon, 12 Oct 2026 22:17:10 +0000 (GMT)
Received: from [9.61.159.45] (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 22:17:10 +0000 (GMT)
Message-ID: <bcd29f49-cbcf-40da-afb3-3dd988496f9f@linux.ibm.com>
Date: Mon, 12 Oct 2026 18:17:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-12-akrowiak@linux.ibm.com>
 <sashiko-outbox-165452@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165452@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4OCBTYWx0ZWRfX1MDUH+pp+9YB
 XcAP3IRDKLGYGVM69806NkvlWBecq6KnEWm/oeTUzJjJ5pucz2VnmG4NXE1PfFRz4swXMFDXiSj
 USxjb2BewBhQESojhNgHWSvT3LUIKvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4OCBTYWx0ZWRfX+koc2G4sqqGc
 6HgBQPyUE0iXRfR/A5Mn7mqCw3RjfF2A1B1BUfbAIGJ4e70yF8uAZ3vjBFzQSKqpbj2gaEwidII
 ofhzJpFeRnRpy1uZ6IRc/VUIO4BycMYbM7Bs/eZ+7h9gseXl+0Kr2mt8nSvUx/Q8DMNFQ0QGRqD
 Lt6dGw12ksTsfHI0CTVrxB6PYyPWLLAH4wue/e3bSHqpHILz5YUVFJAHzNIueskPMGotXOQKLE+
 QWvX3rHvNFKEDke/lhc91N0qHzarhhaQjYgTwW9LcBRStWO4ZyTVzvLyHSM+XmaoTjf5ulJ6+uc
 YcFVZNtS+BlgrN3xbaZx+NnCmIoDtaf0a5sUaTiWS/atIZts2Yo4bsQTiV/AdkSsfNxeJga/1F+
 ym7xIOpSySiyfRNui8vCIcpsKSd/KjwRCKtIH6uZ0nfMjr/mwm4eMnH0ty48nx6gZwBbN1tR9tw
 QAGSCng4ZlPJ+Sf+VSQ==
X-Proofpoint-GUID: 8XJiU4q8WpbwbPO2jIxVjWWsB2YZPCgM
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acd5c69 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1Ibm_CRvn4jo12nm47sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8XJiU4q8WpbwbPO2jIxVjWWsB2YZPCgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120088



On 10/9/26 7:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] locking: DoS via userfaultfd stalling under global mutexes in vfio_ap_resuming_write()
> --
>
> commit 0439535c7d2f8e78d7863822666908892163a421
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the file stream used to
> restore the vfio-ap device state on a destination system during the
> RESUMING migration phase. It copies the source guest's AP configuration
> from userspace, validates its compatibility with the destination host,
> and applies it if compatible.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 7b9851b79ec5f..caae95b47a9aa 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -448,11 +504,644 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
>>   	return filp;
>>   }
> [ ... ]
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	/*
>> +	 * Hold ap_attr_mutex for the full duration of the write, just as
>> +	 * (un)assign_adapter_store() and (un)assign_domain_store() do.  This
>> +	 * prevents the AP bus apmask/aqmask attributes from being changed
>> +	 * while the guest's AP configuration is being updated.
>> +	 *
>> +	 * get_update_locks_for_mdev() then acquires guests_lock, kvm->lock,
>> +	 * and mdevs_lock in the correct order. This serialises
>> +	 * the entire operation against concurrent AP attribute writers
>> +	 * while the guest's AP configuration is being changed.
>> +	 *
>> +	 * Holding these locks for the full duration of a potentially chunked
>> +	 * write could in theory affect performance, but this is acceptable for
>> +	 * several reasons: migration is an infrequent operation; real-world
>> +	 * guest AP configurations are small (each CEX8 card has 2 adapters and
>> +	 * up to 16 domains, and the 85 cards in a system are shared across all
>> +	 * LPARs and guests); and each chunk write completes quickly.
>> +	 */
>> +	matrix_mdev = filp->private_data;
>> +	mutex_lock(&ap_attr_mutex);
>> +	get_update_locks_for_mdev(matrix_mdev);
>> +	pos = &filp->f_pos;
>> +
>> +	ret = validate_resuming_write_parms(filp, len);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>> +
>> +	if (copy_from_user((char *)ap_config + *pos, buf, len)) {
> [Severity: High]
> Does this code allow a malicious userspace process to stall the kernel
> indefinitely using userfaultfd?
>
> Holding global subsystem mutexes (ap_attr_mutex, matrix_dev->guests_lock,
> matrix_dev->mdevs_lock) and the VM's kvm->lock during copy_from_user()
> allows a compromised userspace process (such as a QEMU instance) to stall
> execution by mapping the buffer with userfaultfd and never resolving the
> page fault.
>
> This would freeze all AP bus attribute changes and vfio_ap mdev lifecycle
> operations globally across the host, and lock up the affected KVM instance.
> Even without userfaultfd, normal page faults from swap or network
> filesystems could cause unpredictable and severe global latency spikes.

Agreed. Holding ap_attr_mutex, guests_lock, kvm->lock and mdevs_lock
across copy_from_user() lets a buffer that blocks indefinitely stall
all AP attribute updates and mdev operations on the host and the
affected guest.

In the next version, vfio_ap_resuming_write() will copy the user data
into a kernel buffer with vmemdup_user() before taking any lock and use
memcpy to copy the contents of the buffer into ap_config instead of
copy_from_user.

>
>> +		ret = -EFAULT;
>> +		goto out_unlock;
>> +	}
>> +
>> +	*pos += len;
> [ ... ]
>

