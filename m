Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCC3FADFB;
	Thu, 23 Jul 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811549; cv=none; b=D3bPCZa1cQbUPP+/G9m2lJOWBnhzCOxQDIuOGkL063iTQpLhrso5AFJ9XSWce5W+Yw0Ahe6Rc1F9FJ/UkYi4KJUjJ1hYATScaKY0bmop/3vP5TpO0IMSnP+CWf2AfKABLItRvoJHxmIo3X08q7wcBBA8r+dtH+9Zxj5xEpBeg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811549; c=relaxed/simple;
	bh=6KByUBuCKivDae5dGIMRk2qqpiqgK78lTVIr8QrH/yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDabi94+tbD5q67bqoZv3Xfu/aVR2PLJUXMMXiaZlH5+sogs05Nxen3fxfQ2pW7xGoUOmCYGTP6KayRDrKOx0uLWIevYCINWOW3XxMMnafeTu7FhmcNoe6fKikrO0NcANup4GuT0AC4/SLptZdtOSMoI5ElScIh1292fQcu6RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SRoxsSkv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SRoxsSkv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Bt832505677;
	Thu, 23 Jul 2026 12:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FWhuSu
	RuNnd86gmvCzq6uIzBG13c7PbIyeQcdJ9QoeE=; b=SRoxsSkv/9wV5uo74ZDOZj
	PG0odncmKeTpJ22OQsqvzTRNh/VldOLINbWCQZQqEoEA4WohAc5BChQpsnlciN4D
	6FgLGKgO3ArOQDPvT8SIEUSTamy9xAMszceBkfRMpoeAzSveUTClHGSNqrRPcPkE
	9nHOPG5ZndhjG0/J6hjN/bzZg7lpD/aVZKGTcd9D/x3uaWew4cKuXUYgWG9ewzeu
	G+5Zv0M9L8YWczTdj9ePpbSSeOfxa37IHuV4kI9iOsFhTOxcLbcSmnpiP3VKNsPb
	KKOsprOqh5sNUFOXloyUZXZljGMg7xT+cO11vGNN8inPLXyKmXmmh/dQIV8Ky7lw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kf0vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:59:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NCncQ8032344;
	Thu, 23 Jul 2026 12:59:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk46sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:59:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NCx1gW51708228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:59:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90DB12004F;
	Thu, 23 Jul 2026 12:59:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 452832004B;
	Thu, 23 Jul 2026 12:59:01 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:59:01 +0000 (GMT)
Message-ID: <6cefe506-b36c-472a-8ab7-ca2483dcc0a9@linux.ibm.com>
Date: Thu, 23 Jul 2026 14:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM s390x PCI fixes
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a62101a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UMrupAhgEYF7zp5bVJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfXzGTVyh/77psK
 FoQaPJw0XlR/eMOpU2hQ0RxbN1Gd8mVa43T4OW8coSfCJL0RQuUB4FH/M6zJG3aAk12zRvm1PGN
 lozGXFCuQUw9H05Ilggic2bKOE91Ec7llHd5Php3Frf37g6PcXiEumGSiUbdXpvcoEuJjxR7QJP
 rT6SqQPLQOZE58hAbChLI/2aUkjhpEW8YFDI9zuuOjkGBWLyM869znNCW0Nz5uU0J2RId8hc1AF
 Sffjs3Y98YC3tV239AcYl4lQEeyasQZ+GBnGksKTepQKCHbdW9ng3S0bzYNiIo1tKUgnj4QI2u1
 Owbld8+AvooFY8YQt05An/jnr+mh+m1P11r7rKTV3sNHHPXRC7/WT6kW9ulhwW4lJFVr++67cDy
 YdPU5+ujsO7U3h2CZCUHJroaG4bz1lVvLSVORYXhpwWF3ozMsEm5lNN8XuPH8rO/BpGwLBVEZ1N
 v/m/yN84F97AvUUhBag==
X-Proofpoint-ORIG-GUID: Lai97l7CaxTYATjKQZyDjlPgvyZwEpHd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfXxpMz/E1NJQa2
 sYWb3ll82YTuYMODgS6UC022j7UVSI/oV6G4IuV+rZYs5yBhHqxXepkmNno73D0pyX3RQY3q8N8
 62mdwjvpa9Bc7PBP73CrvkSpSgbYx50=
X-Proofpoint-GUID: Lai97l7CaxTYATjKQZyDjlPgvyZwEpHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230125


Am 22.07.26 um 19:06 schrieb Farhan Ali:
> Hi,
> 
> This series attempts to fix some the pre-existing issues[1] found by sashiko.
> 
> [1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/
> 
> Thanks
> Farhan
> 
> ChangeLog
> ---------
> v3: https://lore.kernel.org/all/20260720175819.1723-1-alifm@linux.ibm.com/
> v3 -> v4
>     - Add validation checks for AISB/AIBV spanning more than a page.
>     - Reject multiple ioctl call for the same device, if adapter interrupt
>     forwarding is already enabled for the device.
>     - Rebase on 7.2-rc4.
> 
> v2: https://lore.kernel.org/all/20260716175241.1039-1-alifm@linux.ibm.com/
> v2 -> v3
>     - Remove overwriting guest FIB since we don't use it for
>     re-issue (patch 4).
> 
> v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
> v1 -> v2
>     - Drop fix handling AISB/AIBV spanning multiple pages.
>     - Fix memory accounting functions for the case when interrupt forwarding
>     is enabled by one process but disabled by a different process (patch 1).
> 
> 
> Farhan Ali (6):
>    KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
>    KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
>    KVM: s390: pci: Fix missing error codes and memory unaccounting
>    KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
>    KVM: s390: pci: Fix resource leak on IRQ registration failure
>    KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
> 
>   arch/s390/kvm/pci.c | 102 +++++++++++++++++++++++++++++++++++---------
>   arch/s390/kvm/pci.h |   2 +
>   2 files changed, 84 insertions(+), 20 deletions(-)
> 

I would take this series and do small fixups where necessary. Just tell
me if the change for patch 6 is fine. Or provide a v5.

I suggest to add cc stable to all patches.
