Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C63C2794;
	Mon, 13 Apr 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087819; cv=none; b=h/GAsUBYpleYY+mxAia8mwYovusahRIm15tjRqegmeGhY6DulgWi6pW0lZ5W4sp9J1nutpD6vc6/aLcktnLH+oCO7FGqVvv5VH+JZ1BhbYa8Ie456T1XjHmC2L0lsKw1Ya+iaoDfz9ZZe+VQIDoub2G/lNF3GbZTpv3iwXt2FCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087819; c=relaxed/simple;
	bh=v1OvISVwdKwykiC0GWVuFtU6upLOQIBd7MvIItNAFos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzto4lITpgtcZeKKcmU+QZbWu1rKQ6kbnXbWRkLs/EvDeAbTJsU8d7kUsoD8gtG7DTmGAup7oqod6VnKSLFwrUzBXVJJ3TKY1NUXra8OLwho5D/LP2G08dm6vyMwhueBkbDmElERjCBhl4FDa/MA9JZW0UyZvfVeKa41vc6Y9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mnIW1wS1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mnIW1wS1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CKECrY3021224;
	Mon, 13 Apr 2026 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=saf5SXp3wlvOnOLzLMjfVdHAFSBVv9
	+8L7w7kLpMC/8=; b=mnIW1wS1tMvmc/4IdmfuUvRlSHB9Nn6BjP6lB47IZD5use
	LIBd47QC5BwPpinJbYEGM5Izkas6xM2/lz89P6OL6A6GVZ5fTvIuKviJ+LeLFb4+
	VYFH12S9Q2RysppFnJVbEWmNK+IutW4e3RIA8Q8bHEF81PBtmHTkD51Y5ZwEremI
	Ip4CpQjq7L0IAtqz7fN4pvKVajk+gZP5PqVr4xwKQyCZJQ6CXbMi0mMopmmcOhvY
	IQjoP3SP6qhydFbGAe/SDpxup0dS4fn0BrOpeW8pKOa5JXvct2ULXdikDHo7tKy6
	hacASYLAJhtDAqPEDi1xZZZM9XToiGidp/aojFlQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkfskv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 13:43:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DA4meW025781;
	Mon, 13 Apr 2026 13:43:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1d3wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 13:43:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DDhOt553019082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 13:43:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CF512004D;
	Mon, 13 Apr 2026 13:43:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE32D20043;
	Mon, 13 Apr 2026 13:43:23 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 13:43:23 +0000 (GMT)
Date: Mon, 13 Apr 2026 15:43:22 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <896b3d93-8e60-42e2-b8bb-d3d4e8c99927-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dcf300 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yNaC3uHPhY_xAc1mEpIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: l9a5izobHhmuJWMjreMWf-1yG0SVJluB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzMSBTYWx0ZWRfX/NimbRRhGaFD
 Jjy+q0LVUcC6dU1MpAjKESCfvT9kNOxcc47zp9DjfkwDYbHX8DktSB55qnzUjOXpCa6g3uJTaZW
 teNGQCyWRLriO7ZYrqSlogIsW1PwGItZYXRtyvU2UxgDsdGwnMNtT63jhIDAkZQ9J4KQjPwwbx/
 7wwNp57YRbVNQqvkO6Vce9Bde61f5KWspkNHqi/5Ka9JC7+zaXsyg4B73fPT6/rQM2K6LZhZn/E
 P3jxkXLDqDLQKWXJQKk5n4q2nHBNGT1tJoWhPMBKlZtxuulPZlbUA8nTNDdARp2Q13OpUu+wpdV
 PefhH1KrSmLrsC8mN96/50r+T8xuA9btJq6pgpTajcpb+iAo9iVQRbWMtIO10qprKvEyCs/RPK8
 cMiQHhFxggwVIyxbUSJayKt99zfeu+Wouc+Zp9ytxVPdJLGb3LOZTpEVLcaFiX0I2+cYPopRovr
 Arq1RcgMd+aksQbMS3Q==
X-Proofpoint-ORIG-GUID: l9a5izobHhmuJWMjreMWf-1yG0SVJluB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130131

On Tue, Mar 31, 2026 at 11:11:22PM +0200, David Hildenbrand (Arm) wrote:
> >>> + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with
> >>> parameters
> >>
> >> You have to be a lot clearer about implications. For example, what
> >> happens if we would bail out and not process all ptes? What are the
> >> exact semantics.
> > 
> > The only implication is "only this address/PTE range could be updated
> > and that range may span one page table at most".
> 
> Probably phrase it stronger. "No ptes outside of this range must be
> updated" etc.

That turns out to be bit more complicated. The below cases do not fit
such a strong requirement:

1. copy_pte_range() operates on two ranges: source and destination.
Though lazy_mmu_mode_enable_for_pte_range() applies to the source one,
updates to the destination are still happen while in tha lazy mode.
(Although the lazy mode is not actually needed for the destination
unattached MM).

2. move_ptes() also operates on a source and destination ranges, but
unlike copy_pte_range() the destination range is also attached to the
currently active task.

3. Though theoretical, nesting sections with interleaving calls to
lazy_mmu_mode_enable() and lazy_mmu_mode_enable_for_pte_range() make
it difficult to define (let alone to implement) which range is currently
active, if any.

All of these goes away if we switch from for_pte_range() to fast_pte_range()
semantics:

/**
 * lazy_mmu_mode_enable_fast_pte_range() - Enable the lazy MMU mode with fast updates.
 * @mm: Address space the ptes represent.
 * @addr: Address of the first pte.
 * @end: End address of the range.
 * @ptep: Page table pointer for the first entry.
 *
 * Enters a new lazy MMU mode section and allows fast updates for PTEs
 * within the specified range, while PTEs outside of the range are
 * updated in the normal way - as if lazy_mmu_mode_enable() was called;
 * if lazy MMU mode was not already enabled, enables it and calls
 * arch_enter_lazy_mmu_mode_fast_pte_range(); if the mode was already
 * enabled, the provided PTE range is ignored.
 *
 * The PTE range must belong to the provided memory space and must
 * not cross a page table boundary.
 *
 * There are no requirements on the order or range completeness of PTE updates.
 *
 * Must be paired with a call to lazy_mmu_mode_disable().
 *
 * Has no effect if called:
 * - while paused (see lazy_mmu_mode_pause())
 * - in interrupt context
 */

Thoughts?

Thanks!
