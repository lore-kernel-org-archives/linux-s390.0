Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698630E82E;
	Wed, 27 May 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889089; cv=none; b=MjFF+qGsBRcL0VaknlXvGn7GoEwR2xwH/pIxuNeZkRLI4vAnfZb+5GNc2eXTfZ7dLSNq4oD5eXCIyPw6uacyulWBiyhZjamdTkR9LkCsc9baMXW0n9JapY3Ynts+CHcz4Ikp+b3e5z0x8qc42e5BL3jG+rkYzoq9oqhikuJWlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889089; c=relaxed/simple;
	bh=kVLOQFb6dYbdzoXZTOYcrHQLFpyCaZxMpWjCCioNszE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InJKkJXozq3SmEZUhLnEbOPuvxxcwdOP/rAeJvtlW9KFuVrR6ZwkuVFNO9Ov7lpS9aIhuc03AnqIt23ODi7u1FJhXET/WTdCvk2RihO7BYEfS0TNLb7iGvO4W9n0UsoMyyIkD7DYYR6BGxU62xq1AWgexiEm7sDCJHiww/A9Ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SaceMvkK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaceMvkK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RDTo4r3850858;
	Wed, 27 May 2026 13:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0QpQbM
	hvFIgvU13hb+Q9NYVATx60HmpJCTfDGJsbFBY=; b=SaceMvkK+3Pu5pRTRoaIlL
	V+j/Xbzxjs5LX2RYoFap7adn3oRtExLOwdHcshh9v3P4hxUZQiuzC5mZwcNM/Afk
	p/CToVy1uRSvJcZp/36Uz3Yj2Wr4lNnTg3UksTZ4AiIud7CkjMaM2K9FcLHU5csr
	Q9R8Pd+LtLfZDXPuBXcRYLg2kr7B0tQjGVaoSJgHicrbLhjrad9OtZw9JZRqV46a
	ELYufGCgIWJ70Y/CmQYIQtRUYkB3JOy094YiNl3zY08Yxf799po57YM52UjSSU5R
	qTApAJon5EiQ6109iC3ZfU31TRE+tJBkAVZlJ2a7IENI28ibma8I6ilg0ThY8uqg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdgbg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:37:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RDO8cV004300;
	Wed, 27 May 2026 13:37:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb370s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 13:37:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RDbc4u51970346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 13:37:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFE820043;
	Wed, 27 May 2026 13:37:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A80CE20040;
	Wed, 27 May 2026 13:37:37 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 13:37:37 +0000 (GMT)
Date: Wed, 27 May 2026 15:37:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Boqun Feng <boqun@kernel.org>, Jan Polensky <japo@linux.ibm.com>,
        gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
Message-ID: <20260527133736.9471B16-hca@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <DITFTAVVHTNQ.380OHUHGTOI6M@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DITFTAVVHTNQ.380OHUHGTOI6M@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a16f3a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3ML_DYOZ7-uCvVHPyScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qmp0ME933gV7gpQKo0nhnEr8qHaewiML
X-Proofpoint-ORIG-GUID: yAsi79U5fKeomIm390jDyXdZ2GYfwCKu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzMyBTYWx0ZWRfXxfQSskk9o1n9
 BJBTNVGDYsL4uCIXsN520y5KWIz6JuoXLRRo1Aagyn2Xd2M+cwHhXWqo1V8lX2Rehzx1Ai5c+nk
 yZoCoZrnPab8YXlK9RjExuqmdQe5UOlAKnkzaxv7GNjr/F34D77Ogbb8Al7/Tft/UwoZk/Vw30B
 lkKKnPXKdUojj3J4vhfKBMWw5EcVk+qC2dgEuyi9WWi6xnrzRX4kPal+cGf5fgOt/oeHf4uskmD
 RWGJwO0z+HSs1NlA+JSTxQNyhoRqZaJEWo9JJp2rol6V9fxw9DxTn+qRmv+Vc85tD2ggAxmfLIV
 uMnwhCQmInOeDUL47XRSe3lXfWclPaPFTTPtAGNSbr+UjVHdlWebdOyX1nFZVuUfsMHfkjr7XVs
 hkHmuv6HfqIV0LI0jXuSkGiuRjyHFMb9KRqNDHw3NlElBitmed2oXRk371va0oOlYdwuKO3pl+i
 323heGHLPi96kLOW3zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270133

On Wed, May 27, 2026 at 12:54:13PM +0100, Gary Guo wrote:
> On Wed May 27, 2026 at 11:08 AM BST, Miguel Ojeda wrote:
> > On Tue, May 26, 2026 at 6:13 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> > I also found a couple bits: in a KASAN build, I got [1] -- Cc'ing
> > Boqun in case he is interested:
> >
> >   [    5.323670] ok 5 rust_allocator
> >   [    5.324134]     KTAP version 1
> >   [    5.324194]     # Subtest: rust_atomics
> >   [    5.324251]     # speed: normal
> >   [    5.324367]     1..8
> >   [    5.332184]     # atomic_basic_tests.speed: normal
> >   [    5.332356]     ok 1 atomic_basic_tests
> >   [    5.340797]     # atomic_acquire_release_tests.speed: normal
> >   [    5.341054]     ok 2 atomic_acquire_release_tests
> >   [    5.344127]
> > ==================================================================
> >   [    5.344584] BUG: KASAN: stack-out-of-bounds in
> > rust_helper_atomic_i8_xchg+0xb2/0xc0
> >   [    5.345283] Read of size 4 at addr 001bff7ffdbefcf0 by task
> > kunit_try_catch/142
> >   [    5.345493]
> >   [    5.346499] CPU: 2 UID: 0 PID: 142 Comm: kunit_try_catch Tainted:
> > G                 N  7.1.0-rc4-00009-g60c6b4b89923 #10 PREEMPTLAZY
> >   [    5.347065] Tainted: [N]=TEST
> >   [    5.347124] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> >   [    5.347323] Call Trace:
> >   [    5.347408]  [<001bfffffcb9c6b0>] dump_stack_lvl+0x80/0xa0
> >   [    5.347663]  [<001bfffffcb90846>] print_report+0xd6/0x310
> >   [    5.347784]  [<001bfffffd596e08>] kasan_report+0xe8/0x110
> >   [    5.347895]  [<001bfffffde5a042>] rust_helper_atomic_i8_xchg+0xb2/0xc0
> >   [    5.347983]  [<001bfffffde917fe>]
> > _RNvNtNtNtNtCseBLeUu9QniM_6kernel4sync6atomic9predefine5tests36kunit_rust_wrapper_atomic_xchg_tests+0x5be/0x4f90
> >   [    5.348088]  [<001bfffffdf59e50>] kunit_try_run_case+0x150/0x3d0
> >   [    5.348194]  [<001bfffffdf60500>]
> > kunit_generic_run_threadfn_adapter+0x90/0x130
> >   [    5.348257]  [<001bfffffccf9fde>] kthread+0x33e/0x410
> >   [    5.348309]  [<001bfffffcba122e>] __ret_from_fork+0x9e/0x3c0
> >   [    5.348357]  [<001bfffffec96faa>] ret_from_fork+0xa/0x30
> 
> The issue looks like an incorrect implementation of __arch_xchg1 and
> __arch_xchg2 for s390. The `READ_ONCE` (and subsequent cmpxchg) causes a 4-byte
> operations when only 1-byte can be touched.
> 
> The functions should either be re-implemented in assembly, or be marked as
> __no_sanitize_or_inline.

I wouldn't call the implementation incorrect; due to lack of native 1- and
2-byte cmpxchg instructions those have to be emulated with the 4-byte variant.

So yes, the fix seems to be to mark those variants of __arch_xchg() and
__arch_cmpxchg() __no_sanitize_or_inline. But that's up to Jan :)
