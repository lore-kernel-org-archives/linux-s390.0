Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077E2DA749;
	Thu, 26 Feb 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110695; cv=none; b=YN9x3b63S3yDhDYu0OAGu31VAcxklwc+LdA8h+4foN15Oh4ZYzbxPQO3frNNdGqgh9ioQ7XgfiK2h3ly4KBDiyQ7gRUzKEJXvLMr4+7j4ftaK1Wq7XWGoHpwaTyIWl05pRvwiAAN7fUntBCcntK81WoW1k6iDQ77AYsOjnZLKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110695; c=relaxed/simple;
	bh=Xi7EqVNnVWGyp1GDoYgc7PSh9rNruF0z+gzt0dvmf/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2lHwGpA4ryiNkmuXD+tfJHOJIR/qYbsPXAI6/RYpemw/KeLX6QlYQg/SY+l0+DswPc94/ST8mfOrIcNccH9z/Ld/gaXszxQ7PeNhrLFzJsdi8TvwnSm1U7V6h74p1XNZdFkT8uLlffU4MX3IQD7eDhUg1vUakW7D//K3hcLue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a0QAU3ik; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a0QAU3ik"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q9fjsv2648089;
	Thu, 26 Feb 2026 12:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A/qcQk
	LejviopmH2ocmloAo9ZlfdP0R45ljtxldPit4=; b=a0QAU3ik+ZDl/Z7duaUZRD
	NAtGKtV6zvCZ9RbnIiBwj/pyi4FlkXMqeY8NwdRTVbEc5TEw5FfAbfOlnnM+36OY
	Y0b5I65Fn+qQSyAK+jQZRxShlkBy2xof0RtnGACCM80WwFdOk0BihArFh9tUjAsC
	26kWuXMPp1Yi/fCwqEbeByNyT2zNWYxCi5aDpgNHbb+K6uG8zMPPyfKynM/fhfd8
	EMCLUCsiS0JUHpNFx6rGFKY2YVOh95sQmu6truosO3Zz1Y71u0q4ztkUb0EIa1+S
	2SmbnX5QbTdyx9fOZI9wbL/QfvLr5yaTCbkcVTzgqLoimpBapXvVBuZAEvPxIUrw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cdkv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 12:57:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QBKxMY027812;
	Thu, 26 Feb 2026 12:57:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr236y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 12:57:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QCvSBK46727672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 12:57:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C52B2004B;
	Thu, 26 Feb 2026 12:57:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E71120040;
	Thu, 26 Feb 2026 12:57:22 +0000 (GMT)
Received: from [9.39.17.58] (unknown [9.39.17.58])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 12:57:22 +0000 (GMT)
Message-ID: <129ebc98-6d1c-42c0-8e60-4072fa82719e@linux.ibm.com>
Date: Thu, 26 Feb 2026 18:27:21 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-5-frederic@kernel.org>
 <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
 <9ab1e7d7-57ee-49f9-963c-3a1b96dda684@kernel.org>
 <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
 <1c1e5cf6-5b38-476c-ba49-35510312b064@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1c1e5cf6-5b38-476c-ba49-35510312b064@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExNCBTYWx0ZWRfX/CCnAH//3SmG
 Kt2gN8BfZiChmASyXp7/StDlt3jCLfHmVQRXLl/KLab/RNovFlrpa6FxRbrQ7q9iSiMwoChrC6M
 du5G1acoa2tbTo4xa/r2S5S042gvV5xjKvjzsFJ/9N9fsHD7CpOLibh1DoUg3auGGZjVX8MYtub
 7hkGxbdtItlKGEUZoqzQSHzkWgEwWsmNeFFLJFwsgXg8jrg4i3YhOZkTLlOQNgJ/cwU7PP0UeRF
 iDG7QIsSJYoJEIRkdbx+iXnAziBjmZBh3UWYpDqrXcZewoixzuy3eE+nBezDgy+SMKJxzx0fkQD
 U/r2MsnigpfJNqmlSbzxKCZqqVoQ3mViVQpmzLQit+WsewNl+z14jCNyLa8fNz48pn+hd7q3fnR
 I9bx489bSyoaXIVHhkvmnNkUfb8xeeiBVqWo+f9BHq6vaeyFkuPl6F1R8fcmXzl+bgf+fqbXNla
 M8M0TV3Cu4eSQvcXwjQ==
X-Proofpoint-ORIG-GUID: 7cmKtdgDQHK2cqD4DGWSagANoTD8iAKA
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a0433e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zlYsBo3-bph3zESPOqkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eLrZGOqrYbJYs4jS4w0-JPJwZ3aBQmiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260114


Hi Christophe.

>> No. With this patch there will not be any performance difference.
>> All it does is, instead of using mftb uses sched_clock at those places.
>>
> 
> For the record, I did some benchmark test with tools/testing/selftests/ 
> powerpc/benchmarks/null_syscall on powerpc 885 microcontroller:
> 
> Without your proposed patch:
> 
> root@vgoip:~# ./null_syscall
>     2729.98 ns     360.36 cycles
> 
> With your proposed patch below:
> 
> root@vgoip:~# ./null_syscall
>     3370.80 ns     444.95 cycles
> 
> So as expected it is a huge regression, almost 25% more time to run the 
> syscall.
> 
> Christophe
> 
> 
>>

Got it. My bad  in assuming it may not happen multiple before vtime_flush.

Btw, can you try latest vtime_reset patch? It shouldn't make any difference.
I tried perf bench syscall basic, and ./null_syscall.
I don't any difference for vtime_reset patch.
