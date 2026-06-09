Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1A3563EB;
	Tue,  9 Jun 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999463; cv=none; b=F7Yuqfu9e8Cc8Zjq00Wj0aSrtnVAZIDIaHKGC8E5w62TMnul6YC2AwvtnC5DiCC+KjgNBbt/ATEP2wCWMi2r9692jkfdcSnJKIHwlKJ0oSDIh+35ZKyFH6V3rf+baYZVtcfM1XPpo8b9p9ZXafD+NpgtdFPkDfwQrSlAtVPblRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999463; c=relaxed/simple;
	bh=NuWRbZ8/1BVHP/L2E/8jpal3eLTmi1oenbxC7PUu/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbUZvlFT5jtmw4m7wuIikhyvZc5DrZztbqgKm2ERLK4TUWvddHRdep3099WAGjMCNl2Mx6cYpTjwxlusz3Nb3SoYRtGBhGThHkpZMcTit6cJc5Vd8DEbZhgNYPaDgN6hTCsrvmQWgH7SY8tRCLzx5GUOzH0ytdpHsIbshAJccTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E7u2qW9p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E7u2qW9p"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65953GHq3934488;
	Tue, 9 Jun 2026 10:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aMQDQh
	HbSIE0wNlhfWDGmtQNz7fssF1I6QaeiFDE1JU=; b=E7u2qW9p/u1/jx4S7Xh9Y4
	wk+P3fm2s6jCf8HCXFVpWFL6yHlSfKcjqLhEKZCw1Dj1zCu6UpMuJhMcePKE76cw
	RgHLFGgBBFDTI/+Rm7osYO4WWcb0IRm1GMUnBh5YuMcAE+2jtJgu6j9UNufB2OgO
	E2rOxNVysEA2WIm3inBwT1Xaz5ESlsz5QPi4Wfa7G/sa+asFwA0D+bxoxBz4PUML
	/ogNZlKtx6cwot4+Du5H+OPUOHyqBAwf75COP1Oasn3Z+fpbRd8/TBrth5lxAdhu
	Mb94k55B4CglP792DH2oNpHS6BWVeZ0VU8uFDDngLe8GBCSBZKOU88oe/tJZPI6g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6su9hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:04:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6599nbrR006173;
	Tue, 9 Jun 2026 10:04:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych1cjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:04:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659A49uZ34078984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:04:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AB72004B;
	Tue,  9 Jun 2026 10:04:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D09520043;
	Tue,  9 Jun 2026 10:04:09 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:04:09 +0000 (GMT)
Message-ID: <b2b8cf98-bc41-43b6-838b-60822a9a4c89@linux.ibm.com>
Date: Tue, 9 Jun 2026 12:04:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
To: Christian Loehle <christian.loehle@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-2-meted@linux.ibm.com>
 <e70007af-aa98-4870-985a-6648564127fd@arm.com>
 <7d2ace86-f355-4ff7-886b-7963574b2202@linux.ibm.com>
 <dece845e-12df-4aa0-b515-a41458bfbae3@arm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <dece845e-12df-4aa0-b515-a41458bfbae3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ok-1e1Ow2uwaSa8MahSe4DsAiIm2Mree
X-Proofpoint-GUID: ok-1e1Ow2uwaSa8MahSe4DsAiIm2Mree
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27e51d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=h0VFYf4W8FCvH31RdjUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4OSBTYWx0ZWRfX2q7VL4hZEJBX
 uSC0An5UBOdEsNEabcarzg3EeaWSToPII2BpfcoFDSVpSuwXInGtF6Co8yl1p2ubhGbpXeC84Ux
 APCFXI1JwlNxT2sPB0PnzQJabJQBuODRmnTSh9AXk34qLHpoNWmqWxSpyZwtGqYTSMM6m2dFKQy
 cIelriN8/xocAnvkBR4nASDgpTgE511q2p2VfV6nxa+e/GfiLroVC0d0kq9kizqD9ARYEW/Rsai
 WLAeIUYalky49FxnqbWHeha8hHI8GajUWpGeV63mFoH27zRTAHn4CPczG9xel8xcN1vDfV2U25a
 vSDd9ponuH38CiN8B+4RqC/hQ0/iItMVyxg5toDgeBQYCWVE7HPlLvTnCIrjbC9oQJKNKSsPOZf
 2GtKkQyjTgNlkZuF1daxb+NFoZvZGfbswuY7mpc5mDsMvbwGoW1WcUnI82+iME6T2JN12ofOMpy
 lK74Kf843/LRHVPXTng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090089

On 6/9/26 11:52, Christian Loehle wrote:
> On 6/9/26 10:40, Mete Durlu wrote:
>> On 6/9/26 10:10, Christian Loehle wrote:
>>> On 6/9/26 08:52, Mete Durlu wrote:
>>>> Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
>>>> handles frequent sleep/wakeup cycles more effectively.
>>>>
>>>> [1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/
>>>>
>>>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>>>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>>>> ---
>>> For bisectibility does it make sense to move this and 2/5 to the end?
>>
>> I am unable to see how that would help. Could you elaborate?
> 
> CIF_NOHZ_DELAY is only obsolete because of the new s390 cpuidle driver
> handles NOHZ better overall right?
> So my suggestion was to only obsolete it once everything is in place?

CIF_NOHZ_DELAY could modify the idle driver's decisions when it comes to
disabling the scheduling tick. It could be hard to bisect a problem with
the driver if we move the removal of the flag after the drivers
introduction. Because then the commit that enables the driver can have
a significantly different behavior.

Plus,having the flag obsolete without any other mechanism doing a
similar job would make the effect and related behavior more visible and
easier to debug.

At least this is my opinion but I am not an expert in kernel bisecting
tbh.
