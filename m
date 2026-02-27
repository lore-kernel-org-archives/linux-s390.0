Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E53EF0B8;
	Fri, 27 Feb 2026 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191412; cv=none; b=AbVA8EujdzlK4RHTTTDTftYzwuETNme5szkgj8d0jEFkpuAWrB+JIzpSM1W0qMiVji3/pr1UaihiL/O0VOfMY8XJ+8P1sTe5xfT+cs+9k9GuFjAfoNBZaJobM+rJuNvRe3WYO//SVNhH3UE4k6VljJnK02U6BfnBITC9BSLRHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191412; c=relaxed/simple;
	bh=7lP2OlwL0IP8xBEk7nVacq4bj58bnRYBOhi4gg0xYzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0V82DOJu4VeBpEm9b5qrpSpYSGn22QzDGv1FsixFqgnlMECtSS9FTPnOO7/AD6Em7zxZBwSOw1KTNFLAAYGIl8pBaTf/jnINivoWtBgrc0qY095ca/x0bZBixLUEMd0bmLXKtifz62hohc+p/wuFhHNcQZwU1VaQLeQVoSThxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hZJtI0ZH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hZJtI0ZH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R4eW362760220;
	Fri, 27 Feb 2026 11:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CV0Nv2
	MpYOZumLGTiltVSt/dqZv4evjHvl85pAzwaOs=; b=hZJtI0ZHPk6F8KCwzC59K1
	j6ya0hpQkJ+Xi0rpbjD/78YKKQS0BLFWCbSBtZVGHAPRUD0VEn+kRs7HlprYNstY
	ZZTyT7vTYGFe2FSqQmnXXHevcnJv7u81ISGrwcERd03ysJcW5ShWyn8sdKrokzKq
	Nrm74gaaL2REOz9BJXUhlTZRLnxtVHj/Uvd968LbefZ7X/6LknlCsSSYHxq7bbJe
	BCXusiMsIaA9cH6N/wcxMUrm6IPopCHvRhd1YZm5m8sfA2bEIQrG51QFYBvahO21
	NexShAW9jjAzA18NrhGoqUjJYbH6SWaNXYyfVAEEwt+XRpEP83ADNi43NGPTI1Ow
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34ckev2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 11:23:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RAAwZN013431;
	Fri, 27 Feb 2026 11:23:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyj00y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 11:23:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RBNO1C37356152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 11:23:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB45F5804E;
	Fri, 27 Feb 2026 11:23:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFF8058054;
	Fri, 27 Feb 2026 11:23:22 +0000 (GMT)
Received: from [9.111.177.245] (unknown [9.111.177.245])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 11:23:22 +0000 (GMT)
Message-ID: <5d30ad0a-9c16-4802-adfe-e795c38f5990@linux.ibm.com>
Date: Fri, 27 Feb 2026 12:23:03 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
To: Leon Romanovsky <leon@kernel.org>, Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
 <20260226183945.GL12611@unreal>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260226183945.GL12611@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5NyBTYWx0ZWRfX+pB6c2N1qjKC
 ZhVmOxE+ME9+WGqlS35gTGl286HqTvR9BikGeEfBoAq/7MJEG4j2BhVup7CsITJ1M6x8gmr2gxR
 /NapCNCcgVZ+szzGoa5TG40ja+0eAE8QcpLId8wln4qNmBOKZpoiGngSag4BTaEiGH1FyKAHLnK
 pMamq8ktA7cXrLaQK4bEHbwsdcgBatZIFR7nPkgfK1SyQ9X0+Eu//D5fVAd+VJEt4C0XwZIrcUO
 9kmqUDkmciX6BE9UHQJ6AwGkE0EeinkKk3Z4I9RTcYTqXDsTeexSCIxuGQqGVpclpheBG9UFNwu
 Wy81xbzzMXR4ISwbpKQ+cQwlyMHAaL+Y2HZXSW1iaASJXmp4dKGRahMCv/TkOys2kVTr3+RhBht
 gS+FO5GecgIr0U1H33gI6txloDkNLzceLvxWmfWi7QlQs2WG/0kxEw9nBENYOJCfm3T3yDAym35
 Nz7blaKaGHbNmMvVtQA==
X-Proofpoint-ORIG-GUID: Q253pkMA2MCa5VkPCszBWVjNnDtIT2JR
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a17eaf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=GhQEx97vAAAA:20 a=q3RWh7Z-AAAA:20 a=YJjgjBlOu19txBby-lAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: rzyBig3rccBvmEkL-9Qn0LHAeVh9qSUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270097

On 2/26/2026 7:39 PM, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
>> On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
>>> On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
>>>> Add a new write-only 'uevent' attribute to PCI slot sysfs
>>>> entries. This provides a mechanism for userspace to explicitly
>>>> synthesize PCI slot uevents when needed.
>>>>
>>>> For cold-plugged PCI devices, slots may be created before
>>>> udev is ready to receive events, causing the initial 'add'
>>>> uevents to be missed. As a result, slot specific udev
>>>> rules that define naming, permissions, and related policies,
>>>> are not applied at boot. Allowing userspace to resynthesize
>>>> the 'add' uevent ensures these rules are processed correctly.
>>> This patch sounds like a hack to me. AFAIK, "udevadm trigger"
>>> performs exactly that.
>>>
>>> Thanks
>>
>> AFAIK, PCI slots do not yet raise a uevent. 

That is only partially true. PCI slots are represented in sysfs by a
kobject (pci_slot.kobj) and pci_hotplug_core generates uevents for these
kobjects during pci_hp_add() [1].

Here is an example for these uevents:

KERNEL[62021.190266] add      /bus/pci/slots/000018d0 (slots)
ACTION=add
DEVPATH=/bus/pci/slots/000018d0
SUBSYSTEM=slots
SEQNUM=1638

KERNEL[62032.304390] remove   /bus/pci/slots/000018d0 (slots)
ACTION=remove
DEVPATH=/bus/pci/slots/000018d0
SUBSYSTEM=slots
SEQNUM=1682

On s390 there is a use case for reacting to these events via udev rules,
namely to persistently apply a user-specified, per-slot power state.

>> Secondly there is no uevent attribute in slot-id directory to submit requests to raise a uevent. This 
>> patch fills that gap
> 
> Please start from the beginning and explain what you mean by 'the gap'.
> Which scenario failed before and began working after this patch? From your
> description, it sounds like the behavior should already be covered by the
> 'udevadm trigger' command.

The problem is that PCI slots registered during early boot generate
uevents before udevd is running, therefore no udev rule is triggered for
them. While systemd re-triggers early uevents after udevd was started
via a call to `udevadm trigger`, udevadm relies on the existence of
writable "uevent" sysfs attributes [2] to generate these replay events.

Driver model code automatically creates "uevent" attributes for struct
devices (such as pci_dev.dev) and struct drivers, but there is no such
automatism for kobjects like pci_slot.kobj. As a result, early uevents
are missed by `udevadm trigger` and the per-slot udev rules are ineffective.

This patch tries to resolve the issue by adding the "uevent" sysfs
attribute for PCI slots. Another patch is required in systemd/udevadm to
also consider these newly added "uevent" attributes during sysfs
enumeration.

> I want to note that drivers/pci/slot.c has remained largely unchanged since 2008.

The requirement to be able to consume PCI slot uevents existed for some
time on s390. This was previously addressed via crude workarounds using
boot scripts [3] but with PCI usage increasing on recent s390 hardware,
the lack of a proper solution is turning into a real limitation.


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/hotplug/pci_hotplug_core.c#n424
[2]
https://github.com/systemd/systemd/blob/main/src/libsystemd/sd-device/sd-device.c#L2796
[3]
https://github.com/ibm-s390-linux/s390-tools/blob/master/zdev/dracut/95zdev/parse-zdev.sh#L48

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
