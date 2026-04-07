Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518722032D;
	Tue,  7 Apr 2026 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596637; cv=none; b=OHz1B27YX5vrSHv8pR3rsi5AkCtfc+CLdW/clwT732SK43ysaHs1/JU3w2DtM9Aq1pDsJODOvrbfqzOtY6DDpNT0C5iAGdkFz7RhX5sMFPD9VcViBUmlaQPNaVZlM2SUIrI6o6Y1OchuA2ROS2NF1fm18mKYvlanKuylOudVm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596637; c=relaxed/simple;
	bh=TA0fXGY5PNGFQVU9U4P30Y/NE6S61I2flZB/1VabXHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/g5jHBfNPKWxdkFNQEFJiuIZQ6+FPad3WlfawP1vVm8C2s9t2GRnSN0f1t3aC9E3aAidvZBDMNI13rF9Xiz4CM3AId23t3fGoDTxXnRmhy4JjScL5hL1eJV/T7Nmbrs8D4nIkKDh4hhwIZ/gUROyeWM06ikMCTHRK8zG62N6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1gt46Wu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1gt46Wu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Efc1W2301642;
	Tue, 7 Apr 2026 21:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LF5J3r
	qYnK5IhXPetz3tjVyZVYzOfzIbTOp8ZHnfS8A=; b=P1gt46Wu34er+kqztYLkjU
	TASr57ZHtaXONF2dgnVMBRz+WhixjyGj3HRwIHejBUmSjms5UIf3O1pz7h1OT9Vn
	AemHejs/ePRoZxNJzTrnVJO7phASll8gHghrNNY78DuEAZIrqzu//Vr8eM+g17cb
	LM+9v0kWh9ihYa6T9jR2JYbhceVp6mGdLhe8lNeAHtDAfsnTVfMBvyMG+i8HJ/yC
	YHi8dYx8hStMnz5qVnl+LlZ7zLCYCsQ3NxdPkxztzHOxbij/pxANaNBH05NGB5rR
	rrUU+YiYOv8JKf+QBHNRn22mBWzdZZG2Qx2npAQgDzKjkbpCCLOQzRFVz/TYXi1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fd59t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 21:17:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637JHclA014378;
	Tue, 7 Apr 2026 21:17:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4mw6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 21:17:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637LH8d429557490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 21:17:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A505805D;
	Tue,  7 Apr 2026 21:17:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F9AC58055;
	Tue,  7 Apr 2026 21:17:07 +0000 (GMT)
Received: from [9.61.244.198] (unknown [9.61.244.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 21:17:07 +0000 (GMT)
Message-ID: <8451fcee-8585-4daa-808a-c76c98f1cd23@linux.ibm.com>
Date: Tue, 7 Apr 2026 14:17:07 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/7] PCI: Avoid saving config space state if
 inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20260407195640.GA251318@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260407195640.GA251318@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX6EejYf/6aXkb
 V7omgdJrhhvUCjy8dn/QsS93GYzf7FQ4y+DQCl2dqG/lSpckOrpsjF0RNb1mWmqo83UmcNicDgl
 ZamfdzYfJtTPJW6tOcgxmfne6FvGZCKfnLg8/zThqDu5AdA+ON1wudN7GHy0rLxIRkcSICeJmnL
 tShjIea62+8wLVku8a5G19CMDEcwfTNTRhPoGeEQF+Uo1lelYX9Boj72Rjjv1C7Hjf8FVPAcl34
 6hmfRy45VsV1D7JHEb7Jqa/4FV+lRS/3MbSIbW2g2WM9UeteynHgb7SElVtCtcsF8xXzO+zNjU8
 IZaQ7zJfgTjpvNQ/R8MuNmGxaQbPesWOlh29G3ybDuLQlhGifTyKMAwA0HbCfnGUqVmbxnQo4wP
 zEmiKyeSlQE3j+Plw8NvCJJh2wFD0hCjBOHIPlV1O6YOyeHMsMpezmEAYeJjuhDt8bsh6sX9sR6
 PXWon2prX6EUIKlyGBw==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d57456 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=SrNceKyLKhhAJAvz0vcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l_0_uArJ57TT0iCerhybaltZ3rJcAJbh
X-Proofpoint-GUID: A08AI_3eBOOTIb9tVscItBSglvNwfwRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189


On 4/7/2026 12:56 PM, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2026 at 10:40:06AM -0700, Farhan Ali wrote:
>> The current reset process saves the device's config space state before
>> reset and restores it afterward. However errors may occur unexpectedly and
>> it may then be impossible to save config space because the device may be
>> inaccessible (e.g. DPC). This results in saving invalid values that get
>> written back to the device during state restoration.
>>
>> With a reset we want to recover/restore the device into a functional state.
>> So avoid saving the state of the config space when the device config space
>> is inaccessible.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/pci.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 70162f15a72c..b36263834289 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
>>   
>> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
>> +{
>> +	u32 val;
>> +
>> +	/*
>> +	 * If device's config space is inaccessible it can return ~0 for
>> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
>> +	 * check Command and Status registers. Note that this is racy
>> +	 * because the device may become inaccessible partway through
>> +	 * next access.
>> +	 */
>> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
>> +	if (PCI_POSSIBLE_ERROR(val)) {
>> +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
>> +				msg);
>> +		return false;
> I wonder if it's feasible to do the pci_save_state() into a temporary
> buffer, check the buffer for PCI_POSSIBLE_ERROR(), and copy the temp
> buffer into the real buffer if we think the save was successful.  I
> know this is a lot more work, but I would like to avoid the raciness
> if possible.

I just want to clarify, are you suggesting we do that in 
pci_save_state() function? If not then we need to do something similar 
to pci_save_state() and then check for errors. At that point wouldn't it 
just make sense to add the check in places where we save the bits the 
kernel wants? Please correct me if I misunderstood you.

Thanks

Farhan

>> +	}
>> +
>> +	return true;
>> +}
>> +
>>   /**
>>    * pci_find_parent_resource - return resource region of parent bus of given
>>    *			      region
>> @@ -5029,6 +5050,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   	 */
>>   	pci_set_power_state(dev, PCI_D0);
>>   
>> +	if (!pci_dev_config_accessible(dev, "save state"))
>> +		return;
>> +
>>   	pci_save_state(dev);
>>   	/*
>>   	 * Disable the device by clearing the Command register, except for
>> -- 
>> 2.43.0
>>
