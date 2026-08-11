Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7253932D4;
	Tue, 11 Aug 2026 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474447; cv=none; b=cFWjSMNPJ0/yOLLf3MAyAPvbm1KgPqKBpi6zkzWXsVtRd1j96IQ1OBUxoIcpbCyLLpQyMd4de60VUzx6MXW94lQnE95fofVaIQMKCAkFJWdKJdWyYzs9p6oea2zZsr9bvi8vSeBdLDsjj+GTXSVzgrcapwAZ2bS57+XmWFTuJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474447; c=relaxed/simple;
	bh=C2cyeyvzWbUOvml+C+zC7hEl4d3+vExD8RvTnskxUQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnFgE+bfFM9MXevbbGKrwCwEJkigx/Z8/Vh8vUMlfiXQoJYNfKP3o5GOKj1LyyzLhvxriNBvlwIrkCeB7vUDmLLmcmHEAsE5Jr15j15+kz/cfY+WeWrufPKweQ1G0Nrs+Fi8Rc6JW33ewq7zJBPwuJmuOenHrEN7YoEhqMmS/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Im4Byakn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Im4Byakn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVVeh889293;
	Tue, 11 Aug 2026 18:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C2cyey
	vzWbUOvml+C+zC7hEl4d3+vExD8RvTnskxUQA=; b=Im4ByaknTIJR2RBjBfyaxE
	MzE9DjfiMC+YGOk46880ZEexIHvUbU+Ajt4ghDtedeZYrQoWts+7H4+sBtEdrbJR
	pdDfTRr1emaNrImb0ZPbLLHhlZ1wrHRkx0NQjgGOYSybJ3vlii4NQUWbkKCnfrMC
	PAmXEI6aI+OiV4LD6HB3CqNBmdBZOJ6q8DFB99fP9wXuAZ01eYJ7B69drsLiCVxG
	9r4VvYo9fLMZQE+qISzXuwfv/l88RafGcDaDQgG5MnVfrxct5ygBq6tkmfyoivR5
	gLb0Mb4hzfeKqMT/3siw+tKuxuHBLPmBJr66aHeiPxwBotVtMdH0Fbz9YkoKiaJQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9ej0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:53:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfIFi029001;
	Tue, 11 Aug 2026 18:53:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h2918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:53:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIrIvZ20972078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:53:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBC8C58056;
	Tue, 11 Aug 2026 18:53:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A91BD58052;
	Tue, 11 Aug 2026 18:53:55 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:53:55 +0000 (GMT)
Message-ID: <16b7450a-30e6-48ee-b4ba-ce2193eb11c1@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:53:55 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] s390/vfio-ap: Fix use of wrong lock in mdev probe
 function
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-4-akrowiak@linux.ibm.com>
 <4ca672ce-da47-497c-aed1-9500b7e89798@linux.ibm.com>
 <00b0ea7d-bdeb-42d3-aad1-a8a827f2deb1@linux.ibm.com>
 <85212e98-c8db-4428-b5f2-70a0d9fb1207@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <85212e98-c8db-4428-b5f2-70a0d9fb1207@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sNMUXb6LxuFLnvnX-dGD1e60KYPvjUZB
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b6fc7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=faPK2kdyBIRx-JsfH94A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX5iK+QVawx4ct
 AY0MC9SMTozAd8oNjf/NYuFSq5dcQPZMhUkJkaEqUjYg5i3cb4LA2CXn20zp454iICsaSDyOwb3
 Ow3VoJ0E3+WB0/ekk/1X8KN0Eo4sX4KWB49V5+wDtt2oLhyjjV6u68D5xe2zx2vPQHec9m2DMlY
 0+V/RiOEJKsveIjnrAsF9FVXzPpiwaQiBffW9WSzfUjzCMaRe1t4TU8NaYBsae8niJizXShZHZO
 YxPUVXM3TiUxQXdINMVKONgh5htg0tV7331mo4WbRpbTNQZ44xgHCWwhWzWRiMcpa7gt2eQr1Ea
 /Uaf2ADQ8ygCn3uCSHKokN3HeXAKpmcCqL708VOyxwTZoWOD2E2JZmqH9aZr+7/7QhoF5Bsi8Wl
 1UloRw3dZgrwXsusHe/MZIjZgVWQyEBDJZWu60RPhbKxeIgxBdducq/17RqinRCZHDmN2t3sxHE
 bEtRKxeVM4Foj1/e5Jg==
X-Proofpoint-ORIG-GUID: sNMUXb6LxuFLnvnX-dGD1e60KYPvjUZB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX6nTwnrLUm5WH
 bV9ODdoSaf9pMbHbp5y1U7m0GP/QDN1mCmPwhO5E1GazhAaP8n2lKoaYSXZjjMZBniRMZHfvKlO
 NHW8cuxotDtfST6FjamDFn32/DKSBks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155



On 8/11/26 2:44 PM, Matthew Rosato wrote:
>>> Sashiko reports that this patch introduces a regression, which seems
>>> valid.
>>>
>>> AFAICT you resolve this regression with patch 7 of this series.
>>>
>>> For the sake of bisect, can you look at whether squashing these 2
>>> patches together would work so that we don't have an interim regression?
>> The reason for the two different patches is because the shah on the
>> Fixes: tag
>> differ.
>>
> That's not a good enough reason to break bisect and introduce a regression.

Then I guess I'll squash them and use the commit that introduced the bug in
the probe function.

>
>

