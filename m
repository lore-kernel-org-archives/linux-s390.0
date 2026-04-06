Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A984386439;
	Mon,  6 Apr 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492123; cv=none; b=FgCBm6VfcWGe98eciraPtlMenKEg4KmmQjdU1Gzj/7u3gCa0fMBXLp5IfawMrM1uC8UVEs6UkXRMzSFd/VD/3Oym1kqDoL7ivEA6tO1OpuC+IxIeudRkaFxvandG2JZdSR7xrMFvdzg+4D8+ZwT2WoIW77AB35FYQsndk+kmV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492123; c=relaxed/simple;
	bh=qO1wsHI3zJF3G8Crb+tvY3nmdS1d+EiYiVCTx8QfSJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oin6ohg5ZswWuCchMZHuj4h2zYY0hzTp0548ITudzpLKahYYUQZVsQMc8+ke2SRCmsAQZea1V2s+pkyp6itUUGiDkFrTFbWzWlUo8k6ff6TiKHqZ9wKoPUI9RbIuyx+GDWxMLZGJBBChN4PPKXeV6WhJOgdw5Z78Y8xm5oqAexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mf6Da5Fi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mf6Da5Fi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636FqVLH3623154;
	Mon, 6 Apr 2026 16:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9uWnM1
	R7+lLVXwLn2w3j9CmT3eXTVmgiof2uaPTVWt0=; b=mf6Da5Fi9lRQnEVCRMU1nb
	LHvWQQqd5V3eGUW7RsqGq6pgjdqNiDfYcYmC9J4sNVwWeFs8tb6iMLBzpOHlzcTY
	mvrJbZUOAGi4pPP0LmcdVt4zJ4gdRRGkrvRIYWcjdW8wnsbHtEIjTLMxpNlo3oMW
	7Vq55CNTw/5vVXFVsuOtYIf8ovNRJUysq/PprkE4iWnpsj+9pFChjChz1Onuqpdd
	9+fr4Ro49AD52EZDTCt37TmLd6y2d/r3xKR6iUUPGHitd5sKL4XAmqwUUNRKb47O
	DN7HdF4s9UKlQEVbRLwuxG777mXOQw9gx7cib9tMfATxmvKq1Bxt0qsa9SX4jXfg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bxxcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 16:15:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636F89uA018525;
	Mon, 6 Apr 2026 16:15:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcyswfj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 16:15:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636GFAxR13042228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 16:15:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7938158057;
	Mon,  6 Apr 2026 16:15:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D4358058;
	Mon,  6 Apr 2026 16:15:09 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 16:15:09 +0000 (GMT)
Message-ID: <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
Date: Mon, 6 Apr 2026 12:15:09 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-4-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260406064419.14384-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t5nOTwMUGQrFfhoxVVVSLz9vQ9T0yR96
X-Proofpoint-GUID: t5nOTwMUGQrFfhoxVVVSLz9vQ9T0yR96
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d3dc11 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=kKUgNAbpS4blpuYazJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1NiBTYWx0ZWRfX1E3F+FX6SGnY
 GNbdsRnKWG77YBz+NJRBwmfzeiLlbQIlBGHocA6CdQJ6cYV9gHj0IEYTy3je3+FoEGOh0LaKFJl
 A/orqiy1tYQafoL6s+Y0JlHJw2jvfjDCPwikn7eaN6PQnG/deNaorlIFzuomcuszkUcHmAGL9i0
 CgFQ2uEG3PCKJjg/iBUKA6P9WpGFbBUKmdtMb0rhkXqtGeFqdL1VqlAZmNAnOKYPwIL9lqT9Vh/
 6wgUjBtuTfpyxaPiOd+jwRl0IKs6B7oipeq7fk7sCMOctWbfSeq5repxY7e1lH8Prz7uxmu/jWE
 pJ8lSiWxtaqJgkGqjwkm+YJYJbGDwCvgkFslhhc0XE9kG3AvZTsdvSVs26habUBoDyY/6nN4k8d
 mgXlteB0M3LAko/iPJv3oTWxf3igQ2/5atY63fpzBFPVp9NQttC0S9vm/u55fVjV+cj96D5L4vv
 aBaVIYd0jlIa6DR37DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060156

On 4/6/26 2:44 AM, Douglas Freimuth wrote:
> S390 needs a fast path for irq injection, and along those lines we 
> introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> the global work queue as it does today, this patch provides a fast path for
> irq injection.
> 
> The inatomic fast path cannot lose control since it is running with
> interrupts disabled. This meant making the following changes that exist on 
> the slow path today. First, the adapter_indicators page needs to be mapped
> since it is accessed with interrupts disabled, so we added map/unmap
> functions. Second, access to shared resources between the fast and slow 
> paths needed to be changed from mutex and semaphores to spin_lock's.
> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> these enhancements were required to prevent blocking on the fast inject
> path.
> 
> Fencing of Fast Inject in Secure Execution environments is enabled in the
> patch series by not mapping adapter indicator pages. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> io_set_adapter_int and io_390_inatomic_adapter_masked.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>


Sashiko complains about PREEMPT_RT kernels and spinlocks being sleepable
in this case which would break the whole point of kvm_arch_set_irq_inatomic.

I suspect actually the kvm_arch_set_irq_inatomic() call itself shouldn't
be used in this case, or in other words it wouldn't be an issue with
just this s390 implementation but rather all of arch implementations?

I did not try enabling it and running a test, but I did do some
searching of the codebase and I can found at least 1 spinlock acquired
somewhere along the inatomic path for the existing implementations...

longarch (pch_pic_set_irq)
arm64 (vgic_its_inject_cached_translation)
powerpc (icp_deliver_irq)
riscv (kvm_riscv_aia_aplic_inject)

For x86 I didn't find a spinlock -- maybe I didn't look hard enough! --
but I did find a path that uses RCU (kvm_irq_delivery_to_apic_fast)
which AFAIU would also become preemptible under PREEMPT_RT.

So for this series it seems reasonable to me to proceed as-is, with an
open question whether there should be a KVM-wide avoidance of
kvm_arch_set_irq_inatomic() under PREEMPT_RT?
