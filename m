Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B61400C;
	Tue,  3 Mar 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529421; cv=none; b=QKKmgYQVhHtohLWJdLJhh1R6PwzjZzSEGfEH4Zsrkl9kDLhyS1JC+X82+txY1y30DG/J4Xu7he2lQsR3M66tsk1nlKF6xi8GU5H5/x1wtzJjCLVKebXo/1fS1DcViM+u2ABXLiN/nW2iIpdnRiMpcn9LNQAg0fRHpEv1c5ll0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529421; c=relaxed/simple;
	bh=8l4hat8ARKCC6ftMbifpfcF3e9yWpKScZDJzU+i6L90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJAQCDl+p657HwKJR+//Wd45sU9XsKVsn41jFrMIMuSfJP3cq5Ey2PYMd2ADg0X9QKpSIaHdinknLgg3wXQ2kYgiDCvJ1CQ57++BSCNbFEgtyTZVct76tHPN29+/0ycOXbI8k2q8xwmdbXH/scIsK4Vq5RjsSRh7MQjT8MhMQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f76jqwvk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f76jqwvk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6238EmUG2148025;
	Tue, 3 Mar 2026 09:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9U2gmJ
	k04jZtTlBKxJFehVeH/R74LYNRxDr5143c7CM=; b=f76jqwvkJu3e2vyG4lGlGJ
	K/8aMRi9OSs1qFxy8UX9Pyyi1KqbhP86i6Qr9RxDdVYPlFibxtnN53hQN1metP3K
	ld0DRkjoG7/8O6S3lgJCVtZLUTUWJKACxSwRBHp45umQ16C9unLmICmACgNKtAwT
	x077THYM/sHDIczflE8UXqzEBk60APtT1WLTF92cxJmP61OMCbG2h25v58X2h4VE
	jsLLYgit7Im2H21Skv/8RB6Mu47hFJmmDBZqVIYdfBeKXCrLo7xNL7dKPt075s/e
	CzvVePpAErsyxtOxEyLZ4ZHNMEYFy2GzGTW40201s1P0VEevQNUC64ixAAoxehdg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjda9x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 09:16:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6235Eeka010335;
	Tue, 3 Mar 2026 09:16:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k1geg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 09:16:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6239FvL244237198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 09:15:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E861C20043;
	Tue,  3 Mar 2026 09:15:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9074720040;
	Tue,  3 Mar 2026 09:15:55 +0000 (GMT)
Received: from [9.111.22.130] (unknown [9.111.22.130])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 09:15:55 +0000 (GMT)
Message-ID: <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>
Date: Tue, 3 Mar 2026 09:15:55 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Douglas Freimuth <freimuth@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
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
 <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a6a6d2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=rVzeq6iDyh4eWtLyzegA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yRrZXVTmB9EbNCzREd2bXzeB1Bg7orDv
X-Proofpoint-GUID: 5uJq-KMg5mrQbXFusCWoZeV0_p4HVrtt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2OCBTYWx0ZWRfXy+cqwaeV6Lp/
 qibZkH5GwFdbbN6wmvrU4lgP77c8lhjE+hrIWFe/VqLAayvpE1nop7il4FyKgGkamPSDJzp/KSf
 CdPvCjNsqOLXg9eYb1KdIQ5sVQc/5ECfgQz/pcw8sAIYEsVa8j2GjDNyCGRvqvps57HXbdit4gL
 nrIVMZiehI/gIbcZKK7RJBObbNz/MM2IqzshAsHeiQeRf81PbMbjAAHNhgKPBXQmJkyrhKhIjAb
 nbSemp/0sj4CFeKuh3KQzv56HrdgXdkiBvAeXNPXYSiPj8gDGPcOlBoOjp0Kkew5JWi3SRJ2PGv
 gqVj37wikKqfzBKO3hJ6vZHkUKJjpMgncZENYnjPOl7bvUT36sT7u/NDsrxrcY55CCOJNf4VP06
 0ocqbUpQp3qqZjDKR3Rxsgbz/G8sbrCJSiKSxsqbM3S/IXjdcN5WW1aQrYRYa9FFyVO2z9R+qSO
 C/RXLNDXWSdgYwxRi6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030068

A quick update on the issue.
Introducing kvm_arch_set_irq_inatomic() appears to make the problem go away on my setup.
That said, this still begs the question: why does irqfd_wakeup behave differently (or poorly) in this scenario compared to the in-atomic IRQ injection path?
Is there a known interaction with workqueues, contexts, or locking that would explain the divergence here?

Observations:
irqfd_wakeup: triggers the problematic behaviour.
Forcing in-atomic IRQ injection (kvm_arch_set_irq_inatomic): issue not observed.

@Peter Zijlstra — Peter, do you have thoughts on how the workqueue scheduling context here could differ enough to cause this regression?
Any pointers on what to trace specifically in irqfd_wakeup and the work item path would be appreciated.
Thanks,
Ciunas Bennett

On 25/02/2026 18:30, Douglas Freimuth wrote:
> 
> Christian, the patch is very close to ready. The last step, I rebased on Master today to pickup the latest changes to interrupt.c. I am building that now and will test for non-SE and SE environments. I have been testing my solution for SE environments for a few weeks and it seems to cover the use cases I have tested.
> 
> 

