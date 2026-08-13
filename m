Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4A3CC314;
	Thu, 13 Aug 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613648; cv=none; b=VHWipVRM4AZgDNZZH8VnQaW3LIJ2IoMkYhaTanH4QFm0T2QPV0kMi0S4XI5wiUovoSi2AR6QrGv2rIYmaXUBPYYacduatFT8/+KvtEhMIqVvrRrDVyY0uF6MOwm2QzZAjlliW+hF6/zc8kGHNlfI2IQFuZZnRgntb9udHLHDH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613648; c=relaxed/simple;
	bh=WZcKegKusGSYc+j1Wkf8jKtJ41TaZy/jhhpAMK5Js9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duWaH95pLnSUGAibeNsEqsyzs2Xo47lWMsxPtuS5hYQlSgtzjm+EMJZG/nLdkKuugdRtV8tyF1LUX0zn3cWT976qIr7HTikdW9Iac+LdWr+2WyYz0u7mNP0ZwV6J/vbI1O1hp3/EDz1IvQ7yh0yTwpPYmvdII/HTRiXEAdYU8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bpJcrEAp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpJcrEAp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98vfb1949754;
	Thu, 13 Aug 2026 09:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=128j5y
	xQWpx+4Nfn3fGJu3UpPbXfHhXb3HJpm34WKW8=; b=bpJcrEApNS76irch0XiVze
	zvywkgTvvPhOcAZayMwVefelhe5S7OGw8GtUf4Im5Dbes0fwOnMub9ZRrmPQBf5T
	EEGTijZVeyUdBlpgy8d55HZgDMjPN2/wDf3/qkL58xrO8VpBjCmBLKyQ8n3XRgfx
	L5Z91bBrzsyBSDjo9i0gm7ekUX23wtXphC6xBUbtKRcSidekVY6ogwnc5hBexjLB
	ivy8icc5Lbkl5Kr4XMVJN9sJyaFhUeIzQ93l6JgVDZ8SOGKqmPbbYPW1uTGZVsfh
	zHxLvKi8lyM0CiHJPLDBiHx4COYqKsaxxgOLIAkQht6I5IBAuR8dw6CcIdwERJLA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwe83x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:34:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D9QWa9022756;
	Thu, 13 Aug 2026 09:34:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hac1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:34:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D9Y05l31981954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:34:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C8C420043;
	Thu, 13 Aug 2026 09:34:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E6020040;
	Thu, 13 Aug 2026 09:33:59 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:33:59 +0000 (GMT)
Message-ID: <e13682db-e68a-4196-807b-8c67bea68a2a@linux.ibm.com>
Date: Thu, 13 Aug 2026 11:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260813070815.2692398-1-tmricht@linux.ibm.com>
 <20260813072156.9C4311F000E9@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260813072156.9C4311F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7d8f8c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=_CkJLOUM1Kt26T3VhsEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -jr7y3OyPJoaeNEZmAZqNyzNu3SZ1tp2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX9ozMIUZ0Qz+n
 1nDEgL13ElsSrxpbT5WA5ZoNy+qvGzJJVgdoLdTPbbhQ0mVJa9eS29QZaSZG/AP321n9Cwit4/M
 9W7QOH4yZcIntxJIexiU945wpvz61WRcv+cuLw2rc6pJZA9osKfiQnBU6Hhn4S2tK9KXnCyWs64
 +wwE9cngF4RlBIZ02TEuvArDAyqBLcQN5ZKYTfJKgpL6fAWVFkntUNYTGDXSc0gPOwL19u/pTWv
 NwRTI0sRuJqKYlcF+Mp/MS3rwjmGArdtGOg+fXfw0c1rnIlkgq77AAO8swNSFRaVdzCDHxadaXj
 JWAg3UTbcCG5cRPJtZ3bSLdGs7UiV8VC+hny6stndvSV2BxRhPnT/bawZOWKOxqYHxvoVnHusg/
 mHxxsxFYWorNRH1IZ65OAauOlD29g+zvwbUoOFWoaORYiZFCA0QPDae/Mv9vXY8yL2dQ0PabLJx
 L25JebjIiyUAskhawyg==
X-Proofpoint-ORIG-GUID: -jr7y3OyPJoaeNEZmAZqNyzNu3SZ1tp2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX4FHbjM9QdaUO
 ySAxdxkhTb472Gf1jUwf9ZLRtltE2KdJ97OHFSLRt3oLKT9/SXaTYVJ1gr/Rj9cgIb/mPsJHSVA
 /eJGIXiTsEtB74OmGzSYED96VDBvBvI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130066

On 8/13/26 09:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe iteration over `cpump->syswide_list` in `pai_have_samples()` leads to a kernel crash (LIST_POISON dereference) if an event overflows and is synchronously throttled during the loop.
> --

This can not happen. The syswide_list is anchored by per-CPU pai_map::syswide_list and tracks
all events which are bound to that particular CPU. The event was installed only on that particular
CPU and does not move with the process/task. Each CPU has its own list anchored by
 pai_map::syswide_list.

The call chains are either

 paicrypt_sched_task() or paiext_sched_task
 +--> pai_have_samples() iterates over syswide_list and calls
      +--> pai_have_sample

or
 pai_stop()
 +--> list_del() to remove the event from that CPU.

 Since a CPU can only execute one given code path at any one time:
 - either schedule out
 - or stop the event
 both can not happen at the same time. PAI PMU does not install an interrupt handler,
 there is no supoprt for interrupts.

 I think this is safe or am I mistaken?


...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
