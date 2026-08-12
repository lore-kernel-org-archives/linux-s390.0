Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAD403AE0;
	Wed, 12 Aug 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573356; cv=none; b=WavWa/ds87qUHXHgeHwi3+frrI5QTPeQU9kRC5r7CLhnyfOnUIvMG1zGgsqgsFi3tALuOuU937U/6YIOVZGqb9RHNMWaWmOuAHmZKrSW7HsWtenKBjVeBrPvLdU5/FRxXrvHaM0GcAiAXPfaCsL1INC227fSjkjPZG8GcTtcVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573356; c=relaxed/simple;
	bh=mAILMmbcW+cn+digLXum+WL1JqyuMj+WYtD4WPQI5Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lULidTkBbbixWAIOrJf3FYdyZPEZZGE4NYSzs8iFvRCNp+Agf3qzB1n03kQdgdEHCuuMM81t30/AgVZRvSWMHdfEnDD0ezjKHOQCgTVvnNdk52gjnOfCr21eEeJc8EqK4YrPaGGvfdA5YCEDRHEk8g0cXp6FJfVueRGy4FvJkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shm8EA04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shm8EA04"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2ubF323376;
	Wed, 12 Aug 2026 22:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6wekvw
	SxMnOrZjPisuMyq9xjPdGHOVhFDYLgMGYE79k=; b=shm8EA04VOMsHTHm4fqhSi
	LPSwWsRv2hhSfgFYbpQ3W9FHS+3vWfF0o/yeTB0GxAnxx/I6uRtua0oPbrLqZ5Pl
	1mE7a2+UWJP7YIHOvk2IIiFn+DwjKgnI6Q+lEE5M8TZImKHQ6VCQ5fnbnjupUCTU
	5cmmJiC20SOA3IYJfjmhKnCyqaHZXz55Uaf4co+g2SNeshcMQngdaZaYH7xNEIP3
	/IzcMhmNSGsxR2VVKe2IunHMbAcUi4YBDJM0c4RUeA45gVDKJazgAz9BKR8APOR1
	+RHpWCr4+ugFaTILEQ2eRYhTUA3vmMMq845x5zkCp7ac4hCbKkpL98FV2AmAfcDg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwc4xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:22:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBKFP014220;
	Wed, 12 Aug 2026 22:22:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gg77d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:22:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMMUt631130238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:22:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A877258056;
	Wed, 12 Aug 2026 22:22:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB8158052;
	Wed, 12 Aug 2026 22:22:30 +0000 (GMT)
Received: from [9.61.244.42] (unknown [9.61.244.42])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:22:30 +0000 (GMT)
Message-ID: <30091f98-5780-4cb2-82ef-1911a382a097@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:22:30 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Bjorn Helgaas <helgaas@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org
References: <20260812220905.GA1082162@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260812220905.GA1082162@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cf228 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=CMBW2Snu30QOZj9-FvsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 9SCE5F-CTsJNsfa2TsBuW9kL6Dz4YxTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX8+TyBFRxQ5eQ
 3gnOD2eLZeFQmKXxqgrGkyUVcQDRKS6nwe9EVGXXWeSnxWKzBFNoltMCAh3v5A74+BpgL12GuMW
 J+MDSJMFr+1XRFzI7E2CDdzH6ziB7HBr/YVI6uD+exfV4Cfx0NiVW0NU8X0p7jqRP0yBZBzwB98
 Y3s6TfFDAjQ8PJng0iFHmwcMPeQLcWZ/i+IBR0wMoKJk0hdHterJ6H/VYHmsQqH3I7DZyuSStet
 aMYFtCPs6mxPTvxxwLwRYn5hODNl78ucmKQ/mnOk0pqFehFlyoSzEg9IXNc5Anx/354njjK6aEU
 U1fdpN1G/J8IKcyvftHqhxaNb1L9WnKE15HKuUR+aoJznrhAgw0tNRwq+swzSzh4vvvZD2M+HwL
 R2KaQomncu0J5ZJA43c7J+K0G6ULnEkvoonf1dD6W/x0hsHfHlVsnMR5v8Ozr6ud+Vl1AZRc6Qh
 dNBaToHImctoPw5WDaA==
X-Proofpoint-ORIG-GUID: 9SCE5F-CTsJNsfa2TsBuW9kL6Dz4YxTt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX5XXjRe6DVlML
 nibxpXzJX1/chU0WL31Yzb5K3HJlgrx17nn8rCXX05PyjH1PN44YobCZeAJdN+JEOd3XP3jpi31
 C0ZmymPrR869h0p4bdbW7t0CWeVPA2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177


On 8/12/2026 3:09 PM, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2026 at 05:07:58PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Missing error check on PCI_COMMAND read leads to permanent register corruption and unintended device enablement on transient PCI errors.
> This does seem like a possible issue, but we do the same thing all
> over the place, including in pci_intx_for_msi() just above. I don't
> think checking for ~0 here will significantly reduce the chance of
> problems.

Yes, it could impact in other places and I agree checking for ~0 here 
will not help.

Thanks

Farhan

>
>> --
>>
>> --- Patch [5]: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring MSI-X messages ---
>> commit 6d8ddd25b8ed47c23845049339a3c29cd4e53440
>> Author: Farhan Ali <alifm@linux.ibm.com>
>>
>> PCI/MSI: Enable memory decoding before restoring MSI-X messages
>>
>> This commit temporarily enables the Memory bit in the Command register
>> before writing MSI-X messages to prevent Unsupported Request errors.
>> It then restores the original Command register state afterwards.
>>
>>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>>> index 209373c92e9e1..79c7e84d314b7 100644
>>> --- a/drivers/pci/msi/msi.c
>>> +++ b/drivers/pci/msi/msi.c
>> [ ... ]
>>
>>> @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>>   	pci_msix_clear_and_set_ctrl(dev, 0,
>>>   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>>>   
>>> +	/*
>>> +	 * The restored device state may not have Memory decoding enabled
>>> +	 * in the Command register. Since the MSI-X was enabled for the
>>> +	 * device, enable Memory decoding before restoring MSI-X.
>>> +	 */
>>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>> [Severity: High]
>> If the device is inaccessible or experiencing a transient error (e.g., an AER
>> link reset), can this read fail and set cmd to 0xFFFF?
>>
>> Looking at pci_read_config_word(), it uses PCI_SET_ERROR_RESPONSE() on failure:
>>
>> int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>> {
>>          if (pci_dev_is_disconnected(dev)) {
>>                  PCI_SET_ERROR_RESPONSE(val);
>>                  return PCIBIOS_DEVICE_NOT_FOUND;
>>          }
>>          ...
>> }
>>
>> If cmd is set to 0xFFFF, the subsequent pci_write_config_word() will write
>> 0xFFFF back to the Command register.
>>
>> Does this unintentionally enable all device capabilities, including Bus
>> Mastering (which could lead to rogue DMA) and SERR#?
>>
>> Should we check the return value of pci_read_config_word() before writing?
>>
>>> +
>>>   	write_msg = arch_restore_msi_irqs(dev);
>>>   
>>>   	scoped_guard (msi_descs_lock, &dev->dev) {
>> [ ... ]
>>
>>> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>>   		}
>>>   	}
>>>   
>>> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
>> [Severity: High]
>> If cmd was populated with the error response 0xFFFF, does this write
>> permanently commit the corrupted state back to the device?
>>
>>>   	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>>>   }
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260805165518.794-1-alifm@linux.ibm.com?part=5
