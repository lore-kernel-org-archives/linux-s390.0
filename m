Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8936167E
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112725; cv=none; b=eRlTEqF6K5QOiOUpBWNPqQQ0QM3y/Fm7ZlG3px1MtenZ4ohdQ4W7u04CpCwl7vxbEWLBzOPP1mdenTFJtXcL5BjxsF9r05OqFifJA4rxCmwDWefVV55P3dz4Zm2KYfI5GcQm1dGEDt/7XJY4QhC3Qh2L7nA8twddH04+Zy3UZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112725; c=relaxed/simple;
	bh=1gmJ9Q1VLp9Duosg4MQDVpmZsI9sVWEZ3lV+m/8Z/kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgPH83r2Mtxh5mMi+Go451yQg9dM1+xoByoHBlcOOoFtk5yM1cQRqT+EKwvkaxVkfQxH9zVCn53pfPuR8ebDj6T/lSyiXNsLlVSep4Cy3bDqds+DmhJ5SIjiIBtBea/pZTI9TDbL/pUMj2HNaVcWJotszs/IpGChCY2QNSrDycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QY7Lfxgp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QY7Lfxgp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5IZrS1572658
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GbM4Aa
	yiwGhEsocvsxaA0a3BUbQW/TDHvbuoIRfZjOc=; b=QY7Lfxgpn37xZU4cnPTRSG
	Hs5Nwz+CJyqDuudcr6wDhiZe/dp5aOY1p1XqmTRblLyUdTWXf+BQtQF1vks9ks8F
	LVLGJCjykcr/gxzoGn006uTK6yLQ7gxLqC6E8p1aCCzw7q3A8Q6+dnIWs5h3kaMC
	S+4gh4lgT72z9OJf2LuX2pmkVHM8TEO/K0DMaphRPdT/JdlEphN3xrVRUUprtHTX
	q/217YMuFXZLz5t0h7zuTePKM9or/ngMFDG6qSSGDRTk93UPmAv7Mzb/oi7+3jaZ
	TTICVwpqCfCfV7vESxKSOkWLv9K13O4d2dtkFJp7/ixqILcJE4gGP1Wfrk5vbu/w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsfpbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:18:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M74aOP001157
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:18:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph4w97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:18:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M7IbNY53543298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 07:18:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBF0E20043;
	Mon, 22 Jun 2026 07:18:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B19702004B;
	Mon, 22 Jun 2026 07:18:37 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 07:18:37 +0000 (GMT)
Message-ID: <abbb14be-e500-453d-84e7-07ff95f09a86@linux.ibm.com>
Date: Mon, 22 Jun 2026 09:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for
 single exit point
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260619101349.162430-1-ciunas@linux.ibm.com>
 <20260619101349.162430-2-ciunas@linux.ibm.com>
 <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
 <20260619134920.18590Ec9-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260619134920.18590Ec9-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3MCBTYWx0ZWRfX/AaEf2EPh5+f
 R2p+g2ecjIM2cie/reUimM4ufA21do4ZkhcI27QSsphIjeVlQ5e118tbfbeSYWz9yrWa9Sy3OQp
 FU5D0aR5x5Y4DU566YPKOCIyw5r2A3Y7dyW6kjfEhczP83Motq7/umGoG0kE9jmp9HwBP2qVWEL
 HZhb/Yl1smyFieQ/PZLW8fMCJSdZxM/jYrv4wrfjHot4nIJtvCvqWiMfmUgRSGr40QmDE2iujv8
 tsYODhQ2QMEhvu2UchuPnMGrMQptyx09H4+pbIRBXmhFbW4YoGfftzY1u7RL9SCvA1ibZ9LNWNU
 dz/3IuxFLklsCMWALCJXkR0cKxs9ITjn4OOYYzW12lcNqQGx7f3W/ssr8i7mb1W0KHMbFf2/nXR
 DnIfSTifGSDu+9hXyx+Hdnso5f8CQrH8GAb9ujjmB5xT7KGGdUsJFVGv0fUwUKZ5uu5jNwYq8dk
 eJKL8i+8YyFVxpGyXzQ==
X-Proofpoint-GUID: SGvNZaDGOUhbc5AoZyL1WDSM0ZAWe_WF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3MCBTYWx0ZWRfX68zBaiRTdu4W
 OQ+JAuazJ+47rh2bm3AV8gnvdeGT7R2kVh4wQxJQ5z1rAuzPhsa/1xhO2CGh1j3CzKBs9An8Wj2
 oWD6vgsSDHI9lCECl5RJ41OGDJrrmcw=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a38e1d2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=x48mGG0jxMLMqoUHqhkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SGvNZaDGOUhbc5AoZyL1WDSM0ZAWe_WF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220070



Am 19.06.26 um 15:49 schrieb Heiko Carstens:
> On Fri, Jun 19, 2026 at 12:27:56PM +0200, Christian Borntraeger wrote:
>>> +	const char *result;
> ...
>>> +	result = "ignored";
>>> +out:
>>> +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
>>> +		   result);
>>
>> result is a local variable that will go out of scope. You can not reference those
>> in the s390dbf feature as it will only store the string pointer and it will not
>> resolve the %s. So this wont work.
> 
> Why should this not work? The life time of result doesn't matter. The
> _content_ of 'result', which is a pointer to ro.data section, where
> the strings reside, is passed to the debug feature call. 'result' is
> not required to resolve "%s" later.
> 
> But maybe I miss your point?

No you are right. The string "ignored" and co are indeed not on the stack so
this will work.

