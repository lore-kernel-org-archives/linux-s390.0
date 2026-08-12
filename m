Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F5495048;
	Wed, 12 Aug 2026 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574723; cv=none; b=gJoqgQT6uBcOqP5HklF/2fS0Y/CAfPaCj8r578loherYT+sABSs+VU1wvjc7K1yBTrIVycfQwWfdDwp6jVdtkV7yDkuXC1RDSieQFCe/BgIa/9M8MTgZZ/Btb1hO3PvWsBkGnjc9OToPxkHKkv1px4qhD0baEgPVzjydp+QvyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574723; c=relaxed/simple;
	bh=OFk3M7NcIux2MetSoSsHMwmMs0ahxJOY2+dHLWvxYW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ol+u8DK23FDWhRv7z27xKJ1EjZpjzHHhbzkTZrGDCpk75jc3hfQJb1vyXVaLwgcRQ+kNOlE2DDJ+Qm7nIdSUGPbfVlWY5t0J+mJ638sJMECSTjpojbfphJXe5f4FRn9jC8eRbYb5ASIHNwSmSoLkWhJT82d0Pf/O8hgT11Gn8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALKamtKl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALKamtKl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2m8c292164;
	Wed, 12 Aug 2026 22:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gB6Nk+
	l5JcfhBzVN8/vXCu+VApu9ZiINTS66znEri0E=; b=ALKamtKl+8BX4OhOK9HcrY
	KY6Lu08qENK/n7hXtLFgsl8DajAcYyzprFPQ+fb3k3mcXk8EVWWs0hmlITeucDpw
	Ky1qFVAf29k+n9pUXpTipu/I5dR53ypUQ0Mj0RYSsEOPZEaJDeZ/wvbH6S9q0iM9
	Zlo6FkiuxQ1ZrWxfKu7xCuDA3X/zlfxueSIkKkv9WZd2fnBIdE/9Us/hK+qTyCeE
	lz/g3Lbkz/gTnFQZNZp2klqzDQW2pOROMreI+EK+ZlbeBzH2PKWU72KwQrEuw0As
	VkGXIvC/49v6FzpOC7+4bjjW7uUxQq8ZGrgEmB8QK4/awU47tDyk1FLlRiyhhIsQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9w6b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:45:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMfIpw017440;
	Wed, 12 Aug 2026 22:45:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk0e93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:45:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMjFFU22413880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:45:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7960758052;
	Wed, 12 Aug 2026 22:45:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E737F5805A;
	Wed, 12 Aug 2026 22:45:14 +0000 (GMT)
Received: from [9.61.244.42] (unknown [9.61.244.42])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:45:14 +0000 (GMT)
Message-ID: <dc71d9c8-c499-437d-9b54-814604507953@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:45:14 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 4/5] PCI: Fail FLR when config space is inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
References: <20260812223459.GA1087632@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260812223459.GA1087632@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfX9cBu0BN/jY2I
 J8E9NPnpzcUvirX2XsNvcNhpNEU37Mfm8YxVQKiBA7UHV8uqA7gb9kQAEF7m+QtQYlJbYazf74r
 H0rXEGmFB+I+iajB/iC3jfos1SULXHAilLqXkOk+VRdkQbBemduHIHrDwWRXJGarlZ61W2JU0KW
 sHZyFBASsBFvChcJaS3Qa8ZsF6dwwUtnAJACion03gn4VCpsM7XSQACm8XP8rImL3tVh6LRAH9t
 Zdl71797pDKAZcqh/IgHdzQzxNGlbIju3WTMDxRltRnXDtoZYYafiiF56pOjjuBN6BrM9ZivGcR
 nsALQ5UUQ6aAcK3B3tQrqHC5WNUdZXFpGLEPWfipSVoh+WZOcUkQYNi/EqlrExX8ueG6wGP70sf
 auEcAqcItWYr45/XAEBT3v6CLGzBQqDhiKjxjr/j3K4tZiZ1klNNAAVjQ6h6GZ2XY0S/UrHvf+H
 BMbS/ho9KOxpnD/+6PQ==
X-Proofpoint-ORIG-GUID: WdxHWTwsZ2oFYPcelFXc3BFyjt2Zxxsk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfX/i2A8mhhcGmK
 QMuKy7H9Bq/7exQjuQ1FWr1kR99Ebmy1xKBrFnwM/jVhrwwcnuM/cjXmeDVIFacjywkBMEjhxoi
 6OnbnsdeVnN6vmHLPW0febF6pBjx89E=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cf77d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rrzeS6hzJ0Wm-PAqi00A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WdxHWTwsZ2oFYPcelFXc3BFyjt2Zxxsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120182


On 8/12/2026 3:34 PM, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2026 at 09:55:17AM -0700, Farhan Ali wrote:
>> If a device is in an error state, then it's config space may not be
>> accssible. Add additional check to validate if a device's config space is
>> accessible before doing an FLR reset.
>>
>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e8d7de77241a..9a9d021301c4 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
>>   {
>>   	int ret;
>>   
>> +	if (!pci_dev_config_accessible(dev, "FLR"))
>> +		return -ENOTTY;
> I'm not really keen on this racy check to begin with (though I know I
> acked it earlier :)), and also a little hesitant about doing it only
> here and not in a more generic place, since several of the reset
> methods are susceptible to the same issue.
>
> But I guess in your use case, FLR is the typical method used and maybe
> we can worry about the others later.

Yeah, I was also hesitant adding it to the other reset methods as I 
don't have hardware to test it. One reason to have the 
pci_dev_config_accessible() function was to be able to use it in other 
reset methods if needed.

Thanks for reviewing and merging the changes!

Thanks

Farhan


>
>>   	if (!pci_wait_for_pending_transaction(dev))
>>   		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>   
>> -- 
>> 2.43.0
>>
