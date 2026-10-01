Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6E327C08;
	Thu,  1 Oct 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841668; cv=none; b=AVA3F3KXv++hz7CD8K1NyZ9SYMcUSFWFXuGD8QbB2AVzFKz7DieP4m46hVWSO6lBOBtEX+RhscrhjC0bwveKn4xYQxOfZWDwpCh8+j+ufwX3y3J86Xz1N8rFdxyNIMgX8B9JAxOD972m1NedUmx9EIYqCAxuFGiOGL3YUlyWpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841668; c=relaxed/simple;
	bh=EYHi4g1akhjQcrRiixtJasq3p1fNPiPMkObrWuXs8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1VcgKoIEP8EFfOTIPHZHbWMFwZp5dmNkm7XSltbGUwpxUX/rqWgq/pSP/ut5y3DWJ8CaQIcAnGUZvx37upnMaxfLRgFp37oQCgd/5tpZDNrdn/Ou+o1S7fIP5CWT53KI5+ptyZpUvuUDNCa/ye7UieDp5vaXVc1OK5iaI/GQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WvUyfFJK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WvUyfFJK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Xug3446209;
	Thu, 1 Oct 2026 08:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+MTva56L4+MD5F+jwR8XlVy8f0pKRk
	7aCi8mRoUiY0w=; b=WvUyfFJKFW0VDbmrHYWDGwwFB5wCgoN9X0fs973me+S9S/
	qthidMoseVBJmpR0BdS1VeLZVJ6mLBBhJwl/if+/uPekWefVnZrw5Q0SYNjIC6TD
	DN7UJKAPEb6k3e3SaGJ0pn5SOXJ4IvIZ76riKCaY1N/bBoWvSXAsqB5/Qp7sK3ui
	l59XkNk4tagBBnhULN4Py4TXgiQf7MAnzZ4aogTM//GfSPhBRkyQBK4uobAjGSoe
	5VrqKa7Xv16W6OQtDtIF+waFmr6mINPX9WDA5wbr5sDCSTEPoZ4Zdw+DsReQkoR2
	oDHz6YDwpRoFF3lscoNgGtD2fChqbtyizG3x8QZA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrhxbc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:01:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172VwZ520704;
	Thu, 1 Oct 2026 08:01:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpfrvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:01:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69180uNQ38797662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 08:00:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E072120043;
	Thu,  1 Oct 2026 08:00:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D6D520040;
	Thu,  1 Oct 2026 08:00:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.54.207])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 08:00:56 +0000 (GMT)
Date: Thu, 1 Oct 2026 10:00:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <b66a61a4-a532-44ba-a1c6-26f02193fb05-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824104048.11040Cdc-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX6YkfKWEpBcwQ
 N2xtb1Zed75UiX/0yLNPdPQE96ozCdqKrFZHX/6ymzjryvv/daZNPMdeaQnxgFwHnckyHhm3NOa
 Qv9LHLuGwBZ238IfOmW9PKzH7M4ZVNn0MnBYRrMckVVE8mL/aYMKH4LXagsu5wi5Q6izOYdBQnd
 P1AuYkstpiJGwkTpkfHfF+F2TeXPrfjupHcu0t1ch9SLsw81nFLMmNPkq9BlsILeuoG51t/y6S2
 j1hEBQo4HLq9NAWedmxUKmzWctC8gJzsf/Dam3pjWBRmBrKPwnBFyf+1yY73IInOAFsetjMG0hn
 MUiEr6JISkKZuUZA1uTdpDKMnK1Zcf9Vx7BexLsIjgN8pKlIJlBqQXosKSVQ4aPyszalJYMO/aF
 8wzcOHl+ce6RRq+wqykxuNdoIokl6NjqXhVRs+HrVJr0iaBGjrNAQbGNlcS+kDkY+dGbuY/oGPS
 +YiLDdFYJORXuPr2o+w==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe133e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=m8Li7VA48kL__Rn2agMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TK7xsE2_XFdNWioSpWUiuMdbLcLFSrY1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfXxyXQgnjU9D0X
 tHuY+PHhFc0+n146WPgAoCn5CXGMkEz1Xcon9MFTMa/vr85rvUu+TYqhuXHR0vgHIurZX6X4FGL
 H+EpDwZzW7oLW3wfVHrtJk35nIoyOqo=
X-Proofpoint-GUID: snOW1WwzWZreqGa1tdD562TZ2vVp2wdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010030

On Mon, Aug 24, 2026 at 12:40:48PM +0200, Heiko Carstens wrote:
> > +static __always_inline bool is_lazy_mmu_active(void)
> > +{
> > +	if (__is_defined(__DECOMPRESSOR))
> > +		return false;
> > +	if (!get_lowcore()->lazy_mmu_count)
> > +		return false;
> 
> I guess there is opportunity to generate better code here using an
> alternative and using a flag output constraint too.

It is only CY and LT instructions that make sense for me.
Here is what I came up with:

 static __always_inline bool is_lazy_mmu_active(void)
 {
	unsigned long lc_lazy_mmu_count;
	int cc;

 	if (__is_defined(__DECOMPRESSOR))
 		return false;
	lc_lazy_mmu_count = offsetof(struct lowcore, lazy_mmu_count);
	asm_inline(
		ALTERNATIVE("	cy	%[zero],%[offzero](%%r0)\n",
			    "	cy	%[zero],%[offalt](%%r0)\n",
			    ALT_FEATURE(MFEATURE_LOWCORE))
		CC_IPM(cc)
		: CC_OUT(cc, cc)
		: [offzero] "i" (lc_lazy_mmu_count),
		  [offalt] "i" (lc_lazy_mmu_count + LOWCORE_ALT_ADDRESS),
		  [zero] "d" (0), "m" (((struct lowcore *)0)->lazy_mmu_count)
		: CC_CLOBBER);
	return CC_TRANSFORM(cc);
 }

As result instead of gcc code:

	lghi	%r8,0
	lt	%r1,1032(%r8)
	je	...

We get more or less the same:

	lhi	%r1,0
	cy	%r1,1032
	jne	...

The only benefit is [zero] "d" (0) could sometimes avoid LHI if a
zeroed register is already around. But also the KASAN coverage is
not generated.

Does it make sense to go ahead whith the alternative?
