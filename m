Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D43168F6;
	Tue, 17 Feb 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367176; cv=none; b=L1sZy1t7W9xpXJl/dNq5OpeHl9xIknbUg2VN3/1qmD6nICC0/fzA+YFXW6xK0dp5mmfRe//l+RDjeFeS4Bi0keZCC+4lAUiS7DfsyczrTFfTDn8YQ5cMK410To88m5djrbZzldD8jq4TltYOFd6LUz/pOdS7t+wifiVXJ8CLf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367176; c=relaxed/simple;
	bh=CauXCMMScNpDHMis5FXdfmpRKk7l7qV/1VODtjPxiy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+gHZdMUGlO6pwT4vFzwjEnW3kz90jbrdgYmvXmEPOrwy2JwJM0fsUvdOOMYd0iZKIrRA7ZPGG9yeAIPmCOJY4es+jjUgQKLH4/vb4Xu8mSJ9W2YYk/4lZMXJ4hcI+ShViA4NtVePU8TRUj0axA8AblukV6vrpPFhpjnTKvxEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TA5BMCcb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TA5BMCcb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HFNtfu3162998;
	Tue, 17 Feb 2026 22:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QwjtRP
	wA/PezjxlQV3WevGyD2tRCq3nS5TSoVTM0NJw=; b=TA5BMCcbD958MjA6IeR/0s
	agtrYOJtMy3f1zuSgBfJhsi9/+dOid5DfNJ+bZgybrJ//8xp94VCBirmTwcMIesq
	5JaRJrqD5iKVyOPpqIM3OCf9UMYBmJOoXe5ASM1drbRt4/tMOYs4YYQA/DpABlho
	1dUDxAYqpGFDDUp83YEc6HdUY0UB0M/d9/cLLfwMWZvJPHPz9fulWCScvehuQI3l
	fcTBL/dOaUQLrZQul6dx81Xer3sI/bgCTL6dcquSxKPQM1G2+8GVlaCd+xiloOCi
	hX2AeesTWvoI/V/KvJHodft3YAAnKzz9njLFepmCsvNYpG61D8AUvpgmYq09q4Dg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rxsju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 22:26:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HLReJn015721;
	Tue, 17 Feb 2026 22:26:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb455fgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 22:26:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HMQ6DD28967664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 22:26:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 294FB5805D;
	Tue, 17 Feb 2026 22:26:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5129458043;
	Tue, 17 Feb 2026 22:26:05 +0000 (GMT)
Received: from [9.61.242.249] (unknown [9.61.242.249])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 22:26:05 +0000 (GMT)
Message-ID: <54301c56-1add-4029-b6ed-b441e4fda8dc@linux.ibm.com>
Date: Tue, 17 Feb 2026 14:26:05 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/9] PCI: Allow per function PCI slots
To: Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-2-alifm@linux.ibm.com> <aZTaPH85j5R81Vna@kbusch-mbp>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <aZTaPH85j5R81Vna@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994eb01 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=4BKzHjxeoT3xkgTLmf0A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: abp-wa7Y40mvobzzDtxKv440EMz939mo
X-Proofpoint-ORIG-GUID: abp-wa7Y40mvobzzDtxKv440EMz939mo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE4MiBTYWx0ZWRfX5LkuWb2sNnek
 i0/xoZdRkZ6BbxhdyyXUv3KcwtSaiSOtGsBd/g7zHR0uVP1vgg6y2s+asomtA59XDA0ZLELk0dV
 1X8xE8mm3/mb1fy2zvgNtU84zeYnAjppaMJGq+kJ0Zt1sh0uidMvih8Wtu4ojeMxhjp01izA5S7
 Vhi/DInsNfk50I7tW2VRTrdiQ+nIGqcvcijoMpZzkPyJSvp5xoODgFoBIrLr6VL1DUmOmh/4elE
 geZuxTm+4yQJKmx51e4dCHjqOsSp+R0aI4/3XQ3GfaMasWGeVH2Vw0qXc02N7XU7UH8jSUhsXZy
 D/J6lp8sDR+qZPZen9Vm7X3oKlKky+yKtua9qt7TxITKUyzzS6rLnn1JgozHw0l6GasMkMRNUzG
 VBYnRdcG5cuZFXTWxQBLHmhiF6LrQsZRW2ZGp19uwRzcnXAL5oe6QD6ooinPSoYlymtJI0vZQoI
 Vefe/wuTVIYu0be2X3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170182


On 2/17/2026 1:14 PM, Keith Busch wrote:
> On Tue, Feb 17, 2026 at 10:22:49AM -0800, Farhan Ali wrote:
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
> I think leakage is because s390 is passing in devfn when pci_create_slot
> is expecting devnr, so things are not getting matched and assigned as
> expected.
>
> If you're able to make this change, it will clash with one existing
> thing, and another proposal I've got at v5 now(*). Specifically, this
> would allow all 8 bits to be used for the pci_slot 'number' when it's
> currently expected to be limited to 5 bits. 0xff is special, and I'm
> proposing another special value. If we are going to allow the slot
> numbers to use all 8 bits, I think we need to change the type from u8 to
> u16 so that there is space to encode such special values.
>
>   * https://lore.kernel.org/linux-pci/20260217160836.2709885-3-kbusch@meta.com/

I am open to suggestions on how we can better model a pci_slot per 
function. And yeah, I think it makes sense to update the pci_slot 
'number' to u16.

Thanks

Farhan

