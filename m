Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEB311954;
	Wed, 25 Feb 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013415; cv=none; b=bECnvVEHi/qXDEokaZ4xvhQD3P8sLzWNHz9j4pNxF1MHMfOx35MbmHbej5aLGkX8npg7qmYdGydVEL6KZWpQKiNcbDS1f8iRrrOOr9kDv7X6pCynebQY7xlfWWkhgXwnWQBYlA7GRQa4wfH52PVAd9lngiIe3janIJe84vP4X0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013415; c=relaxed/simple;
	bh=MfjPxYsnbrkxjssASivGHP3yjeEkQ580YwkZdUjoVcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0+2eWaAENhBk1+Z87+1HYO/WCuKG4PUIk2m5hqDnSOLqBvNdgbHrE7952n2BgEQgn7jl9EQnvKArHVWRyDo587G1WpzdbW2iZdFZGmKmILBivU62pFIrevdC3c3kpPwBQM20nLdQRCkSWx4aaNrLevGXSgpz6h02iwfkpWgXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q+BaN0SV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q+BaN0SV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9dKH61745446;
	Wed, 25 Feb 2026 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y8Lyc1
	nD/yoDJtt6s3WDTVa54KOOxljFKULDXaKQ+jw=; b=Q+BaN0SVuSUNVjqNR/dCSr
	Nq+PH8AJPRLrtFyqQWqhGsNnjHODaJ7OX8kEgkAsJ8yoQb8j2+Qj63O+Xm6d/t0Z
	MxqJ0KLZZ5LGZTO7TPG9kI6ow3NYWsrW8URtFkZ5WF/aYPrFPp/vIBMyFMqNj7Ta
	uLZDjdVaK/AX6AStyvInKUs/P8NxcuL3gosnjKVts3CcxYTEB7P3DPcAyh4I1MUg
	OEAKhnF8S5jd4RDQwaTjPZ09pL/cGeIKzj0r7s0/48RoMy+6/tsAASOvjQOGA6ek
	8GxI2HFZ7w8V1AF8YAFKP5nLWdNTu7XwUq82o2WD3D03GkDM3YHfgHzplcnj/Kuw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqykjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:56:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P783MY015758;
	Wed, 25 Feb 2026 09:56:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1smvw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:56:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61P9uV2Q57016604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 09:56:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BE920043;
	Wed, 25 Feb 2026 09:56:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5139220040;
	Wed, 25 Feb 2026 09:56:30 +0000 (GMT)
Received: from [9.111.20.176] (unknown [9.111.20.176])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 09:56:30 +0000 (GMT)
Message-ID: <577cbf87-277a-4c6c-802f-00096c788036@linux.ibm.com>
Date: Wed, 25 Feb 2026 09:56:29 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <20260224171111.pMPZGcan@linutronix.de>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <20260224171111.pMPZGcan@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ggHshAP3UyibOZyxBiXtLS-kZivmJKZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA5NCBTYWx0ZWRfX0MbjVq7t+wi3
 6zdy+FZeEgMGKB1KxjX0sPy8FNQ9/VpU2wLzRKEFKJw93j4/VawIGTWIsmUsa7PY7XKqR/cQYVR
 E8zXF3NjoJGsp5nlUuTwE1DALmRweDnTugiMftniuxl82V6KY+inyjQbCc+dxl8w8WgWs9r4m/d
 PPWUum0gUrOqWgzT0uPDCsmKTf1hQEGyx7XqRZyMjcJgzPhbnSCKbqhiW/A4gnZG6p5/4PAnd9u
 kAiIksHMxdMb5inu3saoAhfTew180tB+9dG5dtAiIVSvmhAHfjNwGZR8nWeCtEKsypJBnkNbZyd
 rlbuPYW/SzwHPUAk/jXyLzIxkb86Z8PlGW2zqJv2+rlIB6TdI8btTCdD6l4BNETn+3MJ9Xiu21G
 eqozPPm7PiejJSMbdLze34zuRbEF1MtEyj267DgHFOOXP8njhKIfrvrgfLrfWxMJ4Wi66poMKmN
 TECSe/ft1FdvoWByUHg==
X-Proofpoint-GUID: ywS_kq-zX7Bgtpvgm1LejcIjFR0T7asY
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ec752 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=315T5f-plpDpaHdBaGwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250094



On 24/02/2026 17:11, Sebastian Andrzej Siewior wrote:
> On 2026-02-24 15:45:39 [+0000], Ciunas Bennett wrote:

>> Changing guest configuration to disable mergeable RX buffers:
>>        <host mrg_rxbuf="off"/>
>>        had a clear effect on throughput:
>>        PREEMPT_LAZY: throughput improved from 40 Gb/s → 60 Gb/s
>>
> 
> Brings this the workload/ test to PREEMPT_FULL level?
>

Sorry was not clear here, so when I enable this there is also an improvement in PREEMPT_FULL
from 55Gb/s -> 60Gb/s

So I see an improvement in both test cases.
PREEMPT_LAZY: throughput improved from 40 Gb/s → 60 Gb/s
PREEMPT_FULL: throughput improved from 55 Gb/s → 60 Gb/s
