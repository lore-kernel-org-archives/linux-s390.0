Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25F4119F4;
	Wed,  7 Oct 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374808; cv=none; b=oiC+TfELL/dT02ATVk2mjeaTcjHrpfLMdxM9czKCAC17XPDbWMpBvaPXGa5gjRYUjiz+SHYlukBHPdIahk/1amWcANatCjOWVzBROFfIxiMepppWrom3enMhK9fIEnfu4TFj+Ih46NpqJJG8C3bCsHL6Be7SvRYN6rsTlhVRt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374808; c=relaxed/simple;
	bh=wKlJ2DHRqIhAdaST3wmyUh3jO4bx9A65bBiPfUs5SF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7YmW0+usy0wuBaw7AIjEK8Df/SRMRqrM6hfJ7JetV3oegRuXRemNiY5hqWNtJfiFnv/tZtzlj1HdxfQC6q4asSxyXQBEesVHt8fvSg4E5xcPZP8jQQnHd4I/cvCRQoRmekAKLqGSG5edcOdVpJOJMQ2DPhbrgrfvxBsdMrvvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nY8gB82m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nY8gB82m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZw1U597192;
	Wed, 7 Oct 2026 12:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aHl/f0
	PxPOIXzHvjNa4odrw4F9RL3GJE/YaGipHz4b0=; b=nY8gB82meMmTOa0VlPxwqB
	K759TAqpHozvq2V4vl0/9zY3qmX5pIlfd3HvvG9TsftaNvtMSBTBlwaIEOMCcXl9
	FTqVFvUuc6xfu9FIsSmqH/J0O0CrfTD2bMqON7DBXwgBO9jBvUG6rq0y0f83LlFq
	e3OgFEhJ+fdlZKKqOpW/PDpR3qDjsh79ef9pBAQ0TOIMp8u4ziqituh/1oEuWQx0
	prJmnAZS7Y2gecuJjUfdix4kZKeIEbnMz//n5SBHIhswzCfZPMz+mdPNWi5wVHLk
	rZW64k017ni/sNZRbTScjNWUaSJabKpmtdBMMhazldVAJ8ndtF7D5cnOai9eVmbA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn8n2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:06:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BlaWg1808466;
	Wed, 7 Oct 2026 12:06:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:06:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697C6RZj18940464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 12:06:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E495806C;
	Wed,  7 Oct 2026 12:06:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A838658066;
	Wed,  7 Oct 2026 12:06:25 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 12:06:25 +0000 (GMT)
Message-ID: <f50d6afd-a54d-4bd9-a745-6bced1e6e86a@linux.ibm.com>
Date: Wed, 7 Oct 2026 08:06:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs
 'features' attribute
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-15-akrowiak@linux.ibm.com>
 <8b8dc348-ac31-4dbe-a518-9563d5414f09@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <8b8dc348-ac31-4dbe-a518-9563d5414f09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfXyWGCSb1DwN4B
 W43Me398UhcyI1+tt/pyMh3PDkvI20RcpiOOKamD783aPQMQlErKwHFSD/3T9FFJ3TvD4X/z0vE
 eKxM8qekhtiBuivO4StsiwU94DPfbb8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfX1pZr28jah2fO
 SGA78iSjdQdtYcpso/efUJR3++MMXWDZPIKiSskHr6HqIIThJ07kRR2lyfJOX4yXBu9zuBTAQtM
 SwrULto+sKOwRMnIoW9/HqjcPrxvwVfToJoQj3Xrcy6zmXtX4IL3PMy4gfnLEY6Qde5J0NddZ4p
 YllUIOCwBG9RAlcI1VswWnDcR8Bt00M/KodaGgkGiO4YDYwo6BKtRPKcdqTGWtmIjY1VOQkoKXk
 +urqu32Z0B2tXhL6in9hwAXxLldmn+tD22/JLPRfL5BC7XTx43XQ7+PLIOwe3IxcVbyMCM7DPKr
 lqE2pBbquk/VqQBF+dRbrEUT/8Comfs2Xw/Eb3hnrNHfdN15n92dVi6193M4WiMvV/cF1X0iab9
 9N+rv4zsGH5mQXTyd8gwrJRCVFTTm8yIyNjfWiBBr95VYSGMLlMkNgEi8WVJ1+KBwfY8MyjVYFv
 EGRnfdNdhexYDSZN+BQ==
X-Proofpoint-GUID: F7R09YOK10rAc8pjJIWzD_wfBnm8eEAm
X-Proofpoint-ORIG-GUID: F7R09YOK10rAc8pjJIWzD_wfBnm8eEAm
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac635c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qnWB845URLmzp39-Ai4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070048



On 8/20/26 9:01 AM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Add the 'migratable' feature to the features provided by the sysfs
>> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
>> of vfio devices is supported. Since live guest migration is not 
>> supported
>> for SE guests, the 'migratable' feature will not be included when the
>> feature attribute is displayed.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index 8e69ed286bb9..abfb34421d74 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
>>   struct ap_matrix_dev *matrix_dev;
>>   debug_info_t *vfio_ap_dbf_info;
>>   +#define VFIO_AP_DRV_FEATURES    "guest_matrix hotplug ap_config 
>> migratable"
>> +#define SE_GUEST_FEATURES    "guest_matrix hotplug ap_config"
>> +
>>   static ssize_t features_show(struct device *dev, struct 
>> device_attribute *attr, char *buf)
>>   {
>> -    return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
>> +    /*
>> +     * If the system running is an SE guest, it will support a 
>> different
>> +     * set of features; for example, it will not support live guest
>> +     * migration
>> +     */
>> +    if (ap_is_se_guest())
>> +        return sysfs_emit(buf, "%s\n", SE_GUEST_FEATURES);
>
> ap_is_se_guest() is defined like this:
> is_prot_virt_guest() && ap_sb_available();
>
> is_prot_virt_guest() makes sense, this tells is this is actually a 
> secured guest.
>
> But ap_sb_available() "Returns 1 if secure binding facility is 
> available".
>
> What do we want to happen here if is_prot_virt_guest() = TRUE while 
> ap_sb_available() = FALSE? Have you considered this scenario?
>
> Also, the code would be a bit more extendible if you emitted the 
> static string of always supported features, and then if(se) emit the 
> string of se support features prepended with a space. Then new feature 
> updates only have a single string to modify, so no risk of 
> accidentally missing one.

Is this what you had in mind?

#define VFIO_AP_BASE_FEATURES "guest_matrix hotplug ap_config"
#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"

if (ap_is_se_guest)
     sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
else
     sysfs_emit(buf, "%s %s\n", VFIO_AP_SE_EXCLUDED_FEATURES);


>
> Also, I'd consider using "migrate" or "migration" as they match 
> existing feature designations better. We did not use hotpluggable :)
>
>> +
>> +    /* Return all features supported by the vfio_ap device driver */
>> +    return sysfs_emit(buf, "%s\n", VFIO_AP_DRV_FEATURES);
>>   }
>>   static DEVICE_ATTR_RO(features);
>
>

