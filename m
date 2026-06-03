Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38793859EC;
	Wed,  3 Jun 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511198; cv=none; b=YqyEj8LGVPjFYH4px6R7UCB+piyeDpjIpJ/AacUoBE7waL8pCaDx5EUWQilj2WHIIIIwMQxBwwIKOlj/oKz77KZXrJENpqc4W1Cm4E5Kge9E/t3YneCj8k8TDSeeFhmRGBVuHJIwojN7XBsRJzVwIV1j98Mt9Dv2Nbkpswelss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511198; c=relaxed/simple;
	bh=ZUAJC8Zbe+xjYIriju/65UrSW/aNvrY63FyQTSuTN+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p//c42Dqqv6rza5nk1Le8ErbLAx5Qmy5U23zP/22Gl2t0j7SbfoYjHmTEMhvqFQbyClpm5j2IqppAjljKvvUOf4yQ/U0rBX9Hfn1aWBOIiI2nrm5IVVuyII2pgHQELhoaD7vsKLDoF2Htj0usM0cxTtMTDcSXA4dsJGoBl0RfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DlgT/Biy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DlgT/Biy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653Hn4BP3707938;
	Wed, 3 Jun 2026 18:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YKr+6y
	hnyN2nRITViubajD62fc9aLu3O2r7mMdTHnSI=; b=DlgT/BiyWVmCaEk9r88xKr
	29oliCk0eh86T05Ku/K5UPOI4YNutgbU5dMr6T1WBnsvDLQrZHQMd/VbcEBYwzZB
	iAUUw3fxJkvAyzXoxBOPr4B2yCD8+YxLKz9o5HzpghvpOFwXB5ExWljyn6Z0ybD1
	VU2NpAKtp+VlG4n3nXjMsCORB7s/34ia2hMIGNURwq22ANjlT36RlqQbk+yz8ExY
	T3UcxTQd0oLW0W03rDEciD1el8for6sOZNVVWqbiOrNbIO93b5+P5k7e7AJTkpfk
	1i9rBDiSmJeDNMdadlcY/BPaH15FCTLAWcjhylXoCeVo9EAn5HV9A4NmExHQhB7Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaebvk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:26:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653IO7cC007625;
	Wed, 3 Jun 2026 18:26:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyh80e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:26:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IQV1520709992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:26:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9BB58056;
	Wed,  3 Jun 2026 18:26:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E57DE5803F;
	Wed,  3 Jun 2026 18:26:30 +0000 (GMT)
Received: from [9.12.78.81] (unknown [9.12.78.81])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jun 2026 18:26:30 +0000 (GMT)
Message-ID: <cc2cb880-2d53-419f-a813-539ce0f5311b@linux.ibm.com>
Date: Wed, 3 Jun 2026 14:26:30 -0400
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
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260603095538.65b07206@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2071da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QGBQNg2pMCFovZr3b98A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AkrNEytQc4rpXZG1RIGUgTd1hgOdrSqb
X-Proofpoint-ORIG-GUID: AkrNEytQc4rpXZG1RIGUgTd1hgOdrSqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfX2JgLf3UAPO4J
 jaAFdH5znwiVeB06Pe1fpZPQPjKHoGKp4v7rm4kw3Jq1PCxzyxZYHv6TTM3tryfSW4/YOAIoDDj
 wmOmDXe/cTuBwjqzYWvakmZtyoCCtHnPeI9D20tQY2RkIV8O0ktREI2BOC3D+6s4xgaGZ87l8Tj
 EjL6EC0aEyG0PT1JKiQCxu5rDWVz6h3x5Yz9da3CTv46G5gjuiq/zGYB8G9r3U/E1+LKazJ6wja
 GTrkUtAYAq/+ysgnXVMkIVwulWpvNddst854QKkydZnpaw2XEOJfEnfCwsUsl9ftq2e7ZyvNkGB
 j0PP8g0MIFzbvSShmL7Kwp5eDf+SsNwNWqapkqz4WqWceIhDcH0iYPK0MeKxtKkkrx9vsHkNJNG
 p9saMlPohA7cZ9+9ykGpZtx7PQsiZnMFBvsh8BawFRZ6I7a8FbhWl2yIP7LcNFemTWPNUOFg37r
 2tfS6l0L0rs7COxFGqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030175

On 6/3/26 11:55 AM, Alex Williamson wrote:
> On Wed, 3 Jun 2026 08:35:43 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
>> On 6/2/26 6:24 PM, Alex Williamson wrote:
>>>
>>> Why does the user need to be able to control these?
>> We want the user (e.g. QEMU) to be able to control these so that when a
>> guest enables or disables the FMB, this state gets cascaded to the host and
>> all the way to the firmware.
>>>
>>> Doesn't allowing the user to disable FMB remove guaranteed host-based
>>> monitoring?
>> Yes it does, but this one isn't an oversight and is intentional behavior
>> to achieve the functionality mentioned above. The host-based monitoring is
>> not necessarily guaranteed and is treated as a device-specific state, so it
>> makes sense in the case of passthrough to have that state reflect the state
>> of the guest that is actually using the device.
> 
> If we really need a SET for enable/disable, I think it should be a
> separate feature.  It really makes no sense to pass a giant structure
> into a SET operation to look at the state of one flag bit.
> 
> [...]
> 
> Hmm, I also see fmb_length in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.  If we
> have that, do we really need structured data in the GET feature?  Maybe
> GET just provides a user pointer and the raw fmb data is copied to it.

If we did this and passed just flags, a user ptr, and possibly a buffer
length field, what would you think of leaving them in one feature? This
way, the SET case would have possibly 8 or 16 bytes of overhead rather
than the entire FMB structs, but would still keep the uAPI simple enough
by avoiding multiple VFIO features for the same firmware feature.

Thanks.

(Apologies for the resend - the previous email was rejected for being 
sent in HTML format.)

> Thanks,
> 
> Alex

