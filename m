Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F983002CF;
	Tue, 24 Mar 2026 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393720; cv=none; b=jzO9NUqUw99vFI8e/RH+po9eYD55BgSLF0Er2HsSXOekOaLx11ZYl2hYkd8sieZVA3apevBfWTu8RPEshiFkU8AIYuEHXCDv7tPkUg+5hoi44fuHdLxzv6CZccF0ZkvEwpWSTYBLA1rTUdjmuMViGuT3tm5lBgcFmyCHBc7riEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393720; c=relaxed/simple;
	bh=6fSyFmbCvBlEwVsaDZriXpq8XFS0gX/9D5B1on5bDU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX9AuOi+6KYsLRhMttKUyWkvXsYOQlOthwDwM92PVjpLqqg0dm0gfxTgY+rEVMwfu6jIAPNwcqjKNkY7MR8xmxAA/TWwtf49F02u+d1X9I1Yf4srALFkNstlCb/dk8qCYg1OPwysNIeZR2yQu3VXPWeUIijEnAcJLfZI05vpwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OgUOgmdN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OgUOgmdN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OE4QsA2892944;
	Tue, 24 Mar 2026 23:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dho0XH
	qk/lBL3QYzEL9QlBUSlI/fVsuig+Hw+6ydC00=; b=OgUOgmdN4O65fto2hha2Xj
	SQJUNwvoQIEOdzFGutuKm8DO6NvrjU5bGYgT6Quj4jr8GWwK4vhOIhh5ydIpZ6W6
	5RhYVwrVSYYwUbQ+svwXFml2MRI/05gor8JAtijrNOZkKieJE/hGoGfRDgYOE0qP
	27JAyZqHYpdYkTitS3H18TBHajfP+H4VV9ZnXduWc5y+uSTP2myl1BNtbJDrjyEw
	hOGJRjQBELcA0AgGskeTJLFlzfHPKOm5ZAOxiP93ia8zfC+XyIvjG3rsG4g0ugca
	wA+joVZj26r/wV/8X3R0X0qA2wVS2+7o+4AP7keSLfpiX4C0NftIYwQ5qPttn/Ow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky059xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:08:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKGSqt004375;
	Tue, 24 Mar 2026 23:08:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c23yas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:08:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ON8UeT28574294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 23:08:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB44E5805D;
	Tue, 24 Mar 2026 23:08:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1153758043;
	Tue, 24 Mar 2026 23:08:30 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 23:08:29 +0000 (GMT)
Message-ID: <a9b7c3d4-e16a-4522-ae56-655a9e38e6e7@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:08:28 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/9] PCI: Allow per function PCI slots
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260324215513.GA1157029@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260324215513.GA1157029@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NiBTYWx0ZWRfX7EYECkUxdTpd
 2TQCNUray8wA5qPVkZTm8dc9WzZ1Zzmt7eiKJ2zjZAdL4nL5iV2TJ70rP2Oqy18giD3dzGTnjnW
 sOHSUG79L8u+bAMOqsURtEdQLLb0o64fRoivPd91t+tjXmaOwqXr5ddliKtgnOO/zKdXBl16YRQ
 gkTUVs5FGJrNVVZqcJ3vXc3cD8LUFnaD02jdPXNaDGdcRpFAr9c4uK7XfW0kq4JXHFYs9en3g+q
 s0orXRJRCl53yYe14QfLFzDIJS5mvcyyMJbtfeN5ZbFSTkQzAAokBA7xPHjmVClJv/hQhyWe5KG
 M1nn3L+vMYRtx81uzZvjH139C7STzC3Zm7SOTwTv801KbDESUS7KcmTWrv2M5rpVBRZD4K+WD6b
 cqVGHdWgRKjd6z3Gx41oV0kQiO5aIKcCaAPsh3VOGRjjr3YvMs61OTQatRiFQkCKlgqMetlZzq1
 QXIIS8YLTYPv/ovv28A==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c31971 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5nvlfnKFYDgl3FLByUcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sBho-ybPAyRwucK84pVu480zlnfTra5t
X-Proofpoint-GUID: sBho-ybPAyRwucK84pVu480zlnfTra5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240176


On 3/24/2026 2:55 PM, Bjorn Helgaas wrote:
> On Mon, Mar 16, 2026 at 12:15:36PM -0700, Farhan Ali wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
> I think this "pass-through" is from the hypervisor to Linux, i.e.,
> what we think of as the host kernel, right?

Yes, on s390x we have PR/SM hypervisor which would this passthrough to a 
Linux. The Linux would be running in a LPAR (Logical Partition) created 
by the PR/SM hypervisor. For end users an LPAR is the 'host' for all 
practical purposes.


>
>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>> to multifunction devices. This approach worked fine on s390 systems that
>> only exposed virtual functions as individual PCI domains to the operating
>> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> s390 supports exposing the topology of multifunction PCI devices by
>> grouping them in a shared PCI domain. When attempting to reset a function
>> through the hotplug driver, the shared slot assignment causes the wrong
>> function to be reset instead of the intended one. It also leaks memory as
>> we do create a pci_slot object for the function, but don't correctly free
>> it in pci_slot_release().
> This alludes to the patch fixing a reset issue, but I think it should
> be more prominent, e.g., the reset and leak fixes could be a separate
> paragraph.  The subject line should also mention at least the reset
> fix.

Will fix this. I will move what we fix into a separate paragraph.


>
>> Add a flag for struct pci_slot to allow per function PCI slots for
>> functions managed through a hypervisor, which exposes individual PCI
>> functions while retaining the topology. Since we can use all 8 bits
>> for slot 'number' (for ARI devices), change slot 'number' u16 to
>> account for special values -1 and PCI_SLOT_ALL_DEVICES.
>> ...
>>   static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>>   {
>> -	if (slot->number == 0xff)
>> +	if (slot->number == (u16)-1)
> This "-1" is mentioned in the commit log, but I don't know where it
> came from.  I guess we must assign -1 as a default somewhere?  Could
> this be a #define to connect that assignment with this test?

The -1 is used a placeholder and from what I could tell 
rpaphp_register_slot() would be the only one to use this. Would you 
prefer this to be a #define?

Thanks

Farhan

>>   		return sysfs_emit(buf, "%04x:%02x\n",
>>   				  pci_domain_nr(slot->bus),
>>   				  slot->bus->number);
