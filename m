Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgBSMtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 07:49:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JCnPum089662
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:49:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubx3pvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:49:44 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 19 Feb 2020 12:49:43 -0000
Date: Wed, 19 Feb 2020 13:49:38 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390: remove obsolete ieee_emulation_warnings
References: <20200214172628.3598516-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214172628.3598516-1-steve@sk2.org>
Message-Id: <your-ad-here.call-01582116578-ext-5731@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Kitt <steve@sk2.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 06:26:28PM +0100, Stephen Kitt wrote:
> s390 math emulation was removed with commit 5a79859ae0f3 ("s390:
> remove 31 bit support"), rendering ieee_emulation_warnings useless.
> The code still built because it was protected by CONFIG_MATHEMU, which
> was no longer selectable.
> 
> This patch removes the sysctl_ieee_emulation_warnings declaration and
> the sysctl entry declaration.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  arch/s390/include/asm/processor.h | 1 -
>  kernel/sysctl.c                   | 9 ---------
>  2 files changed, 10 deletions(-)

Applied, thanks!
