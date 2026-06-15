Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93916298CAB;
	Mon, 15 Jun 2026 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561848; cv=none; b=fT/CVNTTDjvAPe7hHxxX8C3RYZME7lbGQRvFJ7utwqdQa4Fg1CrvF/3YwC9lVpKm9xE/PcyaIQuomupMyJJnwitEWAYUDV3OikEmRj6v7JM4DpcTEix/Fh8FXMJNTzSLuxqa7VTRyXU2J7oeiK7QDiskNFrPLBJYordKlg8X2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561848; c=relaxed/simple;
	bh=OKJpSRpDMRFT+F65dqPO/mANqW7Z+mZ0u7fwuUZNLKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivYv3x2mPJXptxlIls/EX8c8Ny10uj8WYtg+SZvXGpa9JeyRBTl+g0AK/iSG74HUn2ir2jVf4c/bN06AFz0+qje9tvLHSFrg8OhnISZlL8R3tx9pdZTBilX3uunwIxXTxQ3dZnxzuzPc5Mq0FDNMyosR0sIgYldioa03eDqt4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g9AmdsLz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g9AmdsLz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIME83334774;
	Mon, 15 Jun 2026 22:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k1RO11
	5wL3sLz85jGVH/FrX/i1Fhc+OFjhbck8YKZN8=; b=g9AmdsLznwwGYPVIVf5TFm
	SE2rBCpW9ORD+y8h6JzskwHjdCAKwg6NFvNSojgtO0YzilGWwK4geLzGATzRLV/X
	LqiQCuAlZaur69aTX9aUZ9yPWpWslXb2zdUNGG+WW1I+GUcJ1jOVETPagaLusK6F
	YTJYDC1JrYl4zPUySp2l2FJR8YqNw2TBCESEMiwe9BPsNp/z/J0nGJseOMpORZbA
	b4aw9n71RSTY72dzfo62+Z/6y+akKzvM8ZOnyFehJAAmKXL32WKZc61ci3aNYWbc
	2GZbqe4hR3X4i+KKcE8wBGVpdwgNzMFeooT1t/Z6Pg0e/vcppa68ZPlw1MlkPoCA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0jc43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 22:17:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FM4f6q028665;
	Mon, 15 Jun 2026 22:17:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww0q1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 22:17:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FMHKCN58523980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 22:17:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74FF85803F;
	Mon, 15 Jun 2026 22:17:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8891C58054;
	Mon, 15 Jun 2026 22:17:19 +0000 (GMT)
Received: from [9.61.248.131] (unknown [9.61.248.131])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 22:17:19 +0000 (GMT)
Message-ID: <19fe09a8-4b56-4e47-9b03-ba51679f25ff@linux.ibm.com>
Date: Mon, 15 Jun 2026 15:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 4/4] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
References: <20260615183524.2880-1-alifm@linux.ibm.com>
 <20260615183524.2880-5-alifm@linux.ibm.com>
 <02c66b72de27b3360536dfdd0747261dc487059d.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <02c66b72de27b3360536dfdd0747261dc487059d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UyuV7VQRkACD65P0BcEhjKBGwm-lYv28
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a3079f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Av32cbDGmuaKImwTXbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIzMSBTYWx0ZWRfX4NCUsjKzAr5k
 xKM8ky1VAccNzbDFFtxiGhQB5VdGequucC1KU0dA8TrpHCeXnpJkhYPSLdLqusO5gimh+mXlTfE
 K0Q2/uFsqJkwT+mTcLgZRa9HMj7EJHQUb3FbCAwmEyv25BYM9thPMzLtSpCEdLN9VZGx94VuaLa
 W9WzAMXPryx1JkqAxce0n/FkMbIZJ0L8DqidUu7BhvlXXaWeiU9mC+l8aSNyuoa66XXYV40udqa
 F137IA2ZoLKMDYIny3/Hw4Q2h3Nbaqao+F7ZUr5W4rwS3t/Oxocd/llAmG4q6HXa0AQviGIaPFs
 iLUUAN77Uy/h2MI7rJ3pI5nrBLmkzfnf67u02IlRYIbCyzVT65/J8XCoeHjzHSXPmHxIa0A33Gd
 0rurrCI8+/uRESy2s1kZGjm0163E6UCoL32EUh9u8QANFNqHiP8MqFEsCDg9nbD1kZz5YiSFFTw
 ijqAC+OErq3V3CGOEEQ==
X-Proofpoint-ORIG-GUID: UyuV7VQRkACD65P0BcEhjKBGwm-lYv28
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIzMSBTYWx0ZWRfX4UCeNhT8D8+6
 +hwoOBhrgyR/JtOEGld5VDAQYC9ornCWVg9+TEJsfo7B3eCPRpB4bDI5R7QPtvRbZOGL2Xjr69i
 eSoA58+sbq9EWNYmDfNhNHQZmLtBhdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150231


On 6/15/2026 11:59 AM, Niklas Schnelle wrote:
> On Mon, 2026-06-15 at 11:35 -0700, Farhan Ali wrote:
>> The current MSI-X restoration path assumes the Command register Memory bit
>> is enabled when writing MSI-X messages. But its possible the last saved and
>                                                ^ it's
>
>> restored state of device may not have the Memory bit enabled, even if a
>                     ^a
>
>> device driver later enables Memory bit and MSI-X. Attempting to access
>> Memory space without Memory bit enabled can lead to Unsupported Request
>> (UR) from the device. Fix this by enabling Memory bit if we write MSI-X
>> messages, and restore it afterwards.
> Don't we have the same issue in __pci_restore_msi_state()?

I think for MSI it's done through config space registers and so it 
doesn't need to access MMIO.


>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/msi/msi.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 81d24a270a79..d8d3c8a911ac 100644
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
>> @@ -884,6 +885,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>>   
>>   	write_msg = arch_restore_msi_irqs(dev);
>> +	if (write_msg) {
>> +		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> Sashiko complains that the read cmd may be all 0xFF…F in case of
> transient errors. Though I don't see how we'd handle that here without
> a larger refactor.
>
>> +		pci_write_config_word(dev, PCI_COMMAND,
>> +				      cmd | PCI_COMMAND_MEMORY);
>> +	}
>>   
>>   	scoped_guard (msi_descs_lock, &dev->dev) {
>>   		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>> @@ -893,6 +899,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   		}
>>   	}
>>   
>> +	if (write_msg)
>> +		pci_write_config_word(dev, PCI_COMMAND, cmd);
> I wonder if it may be safer to have the Command register reads/writes
> within the msic_descs_lock critical section in case this gets executed
> concurrently and so the restore above from one thread could slip
> between the Memory bit enable and the beginning of the critical
> section.

Hmm I am not sure if its necessary, AFAIU the msi_desc_lock is used to 
protect the descriptor list. Other config space changes in this function 
is also done outside of this critical section.

OTOH Sashiko does mention correctly pci_msix_write_vector_ctrl() can 
happen even when write_msg is false and which I missed. But this got me 
curious, as to why would we write the vector control for an MSI-X entry 
if we are not writing the message (Address and Data). AFAICT the change 
to write message based on arch_restore_msi_irq() was originally 
introduced with 76ccc297018d ("x86/PCI: Expand the x86_msi_ops to have a 
restore MSIs."). Prior to that we always restored the message and vector 
control mask for an entry. So I am not sure if write_msg is false and we 
don't write a message, why would we want to write the vector control 
mask? If we have a valid reason to write the vector control, even though 
we don't write the message then we should we enable the Memory bit 
unconditionally? Thanks

Farhan

>
>> +
>>   	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>>   }
>>
>>
