Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D483A4F29;
	Tue, 24 Feb 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947986; cv=none; b=UL0Fl3sJxY0RqnlnwrcNFe8Da2X19xRBUrqpbJqy8lPmmLvsCR2gCESUJNsPxZ+bf3ockviHj58uz6S4BYyqhSf+hCZJvMQtOHPmVuekWnqiIS7y3ThPwiKPmJ7xazLPpFJ9OwYAeh/2CgX6vSTTjDa7A4AoNboANoa8epKIiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947986; c=relaxed/simple;
	bh=EYqYtHBIlT4F1uNPI1HNw0h0f1IqZDhQ4kWNEd1qhQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1Gtaq6KsHGi/Qu8Z/eaPJbV0mXus9b4h2KptroM0hHJIaSGuZsERkivwwacs8NPTAfuTRB4Nw6BDI92oV1Lq4JEgdV4FiBAiZGiKpSWObkINEzwOEEa4h8DOjcRIyUEFl05pIGXATGCoEn49lWHFaiGqhbc20GSs7Zi73Pb9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GZwrqLJV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GZwrqLJV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8rAnr2848171;
	Tue, 24 Feb 2026 15:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bYwEEV
	Tcqxglj2VmeVm53Fkw5bxCwK7s+qzLeLs201M=; b=GZwrqLJVAnCSYeZfQljjMF
	0MnmFbHlz0goMngEz54BLl8PHolXwUxur4MvECrcAvBCpIgPf5xfSS7OuiWeVJtd
	WsBpNz7efMljYOgYgjy9CUJWjFU8ZpfxQ1VQ5wxf3yGGA0BEKYZlKQcz2G33t/lw
	9VQqOfzctZ5MsmiL1+2iUGiPHXXTg4NT2hWUadqGod1B5HvDXQWz3xS2xdxaGL++
	5g1hVNDTdGsockPzMV+yxhvRyV5YbR/YMzx3Hnkvn8jt05rvxXpP8Q5KahiK9SZQ
	gdmseeD5Js59YQfy4Bp6lkloGAam5Tg894XFxEiI/ZCc9zFlAYjjdbKXky62l0vA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c3pk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 15:45:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OEaqZs027789;
	Tue, 24 Feb 2026 15:45:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1s5ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 15:45:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OFjfRa46858574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 15:45:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 967C32004B;
	Tue, 24 Feb 2026 15:45:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47EEB20043;
	Tue, 24 Feb 2026 15:45:40 +0000 (GMT)
Received: from [9.111.4.35] (unknown [9.111.4.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 15:45:40 +0000 (GMT)
Message-ID: <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
Date: Tue, 24 Feb 2026 15:45:39 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEyOSBTYWx0ZWRfXxgj9PPH8fE3h
 +zNbES+KEnCQ6LAGyvRKhNrLZwDH94/q6PCYgokkvXz0F6+IonQUxN8grHgF97ixLl8r5Hw7OpT
 OC83a3xl6te9moS1hDzP9E3V0qX7nTDDQKHlZX/nNG0BWTe2pvZ93DRuQMBnBRmcAZU2iVqvEKD
 kkBlQYjkwdDJ6DSwvRJe5yiphX5HvCh9gbdrgQETy08USXGpMR8JZ9sb5t/R74xb0GDVH5Vrwgw
 IRMv5PQqXYgomBfpAYT5c/6O206sqAsXGcCQS36x0DsjHE75+j2IYf8OZR9UV1r4Zh0Ksg6t9mi
 cRe36rTn6dh6LPwSWr6yWpevlDtSpoHmWSLjmSYkRQz97vcZFAegYcf7li4zTTE9HMVJKbHbJu7
 aOjuXE98+ZMWK2ngTsteTyCOcSEWmPGpY43SYRiznorrlcasOuLABlFLdUheEXc5fbROQ1LjrMp
 OoIp2EnBNTAJDIBvOHQ==
X-Proofpoint-ORIG-GUID: iJVdRvOQovOl0PDONTeESHxu91Nibjtt
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699dc7a8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=utPUNdWZvXILXUMAFl8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rtgaorHrJPavtSwcprvcseicfw1ZZtei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240129



On 19/12/2025 10:15, Peter Zijlstra wrote:


Hi Peter,
We are observing a performance regression on s390 since enabling PREEMPT_LAZY.
Test Environment
Architecture: s390
Setup:

Single KVM host running two identical guests
Guests are connected virtually via Open vSwitch
Workload: uperf streaming read test with 50 parallel connections
One guest acts as the uperf client, the other as the server

Open vSwitch configuration:

OVS bridge with two ports
Guests attached via virtio‑net
Each guest configured with 4 vhost‑queues

Problem Description
When comparing PREEMPT_LAZY against full PREEMPT, we see a substantial drop in throughput—on some systems up to 50%.

Observed Behaviour
By tracing packets inside Open vSwitch (ovs_do_execute_action), we see:
Packet drops
Retransmissions
Reductions in packet size (from 64K down to 32K)

Capturing traffic inside the VM and inspecting it in Wireshark shows the following TCP‑level differences between PREEMPT_FULL and PREEMPT_LAZY:
|--------------------------------------+--------------+--------------+------------------|
| Wireshark Warning / Note             | PREEMPT_FULL | PREEMPT_LAZY | (lazy vs full)   |
|--------------------------------------+--------------+--------------+------------------|
| D-SACK Sequence                      |          309 |         2603 | ×8.4             |
| Partial Acknowledgement of a segment |           54 |          279 | ×5.2             |
| Ambiguous ACK (Karn)                 |           32 |          747 | ×23              |
| (Suspected) spurious retransmission  |          205 |          857 | ×4.2             |
| (Suspected) fast retransmission      |           54 |         1622 | ×30              |
| Duplicate ACK                        |          504 |         3446 | ×6.8             |
| Packet length exceeds MSS (TSO/GRO)  |        13172 |        34790 | ×2.6             |
| Previous segment(s) not captured     |         9205 |         6730 | -27%             |
| ACKed segment that wasn't captured   |         7022 |         8272 | +18%             |
| (Suspected) out-of-order segment     |          436 |          303 | -31%             |
|--------------------------------------+--------------+--------------+------------------|
This pattern indicates reordering, loss, or scheduling‑related delays, but it is still unclear why PREEMPT_LAZY is causing this behaviour in this workload.

Additional observations:

Monitoring the guest CPU run time shows that it drops from 16% with PREEMPT_FULL to 9% with PREEMPT_LAZY.

The workload is dominated by voluntary preemption (schedule()), and PREEMPT_LAZY is, as far as I understand, mainly concerned with forced preemption.
It is therefore not obvious why PREEMPT_LAZY has an impact here.

Changing guest configuration to disable mergeable RX buffers:
       <host mrg_rxbuf="off"/>
       had a clear effect on throughput:
       PREEMPT_LAZY: throughput improved from 40 Gb/s → 60 Gb/s

