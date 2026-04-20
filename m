Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047D3C872E;
	Mon, 20 Apr 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713872; cv=none; b=UhfGNKSKM7j5SKQLhNqsYXUn4jGgQof8KbgOfezyvr5J23pL01bL+OELaDEmfthxmEWScpF4tq9qGs/371UHm60el/W2DRvohJp06WmjkerK6Nv8Z+uip5Btcu1CDOZb5Epf7Oj2q7SR86EWP2u6IBNmQ6bvoVDo/4VrKh8/cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713872; c=relaxed/simple;
	bh=jMHTE4tbMd0Ik2MeWBlvgzwC4gxSOJlFTyiQrOS4lgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2UwBUKVE52Iw5ePiaNPc3ahDLqDvdG0r+6M01SNSQG2MUjYWMVkm3in/BV2NpzzNSOPos2sGdOP5lCBiqkDJBot0wu4+5tjnJf500RzJkgApR6Cfg8eRD6lTRr/HA+FTDfSqiQBou3nDaTTSaPsQd7A12Q4vOo57KGOhXZezbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fvtp4b3I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fvtp4b3I"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K9SNPO2492449;
	Mon, 20 Apr 2026 19:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=kXfS9t43hMBtiRLlGqvBQDUHz89EVpV6pEmffSvYM7Q=; b=fvtp4b3Im9tz
	X2v7n3DcQALDcnkuZd4MJ6mIYTKTp4T6ATSy8kzovLe+aqRrhkfE0vcvw4THq32G
	AYGIIEhku1H+h5ZR83y/EW7MF8ql5Gg+CBb5PNna7T9jJ9rJRznQA+77W4tvKGYd
	UACKiCJiqpkrgINZ2RreH6C9E8JLh6gRdQuQdfHmF6FOycHSI+rSuTO7JBqumnZE
	J/Pwi4VB/co5KlcR6BhHA64OF9cUXAcfVRz9+LKdV8I5WMsDA3A3HWe83Z1G85Wh
	COQVLScdN6cOfp92m9u8HVL8lrLkSswgng4yRKPpZc0e4l4Z9S3avJea7Qm+sDKW
	47DBwNAfUw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0rmkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 19:37:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KJZI2A021402;
	Mon, 20 Apr 2026 19:37:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsgwyg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 19:37:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KJbl7o1508110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 19:37:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED59658053;
	Mon, 20 Apr 2026 19:37:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EDED58043;
	Mon, 20 Apr 2026 19:37:46 +0000 (GMT)
Received: from [9.16.40.3] (unknown [9.16.40.3])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 19:37:46 +0000 (GMT)
Message-ID: <5c1498cb-5de6-41be-8db7-f76a385237c0@linux.ibm.com>
Date: Mon, 20 Apr 2026 14:37:46 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <91f26c77330be0783aad379dd1b04bb4c1411713.camel@linux.ibm.com>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <91f26c77330be0783aad379dd1b04bb4c1411713.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bB9VXPujCJ7NzEiCp2uGlIrhpKj-cUQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4OCBTYWx0ZWRfX/7VZ1lLWOtMY
 s2BEqBqG4ocGU5sISkT16shJNZkYz88EfuY4CzMuHZ4xiQl3SazE18BFjqwZFcaTPp1p8OSCB8k
 440ndo0l1PHX5U6zoEeoE2YgvbfNg4SIS27R8er9xLLqi3zEZCkC/Ge0RNdFhEE+DXI8g1wBw+W
 sxzGjRp4w+XyRkSERPvVLMdqLtjfPymgZBqwF/ppto2zeN8xbMBZ1M3jJVB1GTRZeSOWn9066ER
 xmAa+BiHKrQoJGXJFnhrwqL+zCUFdpqyTWqzjUqwoFpYxWZPzzz9rKDj5ONWg5AcNrIx+a/UdQY
 s2JBZhl4cQUC5Fulv/zku7s/2T+6dtRFIPVJsYfJWmM0Z+ThuY96mZb2GHMTUaIDvvN0JlNy76F
 K0urwZuqv+cc4v0j37/3PXSZyhpCBK+b1FvKNKqgiMDe4N8soOIQc0LjLUZzwN4DH4QQa+Qp6nd
 bhlU9NuJUorBeA+C7zQ==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e6808d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=RE2A0m1FG7ZolbHhaAUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lZX-d6iqeEQccDjoDCSDTMPkogwtlmqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200188

Thanks for testing and also giving me the review-by

Regards,
Ramesh


On 4/17/2026 4:53 AM, Niklas Schnelle wrote:
> On Thu, 2026-04-16 at 16:39 -0500, Ramesh Errabolu wrote:
>> Add a write-only 'uevent' sysfs attribute for synthesizing
>> uevents for a PCI slot. This extends the existing uevent
>> support which emits a KOBJ_ADD uevent in pci_hp_add() with
>> the ability to replay such uevents for cold plugged devices.
>> As such events are only emitted by hotplug capable PCI slots
>> so is the support for synthesizing them.
>>
>> The change was validated by manually triggering 'add' uevent
>> for a specific hotplug PCI slot:
>>
>>      $ echo "add $(uuidgen)" | sudo tee   \
>>                  /sys/bus/pci/slots/<slot-id>/uevent
>>
>> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
>> ---
>>   drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
> Sorry for the review delay. This looks good to me and will really help
> with udev rule execution for devices which are discovered in standby
> state during boot and thus currently don't create any uevents. Of
> course to work by default this still requires a systemd/udev addition
> that I know you're also working on.
>
> Consequently, I tested the uevent synthesization with both slots with a
> configured (slot powered on) and standby (slot powered off) PCI
> function.
>
> Feel free to add:
>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks,
> Niklas
