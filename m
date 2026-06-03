Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1D401A14;
	Wed,  3 Jun 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521609; cv=none; b=YLCgS8pSRRyT4kJGbkv93gfIN/BHAcelBGODu3hKtkR+xGdUdSyhPQy3l4PyH1xfVuCQa6Ad4Q2fiwqGOe5ddp5xBUcIwDtR7Y9LsmJHQ3IFxKlK35WCsFBlh4jK5KWGJAB3IvwNc1vKj2rX5+HOFmGgGoL3HOFRVeu6ZiyKVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521609; c=relaxed/simple;
	bh=L4ptfZNFxYOQn5NJMCBaIWynLf6X6dfzAXPorGHsn1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRJ3xzfb5njsctjl8k6LhmSsbC63n1dyDsdT6Gj6HR7VursaUmkj0zNuxy3JfD5TGjitoCJKXanPVg9sLMQGq6aW4bWYEcQ33tqgKSyoVZieuZ3XH/1ae746KppJgccAf12+dGqqxmEocQk2uQ1cR2sJU7UUlql+Wu4mBho7baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WviiYMPW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WviiYMPW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653GfMpV2666058;
	Wed, 3 Jun 2026 21:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xghs4G
	CIPGcSFPxGW+mjD2Ubt7LBKn4nlyHrVVVcauY=; b=WviiYMPWSwbdCe8U+j2Wm5
	finaXfXkjCFaed73MBKl903t/9ria7p+wFKpkQEcs+T6k69wzrpSXMaBw4wnhTBU
	Kwk7poV1k7FPvvgDM3X5hezy3GxkOUIlhloIFDs3xucbn6eLSTYi5OOJMGo2yP7B
	4NxLCVcXyrjEDIkZFaDKIACGvt8jlsDJ7akXAKCwCc3ip31XZ+xoYuw62Q8Ypo4K
	84TQcZzpoASbAsXCrlbp7Q6TUbkYdHFZXbnsPvd7Bui8bfyMuuc4R58/W/1e1LWL
	ZJK/Jo4O6/isobwKSsZ6QFJVvNX0xCcgqtHV5/jvPcIKCSjBJvsr3KQDveSw6YGA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtcdfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 21:20:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653L9B9h008751;
	Wed, 3 Jun 2026 21:20:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw2akx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 21:20:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653LK2Yd35848902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 21:20:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6DD858059;
	Wed,  3 Jun 2026 21:20:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9F2F5805E;
	Wed,  3 Jun 2026 21:20:01 +0000 (GMT)
Received: from [9.61.251.217] (unknown [9.61.251.217])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 21:20:01 +0000 (GMT)
Message-ID: <01d55a6e-d62e-449f-827a-3496dd1a9b57@linux.ibm.com>
Date: Wed, 3 Jun 2026 17:20:01 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio-pci/zdev: Add VFIO FMB device feature
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
 <20260519224204.19154-3-oelghoul@linux.ibm.com>
 <20260602162409.1ca3c765@shazbot.org>
 <395b0d85-3057-4bd5-b8cc-10ceea2d978a@linux.ibm.com>
 <20260603095538.65b07206@shazbot.org>
 <cc2cb880-2d53-419f-a813-539ce0f5311b@linux.ibm.com>
 <20260603132415.53e9a934@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260603132415.53e9a934@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zv40cfol5FQy1EbyYS5g33no1IQKVGdc
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a209a85 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=vYy7llgf9Sc9U1ESNrEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwNSBTYWx0ZWRfX1uWKEqWkbGTx
 OLVp4DCFi8tZ+vYYVtMcx+Lq1ufpWUfjvK6lkFcr7bUMBaq7+f0fvpr/Pynl/7ou/nnLbO0+czX
 u4H89VTQ3SFoqMzrl+sImFJrq3FHu7FsnLDQU5mdXmc3qqbGGccU2oTqnR2+B91/7wBQcrM4Oet
 HAtjoVR82c3aig7UO2YjPJqi08FLPdw+++hTbIadWqduHZmZZb3/IXQ9bqpu9v0R5D2uotPNftW
 Nf9yes1Y1i1ysszyKguWXmbVYYXQl5iPNrz5MVyS1P9G9BQCTm/WNtMDOXOonRHUefK5dusFyyU
 J4Vv93zeTFabA3tP5GfPgN6BAzXz9bQ3BjLYj2YL6okL9sQAWWjQF0tdisFHIvlQNujMC39rQkc
 DUTGOlot6tZp1Ej27XquQtgfAR3ejVcw6aUpbWV5JmdQmGSNu/p+Wtu/11WoMbGXeYJRsXSlkTn
 Ww8maTCL5vViBHXG1Ig==
X-Proofpoint-ORIG-GUID: Zv40cfol5FQy1EbyYS5g33no1IQKVGdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030205

On 6/3/26 3:24 PM, Alex Williamson wrote:
> On Wed, 3 Jun 2026 14:26:30 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
>> On 6/3/26 11:55 AM, Alex Williamson wrote:
>>> On Wed, 3 Jun 2026 08:35:43 -0400
>>> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
>>>    
>>>> On 6/2/26 6:24 PM, Alex Williamson wrote:
>>>>>
>>>>> Why does the user need to be able to control these?
>>>> We want the user (e.g. QEMU) to be able to control these so that when a
>>>> guest enables or disables the FMB, this state gets cascaded to the host and
>>>> all the way to the firmware.
>>>>>
>>>>> Doesn't allowing the user to disable FMB remove guaranteed host-based
>>>>> monitoring?
>>>> Yes it does, but this one isn't an oversight and is intentional behavior
>>>> to achieve the functionality mentioned above. The host-based monitoring is
>>>> not necessarily guaranteed and is treated as a device-specific state, so it
>>>> makes sense in the case of passthrough to have that state reflect the state
>>>> of the guest that is actually using the device.
>>>
>>> If we really need a SET for enable/disable, I think it should be a
>>> separate feature.  It really makes no sense to pass a giant structure
>>> into a SET operation to look at the state of one flag bit.
>>>
>>> [...]
>>>
>>> Hmm, I also see fmb_length in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.  If we
>>> have that, do we really need structured data in the GET feature?  Maybe
>>> GET just provides a user pointer and the raw fmb data is copied to it.
>>
>> If we did this and passed just flags, a user ptr, and possibly a buffer
>> length field, what would you think of leaving them in one feature? This
>> way, the SET case would have possibly 8 or 16 bytes of overhead rather
>> than the entire FMB structs, but would still keep the uAPI simple enough
>> by avoiding multiple VFIO features for the same firmware feature.
> 
> It doesn't seem the GET needs either flags or buffer length.  The data
> is opaque through vfio, so there's nothing to flag.  The buffer size is
> at best a sanity check, it has no actual bearing on the copy to user
> buffer.  We're not writing to a variable length ioctl buffer, we're
> writing out to the user pointer.  The feature only needs to be
> consistent that it copies no more than fmb_length.
> 
> The combined SET/GET that perform different actions especially stands
> out because of the structure, but I don't think making the structure
> size more manageable resolves that they do very different things.  I
> think the implementation is also much easier if GET simply dumps the
> FMB to the user pointer and SET takes only a scalar enable/disable
> value, ie. a fundamental type that's handled as a bool.  Thanks,

Acked, I will keep this in mind for future versions.

Thanks.

> 
> Alex
> 

