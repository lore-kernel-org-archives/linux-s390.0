Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885837E5D7;
	Wed, 14 Oct 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007617; cv=none; b=CKM4ktFKUVcpdkEFli89Pr2PnK01RFAg17NKxz6sB5pRacHm/QK8xzyu5pkbp4MDQMNhh6SZs7q98yY2hhgx1z83/QqEMYRX4LCqUlOLylQzBVO+SU3KN7HtnWJCCjVZcRa+TJXt2yWs6by5XT+pjtltyjmaexKFwhmLMJf0xsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007617; c=relaxed/simple;
	bh=VTAoWVOCdIp/EVRjNBbfSU0WcCjzISApELWwH9sb07o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UWwV8p7cbnuGALyEqnS8dHJxyUEX3bgTT/CP8njCWBgQKdB/2TdXu8OueOsjaoiLs4I1kNez0EJmXXC8BKpBqYoGYsbhmppJFgGQ5EQpxN5EuMFZPnm52ByJeLoSLVDvoz7vfgW2J4XNsYHpTDvbB5YRLZB9amYg+FRjDv0V9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jRtNLkKg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jRtNLkKg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiUWt695300;
	Wed, 14 Oct 2026 19:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=osQWi+
	x3dCVtRDk5d4sxyNoA2fuvURWOk0pEbZ6z7Bk=; b=jRtNLkKgRZTDolUhmh/Otg
	8TA6z/j0obnIyMgBRkvOKnt+b1LVR4Wk80zkRy3HeSLbfQZbnrexvk7ShtLNyYR9
	v1ethDm9SO8lD9eHN1nI9Kcg/g+Xbp56eiUQgbTRx6q/IznZjKbRz5KibuoSKRHv
	BP3hYUga43/+YFi+1Zk/gxl5yooGLJ8pePvrlIlpmAAMsrGRGPg2QTYfubjWjr6e
	fO8IIkd2068wNGzHkA5aq01H8boQ75pIy+NANtQ28IM/y2nuWI0SiSxqKyXyIxwa
	vnfJiC4PdwyfJqgzI9gqkmMppCKs0JXNP+r79MrJFXGlq2GJLERL+CuaJlL1lBaw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpfud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:53:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIYQJJ3639707;
	Wed, 14 Oct 2026 19:53:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg47kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:53:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EJrXit31523348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 19:53:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1E4258055;
	Wed, 14 Oct 2026 19:53:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4104158059;
	Wed, 14 Oct 2026 19:53:33 +0000 (GMT)
Received: from [9.61.132.24] (unknown [9.61.132.24])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 19:53:33 +0000 (GMT)
Message-ID: <f0195620-30c2-4dbf-8c38-b6343a92c9f9@linux.ibm.com>
Date: Wed, 14 Oct 2026 15:53:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-12-akrowiak@linux.ibm.com>
 <sashiko-outbox-170099@kernel.org>
 <35a8a596-ffe8-4b7a-89cc-f82465a9dd26@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <35a8a596-ffe8-4b7a-89cc-f82465a9dd26@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX5igSh93F5sED
 /1cHu/FbyhhyocUwrPSeWx+ThNgdf2R0OaGi6Q6+egqnHBPW3Ur3a1Y0PWvN/dinbAWAQYBA3S1
 mODcdKkieTrbZwdiVP30V0TLyNSM9ug=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX/J6AapGvwdm+
 HnW1s5Z5PrJkM7C8GMwvipP/cNbv21BKRcOJhR4spP1MG3dA57GSOgHdvhoWY7RwmCCOTN/Dj1L
 9kAWs/rZWilcSVqgCAXpz10DjT8ARHuiTy/UsZK12wKt7wK/tTkbjUNVPzVKXUjbbuXeIwafCmi
 tM/rAf+enRrC9pRFsry71CXTgqS0My9xAGyPRTmcoyZyZEChjfDTKWjRjFV7NCMZC3jLR78Tbqt
 /jTGaTnz/4zI9rRoBXhqHr1rMVhQLElvD723q3K+gHnzyQoq52xLXiHr1IYmflJ3v+GmFqmu2T2
 4IurcP2hhrDqUzc6lkzEFc3niP875FMw0Nsax0l4EAmOS3A29qoKFKWdliZTHitfAtPutorv9Gm
 dR3Xyv8oSrBaY2QOIhxWrBSJZdNKttWdw+kyBku7IOSHT0fg/JaCNVR2XLoqeqwYwP4/jC6xj66
 Ly39CIENa4nGsWakffw==
X-Proofpoint-GUID: f40qlw7HclvtUX9o6rBt_CsE2PWIlE6a
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acfddbf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YTg-7m8nlAKSPyv0w3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f40qlw7HclvtUX9o6rBt_CsE2PWIlE6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078



On 10/14/26 3:08 PM, Anthony Krowiak wrote:
>
>
> On 10/13/26 12:14 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential 
>> issue(s) to consider:
>> - [High] fortify: __counted_by() traps on memcpy() of ap_config 
>> causing kernel panic
>> - [Low] build: incompatible pointer type warning for num_queues in 
>> vfio_ap_get_config()
>> -- 
>>
>> commit 1f3606fec30cc37e82a55e4d85b768771f43fc2f
>> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>>
>> s390/vfio-ap: File ops called to resume the vfio device migration
>>
>> This commit implements the write callback function for the file stream
>> created to restore the state of the vfio-ap device on the destination 
>> system.
>> Userspace reads the source guest's saved vfio-ap device state and 
>> writes it
>> to this file stream. The write callback copies each chunk into a 
>> pre-allocated
>> vfio_ap_config structure and validates it against the destination host's
>> configuration.
>>
>>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> [ ... ]
>>
>>> @@ -284,7 +340,7 @@ static int vfio_ap_get_config(struct 
>>> ap_matrix_mdev *matrix_mdev)
>>>         lockdep_assert_held(&matrix_dev->mdevs_lock);
>>>   -    ap_config_size = vfio_ap_config_size(matrix_mdev, (int 
>>> *)&num_queues);
>>> +    ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
>> [Severity: Low]
>> Is it possible this causes a build failure? vfio_ap_config_size() 
>> expects
>> an int pointer for its second argument, but num_queues is declared as an
>> unsigned int. Passing an unsigned int pointer here introduces an
>> incompatible pointer type warning which breaks the build under
>> CONFIG_WERROR.
>
> The async bit in the AP queue status word indicates that the response
> code was reported asynchronously. Per the architecture, the only
> response code for which GR2 (hwinfo) is guaranteed to be populated
> is AP_RESPONSE_NORMAL (0x00). For all other response codes, including
> AP_RESPONSE_DECONFIGURED, AP_RESPONSE_CHECKSTOPPED, and any code with
> the async bit set, the architecture states that all fields except the
> response-code field are set to zeros, so hwinfo is not valid.
>
> AP_RESPONSE_BUSY and AP_RESPONSE_RESET_IN_PROGRESS are transient
> conditions; the function will be updated to retry up to 5 times with
> a 10ms delay between attempts, consistent with how other vfio_ap
> operations handle these response codes. All other non-NORMAL response
> codes will return -EIO. The async path in the default branch that
> returned 0 will be removed.

The above response was intended for patch 07/15.
The signature for vfio_ap_config_size() will change the type of the 
num_queues
parameter to unsigned int. This will be done, however, in patch 07/15 where
the function is introduced.

>
>>
>> [ ... ]
>>
>>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char 
>>> __user *buf,
>>> +                      size_t len, loff_t *pos)
>>> +{
>> [ ... ]
>>
>>> +    ret = validate_resuming_write_parms(filp, len);
>>> +    if (ret)
>>> +        goto out_unlock;
>>> +
>>> +    ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>>> +
>>> +    memcpy((char *)ap_config + *pos, kbuf, len);
>> [Severity: High]
>> Does this memcpy() trigger a fortify panic? The struct vfio_ap_config
>> utilizes the __counted_by(num_queues) annotation for its flexible array.
>> During the resuming phase, ap_config is allocated with num_queues 
>> initialized
>> to 0.
>>
>> Because memcpy() is fortified, it evaluates the maximum size of the
>> destination object using __builtin_dynamic_object_size(). At the time of
>> this memcpy(), ap_config->num_queues is still 0, so the compiler 
>> evaluates
>> the destination capacity strictly as the struct header size.
>>
>> If userspace writes the migration data in a chunk larger than the header
>> size, the bounds check will fail before num_queues can be overwritten,
>> triggering a panic and crashing the system.
>
> The memcpy() destination is (char *)ap_config + *pos — a char * into
> the raw allocation, not an access through the flexible array member
> qinfo[]. The __counted_by annotation on qinfo[] constrains accesses
> expressed as ap_config->qinfo[i]; it does not restrict a char * byte
> copy into the same allocation.
>
>>
>>> +    *pos += len;
>>> +
>>> +    /*
>>> +     * Check whether we have received all the data.  We know the total
>>> +     * expected size once num_queues has arrived, i.e. once *pos is 
>>> past
>>> +     * the fixed header.  Until then keep accumulating.
>>> +     */
>>> +    if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
>
>

