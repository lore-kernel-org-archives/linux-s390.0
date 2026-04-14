Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941A16A956;
	Tue, 14 Apr 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192364; cv=none; b=KcrQetnJCYHvu3YIKP1y5SHIiLDtTt5KIRHD+scJLlhEUtsl9e1lZEUnJcx1h3pdshgSBSfTz4c+69UBkXtAN73vOwqy5/cJfiu74XF2MxCLEjz5uByH1kSSupxnKG2C389z8RsUlpIDtDpCwPYOlOuChQlZ+FywxqxG53EcCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192364; c=relaxed/simple;
	bh=4BVLYJNCB08LxpFtuxxwJ6fNFl8wv4GUHgOEmwq7+Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5HfTpGwSZ9IaGXuM//J4cR9NpEHfRllqJBNkir+NDbj/FXxVTspsuKnN9QHO9NuehIz3hB7gUv07mlTSunjt/dRGqnFH/+rZVVxF+DPpGfwD1FbBc19x5WLMvcCgW6OzYIVBc25GeGQKy7QxHu45rTBOma5Akxu0cCpQ7f0v/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQpUY1gs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQpUY1gs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EEEHpb1859874;
	Tue, 14 Apr 2026 18:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pU/Lmt
	NGfbrSzTl3fxBiZbfR12td7Tos12b+70Z29EY=; b=LQpUY1gs5gmkHjO2Q1NwBT
	rDyYn08rWcY0uZKbKSSUjAvhtpZzJ8X+OogqUo/5nlqdB/W7uCKuP29cCKoRR/2s
	UOOgwt/oXOZIf1N/c10YwCfl2F5pO4x7eemTORGZeqYp9fjQ3i2FoHu5TD8oUQ29
	6Hl3MF61J5N3VbsYZWJsWqYt8JT/oUeCP3bDX05sQzhteCRpxyvU1cQiZsoW1NMl
	0fVWrp99XpVzx7qERnX3HI2y/ZCG9WQ7g3TRSxYaZ1Av9jll3W4tEURbk+ftURn/
	Z1WDKyLXPcUFdP2Z8AiwHq0zd3RZjK1NfRlo50NMu/mMm81LAAtRijuJOZdUWP3g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pcdxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 18:45:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EHjFFx025831;
	Tue, 14 Apr 2026 18:45:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1ju11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 18:45:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EIjsOj32375360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 18:45:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF4C258057;
	Tue, 14 Apr 2026 18:45:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35A3E58058;
	Tue, 14 Apr 2026 18:45:54 +0000 (GMT)
Received: from [9.61.240.138] (unknown [9.61.240.138])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 18:45:54 +0000 (GMT)
Message-ID: <9d68b944-bd65-495b-b69c-e0d6758f15ee@linux.ibm.com>
Date: Tue, 14 Apr 2026 11:45:54 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260413210608.2912-1-alifm@linux.ibm.com>
 <20260413210608.2912-6-alifm@linux.ibm.com>
 <20260413165758.0f87312b@shazbot.org>
 <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
 <20260414081238.23e2cecc@shazbot.org>
 <5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
 <20260414114132.31481b48@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260414114132.31481b48@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6yF0ZApbGCOMcO6lu5aPliNWH2KYs_n9
X-Proofpoint-ORIG-GUID: 6yF0ZApbGCOMcO6lu5aPliNWH2KYs_n9
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69de8b64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=g5-iASi6csL-DJVLufsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MSBTYWx0ZWRfX91s2XLUgY+FR
 3oNusot9TSkXQzrIttRr5w36U8nA1QRjOqo2CFUd/J9KjkCsDWIsH2b9hxW93IPh7jaLsl6XpGK
 abI0sD/NABngR6bnmZVaSH/XiIytUCozT1SrnexScipNgKM6g2z2fzqk7KodCgqOSqx2jx0bV/t
 9KIhasUXRQPEbzlvIZI7nqbA8HNLJak12kMifnxnoqj7k6mezWA0ue4IXk8hNppdRmKvneyctmC
 835hwSqUw6/2tqUyTOXP+M89inQ69+mMrM5wFhLGQi8oLZGwhkqAI6WS96422G2AgenDrGFCx8F
 WiMlVfeCpROlqpKZpsWl+Vu4s3BabKXceSYWX/0E+/44AQq0IIHEYwJSwWvPCmV9DkW5IYg61I9
 p+AQpwhdMXsX6ue4dvAoa5vshJtRmO8U2hKTFYv1eM01GtnUhUqXDMpOT15S259RJD8l4tPXE7G
 vI/WMr/+IunUwioJnJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140171


On 4/14/2026 10:41 AM, Alex Williamson wrote:
> On Tue, 14 Apr 2026 10:13:22 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>> On 4/14/2026 7:12 AM, Alex Williamson wrote:
>>> On Mon, 13 Apr 2026 16:40:49 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>> On 4/13/2026 3:57 PM, Alex Williamson wrote:
>>>>> On Mon, 13 Apr 2026 14:06:06 -0700
>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>>> index 5de618a3a5ee..2980ca39dd38 100644
>>>>>> --- a/include/uapi/linux/vfio.h
>>>>>> +++ b/include/uapi/linux/vfio.h
>>>>>> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
>>>>>>      */
>>>>>>     #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>>>>>     
>>>>>> +/**
>>>>>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>>>>>> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
>>>>>> + * involves platform firmware and notification to operating system is done
>>>>>> + * by architecture specific mechanism. Exposing this information to
>>>>>> + * userspace allows it to take appropriate actions to handle an
>>>>>> + * error on the device. The pending_errors provide any additional errors
>>>>>> + * pending for the device, and userspace should read until zero. A value of
>>>>>> + * 0 for pending_errors and pec would indicate no pending errors that need
>>>>>> + * to be handled.
>>>>>> + */
>>>>>> +
>>>>>> +struct vfio_device_feature_zpci_err {
>>>>>> +	__u8 version;
>>>>>> +	__u8 pending_errors;
>>>>>> +	__u16 pec;
>>>>>> +};
>>>>> I assume .version is for compatibility, but we don't define a strategy
>>>>> for using it or specify what the version should be for this table.  It
>>>>> doesn't seem like there's actually an value-add to having it.
>>>> Its possible we may need to extend this structure in the future if we
>>>> want to report more information to userspace. I at least want the
>>>> flexibility to do so. We had some discussion around this [1] in an
>>>> earlier version. I was trying to follow similar versioning pattern we
>>>> had around vfio-pci/zdev structures.
>>> IMHO, the version field is a dead end towards achieving this,
>>> especially if we don't specify from the onset the expected version
>>> value or the compatibility semantics.  All that's going to happen is
>>> that some userspace will hard code that it understands version 1
>>> because that's what's currently reported and matches the struct defined
>>> here, and you can never ever report anything other than version 1
>>> without breaking that user.  At that point you need to come up with
>>> some other means for the user to opt-in to a new version, whether it's
>>> triggered by another feature (as we did with the PRECOPY_INFOv2 above
>>> this), or we reimplement the whole v2 feature.
>> My understanding was based on how we version some of the capability
>> structures for zdev (in include/uapi/linux/vfio_zdev.h). If we wanted to
>> provide more information to userspace in the future, what would be
>> preferred approach? Do we need to explicitly define a v2 feature? I am
>> open to suggestions on this.
>>
>> If we need to define v2 explicitly in the future, then yes I agree we
>> can simplify it to return only the PEC code (or an error code otherwise).
> Maybe I'm reading too much into it, but it sounds like you already have
> plans to expand this.
>
> The existing zdev structures seem to rely on the version field in the
> capability header and maybe you've gotten away with bumping the version
> without breaking userspace, but it's fragile.  AFAICT, the ioctls do not
> define a versioning strategy where vN+1 only adds fields to vN, so all
> it takes is one outspoken userspace tool that hard codes its
> compatibility to a specific version to become a problem for further
> updates.
>
> Likewise this feature doesn't define a versioning policy for userspace
> to follow.  I'm sure there are other examples within vfio that are
> problematic, but let's try not to create more.
>
> If you want to use a version, then also define what the version is and
> what the compatibility policy is for future versions.  A flags field is
> another option that we've used extensively in vfio.  The version field
> might be better for incremental expansion of the structure, while flags
> can address specific fields more directly, ex. a reserved field being
> redefined.  Thanks,
>
> Alex

Just wanted to understand and clarify if we can associate multiple 
fields with a feature flag? I think in that case flags would be better 
here and given its also something that is widely used in vfio. I am just 
trying to figure out the best way we can extend this without a lot of 
code churn in the future.

I appreciate the feedback and discussion on this.

Thanks

Farhan

