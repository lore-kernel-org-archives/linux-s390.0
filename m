Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882726;
	b=ln5W0W2qyh6jktyWDQI/yN69rP/XC5aZTuC3dIOGuG8GkZf8BRH20HbGIu1wo1KNgfGF
	 wSS1d6Zz/w3uHj4pQu3YPFRnmSiSoRujaFQb5rv4/7R82NvVglZJXMJ/1mMdL8ITmqfdn
	 m3bgiku60pYDWeooWJTNRxgftAfjg0Tp6qFix7puP9StDPDt23E/lHHatBQWgIrzdaqWp
	 6IGqNGp9OblMZ39QWwMY5n0DjyPprnJJwE/mAL3wCJvas5V8fR6m58Uu085bFUyTkxngS
	 g2cT9SjIaSXpbajnxhBQiarCo8tPyuHEWVa5zXoQhzUqfkZxhP9TLtH09UtFvZIKrXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MkaEEYBGbJKttQtVQkj/AXYKn1t2kiF0JQQXrTXiQMU=;
	b=Yj+oTnn59ulVWTdIGFqftKJLigFV4ynTHC31jDk3tVbDhCQpFjKPUzyO9200/CCoBgqM
	 f/vunNGptHfIrgtpyOcgVMqIfI5Z8p7l4caSeqOk51rfIfhjLWHdtdmcNaVaF6zmFxS6Y
	 xglSEVXRufWnO9l45ILHnDjItfWPqyaO5A4snivUbQtJZd/6gi0iYQu0glnnueUHeb2vP
	 x6RBDtsrEGmPHqGMsBNh2eszJ4GWhnQN17W+uS/lezZZkQq2S/iYExpFRfyv0WuE0aUBB
	 GVpeSHKxnj4rne2H2XYzQy0nkZYSQ43bfTYHh4WDJ3Yr1Dtv8xIa8OgnHgZTMdX7TkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N9Y1t7jB;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB63606A329;
	Thu,  5 Nov 2026 12:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB63606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N9Y1t7jB
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE8be3220043;
	Thu, 5 Nov 2026 12:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MkaEEY
	BGbJKttQtVQkj/AXYKn1t2kiF0JQQXrTXiQMU=; b=N9Y1t7jB9lM5w6O4dMuq7E
	z0wU/tKWz1fJe0eQAXWjJVxDzPFiRdEjIwahvIZo7ZNBzjnr9MXMbfg/tbg8thJq
	Cs/fzj42mOmSHtvFYZLJI3RfqKUv+sCdPCcVmIsg0T+U/+92sUAHPkWhGlTQRl4N
	iceAj5AOasL6NU7y2aM8jQHn8jm3pJmSuPlpx4KopUTxl9xsdePokzGNEwzwyeFk
	bprZU/iaDmDQSgxDH/wHp2JfeEs6bTtPjltoTm5BWAjK1mgIfepykzSgkGcXGFzX
	xHPd04yjYGbImSKVU2ITXvBUnulDXUgYGaqPUu/GIgb2emv015IlO9AtYQcRPGxw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn82723d5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:45:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4sQu1476759;
	Thu, 5 Nov 2026 12:45:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6st7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:45:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CjJtt26738976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:45:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C59A82004B;
	Thu,  5 Nov 2026 12:45:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8569520040;
	Thu,  5 Nov 2026 12:45:19 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:45:19 +0000 (GMT)
Message-ID: <dda30d4d-0650-46e9-8ddf-9e4df4bb023d@linux.ibm.com>
Date: Thu, 5 Nov 2026 13:45:19 +0100
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
Subject: Re: [PATCH 0/3] KVM: s390: arm64: Fixes for arm64 KVM support
To: Andreas Grapentin <gra@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pr51-U-67ocqMzHztj-7nkIMfjfHnQkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfXy4f1WVCPGJ8v
 K+Pg/C3vlbqYl9r4i81g8eEaJEtBuX5o3f/I68WYdfk6VI25F8luLDnmDATFRzn87WRYC20fI1C
 GBkOj6/uib4ryH4n7SnfC1jESwotWIVzJWLwFWetxHHV+sYu1dvKaHGYJU9MN8WFuHwHmVyfEx9
 hdTo5TabHeXG8OQTvO7Zv+V1isV3XvZIifBj0gjkGAAOODcesZq2pX7BpiRzqCSriajIio8i2bj
 JVV63NQjocy/+ZC/pU9PTyEtW2/H6hzlzxQz8dgYVY0J0ypS4eb/w4jKOELaQMx5+EieaUnIZ1n
 cjIIvpqDWKb5dxAk1oYNPGDC1XZhI9rr9btTwaQNU6d15xftLyGIycEsmEmvz5EbT7WKBV7UtnV
 zkimAWAOiroX+axvg1MOupapjsP1ziKv+g/nYSboXwBV3d9wkLsTJvxMmpdM5qL2zyYMIc4fR8s
 /hmtOZQ8s2uUin0DIZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX8R09Mssh2uqd
 63/S+aONWOdNgm0Fw1zvQ5xkMo1jctLlhaXNostLKRobokxr08zM7XRSiNhtIEo7BBSxFrV/S6z
 U+qLeCCQIr+v0EnH6K/ehL2ExkYSk3U=
X-Proofpoint-GUID: Pr51-U-67ocqMzHztj-7nkIMfjfHnQkQ
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aec7a64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=AB4inXjDjgZuHX5E6hYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050050

Am 03.11.26 um 17:37 schrieb Andreas Grapentin:
> Some fixups for the previous series that introduced arm64 KVM support on
> s390. Forward-declare enum vcpu_sysreg because we are definitely going
> to need that, then make the module naming consistent and iron out an
> inconsistency in the definition of vcpu->arch.pause between s390 and
> native arm64 KVM.
> 
> No functional changes intended on either arm64 or s390.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> ---
> Andreas Grapentin (2):
>        KVM: s390: arm64: Declare enum vcpu_sysreg
>        KVM: s390: arm64: Fix kvm_arm64 module naming consistency
> 
> Steffen Eiden (1):
>        KVM: s390: arm64: Turn vcpu->arch.pause into a counter
> 
>   arch/s390/include/asm/kvm_host_arm64.h |  8 ++++----
>   arch/s390/kvm/arm64/Makefile           | 12 ++++++------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261103-s390_arm64_kvm_fixups-b285654f214c
> 
> Best regards,


Thanks applied.
