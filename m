Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7D3DFC8A;
	Mon, 27 Jul 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148648; cv=none; b=aB0r5BEUsF9ve99dDSW23bHVlubRNzIrzDn11iJQyqk07CwNG03xaL40JfhV0MD+YWUfeHxN/g1JoFzvAgYbOdtMyAUV741z5rKi9ZtjZJ6L+PESNzt/dfuA2IgxeBrGidzLLvgQHkEcMWlUFN9B04WagmoBMA+Ae1CZ0+t3LYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148648; c=relaxed/simple;
	bh=MtzcV8jiLtxni40vzIrA1iaza6OL1O1ZM+m/gNeU/0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWS9Ao24cTbb9vCFREm/OmO9cBg3tFfrvgbJmcl6JTniqd7jDxhASAzhmxtmA+qW0QwZk/hasSCoinqoeaa8jUc/zZv4ana3qF075aWBrKzxKHl563w3aLWBg+ByDARs8r2e7wqZeepuRvrxCBzjB1mpsLaRTJdhyr5BlltWg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V7ejwdhe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V7ejwdhe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIiCK1960405;
	Mon, 27 Jul 2026 10:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PCU5i14J8a76mxVtJ43W1AvB01XDG7
	N7knJAAAWMDJI=; b=V7ejwdhe0M+zSyhnfoZdupfJlNKCGjTx5VRHiRYdOdAgHV
	tsQtJnrPcT4TqbpGgwvVqFl9YPxdkoJOJfvV4YBGselybaUZACvCC37bIcaO6Gmj
	d1T5kqj/iQDjSR8+BfciHy44dclEY1gPFQJ4rY/kXbpCgg3LP65ps+zU8NAiABc5
	jI7gT6P8+XCiqpvT74ZhoPvVVcwQ8DGuCFeLDw47OjCUkMPtQhmh1hfYE6d1oKQ/
	NjHOOZdJaxX9CWGQuJvh1OkfgZSJVIjVtq66ATUG/1mkOtaRU678/w1lu9g80Kqh
	oIO2Ih6mbNue7Ehy/9Ck1BmwC7koau4+maL0SZMQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcq4r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:37:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQddx014370;
	Mon, 27 Jul 2026 10:37:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvw3sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:37:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAbBhl48169452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:37:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A45020128;
	Mon, 27 Jul 2026 10:37:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41D9B20126;
	Mon, 27 Jul 2026 10:37:11 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Jul 2026 10:37:11 +0000 (GMT)
Date: Mon, 27 Jul 2026 12:37:09 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] s390: Reintroduce support for DCACHE_WORD_ACCESS
Message-ID: <ttitxhx@ub.hpns>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gA-c4IJzNdW8gFwDMfDJgse5MrdaonoS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX0N+8N4oZBd8p
 897e6WIDgO6yTJ04fFk6sCjNdehPQRxsCzgb7NXBZOVPZFclDr20W4Z5eTXdxW8+HX8tX+d9coJ
 QEEukpL9XkPfPDyU9TdtoiZLZtyeFCQ=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6734dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=x38aFKVj8ROUqmG2MhkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX/4LJKjJo8CYq
 n9RI6Zi9s1eVDw7kW2HpeOc4/yQICt+uAQuz1RIjzii90hw/EuBeLTRMQXwOPD1YEt0agFv9jsq
 4avrM1DBy6Lnb6nDNlvMumqztHE6QnUghQ/wYjkp5rQlKJ4fpaOA5vRB9PhAC9GoRBN2ppRWVFM
 JsmkUUZ2LVy02yhSd1YyelWKB5uw3+OP3myKnYcA2klQzBfi+Dp9qj46AKe/E2SdHafjqh2FYo9
 UNwjDnGb/QIbt/mpNwFdOb3kdzqLKsC35lKxrU4bi5ieLM5AWI1K785alTIChATqLyQQrRxlwiL
 K1HXrz/ymJawkXinj+LIH9Y2LxQmuKdN4GnsdkICh+lOPWCyHPs4XZ8h8DtaspBSCKv7OWPylgT
 h/+Q3ubFZ+8e8z+8w+GiSzpWXmLdrU1iJPXZY1zJF7Rqvy/YAHxJ4bU/g9XEqZyDiaXiBTjiQb4
 rckhVwtdcZlJdmrYjsw==
X-Proofpoint-GUID: gA-c4IJzNdW8gFwDMfDJgse5MrdaonoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270100

On Mon, Jul 20, 2026 at 10:58:26AM +0200, Heiko Carstens wrote:
> v4:
> - Add two more cleanup patches based on Sashiko feedback, however I
>   don't consider them as bug fixes. This is more cosmetics:
>   - Use handle_fault_error() in do_secure_storage_access()
>   - Use goto statement in do_secure_storage_access()
> 
> v3:
> - Fix two more pre-existing bugs reported by Sashiko
> - Add Christian's Tested-by tag to four of the six patches
> 
> v2:
> - Explicitely PAGE_ALIGN size in uv_alloc_stor_var() [Sashiko]
> - Document that lazy PTE update / TLB flushing is intended [Sashiko]
> 
> v1:
> Support for DCACHE_WORD_ACCESS was recently removed [1] since it caused
> problems with the incomplete handling of secure storage access
> exceptions. It looked like fixing the exception handler would be a larger
> effort; therefore support for DCACHE_WORD_ACCESS was removed as a work
> around.
> 
> Address the potential problems that exist with secure storage access
> exceptions and add support for DCACHE_WORD_ACCESS again.
> 
> In particular address the following problems:
> 
> - Reading the guest variable storage area via the /proc/kcore interface
>   results in short reads. Address this by using a VM_SPARSE area for the
>   guest variable storage area. VM_SPARSE areas will be handled like
>   memory holes (zeros will be read).
> 
> - Fix handling of secure storage access exceptions in vmalloc area.
> 
> - Remove folio handling for secure storage access exceptions to avoid
>   potential data corruption.
> 
> [1] 37540b8c287f ("s390: Revert support for DCACHE_WORD_ACCESS")
> 
> Heiko Carstens (8):
>   KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
>   s390/mm: Add missing mm check to do_secure_storage_access()
>   s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
>   s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
>   s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
>   s390/mm: Use handle_fault_error() in do_secure_storage_access()
>   s390/mm: Use goto statement in do_secure_storage_access()
>   s390: Add support for DCACHE_WORD_ACCESS (again)
> 
>  arch/s390/Kconfig                      |  1 +
>  arch/s390/include/asm/asm-extable.h    |  4 ++
>  arch/s390/include/asm/uv.h             |  2 +
>  arch/s390/include/asm/word-at-a-time.h | 22 +++++++++
>  arch/s390/kernel/uv.c                  | 65 ++++++++++++++++++++++++++
>  arch/s390/kvm/pv.c                     |  6 +--
>  arch/s390/mm/extable.c                 | 18 +++++++
>  arch/s390/mm/fault.c                   | 35 ++++++--------
>  8 files changed, 128 insertions(+), 25 deletions(-)

Applied, thank you!
