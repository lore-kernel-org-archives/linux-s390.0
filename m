Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276882;
	b=NsZwYH5XiVm8jARgF54S4Pyi894LE82xEyPtu5pCrkLxknkdzt8HC9OvBXcmzjZkTWuy
	 KNTYaBm8oz9e7Qk8Yf3SHn3BYtr3ZE7GjV3+/KEnA5ACWaOG6i/HuJI5J6S27xuaUErXs
	 tXP9rNR8WKb8ZqAYAS5hwHEufhKdVKd2STuJEn2OfjabQce5P3rIfM4SUs9TClNXzAwNu
	 FlMhHryrMD+zt8V1DMQg3HEgpfuGYdWYM7GU+/AT5DCni7942AXQBzgmnDhkxjT+RBUNg
	 l8TTz8l5g2bZkaYZJPagnjf+dvG2RrVDGc0KItVsC2NQIKC7FGTcQaxiMiwbh9KqqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276882;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=afURIQgSjuNj8H/0h9C1lu4HfwqgVmdt+unp2XHI2sc=;
	b=Gmm0QnGuOFrEtqJlQ/P52KVPXm9oI6oKsooDi+d+0R5ezkZhnygTbxdZf0XAhk3m9CfI
	 JoPtHEjhKlOPx2c8Mg7HL8+1iT/hk3ilx5vX1LYdLFYum015d+XcXSCKWRRh6m7JPQsKk
	 Qigt9N9hXgK7arSMR3+JW6aZizNDnH4O/zg3riAZESqfsg9bGEbRdbUFssJXSsFTC/Qea
	 Uz232Pr02TrprW9agGeM9MflSh4jioGHX2xpPHit/YqwPnwfhmm+5sntkTHvxCbZdMIQT
	 ewkGacRnxnBOjllk41Raf12bjtZYZ0yRXkFqszXjbY3OEtw0wkVzkfmmjQz9BITbNGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XwSz1H3S;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247E606A327;
	Thu, 29 Oct 2026 12:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D247E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XwSz1H3S
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9E6Fi3962704;
	Thu, 29 Oct 2026 12:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=afURIQ
	gSjuNj8H/0h9C1lu4HfwqgVmdt+unp2XHI2sc=; b=XwSz1H3S+ehfJpOsyQJMNr
	/y1+Z4O9umyNW8bmUU+0n0KMj4klj5qbDl1zekqtDcf+8lqbICw4pv42AtzvpDR9
	bM3LmWlXku/PBjIgmKFa0b4lyWrcYd7xEElIcq1TFS/lzsVE+1GlemDmlO1EfEvP
	zsufi5SpoJppUbIYhSmXrtoEN/kGQsEaF8Ln6n9JyBJhOrLvZgoMK6Zk3ssN3Uoo
	RzltouhJpA1kg/qTyonSeXBzLIlZ9HfmjwG7Eaw1VQkaVXYzmr9vc4YROHbz8tz9
	NAzmro/8mZZ4ZQs5dHt9mu/ZPt4WTS+hjL2Tz+VXqlISWYoDVYSS6j3L1A5ztTkA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm64a3q1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:28:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T950Fc2829705;
	Thu, 29 Oct 2026 12:27:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnhhkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:27:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TCRwe260424512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 12:27:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5591B58052;
	Thu, 29 Oct 2026 12:27:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E62B5805E;
	Thu, 29 Oct 2026 12:27:57 +0000 (GMT)
Received: from [9.61.241.59] (unknown [9.61.241.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 29 Oct 2026 12:27:57 +0000 (GMT)
Message-ID: <fd754769-c15b-4d59-b259-d4d044598a52@linux.ibm.com>
Date: Thu, 29 Oct 2026 08:27:56 -0400
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
To: Niklas Schnelle <schnelle@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-4-oelghoul@linux.ibm.com>
 <sashiko-outbox-188110@kernel.org>
 <72ddf1a4-d672-4d9f-a205-07aec3db1248@linux.ibm.com>
 <1cd8eed2c5268a02df5f8600ae469d023761754c.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <1cd8eed2c5268a02df5f8600ae469d023761754c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfXznUojVge8K1B
 TU+gip8I1KoPtvphJmv2K+9guUj0gRqZWOYUfq54225LbNrQgtnPW32f41+dr0QAjBgBQ37Jk+N
 HzgwS2ySyLZ/a/OO6WmNvJ11mpQ0k90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfXwn+XuJgWFKKB
 qx0u0ePBkON5r63RpvY+yosw6zSdrgt9KcznxCRFnpyvQi1Uh0Eu3km4nFTtC7/8wnzN9iRWSDh
 JqI5IMQWDS/syhM0ge8je16wUVxiiQdRzB6mmmIpLEdWNdl7e2jN4xxyE+auGs1XnRKa0gP1Raw
 aRE59/S9pp1ymeMvkTH148ZUmarshBuJfU2zMH+1FYAU0/Forn6E7UOVG75U8eNLFYyXVKnv5qu
 SH6LnvjI+jFKdlZliFIok4+QD2gtwmJxuo/Me22CZJDKpoExGT/1ztlkGv20+eBi04lKTdxICQ/
 huT1X5kcMyxQY0KJOapX6DO8bX6vGPJatCnjj+KGIFbwfsy4ikHin222CukYeMxjTIGuDJtKhYH
 /Jp4V3OUZBI7XGVl3LfgUh0/RZkpN9gxuQq4CFvvMuCVWQPfm4W1WE/MgwUWx1AVxleUlJUYe/d
 Uj391iszzRSgfD3lf+g==
X-Proofpoint-ORIG-GUID: 8P_4t0yUzvnV1XjYo-IcylLa9K6G3iG8
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae33bd0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ULb8jbz8dg8js5G6V90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8P_4t0yUzvnV1XjYo-IcylLa9K6G3iG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290047

On 10/28/26 5:12 PM, Niklas Schnelle wrote:
> On Wed, 2026-10-28 at 12:15 -0400, Omar Elghoul wrote:
>> On 10/28/26 11:59 AM, sashiko-bot@kernel.org wrote:
>> [...]
>>>
>>> [Severity: Medium]
>>> Can keeping zdev->fmb non-NULL when zpci_mod_fc() fails in zpci_fmb_enable()
>>> leave the FMB enablement state inconsistent?
>>
>> Valid concern, but unfortunately I think this is a tradeoff we are going
>> to have to accept. Based on this discussion [1] under a previous version
>> of the series, we can accept these stale reads because as Niklas said,
>> the firmware-written sample includes a timestamp of the last write. So
>> we're already transparent about giving the user stale data, and in the
>> unlikely event that this happens, the user will be able to recover by
>> disabling and re-enabling statistics via debugfs or simply re-enabling
>> it directly via vfio.
>>
>> Thanks
>>
>> [1]
>> https://lore.kernel.org/all/a24337bd66864dd70ae61e28d86590052ac0fc5d.camel@linux.ibm.com/
>>>
> 
> I think the problem is a slightly different one. With patch 2
> statistics_on tracks if the statistics should be on and zdev->fmb !=
> NULL tracks if they are on. With this patch zdev->fmb loses that
> meaning. So when the zpci_mod_fc() in zpci_fmb_enable() in
> pcibios_enable_device() fails the removal of the "if (cc)" block now
> means that we still do the zpci_fmb_disable() in
> pcibios_disable_device() but that is a sequencing error.

In the unlikely case zpci_fmb_enable() in pcibios_enable_device() fails,
the FMB simply stays disabled from the firmware's perspective. Then the
user will see zeroes or stale counters. AFAIK the architecture doesn't
forbid double-disabling, so IMHO I think the extra disable step in
pcibios_disable_device() in this case is redundant at worst.

> 
> So, as we want to keep the FMB associated to prevent the platform from
> overwriting an already kmem_cache freed different FMB and thus can't
> have zdev->fmb NULL at any point after having it enabled we need to
> track the actual enablement state separately. I'd add another bool to
> zdev for this maybe "fmb_enabled".

I think this will introduce a lot more complexity than is needed for FMB
handling, and even then it will still be really messy to get right and
account for all the cases where firmware can disable measurement without
the user requesting that. That's largely why I thought the tradeoffs of
occasionally giving the user stale counters and allowing them to recover
via debugfs or vfio if needed were acceptable.

Thanks

> 
> Thanks,
> Niklas

