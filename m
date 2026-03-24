Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73F2D94BA;
	Tue, 24 Mar 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394537; cv=none; b=W8I84dPxKpkrFOVEVIoY40/lQ5TYPTWCn3oo02YFipaq2NXgdTjT1CjvP91MMimqs/bdM+8d+TwGSMeXXUzB7+y5NYvc32ZW6bxaNVUIHqkkPdv+MW9LrtqhiwkBDAd1SVIJ3LteaWKdabIo4PYTanHLLV9yoyiwHC5xZel4meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394537; c=relaxed/simple;
	bh=S9WB4pvdHfrf5K12QW1uu3ZYSu6mXVOjEocICQU4DSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgVp0QBJI9v7PgDxl1cOV/QyqFU2GoN6qyim9F1LkSIBCmcPMMab7VH1/nZtJsqurxSR6PvMUad9Tgzy380BOxPPYiDpwIzNcRoiUXsh3JdhXbOdhXuYdIfJr+BG2MWbKNtcldzMIs5KR0nUw4i72CuSZVj5inrvqO3ObQrgT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XegxrPf1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XegxrPf1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCR4hF2665123;
	Tue, 24 Mar 2026 23:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EzQkng
	kuH+HoIy5opF+pjmX6/+7wevWMlpELxi/I3BU=; b=XegxrPf1s72xeLZmrOF61a
	yv9O0PDqoE6RQo9Gz9iumBtiL9jq2a0CkxRMeTC15EFEDaWgswRq0u2WrfwJIxGv
	T/9NlsD8QiObFR0t0R4jnUqG11HiLeLFFRQPx3mhZbFdeQaGQWDxl5f4ydmRmr8T
	3oartlVm2GiUp8iiUlcFupP5Adov6B47Rj3Ku9AWwQAiqgPRD6xbhEydQlzys09+
	NoOxzgc31eAWIqR0qCOxQmkoe8syCUmpBkDBXF1Lht0nOA4E7PgxBpu2dFOiUFku
	LGM1GvoRX6VsuiV7Mt8h0PIZ3uQPtzlM4v/TM0KYaY8wuF1BRM4Qicco9C3uhgjw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuwcvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:22:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJhvJN026864;
	Tue, 24 Mar 2026 23:22:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kv5y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:22:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ONM8cY55509432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 23:22:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA97E5805D;
	Tue, 24 Mar 2026 23:22:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236AD58043;
	Tue, 24 Mar 2026 23:22:07 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 23:22:07 +0000 (GMT)
Message-ID: <9c675fe3-2a2e-4dea-b306-c9ef1712bec1@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:22:05 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] PCI: Add additional checks for flr reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
References: <20260324224936.GA1157694@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260324224936.GA1157694@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lruv3rkZWaqSkdLFc7x6DbkkFetiXgb7
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c31ca2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=C1eItPSzQBTT7hoOHSgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4MCBTYWx0ZWRfX0jRG7RgQrb8W
 FiCTUUupN+saU5KrR5gwv0G8wiVXt59KosFrvJRez31/0hlIs9cjRv+xO4grBKrtJd+yYyK6pU3
 1r38C03A2DGpoKGmar2AzCKfrXxjCPmh84/YQI9S+YI24CIdep0F9aa2ambAm7oeyAZOMPp3aqk
 2oy2xCm3e1/FYVu/q2j1EpycZU4EqjXyjlJinWd4BzyBepRSIV3CoOhy+JQgf+40F8IuQeenCRC
 0+bxhkLbRyrIDtmIaXWVs2TIH47oOEI1UYqAr9k2bSE8tRoCZGjwL9IxUoatGxr4PQ8fYq+jpL6
 GtyTNeGmVvTo2VoIutlIj0p4Y4SgHgXMKEdExFow+tBSmfA2cBpi3vMrWREQ8si3ZoTq2Fcclf8
 fOtXiaBrBNG1nKgkA366nkzeAAELoAYN/TdDFCv6XjE+r3GedbBOGHg1niD57s628lQNo7JyNjL
 oMAE4HBP29kU+SJ5HGQ==
X-Proofpoint-GUID: Lruv3rkZWaqSkdLFc7x6DbkkFetiXgb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240180


On 3/24/2026 3:49 PM, Bjorn Helgaas wrote:
> On Mon, Mar 16, 2026 at 12:15:39PM -0700, Farhan Ali wrote:
>> If a device is in an error state, then any reads of device registers can
>> return error value. Add additional checks to validate if a device is in an
>> error state before doing an flr reset.
> s/flr/FLR/ (also in subject)
>
> Also please extend the subject to say something specific about the
> "additional checks".  E.g.,
>
>    PCI: Fail FLR when config space inaccessible

This makes sense, will update the subject.


>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 373421f4b9d8..8e4d924f4e88 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4371,12 +4371,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>>    */
>>   int pcie_reset_flr(struct pci_dev *dev, bool probe)
>>   {
>> +	u32 reg;
>> +
>>   	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>>   		return -ENOTTY;
>>   
>>   	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>>   		return -ENOTTY;
>>   
>> +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
>> +		pci_warn(dev, "Device unable to do an FLR\n");
>> +		return -ENOTTY;
>> +	}
> I guess the point of this is to detect devices that are inaccessible?
> The same sort of thing as in pci_dev_save_and_disable() from patch
> 3/9?  But we use "dev->error_state == pci_channel_io_perm_failure"
> instead?
>
> No matter what we do, this has the same race as in patch 3/9.  And I
> think using dev->error_state also depends on AER being enabled, which
> cuts out many PCIe devices.
>
> I think using the same exact code as in pci_dev_save_and_disable()
> would be more straightforward.  And also the same sort of wording in
> the message, e.g., "Device config space inaccessible; unable to FLR"
> or similar.  I foresee many of these messages in my future, and it
> will be helpful to have a specific clue about why FLR failed :)

I will update the message :) and update the code to use the same check 
at patch 3 here (will move the check to a common function).

Thanks

Farhan


>
>>   	if (probe)
>>   		return 0;
>>   
>> -- 
>> 2.43.0
>>
