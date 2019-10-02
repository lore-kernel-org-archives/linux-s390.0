Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfJBGqQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 02:46:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x926gwq1021790
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 02:46:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcpry88c5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 02:46:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 07:46:13 +0100
Date: Wed, 2 Oct 2019 08:46:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
Message-Id: <20191002064605.GA7405@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> arch/s390/kvm/kvm-s390.c calls on several places __cpacf_query() directly, 
> which makes it impossible to meet the "i" constraint for the asm operands 
> (opcode in this case).
> 
> As we are now force-enabling CONFIG_OPTIMIZE_INLINING on all 
> architectures, this causes a build failure on s390:
> 
>    In file included from arch/s390/kvm/kvm-s390.c:44:
>    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
>    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
>      179 |  asm volatile(
>          |  ^~~
>    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> 
> Mark __cpacf_query() as __always_inline in order to fix that, analogically 
> how we fixes __cpacf_check_opcode(), cpacf_query_func() and scpacf_query() 
> already.
> 
> Reported-and-tested-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: d83623c5eab2 ("s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline")
> Fixes: e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> I am wondering how is it possible that none of the build-testing 
> infrastructure we have running against linux-next caught this? Not enough 
> non-x86 coverage?

Well, there is plenty of s390 coverage with respect to daily builds
(also here). It doesn't fail for me with gcc 9.1; so you may either
have a different gcc version or different config options(?) so the
compiler decided to not inline the function. I'll apply this in any
case, since your patch is obviously fine.

Thanks!

>  arch/s390/include/asm/cpacf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index a092f63aac6a..c0f3bfeddcbe 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -171,7 +171,7 @@ typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
>   *
>   * Returns 1 if @func is available for @opcode, 0 otherwise
>   */
> -static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
> +static __always_inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>  {
>  	register unsigned long r0 asm("0") = 0;	/* query function */
>  	register unsigned long r1 asm("1") = (unsigned long) mask;
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
