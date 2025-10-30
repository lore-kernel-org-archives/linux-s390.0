Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F903253F3A;
	Thu, 30 Oct 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836365; cv=none; b=V3IDFQAdc31NWnRatGJM453yxdDol+gCNF1g1V8ID9CvCUKqgNtDaej2I/sTnTfv6JwVqXUcMdXWVx0idJmrGH4knE4/LgBvnicEdu6dU7ObrmhGN8C+tvxi++2YOcrKT8i9UiiQ6AVx/q+J9SWRB3PqdaYa52WrZkX3lbXWL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836365; c=relaxed/simple;
	bh=TBkQ7jlW78onLhbg+CwKbnwsG8iZdKr/vA/pDUxvOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubby2mFdoAxPwcDYvAvTnunI5CxI/coC1JpdvSOuEnMK0QG3mni3qCdKyJotU/ZjhA6ppXqhZFwA/IMQPtzMhLwVNq+4FShTxrqcFZrkNm/fKoos4jfw0dLuTjqliI30WHwSgCnxWejIhaBq1VRAlryK9mOGTiR1+B/+xDItc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xg4Syogi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xg4Syogi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDEP1F026053;
	Thu, 30 Oct 2025 14:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=szkv1VBsV5AZDTc7OasVlkTIQXnkgG
	gqPoYbWRPezv0=; b=Xg4SyogiVAXKcG6w/Yr3MNFxIaNM8G6rw3Ge3SywIpdnEL
	aX0YjKId0XAa6ZWEQCn87N/R+akWktPlvn+mBYF3je+YleQx0xY+Kn9rsMfg7una
	lDHteG7oCjMWeTHJRm7Mlj9afFzdgHK5UDu1LdsFuk9CqazvIUtv9hrsX7CxyS3q
	uzpCRaIeLnlf6abatyDEgDtI7dwL9i4jM2fduO0sTlFJ8KqdPxxRc96IhU5Jcyam
	ykX4WNcdoJuZjlRKA6uHLtQM9Z43W1UQcj+oPu+aFY7gIjjYeHCy2Vp63S+Z9U7g
	o1vaLXkczpvUm56OGkWMfWUoYNgoPgvX0aPjuHbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aartm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:59:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDJQLC019555;
	Thu, 30 Oct 2025 14:59:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy99gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:59:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UEx5Vs39256572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:59:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F313C20043;
	Thu, 30 Oct 2025 14:59:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F94B20040;
	Thu, 30 Oct 2025 14:59:04 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Oct 2025 14:59:04 +0000 (GMT)
Date: Thu, 30 Oct 2025 15:59:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luiz Capitulino <luizcap@redhat.com>, borntraeger@linux.ibm.com,
        joao.m.martins@oracle.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        osalvador@suse.de, david@redhat.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-ID: <20251030145902.16837C8a-hca@linux.ibm.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
 <20251028145334.5a97211e0e46ca42fe2fa0d0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028145334.5a97211e0e46ca42fe2fa0d0@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=69037d3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=pnrwH9RaTRmhQM8EeXAA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oHpYfSrcI6OOpyeOQezm9Vb57hP5iAPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX0Ksmz6rT4f+q
 kKyfEFKwabEfiC76idkfmav3QtBTrTLlVq5CPl9EZJLL1FRpZjcwgIyZ/yCe5U7Tz52SMmHfxvs
 YywqnUnsfXy8K0JqE6CBFyvlIinM89AFPwrY+0cjDh3SRvvqqDBxhbLfPSnGd7617H49qpE1uwy
 WhPC5TLsd0k/nz73nTw+0+mqM0DR6nTBN7W8WOWGC8g3obWq74rYKlBlBIiCGqeIGRu1VH8Xplg
 XaGQiYx67SNpwNU2NMqyI2cUYFFj4ykOj7EJ1cn45xum+NF+NzEkQpW4fLKgk9hN/1anE3Vx0Ue
 seuv1applaZsC13GGepco+QQJNalq0VIZrZ+ht4xkz14OcRznwioLr4+4Zw5LHGXFeBmmMezlfd
 Dq/vHqbe+afSWyr+75yIH/nqXqmPVw==
X-Proofpoint-GUID: oHpYfSrcI6OOpyeOQezm9Vb57hP5iAPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Tue, Oct 28, 2025 at 02:53:34PM -0700, Andrew Morton wrote:
> On Tue, 28 Oct 2025 17:15:33 -0400 Luiz Capitulino <luizcap@redhat.com> wrote:
> > A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
> > on s390. The crash and the proposed fix were worked on an s390 KVM guest
> > running on an older hypervisor, as I don't have access to an LPAR. However,
> > the same issue should occur on bare-metal.
> > 
> > Reproducer (it may take a few runs to trigger):
> > 
> >  # sysctl vm.hugetlb_optimize_vmemmap=1
> >  # echo 1 > /proc/sys/vm/nr_hugepages
> >  # echo 0 > /proc/sys/vm/nr_hugepages
> > 
> > ...
> > 
> > This commit fixes this by implementing flush_tlb_all() on s390 as an
> > alias to __tlb_flush_global(). This should cause a flush on all TLB
> > entries on all CPUs as expected by the flush_tlb_all() semantics.
> > 
> > ...
> >
> >  arch/s390/include/asm/tlbflush.h | 6 +++++-
> 
> Thanks, I'll add this to mm.git.  If s390 people prefer to merge it
> (or nack it!) then please do so and I'll drop the mm.git copy.

Andrew, could you drop this one please? After looking a bit deeper
into the real problem, this patch would just paper over the real bug
(and it could still happen).

I added you on Cc for the bug fix, but that is supposed to go via the
s390 tree - just in case you are wondering :)
