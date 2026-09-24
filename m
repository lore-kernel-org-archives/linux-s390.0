Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF1423EA4;
	Thu, 24 Sep 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268486; cv=none; b=O7UnLrMRLCDHJwdsjrECtTp4+3tsKAynHk/uazwCwLJvefTpzGueznQW36MukelX8frhh33H/WjrKoLP6AxUYf9lcbhguWS0r19hQfVRzOUnCzeiKKnZ9zS0oHt6TqskG47jWAGcKzoZ+LnfV1ug5tl+Ukqao4en9tfhvF2Z8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268486; c=relaxed/simple;
	bh=HuP+aR+UGWr0hnkHrwfHUVRhPJv2aoGm0JQlN1t+39c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2ZBcxY2/NF09pbh1BYfKekgtw2vrmM94GpM3rwtXOg3DxZs7aDJc3Buqn0HwEs0mPG4dBkin9NuKolqeLdzQevkfxZmiaVOLujlkZGEGqiDqjyCtkHXWAxOQHhO0WatyQotcvD4eSkhHOMO5/C1aGacRlVJWBSWXLbHNxvgYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEDF1yZZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEDF1yZZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5LEZ825043;
	Thu, 24 Sep 2026 16:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dHVn0S
	AzWcL+Lt1q7XbVpvGwbbZcb+tjCuP7oiTrV+A=; b=lEDF1yZZ1h+hEF25rcpd5b
	nKp4N7Z0n3CTdoaZsQairaeddLuR0DuQT+NorkJsFCB1X2/MZi/GSCBxC7WEwb45
	LB9/SI75Rhbl0QVOo5YsVUJvcv1UpXrgQk2h/Ya7oztWXZ0aMt+QBSHAk25fAQBN
	ZR/rtwDiZwsQ2jQ4QJyvm22xR4Lu/LYXiRnZZxcmjv2/ebSuIkIOw6RygDHfKkIA
	h5v/QiRrKZfDY4WQQPyrXKUuhHC0D72LKzA8J9LiRK3kRRgbxp7qXPwssXv+1bNZ
	U0U/UxIuCl1cLz1odY8XtM6Wh5l+BgoqJd5XHW8EmXD42Mvg75wH8TCXSPeJGimA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske22dpg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:48:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlUN22357107;
	Thu, 24 Sep 2026 16:48:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qpskp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:48:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGlAhT30737020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:47:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A28158052;
	Thu, 24 Sep 2026 16:47:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E60685805A;
	Thu, 24 Sep 2026 16:47:52 +0000 (GMT)
Received: from [9.61.251.135] (unknown [9.61.251.135])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:47:52 +0000 (GMT)
Message-ID: <4af9eb03-e14b-4cb4-986b-b7d9a51fb368@linux.ibm.com>
Date: Thu, 24 Sep 2026 12:47:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org,
        Gerd Bayer <gerd.bayer@de.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
 <d5a32ced819407ae370da37803e30acf541bc5d3.camel@linux.ibm.com>
 <07094b4a-0c11-42a0-a9dd-8c46fe7e47f9@linux.ibm.com>
 <8c1094dda46b18a8c4d12dafbfea94e89c0b0b85.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <8c1094dda46b18a8c4d12dafbfea94e89c0b0b85.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VClUsT_4AGu3ipJpXvZ5I3aCX8EEg5j2
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab55442 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=h6o2qaAk3-Yl8Vf2y7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2OCBTYWx0ZWRfX6FYNQZxu8SiS
 3RnxFaxMNF96rOwZREOL4za5Xbtr+ExjYQy3YxinV2u3WJnrY6roIfIWugKq73HhLFqpzTHvzJ4
 X8HkHvvVXohZ/yqjfmoJWDBCmc7efYU=
X-Proofpoint-GUID: VClUsT_4AGu3ipJpXvZ5I3aCX8EEg5j2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2OCBTYWx0ZWRfX3uPerxD7PITa
 R3CBSIG5XanGxF1y+xIwtvmTbm55obpu1FE5zCYENUedvYsLRZHo61++XHY+9mtq+5ZEP8lW9Sw
 iweHT6eZOTDCKUFufnRk5mRaeX8VErgoOniBiehLbN5uA5cQLjT8UeBXu/I4gjaZEZJiwGwfxMm
 yaC5cJAkeJsNUVnmwZrapleaisAXLEJKz9AnsfS98tOE0nL3SDRzcD/6/35HhnMbG/jgofFhLCO
 CFA6gv2q+qFGeoRlxLIIuXmprJXvaJSxJSELyCFLlgrlFgWkCVjffx/aU4L+Qwf05XnZ3Fk6/bV
 nG7PLX9lZ2azXuRL16MpaiD6Vj/WATSyuNGpXRaEGXoJrXJ/QGk8xqlNeKo75cwkoa34oZxwJCs
 b9auuE0J8gbJoFLrAYk0gUV9PZFErna1xxCk31WpCJC4dFZYrXlWuSJM1Xz2d+d/rP6dDOjgJ05
 WJmk9IYUSmhkxq/CT0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240068

On 9/24/26 11:55 AM, Gerd Bayer wrote:
> 

[...]

>>>
>>> I see a little imbalance of the semantics of "reenable" in
>>> zpci_fmb_reenable_device() vs. zpci_reenable_device():
>>> zpci_reenable_device() "just" enables + registers existing data
>>> structures with the underlying system - while
>>> zpci_fmb_reenable_device() does both the disablement + the enablement.
>>
>> Strictly speaking, the disablement step may not be necessary, provided
>> firmware starts the counters at zero upon changing an FMB address, which
>> does seem to be true in practice. The architecture doesn't explicitly
>> require that though, so I thought it's a reasonable safeguard to use it
>> as an intermediate step that signals firmware to stop counting before we
>> immediately restart measurement after.
> 
> Initially, my point was purely "semantics":
> If it is enough for zpci_reenable_device() to do only "enabling"-kind
> of steps, why is zpci_fmb_reenable_device() then also doing some
> "disabling" (under certain conditions). In my eyes the "reenable" was
> actually a "conditional-toggling-on".
> 
> And this then led me to checking the paths leading into
> zpci_reenable_device(). I found that all paths would call
> zpci_disable_device() before and that led me to the next question:
> 
>>> Since zpci_disable_device() includes the disablement of FMB per
>>> architecture, I wonder if it would suffice to set zdev->fmb_enabled = 0
>>> in that function, and drop the explicit disable FMB there?
>>
>> The semantics of the FMB re-enable function were intended to allow us
>> to re-enable the FMB when we re-enable the device after FMB was
>> implicitly disabled via zpci_disable_device(), like you said. Prior to
>> this patch, there was a sort of "limbo" state where firmware thinks FMB
>> is disabled, but the kernel is unaware of it because it was implicit.
>>
>> For that same reason, I would prefer to not touch zpci_disable_device()
>> at all, neither explicitly disabling FMB nor setting fmb_enabled to 0.
>> The purpose of fmb_enabled variable is to allow us to restore the
>> original FMB enablement when we re-enable the device, and so we want to
>> preserve it here [1].
> 
> OK, I see. The whole point was to preserve the FMB enabled state over
> disable/enable sequences on a zdev: Re-enable if (and only if) it was
> enabled before the sequence. So I agree, you must not set zdev-
>> fmb_enabled = 0 in zpci_disable_device(). But you can trust firmware
> to stop updating the FMB buffer (after the ominous grace-period) after
> zpci_disable_device() ran - the zpci_mod_fc() to set FMB to 0 is done
> implicitly in clp_disable_fh().
> 
> And you wanted to reuse the zdev->fmb buffer if there ever was one
> allocated for the zdev. It just occurred to me, what good is the whole
> zdev_fmb_cache if the life-time of struct zpci_fmb buffers becomes
> almost as static as struct zpci_dev (short of those that never leave
> "STANDBY"). Couldn't we just kzalloc() a struct zpci_fmb right in
> zpci_create_device()?

We could allocate the FMB buffer in zpci_create_device(). But we cannot
use kzalloc() because the architecture requires it to be 16-byte-aligned
(and apparently on some models it can't even cross a 4K-boundary...) The
existing zpci_fmb struct is 80 bytes and is aligned to the nearest power
of 2 (128 bytes), which I presume is to satisfy this requirement.

Thanks

> 
> 
>>
>> Thanks
>>
>> [1]
>> https://lore.kernel.org/all/dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ibm.com/
>>
>>
> 
> [...]
> 
> Thank you,
> Gerd

