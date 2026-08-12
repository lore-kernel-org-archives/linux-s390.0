Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6E44A40F;
	Wed, 12 Aug 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574147; cv=none; b=NYCSv537HvHkV8Om1okQAt81FLw/rM6WEBv+OXbfyDolFoSSBUkAoEOkqVX3xtibP7BuUbq3nPU70Lv37wWmaR84Yu7yi+4vmpiYb3WM2gpy3AuVNFPTdhz/NB9oJp9xzAYPaJ7kJMKC8WlE1IXJzGFYCegmM5KKeuf2ujdVsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574147; c=relaxed/simple;
	bh=j3i6YpYtaMpf0cW2OCfxa6EMeIuAuiSUC/CNLNhG+z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQuAal/8CgpeBhaN7JbUH+BaNg4Na5+BmXDrRsL5NGkjohTz9VJpo/o3O5EBtCb4NpnbMNqKverisUZ/2hN713ckUMAJLwDSAKC/hboRSeIymlMwN5u+/bhca6Sxz/pdaq9X267oqR2NNMvwSwHEVDVRHVtxDZUJ7q123s8h4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TyH4Wg9Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyH4Wg9Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2moh196976;
	Wed, 12 Aug 2026 22:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BwTIIl
	rQ+8Dgc/ij0x5gQDpf7pDr986Mp9ic6ftz3O4=; b=TyH4Wg9ZYaMa+fCPzsg8NO
	iNYQwlHfn6MzqZURoscWBWdhCV5Rpc+drOWIXx7WfNILTRHJHJ7LkahgWI8UIq+Q
	ofXnsZinoxIgOR+g8hX3u48qqA7EX3N7BuNFjOcntiHBQUTFz5/5QHKR3P0klXJn
	o30HZA6O8xbXlB/is+8OD52eg4MhkoJpSxfolYd2HbOPUK3xtc7cI2eRWyujN+AV
	jj3mj3TwUpag5lI0n8pCPfJAicO7tylO9SKX1kRii5SPVwAiNrrZ4OZHfNvaOKPQ
	c8dlEeAgNb4cyXvg5Kby9eC+Puc4yIJYkpBY+KQQRSNw5jQt20xOkwzTLXbN5Fsg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp346mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:35:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMQIb7030754;
	Wed, 12 Aug 2026 22:35:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy86ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:35:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMZeVX3867338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:35:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B28358065;
	Wed, 12 Aug 2026 22:35:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2CF5805A;
	Wed, 12 Aug 2026 22:35:39 +0000 (GMT)
Received: from [9.61.244.42] (unknown [9.61.244.42])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:35:39 +0000 (GMT)
Message-ID: <826ef371-1501-4cce-a7cc-f1aa4527d910@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:35:39 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Thomas Gleixner <tglx@kernel.org>
References: <20260812220719.GA1079019@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260812220719.GA1079019@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cf53e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bejnpUGHTOA4jGtILVUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qxdjfddBS7-shgBDWdGP0Pa9W5dAKmVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfX0/0k1uceJ6mu
 PZzBost9FVifeXJoJjb3LKiyZ0+28yfKN3KqugpGadVOJdOEKfQ53FM3GvUtaT2s4LTC348aZ0g
 ykLfw13GBky2uAR8RAptuPmY1x27ZIA+UyxNKn7vfOrcpogrA7YFqrzs2JdBZHawtahI9P3BCM0
 yjbHh+//UcIU3RpdHtl+5bUm5ydIC/Lsg+amvjRYH+BCYbf4SUwFiEgxbF93s1DhUnwe5acEMLJ
 5znmfE05c1VWI896ikyhWLF+kPqko2K75+gujp1ZGVaCnomNz53AROwX+L9RZfGc9hLklbaoR1Q
 7v9HMRpedMM18w8hUnbkYMxegw5II5wqrWuA9TT7tJHarYBODquQxv/qV35oaFwDymJstbAGmcD
 wefyOOcP7616weS6zjvfHuxBDIujkpBNU+0+j9SZM9Uj6oDmEEAFmVWkFh4fuwrUzHxNa5egFDa
 grWkVvVhIyeFcPv9wbQ==
X-Proofpoint-ORIG-GUID: qxdjfddBS7-shgBDWdGP0Pa9W5dAKmVM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE4MiBTYWx0ZWRfX8Eq4kzVuTBIr
 qgE4flML9nUG3ZaiASkwZNmxw/QnmdYZJkdVUuHONt96dzNW6RjuUWDQLVCS0cjYFB5oWw36S2w
 KpiG5WOFjZatTGCD5ipeh8jsBE5XBks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120182


On 8/12/2026 3:07 PM, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2026 at 09:55:18AM -0700, Farhan Ali wrote:
>> The current MSI-X restoration path assumes the Command register Memory bit
>> is enabled when writing MSI-X messages. But it's possible the last saved
>> and restored state of a device may not have the Memory bit enabled, even if
>> a device driver later enables Memory bit and MSI-X. Attempting to access
>> Memory space without Memory bit enabled can lead to Unsupported Request
>> (UR) from the device. Fix this by enabling Memory bit and restore it
>> afterwards.
>>
>> Fixes: 41017f0cac92 ("[PATCH] PCI: MSI(X) save/restore for suspend/resume")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/msi/msi.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 209373c92e9e..79c7e84d314b 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -870,6 +870,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   {
>>   	struct msi_desc *entry;
>>   	bool write_msg;
>> +	u16 cmd;
>>   
>>   	if (!dev->msix_enabled)
>>   		return;
>> @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   	pci_msix_clear_and_set_ctrl(dev, 0,
>>   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>>   
>> +	/*
>> +	 * The restored device state may not have Memory decoding enabled
>> +	 * in the Command register. Since the MSI-X was enabled for the
>> +	 * device, enable Memory decoding before restoring MSI-X.
> PCI_COMMAND_MEMORY must be set because the MSI-X Table and PBA are in
> Memory space (in a BAR), right?

Yes, since restoring MSI-X would need to access the BAR, we need to set 
PCI_COMMAND_MEMORY.


> I think a more direct way of saying
> this would be:
>
>    * The restored device state may not have Memory Space enabled.
>    * Since the MSI-X Table and PBA are in Memory Space, enable it
>    * while restoring them.

Sure, we can improve this with what you suggested. Would you prefer me 
to re-spin with the updated comment?

Thanks

Farhan

>> +	 */
>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>> +
>>   	write_msg = arch_restore_msi_irqs(dev);
>>   
>>   	scoped_guard (msi_descs_lock, &dev->dev) {
>> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   		}
>>   	}
>>   
>> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
>>   	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>>   }
>>   
>> -- 
>> 2.43.0
>>
