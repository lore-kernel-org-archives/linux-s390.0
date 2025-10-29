Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2732C331;
	Wed, 29 Oct 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734726; cv=none; b=m8z+rj+FnO9KYvmRkoE91rqyIoKUNnves1TGePio2Ho+ynPHUBURUvfZCG2j17u4obNELhGYGJg71qqoa98cIFwDsX3oDqonr4j2QZLnyY5COzscn4wL0+3f1pi1ERdo/hiJZuZDQQmBPxQOvccfPAD5q7OtTdHyux7JJTThS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734726; c=relaxed/simple;
	bh=xUXcPnne74ZPs8BwDoabNGRQ9ytrbTeM0YE8XkweLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfCarVxZ998jcq/+wZryxosIC4f+Jkd5ECV4X9JjskkyJrbA549n0E8bH0fDYddqvX+2tWwNp8DEw7Z8h51/qKdRmXOgpnAx/7zG/+OJSEI+LjPu/FLBSQbcFKwe1QYPWGnS1Jz7A+mn6TQoGoAE9dzo2Arc0DLGdKBNmtTidj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hkg7jyim; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hkg7jyim"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm4AZ025616;
	Wed, 29 Oct 2025 10:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Sq01EnGDr5eRCz4SpQ+rNxwk3z5KS5
	ccSc1QrsKlxS4=; b=hkg7jyimsLURQSpMM1215mCSiTHh0UNvum49WScyfsDD6F
	jAqa+YLBFIWU39YlhOCubwTLXp21pAXKeYSFxrS2HXwm36AzCf53OKva2relivFZ
	LAeymFFzpRwZ63xisNbj5iGmDsqwwzWDbrEuJDUAiPxPWT+MGylWJ+dp+a3CO3gt
	QmGJ2mUEGbKiP6IJs44hlRQyHMlU+F1XwJtIGR1nFlONacWP91QUl1sqKW6URFU2
	LTtTDixsvg3kjHbYn4fDtd1/pVW9nuMEUoa+tOiQhMguPTlT8kccaZAhkI7Jegr/
	vPIRIwwVdclI+AlJdbBqxts0vv47O9MBbUVjgx1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acjt5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:45:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9spqn030714;
	Wed, 29 Oct 2025 10:45:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwjwfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:45:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TAixiw62718458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:44:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 471A520043;
	Wed, 29 Oct 2025 10:44:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D50B82004B;
	Wed, 29 Oct 2025 10:44:58 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Oct 2025 10:44:58 +0000 (GMT)
Date: Wed, 29 Oct 2025 11:44:57 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, borntraeger@linux.ibm.com,
        joao.m.martins@oracle.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-ID: <20251029104457.8393B96-hca@linux.ibm.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=6901f031 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=YKqhbZKFatMI8GZplqcA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: fi9EDziNPk_O6GlKsGKU2u_puYD54L1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX+h5nDC3eaDb+
 BpIao59i4TxtCLpFhzaG2LAsa2cGIwnZkc5HPZnmF0IpcH8ECdLjR4oUozrdVw0mX3qbcGrA5t5
 hf/n957YgLAmy2JYZBHXxQsFcDG9PkENvmCazjfAVXqBhEdUbBcR/DDwssgIeepn4cQpM3bumZT
 oWpeCGfx1TRSKT17GfSRAnH25bMU1kpxVBDbl5FnTLEbApeWspbAyyXF26yiV4JoUVV8wkvwQ/A
 7dEmEIFLAXxQ2oHYB7poY+3qZa77DDF4kw56whpoRvv1CkcQqp6BjiRfQdsm+QJ/GRvvbd+6Fq1
 xL4mp5q7roW5W24mcK9Udnz1X658IuveAv542bvgDaKpCtwdOLVB425ojnkXfe45BwtPNfSkKnf
 PmCGxR1EERI5sNCFvkfr+V528JUKbw==
X-Proofpoint-GUID: fi9EDziNPk_O6GlKsGKU2u_puYD54L1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Wed, Oct 29, 2025 at 10:57:15AM +0100, David Hildenbrand wrote:
> On 28.10.25 22:15, Luiz Capitulino wrote:
> > A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
> > on s390. The crash and the proposed fix were worked on an s390 KVM guest
> > running on an older hypervisor, as I don't have access to an LPAR. However,
> > the same issue should occur on bare-metal.
...
> > This commit fixes this by implementing flush_tlb_all() on s390 as an
> > alias to __tlb_flush_global(). This should cause a flush on all TLB
> > entries on all CPUs as expected by the flush_tlb_all() semantics.
> > 
> > Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
> > Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> > ---
> 
> Nice finding!
> 
> Makes me wonder whether the default flush_tlb_all() should actually map to a
> BUILD_BUG(), such that we don't silently not-flush on archs that don't
> implement it.

Which default flush_tlb_all()? :)

There was a no-op implementation for s390, and besides drivers/xen/balloon.c
there is only mm/hugetlb_vmemmap.c in common code which makes use of this. To
me it looks like both call sites only need to flush TLB entries of the kernel
address space. So I'd rather prefer if flush_tlb_all() would die instead.

But I'm also wondering about the correctness of the whole thing even with this
patch. If I'm not mistaken then vmemmap_split_pmd() changes an active pmd
entry of the kernel mapping. That is: an active leaf entry (aka large page) is
changed to an active entry pointing to a page table.

Changing active entries without the detour over an invalid entry or using
proper instructions like crdte or cspg is not allowed on s390. This was solved
for other parts that change active entries of the kernel mapping in an
architecture compliant way for s390 (see arch/s390/mm/pageattr.c).

Am I missing something?

Gerald, since you enabled the corresponding Kconfig option for s390: is there
any reason why this should work in an architecture compliant way?
