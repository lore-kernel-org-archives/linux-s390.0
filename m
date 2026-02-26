Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD5368965;
	Thu, 26 Feb 2026 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128420; cv=none; b=sLBW8UTo/i2FUCa43Dg/fQ3oHwqaSG2cHTxGv/ot9DS7aUpf5N5KAopNA6tGphQxMv0HUpvN2/MG33YF+tt1ftT9ujv6ozCAGi9P6V7oVelCVXs/FHCT8ZoGi/zie5oxMF+QayosZJAxcqG+pPRZO27SXUcSzq4PtMQBThgowgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128420; c=relaxed/simple;
	bh=KLe66cESz6+dilREiHGNz7462oAcVOJ/8nxD3/w0iG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEMXBvllsT6kzAJNMNo079B99mkmqwyRSypVtB0WHYhnpQHBJgoCw+Z2TPk+ex/FPp8qU3vY4xpzcA/AmW2sV2PBtISRJLC1TbOEA/HVk1UglpdnlgAEU1CqjE3AY7XrNTeae0S+eSxEjLDcwfHAdSNAYDUkxUZrNbUwiKMdN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5iAK9xr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5iAK9xr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QEsGbI2346014;
	Thu, 26 Feb 2026 17:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=G36YKZFvqd9qA6S9InMPsEzM7Y+Whm6qcGCLT5WsJ00=; b=M5iAK9xrzlHi
	sy63aWcDGtsFXmcCQZTYjAkbjxCvetRWdmlTDtQhOaLl2T8EEVLqgQ2NqBFfveYu
	LUsmg6HYI7r+jXCiyqFQ1Qmlla4bfy5DpcPuZPufLSBpJTDpFGMxw4QBykuuVRCC
	keiBQsOjF5ZoikYs3/c+Q5XgUZAWrgDJm6UhjDdm5zFlah5acq3qh2T3gii0SNCe
	+j8brr6J9buTDO0j6Z+Js3bbDzEYU3GCdg/KVj22brbIOGTLF1zjs+9U4iJDHBoZ
	vGIFnGiFf11qeT84+ajRtDBKI9uUTH+mAhs3RwmRY5APzIrSOWmVN5DIlsgcukiw
	3agyi+UgSA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858whdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:53:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QFmLVo001653;
	Thu, 26 Feb 2026 17:53:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nd4pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:53:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QHrX2U30343738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:53:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C125805A;
	Thu, 26 Feb 2026 17:53:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E864F58056;
	Thu, 26 Feb 2026 17:53:32 +0000 (GMT)
Received: from [9.61.243.9] (unknown [9.61.243.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 17:53:32 +0000 (GMT)
Message-ID: <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
Date: Thu, 26 Feb 2026 11:53:32 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20260226083427.GF12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2MCBTYWx0ZWRfX2wARRGVJzCor
 ukyb171YZRxT3TqCRdTR7wHd/1AsKnS6ybY605nEmlh62h6sGa+msRMchz1Jm15JmIOt47iNVVl
 9BLCz4HKVB4eGze+vFtIvhJTOu25vNLgPYBj90ibpRfw3Ldop74Jalx1SFAobVqaT3mxmabmp1N
 Il8RSeF4EYU4qrNVA5I+/wzw7rZEPffUM3kdQWme2s54N8VAgewB+3sHyDio/8qb64kIoRShesn
 Kp+KvKBcs0+/YChNd+3I1xjww5IX51JP5wLTjwAz3qhw+rRbD2orPXJIMbhwJWNWxSvUwukqvO/
 fCqyiyKgZm7m+CtUOzgTFYOq8b1U9wi6VDCP7tEVd6sgWm0JNgoczm743XL7N344cCId6FAmhbK
 AxjmRWvF3m/qInQmjhCbJRrHbGxR06fNqbQfpnaa9sRIOLtOEylw6+99j9itu9cIFn7350j9Z6+
 CdX0Ynn6E4XDjoRwQbA==
X-Proofpoint-GUID: IwsRsZ958oQ8U8nwRnE7-OtFnjzL4kxZ
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a088a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=zhNUnha_GGVnsERX1NwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: p_mm7JRBLgt4qQnF8IrLSe2eun0x_xHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260160


On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
> On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
>> Add a new write-only 'uevent' attribute to PCI slot sysfs
>> entries. This provides a mechanism for userspace to explicitly
>> synthesize PCI slot uevents when needed.
>>
>> For cold-plugged PCI devices, slots may be created before
>> udev is ready to receive events, causing the initial 'add'
>> uevents to be missed. As a result, slot specific udev
>> rules that define naming, permissions, and related policies,
>> are not applied at boot. Allowing userspace to resynthesize
>> the 'add' uevent ensures these rules are processed correctly.
> This patch sounds like a hack to me. AFAIK, "udevadm trigger"
> performs exactly that.
>
> Thanks

AFAIK, PCI slots do not yet raise a uevent. Secondly there is no uevent 
attribute in slot-id directory to submit requests to raise a uevent. 
This  patch fills that gap

>
>> The patch was validated by manually triggering PCI slot 'add'
>> uevents through the slot’s 'uevent' sysfs file and confirming
>> that udev received and processed those events. The following
>> command raises an 'add' uevent for a specific PCI slot:
>>
>>      $ echo "add $(uuidgen)" | sudo tee   \
>>                  /sys/bus/pci/slots/<slot-id>/uevent
>>
>> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
>> ---
>>   drivers/pci/slot.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 787311614e5b..cbc7cf6ab7ad 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -63,6 +63,15 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>>   	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>>   }
>>   
>> +static ssize_t uevent_write_file(struct pci_slot *slot,
>> +				 const char *buf, size_t len)
>> +{
>> +	int rc;
>> +
>> +	rc = kobject_synth_uevent(&slot->kobj, buf, len);
>> +	return rc ? rc : len;
>> +}
>> +
>>   static void pci_slot_release(struct kobject *kobj)
>>   {
>>   	struct pci_dev *dev;
>> @@ -89,11 +98,14 @@ static struct pci_slot_attribute pci_slot_attr_max_speed =
>>   	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
>>   static struct pci_slot_attribute pci_slot_attr_cur_speed =
>>   	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);
>> +static struct pci_slot_attribute pci_slot_attr_uevent =
>> +	__ATTR(uevent, S_IWUSR, NULL, uevent_write_file);
>>   
>>   static struct attribute *pci_slot_default_attrs[] = {
>>   	&pci_slot_attr_address.attr,
>>   	&pci_slot_attr_max_speed.attr,
>>   	&pci_slot_attr_cur_speed.attr,
>> +	&pci_slot_attr_uevent.attr,
>>   	NULL,
>>   };
>>   ATTRIBUTE_GROUPS(pci_slot_default);
>> -- 
>> 2.43.0
>>
>>
