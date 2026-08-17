Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952031D730
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954834; cv=none; b=B/UAqueUJOFIq9drSpGrUgBJQLJd5f7vN4hCV68uEYfDp7SoSo5doXkhPyHe/ERhWp7Pk9LS4SWMgb49lsVj2q/bvh8VRCFfxk30muDfLXax60WvtFrXtfd6XldsUpFDdLieqxOQ6mcBL7Sx+s10mhiz6ovXOH4gkFyNlCetArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954834; c=relaxed/simple;
	bh=ft9UWqNtK2WKr3uGUu1t3wl/XlJga0rRlp7eYPmhH48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI/USt8uII9IvftMHhulgt4/w/U3dBOyKnYa8kWrhlIW75XFpCkIpxAvbwB1hb8u7wZ/M7+aHUr96NeG44QyF3tiM1946q1EV8VDaqPAVEPNXchybz8uvVHBYkEed9mP0AiQ1+cNvz/rMYEehFHFQtqq8QXZ1l2PSeOsSM5TCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PRc1zvpM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PRc1zvpM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLWDHg2629988;
	Mon, 17 Aug 2026 08:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yDImRl
	K7FijdhFAh8fa/DdN3Wd3YlpHd8+LUx+fOs4o=; b=PRc1zvpMHQwgLmnLgLN7X+
	zOrFY/ZWIzik7yOYD3okEj88EDdto/6fiDxudUdtrxKDr9QgcslBuiO2hXtD5yNY
	UQPRupunebrd2duYlJwStoVSKIj00bPfUmWqijaeNdlnJF2rwmDT37SkcYUOoHpP
	IK5z0009LZlBiN6ukrsHLdqBB0BcrYIEHKzSOQkqKL6NWhZdSsHXfOWjvunF9pAR
	G7FJa45LB+zZ7Xqj1seAKg2vFQCDMUrxi9JDWXvymmI3yglj20KczmSDe2pyH/yF
	2Dmxh6gGTNDLfEZlKbfKBkuK7VOLwzS28rlXqDwi5ntnDvUejfRbrhbFdNIZwE+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe116r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:20:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8BLk3015610;
	Mon, 17 Aug 2026 08:20:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejw3y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:20:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H8KJtF39780784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 08:20:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FAC220043;
	Mon, 17 Aug 2026 08:20:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0100220040;
	Mon, 17 Aug 2026 08:20:19 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 08:20:18 +0000 (GMT)
Message-ID: <4cc91126-303d-4771-886b-d159495b7447@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/19] target/s390x: Support AES XTS for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-12-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-12-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX/gXKccL0Kk6g
 /KfLm8fmEVaa+jyCCSd/Dt3DgP4Y6Zbaz8sTnw/Xts9ZJ+ekOoab4GWt8aYBVRm5cu3qaOGMI8+
 yWqcQZt9+smI1cO4eptxh6xy/iUf2gSpd7ZzSoQdshMb1Wm8qATLQKP+4vJbbHNjDwsAxAGmPms
 SrMUJcjG7GuhB7CRa/jsVaiRVzMLETJ9qXnbRpRrSsf0/+r86DwP9Ej+Pxo0I5GOcfwLRCH7bPF
 5SoKPDs8hDdGEKEzUsFQVOlpl22wVOdUpFUO3/rsy4ktc7g7GTTwRHXZcGMLLjb2/53657/C1Hl
 f0GOalbgxMG+o1P8PkhG7CMux1RqwZcBMhv3gwOXppQSGimnc1dsWiyb+xx+4ndCJwgK+DZhBLT
 D47V39YEoBh/STorUBHDi625Bv+rkpPp/yuobU8JxuQmkhooVRkG5e18Ex6WtYmwJI44OIYZAVj
 b9WSK0wMkyoLwvvemDg==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a82c448 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=SiDwfgpHCtFmSTCXE-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YsN9OhKPvSwhKa1GCcE7BjbaKt3fEC3n
X-Proofpoint-GUID: YsN9OhKPvSwhKa1GCcE7BjbaKt3fEC3n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX1rEmFoJ27hgM
 JDp0+R06jM+rq5mdUOm07JYgkx6DRRBOqWaScPhYGuPw8tVZCjhqiKRaoMKZ8XP6dBr768NURFk
 DiSdl1bIoQkJm4I8STQJ0uFgOm3M1Fs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions XTS-AES-128 and XTS-AES-256
> for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 81 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  6 +++
>   4 files changed, 93 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

