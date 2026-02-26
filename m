Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088193290CA;
	Thu, 26 Feb 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138036; cv=none; b=Y0lvajZMfLFZS1zZ3QgiWWPadRt4ORW8wdZORjPKGupRto+e09qPiZN62BnotVgpQlqeUXZBzslIt40lNNCuoOAfD+n7yEFCh6+QkcFfGNu9SeWDS/D12zMiM/KXg75ALyg2EbE/2LmBH7n+leUFGHz8WcizOQAZ2+5vaXMfwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138036; c=relaxed/simple;
	bh=EJQgAPxzatflqoL4azGU1v86RP78yNo+QeYpeGq9FNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+t5umIWiSjvsZGBlPlpsOsp0/2KanEYYvVmuLWQAVR/uusrJl/J6B8to/eJGUhaZ8LBhcZq7HFOAVGigsMNGpLLLXuIgqdOoi6UfE7h/xIk2FLaPcJ1EGJpvDCWhy7eRCB1tZFe0rNVOId3Vu9+zwAiww6ruBiylmgx4Cr4YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ezV3TaVx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ezV3TaVx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIuUj22346005;
	Thu, 26 Feb 2026 20:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=P1K9nuP3EkU0YdA9mlDnCQTrOZMNuWHS0JqtNR0hgVQ=; b=ezV3TaVxPCzv
	msiaf/bnEIIp++FrRgrCiFiqKM8U/WFYYbYCX23J+/fTNc8QCUXDYp3zatxxSJG9
	9UF8gdY9oJRRbqgdvGfZbMoLFiqVuFJijkpOl/FO20REZSsBfZ6xqiZcpVvax7Nz
	qhEsfbJw2oYvifXYDO7Ep1+rjrwW5EE1aLbC8T3BK5osh7/JFmS80u/+ug9Si298
	eT16kkN+O/gj65QgTv6ntMwLsIf2YEJCr493B9OqYDNiWFoSulF7m3QDxp+e1Bky
	EPq7folTc1cIg4hB5qsmYkTgMdAu7RK/HHh3vbvOf11WOE3wZYqIb1YZj4/nr3IT
	ZUs5zNui5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858xbha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:33:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIbOKF001659;
	Thu, 26 Feb 2026 20:33:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1ne0et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:33:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QKXnKa19071576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 20:33:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDD158056;
	Thu, 26 Feb 2026 20:33:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C573F58052;
	Thu, 26 Feb 2026 20:33:48 +0000 (GMT)
Received: from [9.61.243.9] (unknown [9.61.243.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 20:33:48 +0000 (GMT)
Message-ID: <a4a641fc-97d7-4c89-8da8-b6cdaa87eec0@linux.ibm.com>
Date: Thu, 26 Feb 2026 14:33:48 -0600
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
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
 <20260226183945.GL12611@unreal>
 <42881e7b-3e29-4024-83e5-fef5cf109ee0@linux.ibm.com>
 <20260226195153.GN12611@unreal>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20260226195153.GN12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfX3NBePyxk+dO0
 lMDPVJ7dDgI0E/ahjnXrZSggnLs96H5azMyE45izQpCjX58OPH75CSzEW16V1awleenNA581Zk1
 RFaaGM63JWpC0nr0pTUZZ76hacwAPIKer05ZHLHXhba8P9UoPNOpCMj852MHo3MVT2xZ9useK0O
 /ffDqy4/GV73X3HClcouhWY0d9VaSwqb4xC38bijM1X4Q75+MmW48DZWWIHqsbOQCqeFIt0jkcp
 l5o8sJDMTQgxFG4o53/jlRhAi6klHqFFIkEJPvdU458SKr+R3v4+7DZ41ueYoA35xbqVS5Pb7IL
 5Nye6rUTgQhFyfQ2x1tOTaMywQ6OClhIAFFGo4Tw9fA4CV2K1VLjmj+fMMjOecpTb6M0D39BRMQ
 fdcekHUUnTXEQQmM5SZfytfzr5CAmRs1n/TiOZPFiZ8XcOKU28sc649oArvMBT6IwCjxTJuUexu
 boDIywzzhRzvU7XvrLQ==
X-Proofpoint-GUID: sHjrIBp4lDDMr3XCmXg88dMMuUwbS2YB
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a0ae30 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=geXLp1ez0Hof5z_lTs4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mxD4M0FnuHX_HqZee4bg2C_wOSjfIoaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260184


On 2/26/2026 1:51 PM, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 01:31:07PM -0600, Ramesh Errabolu wrote:
>> On 2/26/2026 12:39 PM, Leon Romanovsky wrote:
>>> On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
>>>> On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
>>>>> On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
>>>>>> Add a new write-only 'uevent' attribute to PCI slot sysfs
>>>>>> entries. This provides a mechanism for userspace to explicitly
>>>>>> synthesize PCI slot uevents when needed.
>>>>>>
>>>>>> For cold-plugged PCI devices, slots may be created before
>>>>>> udev is ready to receive events, causing the initial 'add'
>>>>>> uevents to be missed. As a result, slot specific udev
>>>>>> rules that define naming, permissions, and related policies,
>>>>>> are not applied at boot. Allowing userspace to resynthesize
>>>>>> the 'add' uevent ensures these rules are processed correctly.
>>>>> This patch sounds like a hack to me. AFAIK, "udevadm trigger"
>>>>> performs exactly that.
>>>>>
>>>>> Thanks
>>>> AFAIK, PCI slots do not yet raise a uevent.
>>> Right
>>>
>>>> Secondly there is no uevent attribute in slot-id directory to submit requests to raise a uevent. This
>>>> patch fills that gap
>>> Please start from the beginning and explain what you mean by 'the gap'.
>>> Which scenario failed before and began working after this patch? From your
>>> description, it sounds like the behavior should already be covered by the
>>> 'udevadm trigger' command.
>>>
>>> I want to note that drivers/pci/slot.c has remained largely unchanged since 2008.
>>>
>>> Thanks
>> PCI slots are surfaced early in the boot process before udev daemon is able
>> to run and process these uevents. As a consequence any uevents raised by PCI
>> slots are lost. To apply the relevant udev rules, we need to raise PCI slot
>> uevents a second time. This cannot happen if uevent attribute is not surface
>> by PCI slots.
> I don't understand what you are saying. In previous email, we both
> agreed that PCI slots doesn't have uevents and here you are again
> repeating that these uevents are lost.
>
> On my system:
> ➜  ~ ls /sys/bus/pci/slots/
> 0  12  14  8
> ➜  ~ ls /sys/bus/pci/slots/0
> adapter  address  cur_bus_speed  max_bus_speed  power

Thanks for taking time to review. Will  use your example to elaborate. 
Will reference slot 3

Requirement:
   - Be able to define a udev rule to match a PCI slot uevent
    - Enable or Disable a PCI device

Before:
   - PCI slot 3 raises a uevent during boot
   - This uevent is lost i.e. occurs before udevd begins to run
   - Need to resurface uevents arises
   - PCI slot 3 could not raise a uevent on demand
   - udevd could not match any udev rule as there are no uevents

With The Patch:
   - The raising of uevent during boot and it loss continues
   - PCI slot 3 CAN RAISE a uevent on demand
   - This is made possible by uevent attribute
   - udevd could match a udev rule and apply defined configuration


>> To me the sequence is as follows:
>>
>> - udevadm submits a request to raise a PCI Slot uevent
>> - PCI slot uevent handler constructs and publishes a uevent to userspace
>> - udev daemon receives the uevent and processes it i.e. apply configuration
>> encoded by matching udev rules
> I asked slightly different question. "Which scenario failed before and
> began working after this patch?"
>
> Thanks

Before you could not match a udev rule that could be applied. The patch 
if approved will allow this capability


>
>>
