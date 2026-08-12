Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407B4749C1;
	Wed, 12 Aug 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558615; cv=none; b=P64Y8U6jjPbaeB3l6T5mOPVuOuPSqP7Yxpn0Fx4IOd7m2jL2ns7mVJ81UqB1c7sKVAiz5EF6n96HdFIMdn//dnwL0FHKyK67pYVMVAf0mJkrLMi5J0XCokO8odIwRY/vPHTwfcqvj8DT4TG/pLjb67dm3XUYz2kMPeSSsN9a8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558615; c=relaxed/simple;
	bh=i9kRNqh98uquCry/D6aIVakO255TqdR5R3t3AwA7dxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlZ7SdWnc1eTZ/5LgeIprZmNsGK1+JGBThoDBMPAAbohl5mVqLeINDbxRNAA0z5+0qPkkmhRhpiYQ+uzEqEJVMGXYnaXsjYJ9WR4hvn5A0sJLHouljW2XNLGPtS6yoSogFf1OxNKLwLP6sWkbLE5P5TNye4+2KvFkj/vJiLymZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASjjVogK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASjjVogK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1bIl4120376;
	Wed, 12 Aug 2026 18:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JAspSI
	rWWK7Ln9VV9dpdCu9PaPb0+TbOkLDZfJRpjLw=; b=ASjjVogKPsk/YLYA1bZp50
	OQG4ahTG0IZieHTpmx1bKruILMBtsHWNvS+99ri7W7DUpwez+VC62qmcwpyN9tcF
	NZOiszyATyj9+bh0hZpGWsSD9AtN/5HIea6iOE1NTTvDzmFUY+UfI0zMiNxrFn9m
	ZGfJwqhq1nLfnM+uVvCze0i4p1Km2jN36orjl2vz8oNsZw7m4AlRhTsy1DUKtrl5
	brHoLt1vde2bIZXKkUgjOE0x5s01hJAWYdMyxtT9bQq+jWDzXzsTX/n50D8glOIj
	vDusLTXRgovAlcDA24MzP/jRX7IuY6Iw/F/FQAYMimLcCTQCtOD3tLbZEoi4+N/w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwb45u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:16:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIBGLc002196;
	Wed, 12 Aug 2026 18:16:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy75hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:16:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CIGkRe21758692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:16:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AD65805A;
	Wed, 12 Aug 2026 18:16:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E594D58056;
	Wed, 12 Aug 2026 18:16:44 +0000 (GMT)
Received: from [9.61.9.29] (unknown [9.61.9.29])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:16:44 +0000 (GMT)
Message-ID: <a6627241-c96f-4e06-8f97-64738abb19ad@linux.ibm.com>
Date: Wed, 12 Aug 2026 14:16:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-9-akrowiak@linux.ibm.com>
 <ee819372-edee-445a-8373-138040c51a28@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <ee819372-edee-445a-8373-138040c51a28@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cb890 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XNS3fWSvfy2YhT7ojo4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x6ekrUoHzLBV5wOW52thGv74UziPJvi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX2hu4uoMfDWbx
 1SEyLgjIpRwMz8RvU+3qGOaS/VIvY4ikjbbOtKC8wN1rhNS9cY6r9i6xtsQM7BrwF40H8IJgvs/
 RnVXSSmqyTKFV1R8ZXF526d/a05L8IjTa/rCGBZsx5CztzOy85zr5gnkmerwCGqSfNkjIHXcyJ5
 eDTJVHagQeTBGmInkK3z2dEG9ku4o/4QOVGYWlgA0uICGdfknn9hBYEHK2g2uqEG4cDCVxLI3CM
 vX6DNhz/f92mfj7hUX0n0+SlVV/SO2ocMPHncffW2Vtwa8Wx/DntnOtn7DBFqCdMeNTHWhfAsXr
 gNP39oQJ5RXjhd2KZW8kjIBlG2v8EIUD147nEHvgxJZaocLLnd47bgOmy/oXBvbojTgAWrLUFAJ
 RrUzTgPVe2Jg3sct2WWeWy+ufeaM0W53Onxi9isvdfQDixTpG1Fks4yOkCCMT9+CkzHIjvC6iN0
 ki4wBSP6swsdaIsQspA==
X-Proofpoint-ORIG-GUID: x6ekrUoHzLBV5wOW52thGv74UziPJvi1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX83Ubv1mU0aWV
 mvxHr9dYNxmTgqR3RdXay3CZT2AcbXUra8ROK5HRBwJFkGHsY4bBcoeJSvMDeBm9Z4nhpC8TBbN
 30YyhAoJ6Uv1HhGi9SNXv3MvRu+9N1w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120145



On 8/12/26 1:58 PM, Matthew Rosato wrote:
> On 8/12/26 1:09 PM, Anthony Krowiak wrote:
>> When vfio_ap_mdev_probe_queue() creates the sysfs attribute group,
>> the queue's driver data has not yet been set. A concurrent read of
>> the 'status' attribute can therefore call dev_get_drvdata() and
>> get NULL, which is then passed directly to
>> vfio_ap_mdev_for_queue() where q->apqn is unconditionally
>> dereferenced, causing a NULL pointer dereference.
>>
>> Fix this by acquiring the update locks before calling
>> sysfs_create_group(). The status_show() function acquires
>> guests_lock before reading the driver data, so any concurrent
>> read will block until after dev_set_drvdata() has been called
>> and the update locks are released.
>>
>> As a bonus, the APQN no longer needs to be read from the queue
>> struct after allocation — it can be read directly from apdev
>> before allocation and stored in a local variable, which is then
>> assigned to q->apqn once the allocation succeeds.
>>
>> Fixes: 260f3ea141382 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 16779cfc64e8..b0454a296c67 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2424,14 +2424,17 @@ void vfio_ap_mdev_unregister(void)
>>   
>>   int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   {
>> -	int ret;
>> +	int ret, apqn;
>>   	struct vfio_ap_queue *q;
>>   	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   
>> +	apqn = to_ap_queue(&apdev->device)->qid;
>> +	matrix_mdev = get_update_locks_by_apqn(apqn);
>> +
>>   	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
>>   	if (ret)
>> -		return ret;
>> +		goto err_release_locks;
>>   
>>   	q = kzalloc_obj(*q);
>>   	if (!q) {
>> @@ -2439,11 +2442,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   		goto err_remove_group;
>>   	}
>>   
>> -	q->apqn = to_ap_queue(&apdev->device)->qid;
>> +	q->apqn = apqn;
>>   	q->saved_isc = VFIO_AP_ISC_INVALID;
>>   	memset(&q->reset_status, 0, sizeof(q->reset_status));
>>   	INIT_WORK(&q->reset_work, apq_reset_check);
>> -	matrix_mdev = get_update_locks_by_apqn(q->apqn);
>>   
>>   	if (matrix_mdev) {
>>   		vfio_ap_mdev_link_queue(matrix_mdev, q);
>> @@ -2472,8 +2474,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>>   	return ret;
>>   
>>   err_remove_group:
>> +	release_update_locks_for_mdev(matrix_mdev);
> I think now you've just shrunk the window instead of totally closed it?

Since that locks must be released before the call to sysfs_remove_group()
to avoid an ABBA deadlock, it is not possible to totally close it.

>
> Can't sysfs still be accessed between this release and the remove_group?

That possibility is incredibly remote, but I suppose anything is possible.

>
> Do you think adding an additional NULL check against dev_get_drvdata()
> in status_show() and treating the NULL case like the other error
> conditions would be enough to cover that window?

It would cover that window, but that function does not return any error, so
we'd have to decide what makes the most sense between the following
three values, or create new one to indicate we don't know the status.

AP_QUEUE_ASSIGNED
AP_QUEUE_UNASSIGNED
AP_QUEUE_IN_USE

>   
>
>
>

