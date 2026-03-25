Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB718334C28;
	Wed, 25 Mar 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464032; cv=none; b=SJvovSfzLKOmBDFlF5kFxmVwulObRtkNRgDju9JPCVNXF1impLnKG8N4Y+amJfIw0HlpYY3V9G0icEvSdhuMnm8EcH1J3imvTv14ketNyVQ3CsWLNFOlOabCycXGXRlBNxI0njpNn/dXlMsJnMGNRB4m0NumFQsbjYzRwh+JEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464032; c=relaxed/simple;
	bh=uZU/sq3kwemAB6OlVPIuUswJ9ao28UtYmsERBug7Pko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNSTTQIWq+pru00IBMjdf86m5j3edFovR0uP/kYMoGZqszZ3+Zaz0Dfs6ALtGyfiLsWpmpvHvJG2DJdPN+YjmeTeq2Lkwnlsnsrd9HzDyNTE/g79xrx0vGHlDVlY1wwbMVoJNig4s+9Db70PPoH4EdDwyKdpT0IsNqpgqAACOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YzO5xJyI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YzO5xJyI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P76j2J3556089;
	Wed, 25 Mar 2026 18:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=50R0Y3
	aQnOi7rXaM2ZMgBycF1kOCzVB9lOicETk5WAw=; b=YzO5xJyIPGWmoDHugsY7/9
	49ylLlhTZr3iq13DvK9l7N1RX2eG8MDwAhPhpiGlnh2/tZSwY8eD4irTVdNOSYbv
	J+DQp+dp3Pi3eGzGnmTxCQrqpD+9ZIyen6njWNBBI4rHGGLtk2leqTSjPSboGQSe
	LS2o14qOwtRciEt07HnbNMw5Tj1ihsr5t2fUJl8mTtZJDRjpqbW0A5gZ/HdnhnMo
	qURNZzbWYRUDTi3GCukoK9m7LW/pxpVTeV/WejNl/heIV62pOCQPcUb/fFlyE72/
	/Nz7nbve3kJz5bDE8qRk8X0VNMqcZMELaRJDZf7kkcG21IMdPhzC+8cWaFORHM7Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kums4jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 18:40:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFjew5008745;
	Wed, 25 Mar 2026 18:40:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnqtq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 18:40:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PIeMBZ60162352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 18:40:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010745805C;
	Wed, 25 Mar 2026 18:40:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49CC5805B;
	Wed, 25 Mar 2026 18:40:20 +0000 (GMT)
Received: from [9.61.243.197] (unknown [9.61.243.197])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 18:40:20 +0000 (GMT)
Message-ID: <2c6e8399-73df-4552-9603-218b9b42c4bc@linux.ibm.com>
Date: Wed, 25 Mar 2026 11:40:20 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] PCI: Add additional checks for flr reset
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
References: <20260316191544.2279-5-alifm@linux.ibm.com>
 <20260324224936.GA1157694@bhelgaas> <20260325102504.56140878@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260325102504.56140878@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PhwFkBj36F4v8uM00_tb2YPUYYejpGLK
X-Proofpoint-ORIG-GUID: PhwFkBj36F4v8uM00_tb2YPUYYejpGLK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzMyBTYWx0ZWRfX5TjbkQkMclNQ
 H2nQ98cuo8WEchIdqKtjhC6Fq4n598u3bH+LgEHs6+sn9PVTXXcWRcsvP2PA4S7NCiUoFCIds3T
 NRzVbp5nMwEUKOt9w4JQlNc6P5+5wDiahq3kDH/aPQdoHOSMHU3dWvwrNKlWqtPj76g833c12oj
 nCcD/+Z658xfzMxxlS22jl+T/fyW5JEESxM+SXmyXDSrZugA7OT3WC/+AlDlUGqGqqslTIxrVtN
 2iAYXQLhdaj6Q5hYne8d8oL/niNIuBRSG2cwIwp37gSqIVD/Xp1O6/UxsRG+Txc6+/3QjIkmVZb
 oa5Aq8HGB7Aqj7TF3bLyEht2h6O83HILk72ea255zuXqMRERFEAq5AR+fW/iC2j9AHyLwGCadln
 MfQXDrCUyisFs13qD4UOqUS+BBkA8ockaNJ8mAXeQcFoLc/0BKbWi5ybkOYzAucRNWN9xr8y715
 mtwp83d63F3QF3PWFuA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c42c17 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yOeL3KzSd5q1tlI96GIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250133


On 3/25/2026 9:25 AM, Alex Williamson wrote:
> On Tue, 24 Mar 2026 17:49:36 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> On Mon, Mar 16, 2026 at 12:15:39PM -0700, Farhan Ali wrote:
>>> If a device is in an error state, then any reads of device registers can
>>> return error value. Add additional checks to validate if a device is in an
>>> error state before doing an flr reset.
>> s/flr/FLR/ (also in subject)
>>
>> Also please extend the subject to say something specific about the
>> "additional checks".  E.g.,
>>
>>    PCI: Fail FLR when config space inaccessible
>>
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   drivers/pci/pci.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 373421f4b9d8..8e4d924f4e88 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4371,12 +4371,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>>>    */
>>>   int pcie_reset_flr(struct pci_dev *dev, bool probe)
>>>   {
>>> +	u32 reg;
>>> +
>>>   	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>>>   		return -ENOTTY;
>>>   
>>>   	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>>>   		return -ENOTTY;
>>>   
>>> +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
>>> +		pci_warn(dev, "Device unable to do an FLR\n");
>>> +		return -ENOTTY;
>>> +	}
>> I guess the point of this is to detect devices that are inaccessible?
>> The same sort of thing as in pci_dev_save_and_disable() from patch
>> 3/9?  But we use "dev->error_state == pci_channel_io_perm_failure"
>> instead?
>>
>> No matter what we do, this has the same race as in patch 3/9.  And I
>> think using dev->error_state also depends on AER being enabled, which
>> cuts out many PCIe devices.
>>
>> I think using the same exact code as in pci_dev_save_and_disable()
>> would be more straightforward.  And also the same sort of wording in
>> the message, e.g., "Device config space inaccessible; unable to FLR"
>> or similar.  I foresee many of these messages in my future, and it
>> will be helpful to have a specific clue about why FLR failed :)
> I think pci_af_flr() and pci_pm_reset() are all subject to this as
> well, some of the device specific resets too.  Maybe we need a common
> helper with a string provided so we can differentiate the callers, even
> if we don't make all the conversions in this series.  Thanks,
>
> Alex

Yeah I was planning on implementing a common function in the next 
revision. Will include a string parameter to differentiate the callers. 
And yeah I prefer not to update pci_af_flr() or pci_pm_reset() as part 
of this series since I don't have the devices to test those paths.

Thanks

Farhan


