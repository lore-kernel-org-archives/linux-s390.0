Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7634CFCA;
	Mon, 22 Jun 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159749; cv=none; b=dZigftHyy6ppcFjnItgreHTfloOIEtt03iXaNZ5/PNi+8MJI+uWdDTxzxzCAajmUZ1cbLNtOo0ZnWflIbrXl1ZAPwowi1vBks/Y7dDcWWA65x+g0HuECckCkCgYCPoi7LZf0IqcxAKg73jNgWPVmdaQyVUfgFYswwjhupKu/9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159749; c=relaxed/simple;
	bh=M3wtrweJdmBcZVDxHVsN76I7887nNMu5D9CDoVznSNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibZQmdsE929v70yauSQ1qiz2lqEYyn0Ja0njuRz/CiWqjbf70rnm81EadkRKkO6ELTkodZv6zLfclBbgJ+w49kBb5/0uQvq5gxrANaYuBp32hmeLVrHfLilJGxsc0HmcfC1vckXTYgDKodEA+Ni0yj6Jlr1hxeZrjxZ8B9wlloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eXHf3qnY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXHf3qnY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJmP9r3871094;
	Mon, 22 Jun 2026 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B5vVAt
	IDbzaSNkktW0bHKA15zOY7ML5rD0GHaITYyZ4=; b=eXHf3qnYh7BYZPvBnb9Qrl
	ch3v5rztS1CYroOVAOmoT2aGKviodqQsFWxdU1nmpaCbnoOVIAhtldkJwfUiomWg
	2+RlYDDT4S4qPI47aG6MqIPz4YJ5f6RoippJI2TjvracfQUB51Vt4n6O8vWKOFrF
	/QLct0H8hrXNxlg2bOaLU1CsLVbXjdvBgGBazhgtZ+Z+BkUSVda0CJebusCjACgk
	DBKYmbnQBcixo7pmKuuSKFeUWtVCznZl5PfIrfAhHY9GP58lQydolZuhxh/p9z1n
	5FAjPdw3m4klDfF02kePTpdWiNZAI+zLg7GbwsQjIq/XvtJVy5/iToDK4yM2/dBQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsk3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 20:22:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MK4eLR031892;
	Mon, 22 Jun 2026 20:22:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw83mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 20:22:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MKMFt739060174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 20:22:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D305805D;
	Mon, 22 Jun 2026 20:22:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC05C58052;
	Mon, 22 Jun 2026 20:22:14 +0000 (GMT)
Received: from [9.61.251.231] (unknown [9.61.251.231])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 20:22:14 +0000 (GMT)
Message-ID: <5761d5ab-abaf-468c-a931-73c16bdfc7f3@linux.ibm.com>
Date: Mon, 22 Jun 2026 13:22:14 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com>
 <8e0cdec1d92eaadaf0739c7175e2bb78783d4524.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <8e0cdec1d92eaadaf0739c7175e2bb78783d4524.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE5NyBTYWx0ZWRfX9BZH4xkFH+Jc
 hsevkW8HmnMkZiMbq/rBOkPtOTtKg3JpHYfFivG63M24X7d4AgDm3BOwhnYIl7CJd5/F9rIELbM
 dsHKRSlU7Xq15NFiAFKG3qg/S4BZ6DFNNVtNy1jkcOqdwquVjVIoJdMP75FRaGexZvDifOtSHfG
 VTTgFknq7isYxFKh4LsEuBz+2u87anucf5P5t5lkCWpXs8HFXttmTD7RSDrIfKNbY0szgB592nW
 rG+P2y59jz9q7guGWZvGkGJs7zxNGy/BM0XP0jyC36TGHJUa6QLtLgkhEnjW+LbuNM4zxAGv+ro
 UQP358OWXbdApTuutfAcOGjfCUcPFbloWinsvYDQoiyD7HMwxBOdXV0L5IL6lGKQXq31JseMrAf
 ddwxpyyfUYCTC/pajBe5EQDVE2skkJ/Ajj0Y9gUkhqDQhJRTb/Yyq26TbuqTtPg7hHJ2Jr7bSKq
 updwTFva0hYCUaGm6WA==
X-Proofpoint-GUID: XID1W1wuUY-veoNt-_R3fMH6t6zdl6Z2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE5NyBTYWx0ZWRfX8MkXHHD9E2+S
 Bz1/b3EJ4q8ZsxRm4AYqMryBEnoGAMwEKvF9mJAM3vk110Uk446aesAO+99xa8jWPE0ZbFECKDd
 bgaf+ajWBAl0FNTBnff+6oHJffbxSvY=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a399979 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=41MKBYwao-ZyPmYOq8wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XID1W1wuUY-veoNt-_R3fMH6t6zdl6Z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220197


On 6/22/2026 11:54 AM, Niklas Schnelle wrote:
> On Mon, 2026-06-22 at 10:18 -0700, Farhan Ali wrote:
>> The current MSI-X restoration path assumes the Command register Memory bit
>> is enabled when writing MSI-X messages. But its possible the last saved and
> SpellingL "it's"
>
>> restored state of device may not have the Memory bit enabled, even if a
> Missing "a" in "of a device"

Ah I missed correcting these.


>
>> device driver later enables Memory bit and MSI-X. Attempting to access
>> Memory space without Memory bit enabled can lead to Unsupported Request
>> (UR) from the device. Fix this by enabling Memory bit and restore
>> it afterwards.
> The official spec term is "Memory Space Enable" and I think "can lead
> to" is actually underselling it, as the PCIe spec says that accesses
> are "caused to be handled as Unsupported Requests". Also as I
> understand you did see this in practice. Maybe we even want a Fixes
> tag?

This behavior has been present since 41017f0cac92 ("[PATCH] PCI: MSI(X) 
save/restore for suspend/resume"), so I am not sure a fixes tag makes sense?


>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/msi/msi.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 81d24a270a79..46a0d9f68a57 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   {
>>   	struct msi_desc *entry;
>>   	bool write_msg;
>> +	u16 cmd;
>>   
>>   	if (!dev->msix_enabled)
>>   		return;
>> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   	pci_intx_for_msi(dev, 0);
>>   	pci_msix_clear_and_set_ctrl(dev, 0,
>>   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>>   
>>   	write_msg = arch_restore_msi_irqs(dev);
>>   
>> @@ -893,6 +896,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   		}
>>   	}
>>   
>> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
>>   	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>>   }
>>   
> Code wise this all looks good to me so feel free to add.
>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks,
> Niklas

Thanks for reviewing!

Thanks

Farhan


