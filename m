Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgBQRHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:07:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH57vx021624
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:07:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b55rtyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:07:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:07:39 -0000
Date: Mon, 17 Feb 2020 18:07:33 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Explicitly compare PAGE_DEFAULT_KEY against
 zero in storage_key_init_range
References: <20200214064207.10381-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214064207.10381-1-natechancellor@gmail.com>
Message-Id: <your-ad-here.call-01581959253-ext-9953@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Feb 13, 2020 at 11:42:07PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  In file included from ../arch/s390/purgatory/purgatory.c:10:
>  In file included from ../include/linux/kexec.h:18:
>  In file included from ../include/linux/crash_core.h:6:
>  In file included from ../include/linux/elfcore.h:5:
>  In file included from ../include/linux/user.h:1:
>  In file included from ../arch/s390/include/asm/user.h:11:
>  ../arch/s390/include/asm/page.h:45:6: warning: converting the result of
>  '<<' to a boolean always evaluates to false
>  [-Wtautological-constant-compare]
>          if (PAGE_DEFAULT_KEY)
>             ^
>  ../arch/s390/include/asm/page.h:23:44: note: expanded from macro
>  'PAGE_DEFAULT_KEY'
>  #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
>                                                   ^
>  1 warning generated.
> 
> Explicitly compare this against zero to silence the warning as it is
> intended to be used in a boolean context.
> 
> Fixes: de3fa841e429 ("s390/mm: fix compile for PAGE_DEFAULT_KEY != 0")
> Link: https://github.com/ClangBuiltLinux/linux/issues/860
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
Applied to fixes, thanks
