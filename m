Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF792DF76;
	Wed, 25 Feb 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986642; cv=none; b=llkm9z6mqMDkEstPoCgL8HI4cAKWj6LujLJO2/BYnXKLL3GLFea6Wac3807VsOca89Tq9ydUCxLRXDjRqacDkYoOXviBydeICJLErHDgHtv3D3pmMVlX+ejNNu7VVu5xd48dOKf/i57Ryrs8cuetWn8HZJsQbEK25hv8oCrC1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986642; c=relaxed/simple;
	bh=srje3/rkZcoY1cv1CrSfK60b7GlLwIbtXXCUi8835Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOtiM8U98pL8xSVafYcw+h8nAX6pKMXHZlowSz1gDdxGzXifa0XHsVvPK+Teevz47EfAAKQx6kXgi3bLAPQuEFMkQeE/2wyxs3OBz+C07hEr2V0BRg6/7XdtweJAAwgy8uCyA9k4FBqvQ7DfoVqw3tdGKYbqGA9fK/18nP5x+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=caP3zmEY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="caP3zmEY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ODDc1T3239518;
	Wed, 25 Feb 2026 02:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gYBH6q
	QR2fLfyzlhIcUnlDUl4MLoYxJz5P0x8Khak6I=; b=caP3zmEYi3J88A46CeNFXI
	ZTEFkmtFwjiBmO3IX9fX57fP7p1P3hy+MayDkBQ8CRlAoDZ5V6JjEAj1mAWFNYfE
	MsKpt5VaaCHB1eDljhAk2QLQQOxg5MiCfzHOcxYzOQUE5WAkDwPqxnnsHDDxJ61u
	oJq3krUz7QSoEdofZBfzMgR1a0WzhMYoDYGE7E3q8WD9zEQFMgcCk8QAT9UR7gnj
	Umdrwl53q183QudRBhCNWCP3YCNuunJsrmRucBNJrBa4P5uqEJAGwbFVRy2j1+0B
	cEpIdHcwpfVbCRrfDZ+ZhBXXNcG4WrmNdt2X7+gfg+oY+BGO0jxHw81YGVt2Ocvg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gdwj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 02:30:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OMFD54003386;
	Wed, 25 Feb 2026 02:30:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8juarw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 02:30:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61P2U6XT15860010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 02:30:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5980920040;
	Wed, 25 Feb 2026 02:30:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D6F920043;
	Wed, 25 Feb 2026 02:30:05 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.140.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 02:30:05 +0000 (GMT)
Message-ID: <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
Date: Wed, 25 Feb 2026 03:30:04 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Ciunas Bennett <ciunas@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699e5eb3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=SXPTeJ-TAB3VdRXr-XgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GjyrdZDVi83cDyFEmevbYGhwMgunDUod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAxOCBTYWx0ZWRfX50Ij4Qcb4kHk
 M7POklwRM6wr99w4l8rLxKj7llbys7OoORYC34XVNbx1GwmcAop3YRJJrOKAiDDdedyvrtFwxPl
 lsOkRxga8FEcmTKv2K76jNKWjZh/RLD3nFf3MBUABP/IbIq7bYveteuzHiNc574yX8gxd+hHVRE
 iiE6eLHzs/ECMG54U9Q4BVit19qihUDTo9qBwKMLqhD6PKHaKGL0B3RBKsYs5NY/cMzCQBswENV
 ULF2zX02J4fQfUS3NI4orYhkuZVMm4+A+uTNL/280C6m5Ojcs7uVR408swYyrDfjfQfyQCGvWJ3
 4FR+hur3KiO6G+HLW6V1QXKC6ri+iw5aHgHzu4FjSgsTkYEAFHbBzF7+4gaHT4CZaTCD23ipmnO
 NB8nJcD3/TFvjlERzLukUVsmNjUi/1AjzMxUmoGidVDhBEIg3gFIsGH09rrxzXvlaCK+dMKnqzB
 ox4JlYWoxBphQBuGIoQ==
X-Proofpoint-ORIG-GUID: CZv2DLwFx4dLCB-qk4DERIf8loa81Zpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250018

On 2/24/26 16:45, Ciunas Bennett wrote:
>
>
> On 19/12/2025 10:15, Peter Zijlstra wrote:
>
>
> Hi Peter,
> We are observing a performance regression on s390 since enabling 
> PREEMPT_LAZY.
> Test Environment
> Architecture: s390
> Setup:
>
> Single KVM host running two identical guests
> Guests are connected virtually via Open vSwitch
> Workload: uperf streaming read test with 50 parallel connections
> One guest acts as the uperf client, the other as the server
>
> Open vSwitch configuration:
>
> OVS bridge with two ports
> Guests attached via virtio‑net
> Each guest configured with 4 vhost‑queues
>
> Problem Description
> When comparing PREEMPT_LAZY against full PREEMPT, we see a substantial 
> drop in throughput—on some systems up to 50%.
>
> Observed Behaviour
> By tracing packets inside Open vSwitch (ovs_do_execute_action), we see:
> Packet drops
> Retransmissions
> Reductions in packet size (from 64K down to 32K)
>
> Capturing traffic inside the VM and inspecting it in Wireshark shows 
> the following TCP‑level differences between PREEMPT_FULL and 
> PREEMPT_LAZY:
> |--------------------------------------+--------------+--------------+------------------| 
>
> | Wireshark Warning / Note             | PREEMPT_FULL | PREEMPT_LAZY | 
> (lazy vs full)   |
> |--------------------------------------+--------------+--------------+------------------| 
>
> | D-SACK Sequence                      |          309 | 2603 | 
> ×8.4             |
> | Partial Acknowledgement of a segment |           54 | 279 | 
> ×5.2             |
> | Ambiguous ACK (Karn)                 |           32 | 747 | 
> ×23              |
> | (Suspected) spurious retransmission  |          205 | 857 | 
> ×4.2             |
> | (Suspected) fast retransmission      |           54 | 1622 | 
> ×30              |
> | Duplicate ACK                        |          504 | 3446 | 
> ×6.8             |
> | Packet length exceeds MSS (TSO/GRO)  |        13172 | 34790 | 
> ×2.6             |
> | Previous segment(s) not captured     |         9205 | 6730 | 
> -27%             |
> | ACKed segment that wasn't captured   |         7022 | 8272 | 
> +18%             |
> | (Suspected) out-of-order segment     |          436 | 303 | 
> -31%             |
> |--------------------------------------+--------------+--------------+------------------| 
>
> This pattern indicates reordering, loss, or scheduling‑related delays, 
> but it is still unclear why PREEMPT_LAZY is causing this behaviour in 
> this workload.
>
> Additional observations:
>
> Monitoring the guest CPU run time shows that it drops from 16% with 
> PREEMPT_FULL to 9% with PREEMPT_LAZY.
>
> The workload is dominated by voluntary preemption (schedule()), and 
> PREEMPT_LAZY is, as far as I understand, mainly concerned with forced 
> preemption.
> It is therefore not obvious why PREEMPT_LAZY has an impact here.
>
> Changing guest configuration to disable mergeable RX buffers:
>       <host mrg_rxbuf="off"/>
>       had a clear effect on throughput:
>       PREEMPT_LAZY: throughput improved from 40 Gb/s → 60 Gb/s 


When I look at top sched_switch kstacks on s390 with this workload, 20% 
of them are worker_thread() -> schedule(), both with CONFIG_PREEMPT and 
CONFIG_PREEMPT_LAZY. The others are vhost and idle.

On x86 I see only vhost and idle, but not worker_thread().


According to runqlat.bt, average run queue latency goes up from 4us to 
18us when switching from CONFIG_PREEMPT to CONFIG_PREEMPT_LAZY.

I modified the script to show per-comm latencies, and it shows 
that worker_thread() is disproportionately penalized: the latency 
increases from 2us to 60us!

For vhost it's better: 5us -> 2us, and for KVM it's better too: 8us -> 2us.


Finally, what is the worker doing? I looked at __queue_work() kstacks, 
and they all come from irqfd_wakeup().

irqfd_wakeup() calls arch-specific kvm_arch_set_irq_inatomic(), which is 
implemented on x86 and not implemented on s390.


This may explain why we on s390 are the first to see this.


Christian, do you think if it would make sense to 
implement kvm_arch_set_irq_inatomic() on s390?

