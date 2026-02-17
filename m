Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63925D1E9;
	Tue, 17 Feb 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358160; cv=none; b=JVhklWVEnpf+RAzbc10jxK0mV9Kj3ZnDNQbRoHhUYsH8niBGoZVW4W4iw50aMcBGP3bmCofpMGoW1b/e/zUS4pzYUUDgJD3nFzrsj1I5EQdqp0UiRy6nngwE92qwlphf9QBGn4M4DebE0scOw8kDQck1zlrBpMlrbm9EaIfOCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358160; c=relaxed/simple;
	bh=giOWjCQH6wS7nPGAjIXXxjZXzDGkoQy3N64lkyRWLIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoTS1/PTuSZqWVEJrAmPYTtY2pkBd/MZQZa+r58i9KZtgw0NYa/7AaO0SqVsEjZKUU2MSB6LnrLeJqWQ/4jaDaIoR9ut1tmBrSFp1XwBitEy0JqCUbBA0YAqKbhJzwmowdHxCexsFaoJ7LZ4d71w3YKCbwBFAmyUnQO92aUUOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQwFnpJt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQwFnpJt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HIrcqT3309338;
	Tue, 17 Feb 2026 19:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e857/+
	XeurNCek9z3d0m6OAoBNZWbSgBh2bjyUUuag0=; b=rQwFnpJtsfcYzwPDbQcIKu
	ekmHddiYKtxEeHXMKXNEpvVuOqXLlRr9nGpiTRULQzHhxB2awY3iPqz5bS8Z2B+B
	Pj3LM4xdWI5T//EvRUDJu3j8XOWDMl1X/4R9NwRaKMO2vsQ/rfp4Xq5SaJgx0wMC
	YBHFsp7xNXTgScI/NLZeU4tlaISi6qjH4myFVLlCaYbqqmwsr4vFUfOn49H+rB+o
	rmp1khhp0o+bjZGEJYJMwryWd44paL58QgrzmiREN83FalcciY473QnMZNgUMNDi
	47iCQ4FyF2tIP5Si4KjXbyzCcIlXQmoIiLsumzYRE8D1uZ3dIpvZeKEYqGhD4vBw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kdcje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 19:55:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HJ2Ek4023889;
	Tue, 17 Feb 2026 19:55:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb454u1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 19:55:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HJtia315205048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 19:55:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 535B55805E;
	Tue, 17 Feb 2026 19:55:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 746505806D;
	Tue, 17 Feb 2026 19:55:43 +0000 (GMT)
Received: from [9.61.242.249] (unknown [9.61.242.249])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 19:55:43 +0000 (GMT)
Message-ID: <2818bf62-54c0-4416-82fe-b47f5ae2fcd0@linux.ibm.com>
Date: Tue, 17 Feb 2026 11:55:43 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
To: Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-4-alifm@linux.ibm.com> <aZS9X_CQBuo7gQpC@kbusch-mbp>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <aZS9X_CQBuo7gQpC@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE2MSBTYWx0ZWRfX2IajmBNvZO4m
 xz49fdcSeGPQCx0IV0Yg7M1K5w/9IEEfEBKxWEulgeRiRR8tHisoPFVV55AUfxTSaCKulminPve
 YdQu4M5zeYQ0WJJIOu23o06cjxhH6PdE0tKURyBSFnw6Hl5pF9hf22HXv0ubu1iAdNsdoqT3OS5
 hZokVyLkBpdg5yxWldf7vkZecg77k6WCRsaa89Sylyj6RZe10eiKBPKVGokXC1nvQLdc97lgLCp
 kjtUenJd6GK3mBUDjjjImNRbNecRAJacHuVqJIE5fDQrRlHFoUY0Zj1h/aVgOlqVu9vd3Djl9sL
 wU5ABf/j+MtiD7yEueQbbEvU6i7J4TqJNMIsEphVNo5XBWhgWQcbuWF90JgNhNCfTU+acvj6RHn
 BE7SJ3JR6K33yYxUT4SZRWPiXLqCklm6YQvzx3Ca3kOu4XvWZCKcVSGokT9XRWiRW67C+PsuMhr
 Z9gWGqWVWGfqaOg1uRg==
X-Proofpoint-ORIG-GUID: wnIxsI2QEjug02k4k4EMN77zuRDJq61H
X-Proofpoint-GUID: kq08CJRypp2_CBkq94u-gkvRos6n1SBo
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6994c7c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Q7f48Jf6utwjRvlCK7UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170161


On 2/17/2026 11:11 AM, Keith Busch wrote:
> On Tue, Feb 17, 2026 at 10:22:51AM -0800, Farhan Ali wrote:
>> The current reset process saves the device's config space state before
>> reset and restores it afterward. However errors may occur unexpectedly and
>> it may then be impossible to save config space because the device may be
>> inaccessible (e.g. DPC) or config space may be corrupted. This results in
>> saving corrupted values that get written back to the device during state
>> restoration.
>>
>> Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times"),
>> we now save the state of device at enumeration. On every restore we should
>> either use the enumeration saved state or driver's intentional saved state,
>> never a state saved at the unpredictable time of an error recovery reset.
> The vfio driver calls pci_try_reset_function after pci_enable_device,
> but before calling pci_store_saved_state. Won't this change, then, mean
> that the PCI Command register will get restored to the wrong state with
> the resources disabled?

Yes I think you are right, with this change the PCI Command register 
gets restored to state at enumeration. So we will lose the updated state 
after pci_clear_master() and pci_enable_device(). I think we can update 
the vfio driver to call pci_save_state() after pci_enable_device()?

Thanks

Farhan


