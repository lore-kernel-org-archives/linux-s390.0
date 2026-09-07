Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD04C0439;
	Mon,  7 Sep 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785472; cv=none; b=IzVid9htwzmAmsGdIEEfjXXb8MxINTtWNNeodHf1ahh0CfmaH5x1ocdB/lka3J7SmT0/Q+1c5UlodRT5B2bXFM/C6xgffwm89Fg8ctLyj73h7wtLs/cX3ytY7CxrFm4ITr2Mr8W7FBBRMI4fcekk8l4N7Gkdxf8E0ErzNr5Hvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785472; c=relaxed/simple;
	bh=lnZ4wUEvCW1WsfkIbasYC5sg0AAHTLC7tsUYKKdt7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIH4FBzOebGiOKrXbHYKRRUs0m/GjeQQtyClQgxw+opnZA1UiyCsovSgs7aleiOOCi4zYlGLdM1WbTSg3VYwDc8eEltyiPuwfoSIIfLFF0SQsWIv4RWXibMMHTrgMv3G3f3s81XxeaUOmgI1glPzx+d6ywbVyCPpmizAu8mzlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQVmsNEN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQVmsNEN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687B1l7p1652176;
	Mon, 7 Sep 2026 12:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6KLe3S
	+Xp1m1nYXcLXdbvcJCT7lO5yU9Rba9jYwh/Qs=; b=gQVmsNENZSj7TM4Xh02FYu
	VLSHIOlSgYpjnlUeWzgg6M0r51Ne6MYElT8ww3If5/4I+a3HdYRL7z6qBuEsCupq
	ZyfbzNiyeCFyHPJxykR/K5Xv9F9YCEfguTcMVXJXlxJGaBYavaEVxccCSW9aCqXd
	lAsJyspB2i/n3z3ZUtDFnSqjoCwDXsi+JOuDpD5XsJYD7Q+lZc11mBDOMhS+6lxd
	eoOXOdIKk4lEuV7PijVlC0lWA0goZb4AohAT/J+mw6GKphTeTmO6EhP+ElwVuALl
	byijkBFYND5Y6Ep0BHeehIGPMaROTZ97IFl5xx/s+79a1Jz9ru0YKtu8dSJxB+Wg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj80n46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 12:51:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687CfIUI031024;
	Mon, 7 Sep 2026 12:51:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwgww9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 12:51:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687Cp0D746924214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 12:51:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B5F82004B;
	Mon,  7 Sep 2026 12:51:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1065220043;
	Mon,  7 Sep 2026 12:51:00 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  7 Sep 2026 12:51:00 +0000 (GMT)
Date: Mon, 7 Sep 2026 14:50:57 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
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
Subject: Re: [PATCH v2 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <20260907145057.10a74026@p-imbrenda>
In-Reply-To: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
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
X-Proofpoint-GUID: wTIVa_hhgdN7ssegVM1KpZv2hZF7d9Ij
X-Proofpoint-ORIG-GUID: wTIVa_hhgdN7ssegVM1KpZv2hZF7d9Ij
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9eb339 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=9h4rUizqkUNWjDh8Ma0A:9
 a=CjuIK1q_8ugA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX0vECH6JlufM8
 WjrH/Sh50Gwps5C7P/hMQE8alVz9ta1m6au4inuJbmOfiWuKRgBzqfvWCPiOhaa/bEoM2wv/XfC
 n3gPILdfnUDVH3k3vPX5SpIv6raiW3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX4R0uIEnG0Xg8
 qGCIWr7Jo2cUD3JLkOeogcfNV4hXOZJTtjcp4otimW3zL9ZCoutAXwcfEi/IzDlDIjua1Peikxy
 9gSVcxb+QjEvDO3vmGvTal3YnO2eaHGSADAoiZXeCu3vL0crCvj7fKTA8/rIY1bSe9bQgqvXFkr
 UQTzQYC1GAvbrvkG0djdgqRN566JYroNDsmp5jyOdomwpTvWtPukrJvZFIrvSWOTTQKLpgdspBt
 l8j1NQ7cS0sveUlu3r6ZZZqRM+XC7+9L+kRUbCMn1pXE0lEKUBHDY40KLRbRjVnmafgSBuwBtZ+
 1ZTuEh1RhsAGy9dfU0jv0D3XOkX1oxE66UCQk1LfBkNFUGtPHbKOAIJe9PXZ6SKw5TDQHnjH/Vw
 t5jUPkcH1FsZNlhVEXc6KbrKs0UdDNZA52ukBp5MKv9tD8CW3HJbiBARxt7nswNifoNqra2mvi+
 0X0sr9W6TZ4DuFHC+Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070139

On Sun, 06 Sep 2026 11:27:08 +0300
"Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> kmalloc() guarantees alignment, physical contiguity and working
> virt_to_phys() and beside nicer API that returns void * on alloc and
> doesn't require to know the allocation size on free, kmalloc() provides
> better debugging capabilities than page allocator.
> 
> Another thing is that touching these allocation sites gives the reviewers
> opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> another size is appropriate.
> 
> For larger allocations that don't need physically contiguous memory
> kvmalloc() can be a better option that __get_free_pages() because under
> memory pressure it's is easier to allocate several order-0 pages than a
> physically contiguous chunk with the same number of pages.
> 
> And last, but not least, removing needless calls to page allocator should
> help with memdesc (aka project folio) conversion. There will be way less
> places to audit to see if the user was actually using struct page.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-kvm
> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/
> 

whole series:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
> v2 changes:
> * Mask out the next CBR entry offset SIE stores in the low bits of cbrlo
>   before handing the address to kfree()
> * Use __free(kfree) in handle_sthyi()
> 
> v1: https://patch.msgid.link/20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org
> 
> ---
> Mike Rapoport (Microsoft) (4):
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA
> 
>  arch/s390/kvm/s390/intercept.c | 23 ++++++++++-------------
>  arch/s390/kvm/s390/interrupt.c |  8 ++++----
>  arch/s390/kvm/s390/priv.c      | 19 ++++++++++---------
>  arch/s390/kvm/s390/s390.c      | 12 ++++++------
>  4 files changed, 30 insertions(+), 32 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260828-s390-kvm-2015b0d777dc
> 
> --
> Sincerely yours,
> Mike.
> 

