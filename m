Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728455AbhAOKgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Jan 2021 05:36:31 -0500
Date: Fri, 15 Jan 2021 11:35:29 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 12/18] arch: s390: Remove CONFIG_OPROFILE support
Message-ID: <20210115103529.GA10194@osiris>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <d898acaf9320125e9c23b18a16ecd88d70f24170.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d898acaf9320125e9c23b18a16ecd88d70f24170.1610622251.git.viresh.kumar@linaro.org>
List-ID: <linux-s390.vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Richter <rric@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net, William Cohen <wcohen@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 05:05:25PM +0530, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove the old oprofile's architecture specific support.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/s390/Kconfig                 |  1 -
>  arch/s390/Makefile                |  3 ---
>  arch/s390/configs/debug_defconfig |  1 -
>  arch/s390/configs/defconfig       |  1 -
>  arch/s390/oprofile/Makefile       | 10 ---------
>  arch/s390/oprofile/init.c         | 37 -------------------------------
>  6 files changed, 53 deletions(-)
>  delete mode 100644 arch/s390/oprofile/Makefile
>  delete mode 100644 arch/s390/oprofile/init.c

Acked-by: Heiko Carstens <hca@linux.ibm.com>
