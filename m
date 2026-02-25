Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF763D4138;
	Wed, 25 Feb 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044269; cv=none; b=V+Knufk8BOtUDPPRjdfuCKxooJKkWY4kgetcizq6LR+Y7pwRE8BmAlBO0yi8AyUjnG4FmQeijDWdyl/tx8nI+Q8DO9vnZFHW5PRdlDeYJgBMrVCWhDdNB4E/sRdqQTxC1g6G00HDPC+6zv6JyfBoLcaNOlrhrXp07Xh4KG1E4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044269; c=relaxed/simple;
	bh=GutYVpSx9aABE+IgnhvSdNkcvXNfkecqqjnqmX1E4Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NitivI+CRgRyPgyCpoT3XFhMEmnIW4TpObKt6Vh1zF//XNPa6sQhIpHHRA58UgRBn4AFK7gsNHdmIcumm+UBIR6WSLCpDhhzwNNkrjVYhQnoO0thaXKpxyTXZzSqnaEXbPanEMNbxWsXLqCwGsg0pmxndrMaxwXA8129yc6/PoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njb8Kprc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njb8Kprc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PEij3B3015564;
	Wed, 25 Feb 2026 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZvD/f7
	IRLTLmldnkTjsJwBCbwWd/dUwI6kc6EhPH8/k=; b=njb8Kprcrstdg42bXr3/gD
	hM4zrv6nOTrEsOJdZARtOe7dAck9LOlGkJltDY9VLDLNzKZIpkbDuGdi05AVpDQn
	V/itMfwAyo5eu7mi69pIaErJ/xLe0D5tMWymcvSDJeAsATf0vgCXXNSn4Oxhatms
	FcztnV2B40QFm+JNSfYw4rUHAGPCoOTLI3YZsdaa468qaDbadNCurlgAlwlWXV9T
	kfvjtSFyU/4oTBYLQFuzeTISedIF9gZF658NpKI/y1A6saI8tIcgabrX3iw/0Ue+
	Sb1iTHJSNnSEbZ/9wR/lBjkoq73PnKW+DIk0+aNbxhWdVhNwbgzO5ADYQ2VWiUGQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs10sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:30:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PHdFWL003382;
	Wed, 25 Feb 2026 18:30:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jxgf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:30:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PIUFgU40829632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 18:30:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB525805E;
	Wed, 25 Feb 2026 18:30:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A85B75806B;
	Wed, 25 Feb 2026 18:30:13 +0000 (GMT)
Received: from [9.61.247.27] (unknown [9.61.247.27])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 18:30:13 +0000 (GMT)
Message-ID: <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
Date: Wed, 25 Feb 2026 13:30:13 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ciunas Bennett <ciunas@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
 <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _0UMUoKIZlKOKqau5XTtb0XTWq94cAbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE3NCBTYWx0ZWRfX5hzxm1BQVqPQ
 FGBk6ZpsteTOtLR+qOOvnM7R1Pnx3O1g2NTK0XK/e+EVxWjmAPdRrjmfWb2ISMfhn/2sYt4nr3B
 OI+Xh7TjlzW02J38u/lQoMB3U8wBrxZcXzVIpkUubfXFNYIgVd2I9uTQ8GVLdsDfux1LnjtTJua
 o1jG+m7XT4X1qF6G5HUt7i0Q/uaYE8GMnkz/210nVH2x9i1xn2b9d0P2A3VP04KjvQWaql2WIgV
 d3TRrZrkkH+Hl05em2OUxd6Fmiv3RY4/tQCOlLxVWUJKuXA81e3Td9o65CG6YBD5UPAEvDAOO5E
 2Yg0ACUPu6qvQgS4TBvlJNCkYGy5EU2Hl13u0CPOPGUH7ZmollwyqqxIFNomN72w7wlm0hPFuBo
 6fJMs2vLCQwywDeBPYuymJXMwUr/FJLcRvQWDNFTpAEGO+bO0FGJpNeJXfImIMpfSRoaFPPQGWe
 MSvDdxHHfLTGY1rMb8A==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699f3fba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=0MXMk1mwkTAisRVsYMEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LnQXTQu1zciqhCL8NCZSCXgSM0NrDEL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250174



On 2/25/26 11:33 AM, Christian Borntraeger wrote:
> Am 24.02.26 um 21:30 schrieb Ilya Leoshkevich:
>> Finally, what is the worker doing? I looked at __queue_work() kstacks, 
>> and they all come from irqfd_wakeup().
>>
>> irqfd_wakeup() calls arch-specific kvm_arch_set_irq_inatomic(), which 
>> is implemented on x86 and not implemented on s390.
>>
>>
>> This may explain why we on s390 are the first to see this.
>>
>>
>> Christian, do you think if it would make sense to 
>> implement kvm_arch_set_irq_inatomic() on s390?
> 
> So in fact Doug is working on that at the moment. There are some corner
> cases where we had concerns as we have to pin the guest pages holding
> the interrupt bits. This was secure execution, I need to followup if
> we have already solved those cases. But we can try if the current patch
> will help this particular problem.
> 
> If yes, then we can try to speed up the work on this.
> 
> Christian

Christian, the patch is very close to ready. The last step, I rebased on 
Master today to pickup the latest changes to interrupt.c. I am building 
that now and will test for non-SE and SE environments. I have been 
testing my solution for SE environments for a few weeks and it seems to 
cover the use cases I have tested.

