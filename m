Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C933EF;
	Fri, 22 May 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441504; cv=none; b=Xm0Dr7if4ursxTAvfZrJXE0p2GSt34Vb1yXZSdKDUSSMNp17hER3L/yV+KusMlSjkBlGlxdTcoXpML79WhPfo4wz/VIB6trkt5T5PRVrzl/fQ1200+oZHH5/a4J6BZ6EG8Wtow3RMuJeskv+JeQqDfAzQHOda2XhhzkVdwk+QcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441504; c=relaxed/simple;
	bh=GtUkxXLgwb3sHBb+Ph9Hu6hPMaLAduwzeoTJ467rPp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv0ER+6ykIPMzyW/WamQ8ini7HfYxeJbeI4KN0deOH6F5mLdK8xe3/oRnchrZk7Fc7a+8CvIL75TIvkYGvVOayMGZUJ9JiGJMMaEOdiwsP8oNlBIVeQrcr15vqSbhvkR0wkqAbhbjXMEqjDAqYPqWcTGri9aObOhuay7rnFiKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SEibAUc7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SEibAUc7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4WkMU3417833;
	Fri, 22 May 2026 09:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZziwNd
	nS9eWPsVzicJCOBN5Wp4TXBgUxypyXbtk3f2E=; b=SEibAUc793Lqba3n9iTSgc
	zVKT8WwxRp7QsamN9zNqfXZlp70DWQFQG4C815pxXUS/YkCYZHdqLu10yDcBbUZa
	D/+9a/6uacqJBACeDXPmD7/iw8WR5p3NjdIyyPc/590tKgYLRZmR8utVtXdPqIep
	RKF4MlykX52n/05e8TLwsb/R6rEoC8dnf4IrqlUS+fBqMZnMBx2o93gIei4lk4nN
	PPPiIt/ef90mX3qUzNCm8pomQPRJBsdFqn7XQ79AcwirAclRKwKrmU9HRQtm0odI
	GjKPwp1/G38ikI7I9hrTPQ1++U4vxLQPPjkSFSN6sgiW5++ma4OaDhdx3zBLY8gA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8srm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:18:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M99E9W013761;
	Fri, 22 May 2026 09:18:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gr1t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:18:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M9I8Jv51511702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 09:18:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1747520049;
	Fri, 22 May 2026 09:18:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A3B20040;
	Fri, 22 May 2026 09:18:07 +0000 (GMT)
Received: from osiris (unknown [9.111.44.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 May 2026 09:18:07 +0000 (GMT)
Date: Fri, 22 May 2026 11:18:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260522091805.18098A5c-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
 <20260520233409.0683f595@pumpkin>
 <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
 <20260521103742.9603C8c-hca@linux.ibm.com>
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MCBTYWx0ZWRfX75bwWESkOfFL
 8BkKAXVHdtpeusnhhjuNmyQMja6dO38xeTeT+KzjmGDOiMwGlG+w54OUrPExkJtjH+eQ+XxtXvt
 T3Gs7jqqA0eKcJh8D9hcybM4ko05YhMmsyQZD5T90HLZy/3Ntd2+G0tUMt51lP1aA/wSCzyazhL
 uihFv6XGsPovB7zu4pk25cVsYgx6UaBaIR/V3HST3sXQmT3N2nMoYTOBbO3nrFfDJAr+O/T579o
 S9bn1lhHeZUvQ/GqaCh8JnmYD84HH+LI70UfMvPWrbqjHQvcM7caYLNhVu1VMaXUQTrVQ5112Rb
 c8aI5LFBtq71kYGUcpPIjlyqnCCurjoEirrRQSoKyrF2M+ttcePWNIQg7H5BItqCeGqP8qEYmVN
 /iOg79MiVQ6fMrLQoh871onL7NFviIaGHgvWEfPuNnltyu+hj+A3ez7dS+2KxV0zYVNKABNOVUM
 LJ57mZkOvDTDWxzkJ5Q==
X-Proofpoint-GUID: oVmPhIzppPdxSed7dosIKtQSp-RAZC2S
X-Proofpoint-ORIG-GUID: xRLni5UWo0i-pcmPML8ESbRs5eVa3E2r
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a101f54 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GGpo01_-K8tlNGQ1G2MA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220090

On Thu, May 21, 2026 at 10:47:49AM -0700, Yang Shi wrote:
> > As background: s390 has so called prefix pages; the first two pages of every
> > CPU are percpu, via a special prefixing mechanism. Parts of the pages can be
> > used by operating systems as percpu data area, which we use to have fast
> > access to e.g. the 'current' pointer, the pid, percpu_offset of the current
> > cpu, etc.
> > 
> > Helpful is also that for instructions which access memory with a base register
> > zero, its contents are assumed to be zero for address generation by the
> > hardware, regardless of its real contents. That is, the above
> > 
> >          ag %r4,952
> > 
> > is the short version of
> > 
> >          ag %r4,952(%r0)
> > 
> > The eight bytes at offset 952 of the current CPU's prefix page are added to
> > register 4. Real contents of register 0 are irrelevant for such address
> > generations; reducing register pressure.
> 
> Aha, I see. So the prefix pages are some special memory?

No, it is regular memory. The CPU has a special "prefix register". If
that is set to an address not equal to zero all memory accesses to the
first two pages will be transparently redirected to the 8k memory area
specified with that register.

E.g. the prefix register contains the value 0x10000. If then a memory
access to address 0x400 happens the CPU will transparently turn that
into a memory access to address 0x10400. Or in other words, that is a
small per cpu memory area mechanism provided by the architecture.

> > >    11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
> > >    11a8ec:       b9 04 00 43             lgr     %r4,%r3
> > >    11a8f0:       eb 00 43 c0 00 52       mviy    960,4
> > >    11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
> > >    11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
> > >    11a902:       eb 00 03 c0 00 52       mviy    960,0
> > >    11a908:       b9 08 00 25             agr     %r2,%r5
> > >    11a90c        07 fe                   br      %r14

...

> > > 11a920 loads 0 to the register to mark the percpu code section end, this is
> > > not needed with percpu page table.
> > I guess you meant 11a902. But yes, this marks the end of the percpu code
> > section. Just that this is not a register, but a memory location where is
> > written to.
> 
> So both mviy instructions actually do memory store?

Yes.

> > > It sounds a little bit hacky to me TBH and incur some extra overhead for
> > > "migration detection" and fixup.
> > Sure, it is hacky, and the small overhead part is of course true.
> > 
> > Compared to the percpu page table proposal the two mviy instructions above
> > would go away, as well as the extra interrupt/exception overhead. Besides
> > that your proposal is way less hacky.
> 
> It would be great if we can compare the performance number for the two
> approaches. rseq has been discussed for ARM64, but it seems too expensive
> and just move the overhead to somewhere else.

I tried to implement the proposed rseq/kseq, but the required inline
assemblies resulted in code which was larger than what we have now for
s390.

Also with the current proposal I only did some quick micro benchmarks,
which resulted in 0-1% improvement, which is in the expected range.

It is amazing to see the performance improvements you see on arm64, however
I believe that is mainly because of the large amount of code which is
generated by the arm64 implementations of the preempt primitives
__preempt_count_add() and __preempt_count_dec_and_test().

That's a big difference to s390: for both primitives the result is a single
instruction.
