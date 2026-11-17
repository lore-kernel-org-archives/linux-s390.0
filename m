Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951171;
	b=cQ1gWn2/ezZdEZ73GQtgrpaSObQ0xtlyGP3YWqe6tGpI7y8X8eXF889w+Kh8bVISNwZm
	 m10zrJQR9HNNavzhIDCdca8KbiFFLzD6pGxZsX2Z40wULEt/UVX/iSaHjJn55LRRQs5YB
	 jj0z0PK7cRJuUTJc88D/eHoMcaf9TkXCjEbjuejwJ6PsadK1dNXuzuvYzcX7Ft9Hze8I5
	 97zI73Hnpn53JCpg3AvxbLw7J1gwt4FubJbeaJocK7WNZrO5gFqOIT/CKLYqikNUzEGVF
	 ZeaJzccdh/RUz0fhkGDlXrphxrVPFE5r91VdnkbyoPY4LW+3pyCvXFxO6YdB7+I7cvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951171;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XmbKYn7cYCFiHw5XW9TnoudqhK+6mhBs2DWToyv4xPw=;
	b=nnMS8aS/qVmiQvqKRNi7awK67wpgDDE5W3x4OvhpOhvJ58pptvcGh/JNY8jp5IgvBST6
	 xUWhoakmQpDXj+kMMryqqsTi0uYnLjw7YBhLdyNvULVsdYaudzZrOU+KUOAZP2DIrWCZc
	 9m8hdUKEmZUDL/+dct44d5TiWlUHMzl52vwvtySviaO+6mE6sXJUW9lMNstm/K4go9gDk
	 uamMbTQWiydfo5h1A59B1c3SZp01tIO2Hi2IUSIDV1y4ZkDEVt7qfkjBY9eikTRT2RK3U
	 tOOiWcnPTgyFLtCcdZY7ckuA++64HFTyOyebRbB5AN4HkqDe6G7Mzzbq42yQKdOzJNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FfKpy+hy;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100C606A31C;
	Tue, 17 Nov 2026 21:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D100C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FfKpy+hy
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJQBXY2022312;
	Tue, 17 Nov 2026 21:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XmbKYn
	7cYCFiHw5XW9TnoudqhK+6mhBs2DWToyv4xPw=; b=FfKpy+hyv2Scn+BZMTFtfC
	blRPWqUlawkVCYmxXHyJahNHRr+0vQgqfRQTASmRxdtmFf48RUv6cw9UvbJu8Bkk
	sMKTQc1u011G2UwZEs9FILcXizQoIrlBXKSrc0jsniTRq/iNVsU7WywBH9+RjZEF
	nDSQO3NGevNVRkCoX2YlRAExLr+y5ov/yFxIFFr+l9XTgv9wsCiRcNiLlG1POQYf
	ulZZ3RLPi4imy1IdZpI32iC1YJ8Pys37dtYFBs5lFWEaHuusp158LgFt1JSoBEjS
	YynWy7bftxGZHA3yGX6PX6ewnw0AylpTP4kjRefDz5E1/swbI2qWt7VBQX36e6wQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2dcut8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 21:32:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6da02283202;
	Tue, 17 Nov 2026 21:32:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt61n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 21:32:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHLWlij27591290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 21:32:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 876885804E;
	Tue, 17 Nov 2026 21:32:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F375803F;
	Tue, 17 Nov 2026 21:32:46 +0000 (GMT)
Received: from [9.61.4.73] (unknown [9.61.4.73])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 21:32:46 +0000 (GMT)
Message-ID: <d1b8b3a6-9172-4422-b23c-a78df596b83f@linux.ibm.com>
Date: Tue, 17 Nov 2026 16:32:46 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-13-akrowiak@linux.ibm.com>
 <sashiko-outbox-209669@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-209669@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXyLFdMNKLyFeC
 6lPvRHDNE93KQ5bm3Sf1fbHcN3wiU7ZNvIQDlFp4Lh7pn/fGnV6UEsnwOouv4uCyO0Zi2GhPkby
 t6taFH97UG7Nhi4WAFxukB6DHkBICFc=
X-Proofpoint-GUID: ezvfSCkAAyaEDR3AAaw75BrJFD6ay1Ab
X-Proofpoint-ORIG-GUID: ezvfSCkAAyaEDR3AAaw75BrJFD6ay1Ab
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afcc801 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cpCIfTzt5PBBOTSFqewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX9hMbde+DdSmG
 w0bcsluXq9L94+gGNPgBHxocQnw2Wd36WiaBlWpLaBEadxra2Wtzbs2112yhJ8eYgc8xAhxZ5iy
 hcoBH2ig6i1KJMhKWGis3OkQdM9X8Wet0MM7O9aZiqk0XJ9iRXyQNW7N7J6WetYGbb88IT3b7NU
 eVsBNiWv+QhoDOExls+rAPfQucRNGO7kWAJJaMRjF6u3orMv3EylanyqI34aBUeqzx5DyuhPpy6
 x3cViHYdaH+s5jUC/IuEnHgpNbnBgKH/jnWBBJHd3rz4OqpiEVW5ybm3lViSVjvKRm4uF39WHDu
 agOauYehb3bkGqxO1Hky6AlT/7qYgkrPY3yhii9dhtbGxeTVRP4/IQIcsuKX2MkOrf7eV9aYjgj
 gIkRpQEfnekR30wPrVg2IlinHaqd6KSp0Gvsg3k20g5LQExH16GQZ6RZ3OQPm5NO8wgwKKx7oML
 x7oMfgAs4vuLILMd4HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085



On 11/11/26 3:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] s390/vfio-ap: incomplete kernel-doc on
>    vfio_ap_setup_vfio_device_migration()
> --
> 
> commit 4bbee35693e7530ca98001e694624b10c95b87d4
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> 
> s390/vfio-ap: Set up for vfio-ap device migration
> 
> This commit adds vfio_ap_setup_vfio_device_migration() to populate
> vdev.mig_ops and vdev.migration_flags for non-SE guests and calls it from
> vfio_ap_mdev_probe() before registering the device.
> 
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 4af734aeee17e..28370b1b3833e 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1316,6 +1316,28 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
>>   	.migration_get_data_size = vfio_ap_get_data_size,
>>   };
>>   
>> +/**
>> + * vfio_ap_setup_vfio_device_migration:
>> + *
>> + * Plug the object containing the function pointers to the migration callbacks
>> + * used to facilitate migration into the vfio device and set the flags
>> + * indicating migration states STOP, STOP_COPY and RESUMING are supported.
>> + *
>> + * @matrix_mdev: pointer to object containing the vfio device (vdev)
>> + */
> 
> [Severity: Low]
> Does this kernel-doc block need a short description on the identifier line
> and @matrix_mdev placed before the body description?  Without a short
> description after the colon, running kernel-doc with -Wall (make W=2)
> warns about a missing initial short description.

Will be fixed in v14

> 

