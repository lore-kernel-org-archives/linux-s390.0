Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbgC0M6u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:58:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RCY1D3127101
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 08:58:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywd8gwcwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 08:58:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 27 Mar 2020 12:58:45 -0000
Date: Fri, 27 Mar 2020 13:58:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH -next v2] s390/ism: Remove PM support
References: <20200326190549.24565-1-natechancellor@gmail.com>
 <20200326190741.24687-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326190741.24687-1-natechancellor@gmail.com>
Message-Id: <20200327125840.GA4109@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Mar 26, 2020 at 12:07:44PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/s390/net/ism_drv.c:570:12: warning: unused function
> 'ism_suspend' [-Wunused-function]
> static int ism_suspend(struct device *dev)
>            ^
> drivers/s390/net/ism_drv.c:578:12: warning: unused function 'ism_resume'
> [-Wunused-function]
> static int ism_resume(struct device *dev)
>            ^
> 2 warnings generated.
> 
> When CONFIG_PM is unset, SIMPLE_DEV_PM_OPS does not use the suspend or
> resume functions. Power management was recently ripped out of s390 so
> CONFIG_PM will never be set and these functions will always be unused.
> 
> Remove them so that there is no more warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/950
> Fixes: 394216275c7d ("s390: remove broken hibernate / power management support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thank you, however there was already an identical patch from Ursula
which was missing on our branch. It's now there:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=194f75706b86847d1b4237958f7d6bd7ea7baf42
