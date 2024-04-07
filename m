Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB621E861
	for <linux-s390@vger.kernel.org>; Sun,  7 Apr 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510449; cv=none; b=NCvJtq4h/0mcL3O4NkXXMb9J/XinaddbP/P/4OuSWAvdnZ+9T+472hn6VJOYliBfr+8p6EfAyMaSS3rzbn0UypX8Qgiz1JwfkHYpIpZnkeZWtVWx2gJDL0mX3JTLcWAXhgi9hncx2H/aPkYWf5+BbB7+b4oO7srmtPjF4yjcbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510449; c=relaxed/simple;
	bh=fl8QrAPjj32d9Qrehf2wuHz5EQ/BvoAKQ7LzmbNo4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWjpL9sZXTrvVkUpWOU3RDHIspYkws/tgL303BRCJ+iDw5MwO6ULM6DTGeYwvO/ZLnw6uBZjsQNDdjo15HdW2LMCDdj3HbR0B/LJIkIeeyQCfe99f0H/HNZN6IE59pyfI/CjosLPVWSBuGBUz8GZdwCKys5O9zPqhCEgGhsgg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/hYVYj9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/hYVYj9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 437GVQib018929;
	Sun, 7 Apr 2024 17:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wCwzYTi3qQQ8obIcA94XO3Gk5IF757LbEu8pKM5p6e4=;
 b=f/hYVYj9UrKn0dcL64I4sd0BDUJso/AktFobSHs1ka36ocblThYThcWkXssWk74gC2Do
 3hRBuEXta1RHUsIVgiUA4YIFicbSg5I8NDy3+wpKT17i37a3OponLVPxJ4WVyruIqhLM
 sML/0e3KzSbTL+fQhRQ0hhmPcTOTt+sPHKkFG2FnZ4D11HOIC5KNNfZzEP6OU0138NXf
 8Xd304Wd4XSMg1cldcBQNs/+etwR0E6GzewWNqyALEV7TLH8fs0N5hoVZ+E65YiBSyWY
 rIpuvSjW6w2NVUPGW3Nt/p7IySj+g2jPahWlPdayV+Hbn26bsw/8/AjS3knZI6fb2Rk3 kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xbsac0jkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 17:20:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 437HK2eI024934;
	Sun, 7 Apr 2024 17:20:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xbsac0jkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 17:20:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 437G0Upn013760;
	Sun, 7 Apr 2024 17:20:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqt3t8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 17:20:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 437HJtn712058960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Apr 2024 17:19:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C59F20043;
	Sun,  7 Apr 2024 17:19:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F65020040;
	Sun,  7 Apr 2024 17:19:54 +0000 (GMT)
Received: from osiris (unknown [9.179.2.159])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  7 Apr 2024 17:19:54 +0000 (GMT)
Date: Sun, 7 Apr 2024 19:19:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        surenb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 6/7] s390: mm: accelerate pagefault when badaccess
Message-ID: <20240407171952.5958-B-hca@linux.ibm.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-7-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403083805.1818160-7-wangkefeng.wang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b-EEOAEEwlQYwv7cl_y3sNF2TyvQW26w
X-Proofpoint-GUID: a_Cqxs0DB0iEGztJhKKGFrHC8k3JLA6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_10,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=794
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404070138

On Wed, Apr 03, 2024 at 04:38:04PM +0800, Kefeng Wang wrote:
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly handle error, no need to retry with mmap_lock
> again. Since the page faut is handled under per-VMA lock, count it
> as a vma lock event with VMA_LOCK_SUCCESS.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/s390/mm/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index c421dd44ffbe..162ca2576fd4 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -325,7 +325,8 @@ static void do_exception(struct pt_regs *regs, int access)
>  		goto lock_mmap;
>  	if (!(vma->vm_flags & access)) {
>  		vma_end_read(vma);
> -		goto lock_mmap;
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		return handle_fault_error_nolock(regs, SEGV_ACCERR);

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
