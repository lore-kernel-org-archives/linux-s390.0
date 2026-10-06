Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7A27E1DC;
	Tue,  6 Oct 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321382; cv=none; b=cfeJYFQdarYziCFCz7+ebKMBXf3Y9f0tT6eH2E0P8MkTxml2V3DtKQ68+lqBpLOzRbqfiBBwxenm099HBe1tg5no0SgJpZSkOSknnUz12XKMdICMR9dZFK1jBLNPGgADkDKNnoy6U3iq8Ap2+oEZI2cKAKUA8iou4CsmD4u1Gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321382; c=relaxed/simple;
	bh=Wt0tSBXm1m5dvm9QmEBo/E9Zi+TYLJV5vVBCCmQ6bkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1DDOAcp0+5fjtvpLqJCQlecvRpaYv5UFOqGFRtWtrIr/TrYSma6BrWBPesiNHkDt9sT10KUuBqflYHXRSroDF9X/EcO51f++U0DE/aOvCSukLnJbDi2myUenY85DIM/84dBIxwEJ34DpXP7688f5vQ3eykONHTK0dukPO4BRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D1TRSTFr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D1TRSTFr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696I60E4239519;
	Tue, 6 Oct 2026 21:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=On7qUP
	5YkoFz9cJd80++6TqSdJztSGWW/C7z0XCLUcQ=; b=D1TRSTFryOJQHIHt+qEMrm
	+G8K+f4fDg7tOhm8gxm+ZppAhI8WHIZLZma0WaW6xwSfcgtdE1usdp9by/8TRJyz
	8+DqHlOeaoibzxdy5uNoTswMUwB/L6nXJ7cauS6drZ5h/xlpNli7fWLr8JnPO3Ko
	CoIOCychM5Bd9kqagUpNX7PNVWeNRMNkgMSyIbz80sflKBRSylLPHYjIDupkR0SK
	ovRwN4Pjs/gcOCDTQptMPdEOxwh6FV435y6nEQxUvxdkWn4j3tGNIzOr8Mah2hxa
	VZVCnk7o3++/IuPLv6l0tYkz6oYGNCK8F7/03Nd8Zf2IkGwBlTTQaVOIduAbCQ3A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv9brv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 21:16:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696KsuKl860842;
	Tue, 6 Oct 2026 21:16:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek0289-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 21:16:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696LG7Ib10420988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 21:16:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F035805F;
	Tue,  6 Oct 2026 21:16:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D4858059;
	Tue,  6 Oct 2026 21:16:06 +0000 (GMT)
Received: from [9.61.78.19] (unknown [9.61.78.19])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 21:16:05 +0000 (GMT)
Message-ID: <dea9a4d3-f76c-49f7-bb40-d793ebef7da8@linux.ibm.com>
Date: Tue, 6 Oct 2026 17:16:05 -0400
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
X-Proofpoint-ORIG-GUID: 75xFoeZZbkCR0bWsXkJo0D4rhFgoFMso
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac56519 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Bb8CXz_sGeinu_NhX6AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 75xFoeZZbkCR0bWsXkJo0D4rhFgoFMso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4MyBTYWx0ZWRfX5y8xg3ch+Nl/
 NM6iG9wBTRLrrjbp6DYz50VjpPQmblv+eUBqYf7X6tF47Oi0FnjHMmGVJ/2fGlIQGD3vuSJ1aw4
 fLzMPilRB7OuS+/GDMvsXlHb4qjXQi92WDwc95XX9XMwkK6hcY2VnHvh6K4fXf0NEHDLq6EatjN
 uMwLNGFARtVvYtZINMVPYU7N1rsNJkyYpbQO/PIHvlBKClvhRYa7LrpNkff7d+Abptt6t1EPxps
 On6bZAY1CsIN+NToNrOk00GdQjjJUB1uLHl3ksbVyuF0KDhV+k68JAdMCE/he0ylnpOQQp5Cn8+
 TYyMCD3Dt+jfHO8jh82DMNCf4VWPyoTV+0iifuO30nPonYNvy04F7xvkRfXcaJAXiOluup0oQcc
 4J7SCKacOwl0HsTijh1C3+V3FjW6c+hFONMqtnDk4yDFm2+i2DbGOP2r0jNWQTFVG0BWcpAOFK2
 d5puytAAoy57BnDNB+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4MyBTYWx0ZWRfX4s1LSxKpiSZl
 kQIHJ0riFSAryIL82RKxxfd4IUUtn9XSLUuDqveD0022MfGaBNuy89u81DxllxLXZcXSA6IwSqh
 1/vZ97RLTO1CmO2ErJ7EZaE24WWXA3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060083



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

I have not for two reasons:
1. The doc block for ap_is_se_guest() states: Check for SE guest with AP 
pass-through support. Based
     on that it would seem that both are needed
2. This is what the author - Harald - told me to use

>
> Also, the code would be a bit more extendible if you emitted the 
> static string of always supported features, and then if(se) emit the 
> string of se support features prepended with a space. Then new feature 
> updates only have a single string to modify, so no risk of 
> accidentally missing one.

I'm not sure what you're describing here. SE supported features are a 
subset of all supported features.

>
> Also, I'd consider using "migrate" or "migration" as they match 
> existing feature designations better. We did not use hotpluggable :)

Sure, migration is probably better.

>
>> +
>> +    /* Return all features supported by the vfio_ap device driver */
>> +    return sysfs_emit(buf, "%s\n", VFIO_AP_DRV_FEATURES);
>>   }
>>   static DEVICE_ATTR_RO(features);
>

