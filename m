Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D4423781;
	Wed,  5 Aug 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937408; cv=none; b=ZAs/gxpdQQ7/KzXavrnS+Z6NwMi1qsFLNyAhrpnsa8rXYI/E2/SB3ux4ZgV3E9ykGFS7Pk9ic86YwTJ92E+2ABbx2G5BICuWTNTNjeLRdyiiqYLkIECwDSRP82jpyVwyalrYd1dS0ze643xtKQJDZLGK3oLfKcEFkeCItCMkHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937408; c=relaxed/simple;
	bh=zT9RZTOFtMJhBQphlDAr6LxUHBB1q8k5QWtFXy36LDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO6o6Dlc6MuMrUkjbG7SrwRJylswgi6yrWQj/fQT7kaaA10TU8Rx22OJ23xxDruZDeD3dkE1gc3wpDOzB99SXU9NOvyTZbcQSX8ghRQi0u099VSkKYLCNPOEYZWypDHsvEmmVzIucAxO03xeWX9pSbCM8TrvbpmNOvdUgSEs9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z+nzdzIX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z+nzdzIX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHiUK3825274;
	Wed, 5 Aug 2026 13:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B6QFPx
	DU7ZenqIe86X8HYX3U74dG/Ad0oes9JtZ04Rs=; b=Z+nzdzIXgcD3bwQGQQl9SO
	7paJYpwhNYUUtdB4KgBjjeYIpqXnGsyL5+j8YrzUAFi/oIRk5jcN+7Xn95AZqJQw
	4zMa9T8+lCBFW1jf6F9CDOewwt0MSVNPGyF09nIdt5HT/T79pHpszPBYewUm+dlZ
	KYrFBaIs5qD1NgrU/MIuM11h3LNRjdZqnIs6JiZAQSHviahuv8psJvYLPVLRbn+4
	RpHTYC9uIaAk1AMk7ApMaKTgIR3gFaacW1YVJtTsj568+rCM7rBAmpvqHe00GIwM
	Miu7x4qKrVjJeq+Daf21GgUKXH8A5w5WmoQUJXAP/7Dlal4kFB0fe96Y4+jYC8Zg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h53a8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:43:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DfQfA021856;
	Wed, 5 Aug 2026 13:43:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qpwan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:43:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DhN1759834830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:43:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3A058065;
	Wed,  5 Aug 2026 13:43:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B3F5805E;
	Wed,  5 Aug 2026 13:43:23 +0000 (GMT)
Received: from [9.61.13.108] (unknown [9.61.13.108])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:43:22 +0000 (GMT)
Message-ID: <7167cb43-ba0f-456b-86cc-8d83c979799c@linux.ibm.com>
Date: Wed, 5 Aug 2026 09:43:22 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs
 'features' attribute
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Jason Herne
 <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-15-akrowiak@linux.ibm.com>
 <20260727184600.845101F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727184600.845101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfXz7b0FywWkqYZ
 Dz++1G+C1NsQYCq1Kmxw8tkzzIUE3CLnJPqnGazg/DYmMMytISRsdZTQhZ3SqogpcPYf1F5dLqg
 eUdgLN6Drzg4Q8HNn6SJRqSSa9Ww1TU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX+qfYPpJisAEs
 zAXQvdnlEi2gfiqU+7pV86O2EkM77sv5vIamZKUNpiEeIGuOEaOTj/5xGAb8rIjZ3e1riVLMqip
 zaeMUJui8hqAPbZSC5wRRRlAgEJTldUjLB9ApSLB1L9gVwWBqsf9HOI4bmyFgNJgi/Qn851Z5hm
 l3r4o9uMnJ+HpYfV/h0VxGwaYJ60ymAHE0hXakh0A6PEHBhOSt903jeVjuSWXzc+wTV+SDae1fw
 xgHft+PFlmx/sTHVdVoUOcasDncTmOUvMggOHXalIzO/Fl+adduNrrTvSknCSBFHsiw17ZWv20G
 O8wL0Xpn6UtoSzybxvSplf6OnFv3+WOuzjx6zwnw3T36NKHlPnWvL7te3Jg1jEKuKok6r8bwAzT
 Syjny1YxCR68qS4Fa7BVjw84h6e8rrFq640pKpZzPqBGhcaH2o4Y4y5VEYk2uM3OXE+nwRwWcq7
 8xInsI+36/hj9KkkUNg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a733dfe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lqIjiGdpJ0jVdWuzCrUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q4jKxTWiErxiLQziiI9LlXZNGIDIDGwg
X-Proofpoint-GUID: Q4jKxTWiErxiLQziiI9LlXZNGIDIDGwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050107



On 7/27/26 2:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The 'migratable' feature is unconditionally advertised in sysfs, even when migration is unsupported and explicitly disabled.
> --
>
> --- Patch [14]: [PATCH v6 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute ---
> commit 4ed92108ce1d93cfce3f8740cc391bfad091179c
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
>
> This commit adds the 'migratable' feature to the sysfs features attribute
> to indicate that migration of vfio devices is supported.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 8e69ed286bb9c..4e973736522bc 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
>>   struct ap_matrix_dev *matrix_dev;
>>   debug_info_t *vfio_ap_dbf_info;
>>   
>> +#define FEATURES "guest_matrix hotplug ap_config migratable"
>> +
>>   static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
>> +	return sysfs_emit(buf, "%s\n", FEATURES);
> [Severity: Medium]
> Will this unconditionally advertise the migratable feature even when the
> environment does not support it?
>
> If the system is running as a Secure Execution (SE) guest, migration is
> typically disabled. By hardcoding "migratable" into the FEATURES string,
> management tools like libvirt querying the features sysfs attribute might
> incorrectly assume migration is supported.
>
> This could lead orchestrators to make incorrect VM placement decisions,
> followed by unexpected migration failures when QEMU rejects the migration
> because the VFIO mdev lacks the capability.
>
> Should features_show() check environmental constraints, such as
> ap_is_se_guest(), before including the migratable flag in the output?

This is a legitimate concern; the ap_is_se_guest() check will be 
incorporated
to eliminate returning the 'migratable' if it returns true.
>
>>   }
>>   static DEVICE_ATTR_RO(features);

