Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3E43D4E8;
	Fri,  5 Jun 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656257; cv=none; b=rDym+zpgenq7I+NfZUvb8MO3hrzVHpG6JjT0aCREp5TuhnuwWS1wQ7JZp+majItQGm2No6OG1ufqVwvdXLI6l/tbfc1UyYS+6uoWK4qTOF8DIrofJbBwgVdMs+DjG9YqRz5aey6j8MhMI9miM2WbF2sx4jHUgV5U3Ajktfuwn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656257; c=relaxed/simple;
	bh=qQD1iVcO8/kGo4f3d5FPvG4gVUVLgEMOPIuvqpVRITo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRQsrF0xftsZ4t1iulDSMSIyojyhZKdmX4G/qYAPt5D47vf0aByN2r6CPvCqLMfdatqFhEVB25Ho4h+EQ0kk4O/ZKFRXCoHS3d782WVtgmlt1IfI8hzD/sYH6jzsNkkqiRC/oHkq97HiSXR/kR8+hYgUZ2Tid9ljLTF7F6wVDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTojJrnq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTojJrnq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65501bQt2672300;
	Fri, 5 Jun 2026 10:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aajtgd
	4g74ITFaqba2FKOIAP7qKCcxYvvMGYK1oCEq4=; b=OTojJrnqYG+85cgTqPvbng
	L2d2mAHvYDKnCvxUmVM7Nx8a1l+yJVYol6yrDT0fRrDYztuTgNqCyhGW0dez6CTg
	FRMpAk49xjo88tIXR8gtzgmRW9j+xQF1se0QkriBFLcpAd2biFSpsFKlJRY0JZgA
	j2UHxwh8VdsgLXztJTkAHQj08NFoDKDfE0OQ1nlqLA8IsSey6hqmfcvwi1WdS0BW
	Lx8O+mupBZ3A/u3z1YmqiGlTmkp1+/2h46hpOdyPdFGyaJLIAwIGUBnNhYHF6Uyn
	vbwL03BRa9th85eAOqEHDI3KH2cnqz/HbMSE7NT3eizbyE/bk34Ud4pDRlgnGZRA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtk9v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 10:43:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655AdCru013590;
	Fri, 5 Jun 2026 10:43:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhs6aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 10:43:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655AhQYh34865428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 10:43:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D94420040;
	Fri,  5 Jun 2026 10:43:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1BA52004B;
	Fri,  5 Jun 2026 10:43:24 +0000 (GMT)
Received: from [9.111.29.71] (unknown [9.111.29.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 10:43:24 +0000 (GMT)
Message-ID: <6c3fbb6d-d4e1-4984-b584-c067be844098@linux.ibm.com>
Date: Fri, 5 Jun 2026 11:43:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
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
 <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
 <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>
 <20260303115235.GQ1282955@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <20260303115235.GQ1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Tr7eG8kL6PEG0-UCaru3G2vn1OwaOGGL
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a22a853 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=gvEKT50zYTi1MNGVV_wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEwMyBTYWx0ZWRfX/LYYe1ufiFjU
 gtEFAD5gt8KSfDY1L5f8KXkfLpp5bl0YjP99OQOzwS0T5UJPjwwSb4V/qwcN4W8I3gkW746UYtA
 vRNTzgI8lYE5tFHRBA6IcFnprBPNjryvaDAOJaMFfMOumTt+sEjliAPG1kCrfVu0WIW3odZEZay
 2NL5YS7oJeVk8O+Vfy2DUuC5qF8rYwOfb5Rcg7tBMhBHMf4nvqR1uIyFmgEGPEon/TfMOQgpQEn
 OY7DNSGCqTTWf4Ou6zRc1fYVhGN6ansbBR0EJqPrbh2FbM4KtZyO8BJHOkd6xpuLQTB8uxVA87q
 fM7loxkK80HqV3NFX1I9viL74gHHbRPAoxP1B760yNi9lZr1a1S8WM57clnbXxrIxMmn5obGOAj
 zd7z6ZZbHydNR4vJOGlPt8ZvmbMLsrDbwD58paH/M13Fuf872WqTgfpVPFDYMLgp1SNOnAfxyPo
 8yzBTJGKmR+xZsZfx6w==
X-Proofpoint-ORIG-GUID: XIXh7faptC_ugcIJ2ifINDrutanU6P0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050103



On 03/03/2026 11:52, Peter Zijlstra wrote:


> This has two ramifications:
> 
> 1) some ping-pong workloads will turn into block+wakeup, adding
> overhead.
> 
>   FULL: running your task A, an interrupt would come in, wake task B and
>   set Need Resched and the interrupt return path calls schedule() and
>   you're task B. B does its thing, 'wakes' A and blocks.
> 
>   LAZY: running your task A, an interrupt would come in, wake task B (no
>   NR set), you continue running A, A blocks for it needs something of B,
>   now you schedule() [*] B runs, does its thing, does an actual wakeup of
>   A and blocks.
> 
> The distinct difference here is that LAZY does a block of A and
> consequently B has to do a full wakeup of A, whereas FULL doesn't do a
> block of A, and hence the wakeup of A is NOP as well.
> 
> 
> 2) Since the schedule() is delayed, it might happen that by the time it
> does get around to it, your task B is no longer the most eligible
> option.
> 
> Same as above, except now, C is also woken, and the schedule marked with
> [*] picks C, this then results in a detour, delaying things further.
> 
> 
>

Hi Peter,
I wanted to share an update/findings from the investigations that I carried out for the issue mentioned above.

Quick refresh:
Workload: uperf sending TCP data between two VMs (client and server), each configured with a single vhost queue (min vhost ques for testing)
Issue: With lazy preemption as the default preemption mode where previously it was full preemption, there is a significant drop in performance for this workload

Simplification of the issue
We have two tasks:

TaskA produces data
TaskB consumes the data produced by TaskA

Notification path: TaskA informs TaskB that new data is available by adding a new item to a workqueue. This triggers a kworker which runs and notifies TaskB.

Issue
TaskA is configured to use schedule_work(). Internally, schedule_work() uses system_percpu_wq, which is configured as:
<WQ_PERCPU = 1 << 8, /* bound to a specific cpu */>

This means the workqueue item will be woken up and executed on the same CPU that queued the work.
If the task that queues the work (TaskA) is a long-running task with limited opportunities to call schedule(), then the kworker may be delayed significantly before it gets CPU time.
In our scenario:

TaskA continuously produces data
There is no dependency requiring TaskA to yield due to TaskB
As a result, TaskA can occupy the CPU for an entire tick before being preempted by the kworker

Observed behavior
This is exactly what we observe in practice:

TaskB corresponds to the VM consuming data generated by our vhost task
When running uperf, this behavior leads to a significant drop in throughput (Gb/s)
The VM is unable to consume data in a timely manner
When it is finally notified of new data, the delayed signaling introduces jitter
This causes TCP issues, including retransmissions and out-of-order packets

Results:
   |--------------+-----+------------------+------------------------|
   | preempt mode | Gbs | workqueue pool   | kworker latency avg ms |
   |--------------+-----+------------------+------------------------|
   | full         | ~50 | system_percpu_wq |                  0.002 |
   | lazy         | ~13 | system_percpu_wq |                  0.721 |
   | lazy         | ~50 | system_dfl_wq    |                  0.005 |
   |--------------+-----+------------------+------------------------|

So I did some more testing and if I use a different workqueue pool the system_dfl_wq the TP was good again, as you can see in the results table.
Since the kworker is not CPU-bound, the scheduler has flexibility to select a more suitable CPU for execution.

  /* system_dfl_wq is unbound workqueue.  Workers are not bound to
   * any specific CPU, not concurrency managed, and all queued works are
   * executed immediately as long as max_active limit is not reached and
   * resources are available. */

Given this understanding, what would be the best approach here? Should we consider changing the workqueue usage in the KVM code, or do you see an alternative way to address this issue?

