Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79648820D;
	Wed,  2 Sep 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360810; cv=none; b=FDUR5Q6HDlImKgnW0cpTQoCK3zWSeNr4zfa49uxcGHOqZYk2KQpZYWm3kEiKqjbnhEuwcX8IJmKUpak4fsXYIie370xRqTPqX3SBVD+UAl/yjPmfHzp4uZ3P2LoxRIX3+5xxrSB043GvIxMQgsatEagZ48L7R3eE8XIIhImDLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360810; c=relaxed/simple;
	bh=QZNlpbHzqGu67GTCDPymcI6jZrf5t3k7ROAW5RILhNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrjKMG9W32XexygUnXGVfrPff/RVR9GJP2IwoD+sURfd5H2RXhW9vhR8BeSe9PI3ojXBSO8l0/XIPyMJtMqvkw1xS4tONCeYgf2XgJ/rfBCNEeWiHZ59oJJWEDtYNoA+OV6BxWzh0W3GuHv8yRCsw2XvIiYxUbpMjJiKAVlsX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyN2hMe/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyN2hMe/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVtfI046984;
	Wed, 2 Sep 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Xs7Mu
	6jnbGPV8UltG0ZSUs2j/TcJCLYMEpH07v+Iqg=; b=LyN2hMe/qpHb7dbgo09vaj
	SlxO3cdJTT7yP2mv5NsUrAjIozgf5npqbpuUgh+oxFUJU9HLQ9LNI+IZpMJiFOKr
	aX8ThXG7vof+Ek2qbKODtAfzH0Bo1AI2hJk7UNFLX+tiIgMeCM4ZS3xHpRIUJKvd
	jhGg/ThNd7hKooVJUQ3MzaxSQZzkQnK8NlF63wKMR16Ssx+6kf7RKUMpC34BgcHN
	RkDkGXWx5SyRRmaCU1AXQYfG2+I/YZSTi5YlCLCdB/2luX9HKEC0pZ1/sFSjJT4S
	GT0aRB6qlapVWLb2ZcBbkQ2IbjhpeKy/soejKhXo074OFxwGo5nimWbgjsAOSstQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tevgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:53:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EfIQS020342;
	Wed, 2 Sep 2026 14:53:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hjcgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:53:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682ErIgo42729956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:53:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FF3520043;
	Wed,  2 Sep 2026 14:53:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CABF720040;
	Wed,  2 Sep 2026 14:53:17 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  2 Sep 2026 14:53:17 +0000 (GMT)
Date: Wed, 2 Sep 2026 16:53:15 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <20260902165315.06996af6@p-imbrenda>
In-Reply-To: <apghz4XAgv0ro15t@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
	<20260902130612.41500808@p-imbrenda>
	<apghz4XAgv0ro15t@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a983862 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=iT-jVQeAxx133_sytAwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX3r5DrU+hPIcW
 +R/pcZv/kteCuUDX2LkaT6ApUjlBhLWtyovKwsaAQQoCGwbvcZDWmqnSSXphaVBMLn8tgVmCh0y
 RJBe5VAU3V5bEOioIpfs67jwI44Qu2A=
X-Proofpoint-ORIG-GUID: MZWJC2roP1BPdcqri1p0hvQ2eJSxf6mS
X-Proofpoint-GUID: MZWJC2roP1BPdcqri1p0hvQ2eJSxf6mS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX1jzB8OFQsNHP
 mjQXWPCaYr4kLevRUJ8A0C4QPOmEvs9DcOwbiDUAF0tIAMgGJnPR2eEmVCRJxzJBTsTBr7wyr95
 7s7iCuKdY4BcRNmF4dGL/yskgrL3qLP9Q5e5TjuiXzmleig4QBjQYjALbQer+FpVG/7uC6tc/ku
 UWodck2j3oE5uQ2t9eDlyw6guvf1fwL0H055vP1eV+PEc+vR/bvnS3ZEgqGiRn9ijCL4Xb226Sv
 ohoO/C6W5QBjLbf2e008GPpsDo7+y7A53ldHa+e5tiaFJSDdy6YwvR7nvYzJr4SsfFw8SUXC14+
 Pc3z3rM4FttqIc42CCCQWiV/XYeQ8+VBYa5ATVkR1z/HOy+xmhYacFkQB80BpTeyMO5qyaEzYtg
 w2rKsi85ctxTEqGCCi6jlMgo4XoWg6AF5PZq8VgJ4dKBYrbUCm/qqWkq3fiKoIkFgIetVSx55cm
 e5ua7KLfza1fnn7nOJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

On Wed, 2 Sep 2026 16:17:03 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Wed, Sep 02, 2026 at 01:06:12PM +0200, Claudio Imbrenda wrote:
> > On Wed, 02 Sep 2026 09:15:12 +0300
> > "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> >   
> > > This is a (small) part of larger work of replacing page allocator calls
> > > with kmalloc.
> > > 
> > > My initial intention a few month ago was to remove ugly casts [1], but then
> > > willy pointed out that Linus objected to something like this [2] and it
> > > looks like more than a decade old technical debt.
> > > 
> > > Largely, anything that doesn't need struct page (or a memdesc in the
> > > future) should just use kmalloc() or kvmalloc() to allocate memory.
> > > kmalloc() guarantees alignment, physical contiguity and working
> > > virt_to_phys() and beside nicer API that returns void * on alloc and
> > > doesn't require to know the allocation size on free, kmalloc() provides
> > > better debugging capabilities than page allocator.
> > > 
> > > Another thing is that touching these allocation sites gives the reviewers
> > > opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> > > another size is appropriate.
> > > 
> > > For larger allocations that don't need physically contiguous memory
> > > kvmalloc() can be a better option that __get_free_pages() because under
> > > memory pressure it's is easier to allocate several order-0 pages than a
> > > physically contiguous chunk with the same number of pages.
> > > 
> > > And last, but not least, removing needless calls to page allocator should
> > > help with memdesc (aka project folio) conversion. There will be way less
> > > places to audit to see if the user was actually using struct page.  
> > 
> > I have some objections to this series, but not because of what you are
> > trying to do (which is actually nice).
> > 
> > I understand that you probably wanted to touch as little code as
> > possible,  
> 
> Yep :)
> 
> > but now since you're rewriting the allocations to use
> > kmalloc.... I'd like them to be converted to use the __free(kvmalloc)  
> 
> You mean __free(kfree)? Sure, I can look into it.

yep :)

> 
> > system. It will make the code smaller, easier to read and understand,
> > less prone to future errors, etc.
> > 
> > In some places the whole code flow can be simplified a lot.  
> 

