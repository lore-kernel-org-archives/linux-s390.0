Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbfK1Qv5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 11:51:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASGlcYp159361
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 11:51:56 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wjf1v6s4r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 11:51:56 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 28 Nov 2019 16:51:54 -0000
Date: Thu, 28 Nov 2019 17:51:47 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] s390/unwind: drop unnecessary code around calling
 ftrace_graph_ret_addr()
References: <20191106095601.29986-1-mbenes@suse.cz>
 <20191106095601.29986-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106095601.29986-2-mbenes@suse.cz>
Message-Id: <your-ad-here.call-01574959907-ext-0700@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Wed, Nov 06, 2019 at 10:55:58AM +0100, Miroslav Benes wrote:
> The current code around calling ftrace_graph_ret_addr() is ifdeffed and
> also tests if ftrace redirection is present on stack.
> ftrace_graph_ret_addr() however performs the test internally and there
> is a version for !CONFIG_FUNCTION_GRAPH_TRACER as well. The unnecessary
> code can thus be dropped.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  arch/s390/kernel/unwind_bc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

This patch has been picked up from v2 already. It's in Linus tree.
