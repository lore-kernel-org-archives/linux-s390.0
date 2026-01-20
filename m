Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4211392B9A;
	Tue, 20 Jan 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938659; cv=none; b=KLq8wLFL0kJRr4T7uWd7AYkeTzRpF8BxBc64ZBISSQU4IPU1jsn1w53I68URaCtsYhrAmb8TWhe+ciKgouvcVfflBiedeVaByfdWBXNpBXKYWKX9CyKAaqcRaBYqAE5LB0XiyYwNRdI28RraTfryfK3wSyZDFE7RBu9VSuDF+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938659; c=relaxed/simple;
	bh=w/QmKbsSvno27x0r8obIKHfKHoVFpeA+MVJe4ReN8mA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BAUeoVb3LbDmry6ZkJwfrYiJkEvIphxIo9e6D+edQ9h6xH7iIEp3F3uF7vR++6rXossa8RUMQ01E16LCBaWuN3f6bBNh8XJUn9em3UnOO6EsHHKLbmLS3yEhkkcWgIXvfilXoA5qJ+9QjIDq5vd2pLIVGGjW17ELWV0++RgdLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pf23aPVN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pf23aPVN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkxSX007947;
	Tue, 20 Jan 2026 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4IV8oZ
	/CfwrU8phfQTwdy5zNq3Rcawf7tSdXW++AVgg=; b=pf23aPVNNmVmLw90U16E07
	FZquRMNh9CrNxuteoqvn0A3f7OzDPcEdAEi/42i0XjT54FzGgyrDmSsDnYgc34w5
	DwXftidFd9SjJhCJtmRAU5Df+nGWn8jw82PVsJ7u3HDTwMd0+Aq1GXLH6Si20nHQ
	tAfHWjk1sXyh5LVjwDm6WoIsXcaGiPlOT9Ip3RBWzkLyb9OK9s7X1lGtApQdmzVk
	6Lbdrcku5+jle3Dhh8tY5hlh2gCw7pHDwqa6sBqjKsHxx4Fr9D3KbvJnpdNZbMCH
	qnXzgJE4b53muFK8gSmos7V8Hy1XeIG859h+HKPer1sJfkJldAql+7HLGCkJ+VUA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk7d5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 19:50:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KJAhaA001162;
	Tue, 20 Jan 2026 19:50:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjq70n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 19:50:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KJolUi26477180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 19:50:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1205D5805C;
	Tue, 20 Jan 2026 19:50:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEF7C58054;
	Tue, 20 Jan 2026 19:50:45 +0000 (GMT)
Received: from [9.61.246.96] (unknown [9.61.246.96])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 19:50:45 +0000 (GMT)
Message-ID: <86bac48f-c22f-4e58-84cf-58d6df14ccee@linux.ibm.com>
Date: Tue, 20 Jan 2026 11:50:45 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v7 3/9] PCI: Avoid saving config space state if
 inaccessible
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, mjrosato@linux.ibm.com
References: <20260107183217.1365-1-alifm@linux.ibm.com>
 <20260107183217.1365-4-alifm@linux.ibm.com>
 <abbebb0fa74a854e8c794a01659bad2583b87dc8.camel@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <abbebb0fa74a854e8c794a01659bad2583b87dc8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE2NiBTYWx0ZWRfXwDjvlIV0zWyl
 1GRkl2qP8rhnudtNEDSMCOecSVHV2vYnPgBZ+OMrHoQNmKc4qpflZZ6Q1jU4Pljr6T7yE0PiTMS
 c3pZ7FKYVXDsmiR9Mfb/pshb8rP/gQr0X04S9PQhs4/H5E/ae7MkY1iG+bZskJpJXSnyDMCcT7Q
 DaSJfP5XhALrlmwe5yo+tLUYv97ssBwHu7PC4zWGPUhdPH1MLNCLl3sWnv7KeT7jiypSN5Zcx3K
 vufwOU4Kfj+oTnKkFu9iadvEmbdmB6W9+cfca2Hq3PamMkjuBlVOvp3Mulxrx6Oj0y0Dva9DcN2
 6sLakoP01tfqxQhdFz52Ct/5LHczoPOUMFvuhGMfsptcBPlCAvCpkfxa8SdEIlsLG88BXG6eHNe
 wqSQ9pCP/VkQGHY8T4KDxzUg54eoQlOdiuE4Mv2chJWprze2xTD1CUsS0n319wc7qZt7uawOitu
 yXvxlu2xaiJ24PBjw4g==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696fdc99 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=_rwwIbaFfgZrB8Kf2jEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PdpwiDtZFd1W50dyNDJU9HzVLedYSO38
X-Proofpoint-GUID: PdpwiDtZFd1W50dyNDJU9HzVLedYSO38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601200166


On 1/19/2026 1:23 PM, Niklas Schnelle wrote:
> On Wed, 2026-01-07 at 10:32 -0800, Farhan Ali wrote:
>> The current reset process saves the device's config space state before reset
>> and restores it afterward. However errors may occur unexpectedly and it may
>> then be impossible to save config space because the device may be inaccessible
>> (e.g. DPC) or config space may be corrupted. This results in saving corrupted
>> values that get written back to the device during state restoration.
>>
>> With a reset we want to recover/restore the device into a functional
>> state. So avoid saving the state of the config space when the device config
>> space is inaccessible.
>>
>> Signed-off-by: Farhan Ali<alifm@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c105e285cff8..74d21c97654d 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4960,6 +4960,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
>>   
>>   static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   {
>> +	u32 val;
>>   	const struct pci_error_handlers *err_handler =
>>   			dev->driver ? dev->driver->err_handler : NULL;
>>   
>> @@ -4980,6 +4981,12 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   	 */
>>   	pci_set_power_state(dev, PCI_D0);
>>   
>> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> Since the PCI_COMMAND field is only 16 bits I think it warrants a
> comment that you're reading both PCI_COMMAND and PCI_STATUS and that
> both together should never be 0xffffffff and why. I think at least
> PCI_STATUS_PARITY should never be set in a config space we want to
> restore.

Makes sense will add a comment. Note this is the mechanism used to check 
device config accessibility in pci_dev_wait() (for some context 
discussed here 
https://lore.kernel.org/all/cd1fa387-df80-4756-a2dc-5acdd0f09697@linux.ibm.com/). 


Thanks

Farhan

