Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCD3D4130;
	Wed, 25 Feb 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037257; cv=none; b=llaJzPWmv89oYz7FLZuVYN/I5qegFJypuDl4RTfmFEA8sMpgehs3xy+G8LuqC2yKrSrwpoyaHzm2U74LhHW6fpgNTDV1L/FJnATo6HlHJh5UwVjul5lfbL23T/CnZyDaZmTmIdX5Pdb/mSzQPgk2Imyh97iFgq+VQi8rKG2Cf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037257; c=relaxed/simple;
	bh=BuPpzU2Nm3plTuenq90o+rwVvZqFkD2fENtwM+9OBJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip5Mb9UiBVMRMMApCxAobzwdj99A2IINqiq9sA8f67Gr1bD4jm5tQs8p7Ki8Jom19dAl9tJ9Wyuimt9ZJV+sN+sQZD3KnqxqF94D0zYLquhrLulFQh9N3uG8jVql/SZVBdf6ztMg0cJIviM6pXoCfvD180WmSFYWInG6GKBw+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/mvk8v/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/mvk8v/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PFWdDD3390406;
	Wed, 25 Feb 2026 16:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ghQx12
	tzZR240553HTc14VsOQxWrW7/HCl8J94RRd6g=; b=n/mvk8v/LvGM2KzeULhDHe
	JnPcUIeCxDsUrVce8Ac9HhQRAF2c4vrgcJimRk7me061OaWqUow3m0qCcjrzh34X
	PTDUEFDdhkpmqKTW0HEaIbprkOmttO/8gO19anmItDZh0hdj6IzKnOCWZUAsMd4R
	lkJD8QhyiEuocsf6THbT5FymDBaQJPSHiPbmugY9rVshg/QDulmjycKeN2g4xKLt
	EkJOlmO4+H9nhXn/IJ0FTCkmGhWfc5is1BLbi6RXk5fVvtGzCuyoCW2DyFQtb/6D
	wXzpVdEG4Y9YMNS0259xxtsRIRVhoXwHivsX2tSvdecFtUsBUXNOyHMjL/NOljMw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf47218ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 16:33:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PE2JOm027887;
	Wed, 25 Feb 2026 16:33:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1wuxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 16:33:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PGXYeM29688218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 16:33:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF8142004B;
	Wed, 25 Feb 2026 16:33:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8244D20040;
	Wed, 25 Feb 2026 16:33:32 +0000 (GMT)
Received: from [9.57.233.77] (unknown [9.57.233.77])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 16:33:32 +0000 (GMT)
Message-ID: <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
Date: Wed, 25 Feb 2026 11:33:31 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Ilya Leoshkevich <iii@linux.ibm.com>,
        Ciunas Bennett <ciunas@linux.ibm.com>,
        Peter Zijlstra
 <peterz@infradead.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, Douglas Freimuth <freimuth@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Jfh7EpHEygh8w8jW0O2VLecuoOEBQ4M4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1NSBTYWx0ZWRfXwcrDQp8Tsqdj
 cfc9eaQxVRiR1uHKNVFQEAmfHTBMEAb1TdQe8IndsLk1JpYXkbmD4JXByPQn6PVQFg6HgcQip8G
 VpUOjdgRh9hTTnKtQ6aH0nujHc5NsZUpiJLVSgWr8NOvStxR3OazgxIBEP0ldxRiGr3dsUC/oO3
 tFHMjp43xFO16ccs/BULesRvVIJoF9CepehNhQtHLrhrOawKWFW2yqCMPG7A0I9W27mKb/yXKPp
 zRw6ULmiL+hjyoFD7AYmTRUkhpFre2N0AcnPSmWPV0ptBInD91vziySDQ5S6hDjGflVgIrkzx4l
 IMKSzy3mIEiG1HuHHIoRWzGMBHAcgEjbIoKKJNEqiNUNaCaRl0vhR14DYIxEOKRDf5kmMlKuLzq
 f4Rwvk/XkBRuLxzJD2Zc67UltzFscScdQMLF6SzrDnJAEDN8XZt1gBWWWH12DlM8o6Hwfwuzi5w
 TeEXH/B4uf+fD1UZcbg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f2464 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=bkn2mIghrU8GsfLpAlsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HqLlew1xnvvr9pOSEmkxZGAeHmrI8HDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250155

Am 24.02.26 um 21:30 schrieb Ilya Leoshkevich:
> Finally, what is the worker doing? I looked at __queue_work() kstacks, and they all come from irqfd_wakeup().
> 
> irqfd_wakeup() calls arch-specific kvm_arch_set_irq_inatomic(), which is implemented on x86 and not implemented on s390.
> 
> 
> This may explain why we on s390 are the first to see this.
> 
> 
> Christian, do you think if it would make sense to implement kvm_arch_set_irq_inatomic() on s390?

So in fact Doug is working on that at the moment. There are some corner
cases where we had concerns as we have to pin the guest pages holding
the interrupt bits. This was secure execution, I need to followup if
we have already solved those cases. But we can try if the current patch
will help this particular problem.

If yes, then we can try to speed up the work on this.

Christian
