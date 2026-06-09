Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC7315D33;
	Tue,  9 Jun 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997497; cv=none; b=j6K1zsCIQcYhkkfm6YMTYnt10Somgve93g8HGP5a0M5LWyyu6VROXxiT3j61rUzhyZrXS1FyP9+N7cHEjL7MCGSfwIGrSGXTO6+CIYprSyvduDQ2aYfCoCCS7kMBY3KPXYK0YSOh0GKl4HyapU03X77dyq7HFzLCgjhPu23OMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997497; c=relaxed/simple;
	bh=GT3+dqbXFbAqSgbC/unJsdKfrRiAjlIj00/aWSpnCGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC3T5PqS6H1oU9SFidj79aGPBLQowlSAio0QurENCIHTUX21CsguNE8+pYGDcXAqhGxuuLGmprGXPC04TMdLWc03a8KxX84yZ+qB7jk1xy6Ns3h5bVIca8i5FmvmHstsncx7QBLZBAAgiQMpQ0wnKAOgONSTGlQ+Tqva9Q2WIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rv1SqW92; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rv1SqW92"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595sELv3405561;
	Tue, 9 Jun 2026 09:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DcYpp1
	ct3ObgkHoonNx21KwKKSPG1GnFDUVyM7zG7mA=; b=Rv1SqW92oAmunkOeNMxbo4
	MaLpW6Bo1bAXAc9MbB+5TMYhZO038fjj18IGuuIpWkbrYaGMOyL6qgpOUp9pqR+g
	CXWN7thlFwxYzabY0jpQa5w6a4IGT++iFRe5KTZjvvuDTUlQR7k+vhTUGpO8UPfd
	rs0IvA5l2R+0mVAR7uzUPG1S0C7CT5NSDCL6e/DYs1jccA0zqnfciHAiK1JPtapM
	MHQjiWUCOYXbMtKVCtShhibm3gBwcoGZJm/IpHksk75+PhWYBd4EpN1HT25bcbxY
	bwAF4g4w5l4Pk9smnZ7R9C+cnUkqL/M1QM6E6RuWUS7GuVkzouqhX/yDmRfvJxww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qkdmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 09:31:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6599JceG006204;
	Tue, 9 Jun 2026 09:31:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g15c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 09:31:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6599VNMM18219276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 09:31:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3B9320043;
	Tue,  9 Jun 2026 09:31:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EDC12004D;
	Tue,  9 Jun 2026 09:31:23 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 09:31:23 +0000 (GMT)
Message-ID: <77a82533-2f1c-4bf2-925d-f48accf45951@linux.ibm.com>
Date: Tue, 9 Jun 2026 11:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390/idle: Introduce cpuidle for s390
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
 <20260609075213.31094-5-meted@linux.ibm.com>
 <5d9a3d2e-f083-49d4-a311-7801e70ac1a2@arm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <5d9a3d2e-f083-49d4-a311-7801e70ac1a2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27dd70 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=ypV6uxKLhDquFfQIcXMA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bVv7IztOJbrWpdhV6_3ZAvs9WqRqRFwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NCBTYWx0ZWRfX+RTocZaIBDMd
 XInB9udkxczvQ8t4edkgXKnic90bhwfQ8j3u1PaWYUjNgzj/QfuIcAAj8+jY++ViViQh1Pgi1QT
 6Y030miLmIu9qZAVlhd/WeuRzBreT3VkJePvCr4B8CXsv6/RAO3Pq6nl1WAs9rNSZx9Sy7eBMPt
 1eWOImUtU05SH4/JDauXgzRQRiupNAoawoC+GDMBA9n518AKF0qdRzxXnF5iZOepKwo1dXA/eqQ
 fHPfNdBdSoa22pFFGoHUHZ2fyMSgvbVHJLsvia9fbwF198WFJv5laP+qSYMqWYocDpuBgenVjVT
 JQ4BDQclDbPKVuSt6DqulKo2j+XiUr7t9IHtaY5SpLldYMJbYeSf+ecmNizUzlH5JgTZWLadWUA
 WrqW17BX0Eq6OQ6gpXahBYQXrtaIa2ZtzA3F0nb/0JWZnPR9nVZocUWW8hNHDfFdHLX62yDRvDY
 zi5uKA83eLltnv0SKLw==
X-Proofpoint-ORIG-GUID: bVv7IztOJbrWpdhV6_3ZAvs9WqRqRFwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090084

On 6/9/26 10:12, Christian Loehle wrote:
> On 6/9/26 08:52, Mete Durlu wrote:
>> Introduce generic cpuidle driver on s390. Use a two stage approach to
>> handle idle scenarios and use TEO governor for idle stage selection.
>> Two stages are, from shallow to deep, idle polling and enabled wait.
>>
>> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
>>   arch/s390/Kconfig              |   5 ++
>>   drivers/cpuidle/Kconfig        |   5 ++
>>   drivers/cpuidle/Kconfig.s390   |  12 ++++
>>   drivers/cpuidle/Makefile       |   4 ++
>>   drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++
>>   5 files changed, 130 insertions(+)
>>   create mode 100644 drivers/cpuidle/Kconfig.s390
>>   create mode 100644 drivers/cpuidle/cpuidle-s390.c
> 
> Since this will be hard for anybody without the hardware to maintain,
> would you maintain it? Or the existing s390 maintainers?
> If either then please also modify MAINTAINERS to reflect that.


Yes, I'll be maintaining the driver. I am not sure if it should be part
of the patch series but I'll add a new entry like below;

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..6b1eaa3abce7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6766,6 +6766,13 @@ L:       linux-riscv@lists.infradead.org
  S:     Maintained
  F:     drivers/cpuidle/cpuidle-riscv-sbi.c

+CPUIDLE DRIVER - S390
+M:     Mete Durlu <meted@linux.ibm.com>
+L:     linux-pm@vger.kernel.org
+L:     linux-s390@vger.kernel.org
+S:     Maintained
+F:     drivers/cpuidle/cpuidle-s390.c
+
  CPUMASK API [RUST]
  M:     Viresh Kumar <viresh.kumar@linaro.org>
  R:     Yury Norov <yury.norov@gmail.com>
@@ -23499,6 +23506,7 @@ F:      Documentation/arch/s390/
  F:     arch/s390/
  F:     drivers/s390/
  F:     drivers/watchdog/diag288_wdt.c
+F:     drivers/cpuidle/cpuidle-s390.c

  S390 COMMON I/O LAYER
  M:     Vineeth Vijayan <vneethv@linux.ibm.com>
