Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADB33ADB5;
	Tue,  7 Apr 2026 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599368; cv=none; b=r2WBxaW4p1xp6dkt0SscCVjoRMS8wjbS/yYQ5hybellJbjAEkcGSHUlE1ZywoCGTFSlIkQxQC9rIF1b9tByWpETQZbt4PJWAfk4uZVt+3duHkdL1IND2wuU/HaXKiNe3YhzM7xcpIW8w56SBDS40ZjPBBh9ASqv+ghXH3NMll8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599368; c=relaxed/simple;
	bh=gK2MPigpJBBKDMp9oh1+f9GMsvBlkdCnRkzBCsEpTts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7XiX2KvyadDm7rktnAWiWTO6uoNomm2ffK/p6I2+K8LaznMS6lckBA12uJsZM2eIzPBN98gWISYg7SrQIRrX3W5H5JJ1QWA0y/ZQxqf4DTQbZP5EidB1qY37XCjURdMjihb7le1Pyp3gco1WfQzup0+i5D+xGC7rrIcBXolzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JFLlmpd0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JFLlmpd0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DdmsK2592193;
	Tue, 7 Apr 2026 22:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8TDzWm
	0dIidMo3pNKZxea3V5mfghnd+Qf4bKf5B3JCI=; b=JFLlmpd02qBXUg9y38fNyj
	AG+IQBuk/ZJxFQWH8+so2nHw2EFrg21SznIG0zrjHWdAwU7xcGBoITcz+pgJbpIt
	ppcrfuguTk3uE7cKsjxcJHjLFJhwZBJj9sF1ewRDWbReU2K1pIujf4IP9HJMnDOR
	KFNseIXu22ndTMDmoPvzSBhz1lDwlC1YhMbbhZTjWNtl/8Ori3kVHTmBsj1/WFu9
	5rqdr2chrk3KA0DiugZ8IY1mpxtP3t5z6xQA/9y5dL/PE50/cJr/m0vZC9/KV0qH
	yW1pi2m5nat5Y7y2GqD5QoIXtrGRZ8OQ4Nlta5v6JqqKyjrNmYEd5jYLFjBgOo0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e59m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 22:02:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Iq4S4030063;
	Tue, 7 Apr 2026 22:02:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7d1hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 22:02:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637M2aml26411578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 22:02:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B38E758059;
	Tue,  7 Apr 2026 22:02:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7328858058;
	Tue,  7 Apr 2026 22:02:35 +0000 (GMT)
Received: from [9.61.244.198] (unknown [9.61.244.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 22:02:35 +0000 (GMT)
Message-ID: <56029c2e-6814-4c3a-b14a-fac7e6da31da@linux.ibm.com>
Date: Tue, 7 Apr 2026 15:02:35 -0700
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
References: <20260407213207.GA257253@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260407213207.GA257253@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: G1Yk3qwnGyIOuWia9RY-qZihA7e8uEH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5OSBTYWx0ZWRfXw4PWcCyqPS+P
 TvW8AU/no+vxuAQlsxR2B6WDKH0T0S78+mThLzaqIBWL59wD6rsQst5imw1itSworyY90GjcZo6
 uEeW+FMRLQW/LpZrEnrfY3X/FzaPbNZPcA2RuQPpyYBhryr7/9ZRfKM//EUJqgOqRRdFKWD7c7X
 vfBFtvfhbQyYRB79Tnag4mNS9xGEdwBIUslYQAqrvKMTp2ldYokuNoDPAF21ggZFh+iengxqIsV
 miEsEJha92yjzanhPhMU0exa9GulpvcKO/2AHwDuf0ZEOp2JtbXWMub7IyJvmaZPBUViZvcgWrf
 0rTfihPumJGZJsJMrneWO3vN3U2++maAcrEaNJhlJ8eAptNhXq6VylSM+6CN7vu5PxNCfBQKTPp
 m8426Ej+nnGKvKzKXH+iKGdimzODibfJcW2Bs/pNdzGjXTfB3MlRXBsssCYDlPZXT5bp4c/b4lh
 W1kXSIKnLpFU80K6tZw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d57eff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=i-DF6LUwYvOccUtbLu8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UspqPN_nvtgUiS5RqUynJ4UZl3fx768Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070199


On 4/7/2026 2:32 PM, Bjorn Helgaas wrote:
> On Tue, Apr 07, 2026 at 02:17:07PM -0700, Farhan Ali wrote:
>> On 4/7/2026 12:56 PM, Bjorn Helgaas wrote:
>>> On Mon, Mar 30, 2026 at 10:40:06AM -0700, Farhan Ali wrote:
>>>> The current reset process saves the device's config space state before
>>>> reset and restores it afterward. However errors may occur unexpectedly and
>>>> it may then be impossible to save config space because the device may be
>>>> inaccessible (e.g. DPC). This results in saving invalid values that get
>>>> written back to the device during state restoration.
>>>>
>>>> With a reset we want to recover/restore the device into a functional state.
>>>> So avoid saving the state of the config space when the device config space
>>>> is inaccessible.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>    drivers/pci/pci.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 70162f15a72c..b36263834289 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
>>>> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
>>>> +{
>>>> +	u32 val;
>>>> +
>>>> +	/*
>>>> +	 * If device's config space is inaccessible it can return ~0 for
>>>> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
>>>> +	 * check Command and Status registers. Note that this is racy
>>>> +	 * because the device may become inaccessible partway through
>>>> +	 * next access.
>>>> +	 */
>>>> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
>>>> +	if (PCI_POSSIBLE_ERROR(val)) {
>>>> +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
>>>> +				msg);
>>>> +		return false;
>>> I wonder if it's feasible to do the pci_save_state() into a temporary
>>> buffer, check the buffer for PCI_POSSIBLE_ERROR(), and copy the temp
>>> buffer into the real buffer if we think the save was successful.  I
>>> know this is a lot more work, but I would like to avoid the raciness
>>> if possible.
>> I just want to clarify, are you suggesting we do that in pci_save_state()
>> function? If not then we need to do something similar to pci_save_state()
>> and then check for errors. At that point wouldn't it just make sense to add
>> the check in places where we save the bits the kernel wants? Please correct
>> me if I misunderstood you.
> This is kind of a blue-sky idea for exploration, so maybe it's not
> practical.  I think it have to be done inside pci_save_state().  It
> would be a little messy to implement since the pci_cap_saved_state
> structures are in the save_cap_space list, not all in one place.  So I
> think we'd have to allocate a duplicate list for this purpose.

Yeah this would require quite a bit of work and would need some 
refactoring on how we save state today. I would prefer to avoid doing 
that as part of this series. I also think doing this for checking FLR 
(the following patch in this series) would be an overkill?

Just trying to think out loud (and exploring the idea further), I wonder 
how expensive it would be then to save the state as we would need to 
check all the bits the kernel cares about?

Thanks

Farhan


