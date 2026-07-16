Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E5412C07
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203029; cv=none; b=hDJgrMPOYRksPw5k1GliWxZtxJr98syz9Ghq3FyIOblqxFqm7u0dR1MvE/J3O+9DasCKILsn3SkSIWBVMX5AYYehewj4IIt48NzbCYy+iBlHG2/g38IuNOOUz2tUyKKOCwh7hghTRZGU3M/hjkcpdSgBcUT2JrWDJYE4DM9dxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203029; c=relaxed/simple;
	bh=kcjgYzHQ2udbVwJaCqp2Hqwjv09AzW1l7wO7KdsKUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac/WdxgF9WrAFIPxbRd+ZWACkeUti5cjDFZxerdlnN7jniKOfF7WOGFHDWhkNqvxbYVosfTPLnsiWc8KVJUcGDra3ComIy5K1/R5daA3zll8m1iJ2gGf29w5fuKAJ8L6b1On6OqvgkjyhbS7gSssgfLNkZxOkrl+9iXwK6dgSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T+gmIyEW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T+gmIyEW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GABwYI2910913;
	Thu, 16 Jul 2026 11:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AGXtMw+HwzzAwMk768TRelfDyJc5Qy
	mAdFtZS2nAbyw=; b=T+gmIyEWnUO0Mc7s5xIBX81mySIm8sukmbKrTclkUhK2Qd
	od7kHJJFyXZcej9uvyv70NSrDtWECW0FLyhC7ZmjNb5xczFMccdGF/ekNr6VGe9L
	Z+8UMFne91AXDq5YUeOeezTSui+uC4SGWwrR6kNlbQXPLM7+a3lga1zEuIqkvzLY
	C4nwS8jtwlR1EW5FRBw1mDrW8xgk2gpQfuih2MAvh4SP8TqRos2uDixj/elVidRC
	bSpZ+Clqo+8pCSkhj7BRNzGuoZVoQgCylBUgj1yae+m3Wv08ZrUIb8C+kQFqZr4m
	8snMpYoKrI4V9RzoKZwPe/Oj1ehTAmfbFlwnuoLA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxrkry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:56:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GBnZnL005270;
	Thu, 16 Jul 2026 11:56:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k4sx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:56:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GBusl438535670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 11:56:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 252662004B;
	Thu, 16 Jul 2026 11:56:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05AA20040;
	Thu, 16 Jul 2026 11:56:53 +0000 (GMT)
Received: from osiris (unknown [9.111.27.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Jul 2026 11:56:53 +0000 (GMT)
Date: Thu, 16 Jul 2026 13:56:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Boqun Feng <boqun@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>, Lyude Paul <lyude@redhat.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [boqun:rust-rcu 14/27] rust/helpers/interrupt.c:17:9: warning:
 static function 'arch_local_save_flags' is used in an inline function with
 external linkage
Message-ID: <20260716115652.25491C83-hca@linux.ibm.com>
References: <202607131219.euJHPSJ5-lkp@intel.com>
 <alfbtUKkXANyGyYf@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alfbtUKkXANyGyYf@tardis.local>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4orCvh7Ps8WAunvz7Rt1No978nm8Ndhl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfX5nVQJ+OAFLkg
 aKr2vjuPkarmbtBwBpqfDuG7rKWHMgaj9pnSNhi89VqGzKIAOpVaw/Gi5uI2hjwqZDGv/LRvS3E
 qjFKqb4prbWanaR3XfDd+VhRLlTUqkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfX/TsqNFYlnMKW
 ZnZ+JeY8LenYBcONeK/42ICJYAN2qbmX9YI7SEgELrtrfLm/Tu6eshoSZNiviBOseBPBo8iKKgF
 SuEB+/UI43miFBCBip38EWS4vtj26G84ETKVsraZkAHP2QZ3sPF2bRTX80x5EVV/9bSyN9IR/6l
 cNkC1AEgnrLzw7jEOfDi78ZhSRRFC1VhpEYOv+cjYvhsrUy5aOTsUcxNlF8/smjkFm6cToITzse
 GCT8IhJt4HkGs70SMRvcu+8Fpz33ZY9RF+XfW9zqK1PmeuaHyRmrAzPfGG+4XtbQKUmYOwARlvd
 kmD2e5lhECwdQ8QeTn3kU+PzKXukqGC9DdZhqsLMM5UugNYNAn55u1LBgXKCXw15FjqdgsoF95R
 VX46q8ctEPAuaRkIJmnKcatjauQMzJXG+10Hyysos/ZkhJhGisWK2xOzlNCnK/4EdeqNwJPimE1
 wbz8S/qpPmoDjeaJJHg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58c70b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=BoKzBCvMNuogcYMSMhUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4orCvh7Ps8WAunvz7Rt1No978nm8Ndhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160121

On Wed, Jul 15, 2026 at 12:12:53PM -0700, Boqun Feng wrote:
> [Cc s390]
> >    In file included from rust/helpers/helpers.c:68:
> > >> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
> >    17 |         return irqs_disabled();
> >    |                ^
> >    include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
> >    256 |                 raw_local_save_flags(_flags);           \
> >    |                 ^
> >    include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
> >    184 |                 flags = arch_local_save_flags();        \
> >    |                         ^
> >    rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
> >    15 | __rust_helper bool rust_helper_irqs_disabled(void)
> >    | ^
> >    | static
> >    rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
> >    38 | #define __rust_helper __always_inline
> >    |                       ^
> >    include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
> >    55 | #define __always_inline                 inline __attribute__((__always_inline__))
> >    |                                         ^
> >    include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
> >    235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
> >    |                ^
> >    arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
> >    46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
> >    |                                                ^
> >    1 warning generated.
> >    warning: 1 warning emitted
> > 
> 
> This seems not a Rust-only issue to me, basically you got the warning
> whenever you have an inline function calling irqs_disabled(). I'm a bit
> curious why 1b301f5f28ba ("s390/irqflags: do not instrument
> arch_local_irq_*() with KMSAN") wanted to add noinline when KMSAN=y, all
> you need is noinstr, no?

While the combination of __always_inline and noinstr _seems_ to work
with clang, this looks just wrong to me. I guess we really would need
a (single) out-of-line variant of the affected functions in question
for KMSAN.

Ilya, since that was your commit, does that sound sane?
