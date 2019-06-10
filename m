Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390550AbfFJPx4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Jun 2019 11:53:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AFpZix015568
        for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2019 11:53:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t1t7er3px-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2019 11:53:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 10 Jun 2019 16:53:53 +0100
Date: Mon, 10 Jun 2019 17:53:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: mark __ctl_set_bit and __ctl_clear_bit as
 __always_inline
References: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
Message-Id: <20190610155348.GA4031@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 01:35:44PM -0700, Guenter Roeck wrote:
> s390:tinyconfig fails to build with gcc 8.3.0.
...
> Marking __ctl_set_bit and __ctl_clear_bit as __always_inline fixes the
> problem.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/s390/include/asm/ctl_reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
