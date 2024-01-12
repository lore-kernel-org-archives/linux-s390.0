Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D975EE8A
	for <linux-s390@vger.kernel.org>; Fri, 12 Jan 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dlN6Uwz/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CA05qm004480;
	Fri, 12 Jan 2024 10:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fXVAXNr5i/gtqYxm0exlMoUt8iVwd5LdsYlCTNZcQF0=;
 b=dlN6Uwz/W4LsPxnOGXSYPrkgTwlzSA+SWMthG+kMZQY0FlVGDJfOJYrTkVDtisjlzk0S
 Uzuvk78CAT1B+KpAXiPAhctfUFjL73086cvKJQ2vRf2TFlby6sTN2Z6kFx2mIZHARjrI
 8LZsoEz2LGI9shDgZRAZg13rMWKpIk2PGJrNrWmm8HnmJO3YmsUUknsQeypMqnCLBh4E
 y3VGJK7RMAjtP6ftjgAKDS8AcM+vCjs6/amt7JxgoaFC9DjTz/OFXaRfqNHX9VFa1HcJ
 OCTGBdMqHB4MZyxT+2+GrhPEqTgTedhOXMwspnbtZiNRUGMApLWf1krszcgLAjN9bEj3 kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vk39grhww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 10:22:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40C7HeLv004389;
	Fri, 12 Jan 2024 10:22:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpm97fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 10:22:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40CAMTDd34996600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 10:22:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB7720043;
	Fri, 12 Jan 2024 10:22:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8461920040;
	Fri, 12 Jan 2024 10:22:29 +0000 (GMT)
Received: from [9.171.38.120] (unknown [9.171.38.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jan 2024 10:22:29 +0000 (GMT)
Message-ID: <7cd6c2c5-e466-40ed-8208-c2d7f3a85a39@linux.ibm.com>
Date: Fri, 12 Jan 2024 11:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: fix double module refcount decrement
To: Miroslav Franc <mfranc@suse.cz>, linux-s390@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>
References: <a69fb463-384b-4bf1-8cc7-0d442ec72b2c@linux.ibm.com>
 <87le8vyl7l.fsf@>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <87le8vyl7l.fsf@>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z-GqHQiw0-tswmSRhfddX63cw3MgFLRz
X-Proofpoint-GUID: z-GqHQiw0-tswmSRhfddX63cw3MgFLRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_03,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=671 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401120080

On 11/01/2024 15:54, Miroslav Franc wrote:
> Jan Höppner <hoeppner@linux.ibm.com> writes:
> 
>> On 10/01/2024 17:01, Miroslav Franc wrote:
>>> Once the discipline is associated with the device, deleting the device
>>> takes care of decrementing the module's refcount.  Doing it manually on
>>> this error path causes refcount to artificially decrease on each error
>>> while it should just stay the same.
>>>
>>> Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
>>> Signed-off-by: Miroslav Franc <mfranc@suse.cz>
>>> ---
>>>  drivers/s390/block/dasd.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
>>> index 833cfab7d877..739da1c2b71f 100644
>>> --- a/drivers/s390/block/dasd.c
>>> +++ b/drivers/s390/block/dasd.c
>>> @@ -3546,8 +3546,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
>>>  	if (rc) {
>>>  		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
>>>  			dev_name(&cdev->dev), discipline->name, rc);
>>> -		module_put(discipline->owner);
>>> -		module_put(base_discipline->owner);
>>
>> Good catch. I think there is one more line above this part that should
>> also be removed:
>>
>> if (!try_module_get(discipline->owner)) {
>>         module_put(base_discipline->owner); <---
>>         dasd_delete_device(device);
>>         return -EINVAL;
>> }
> 
> Oh, I was under impression that the following line is necessary for
> dasd_delete_device to work that way.

You're absolutely right, I've missed that part, sorry.

> 
> device->base_discipline = base_discipline;
> 
> I could move it before the if statement before removing module_put from
> it.  Does it make sense?

Yes that makes sense. That way the (decrement) refcounting is entirely done
via the dasd_delete_device() function. I'll take your patch as suggested
below. Thanks a lot!

> 
>>
>> Can you add it to the patch? Thanks!
>>
>>>  		dasd_delete_device(device);
>>>  		return rc;
>>>  	}
>>>
> 
> Once the discipline is associated with the device, deleting the device
> takes care of decrementing the module's refcount.  Doing it manually on
> this error path causes refcount to artificially decrease on each error
> while it should just stay the same.
> 
> Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
> Signed-off-by: Miroslav Franc <mfranc@suse.cz>
> ---
>  drivers/s390/block/dasd.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 833cfab7d877..8e453454c271 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3533,12 +3533,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
>  		dasd_delete_device(device);
>  		return -EINVAL;
>  	}
> +	device->base_discipline = base_discipline;
>  	if (!try_module_get(discipline->owner)) {
> -		module_put(base_discipline->owner);
>  		dasd_delete_device(device);
>  		return -EINVAL;
>  	}
> -	device->base_discipline = base_discipline;
>  	device->discipline = discipline;
>  
>  	/* check_device will allocate block device if necessary */
> @@ -3546,8 +3545,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
>  	if (rc) {
>  		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
>  			dev_name(&cdev->dev), discipline->name, rc);
> -		module_put(discipline->owner);
> -		module_put(base_discipline->owner);
>  		dasd_delete_device(device);
>  		return rc;
>  	}

