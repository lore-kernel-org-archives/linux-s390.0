Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31904 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390192AbfJ2QfB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 12:35:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TGMXM4150351
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 12:35:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxq2yv6ea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 12:34:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 29 Oct 2019 16:34:57 -0000
Date: Tue, 29 Oct 2019 17:34:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 0/3] s390/livepatch: Implement reliable stack tracing
 for the consistency model
References: <20191029143904.24051-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029143904.24051-1-mbenes@suse.cz>
Message-Id: <20191029163450.GI5646@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Tue, Oct 29, 2019 at 03:39:01PM +0100, Miroslav Benes wrote:
> - I tried to use the existing infrastructure as much as possible with
>   one exception. I kept unwind_next_frame_reliable() next to the
>   ordinary unwind_next_frame(). I did not come up with a nice solution
>   how to integrate it. The reliable unwinding is executed on a task
>   stack only, which leads to a nice simplification. My integration
>   attempts only obfuscated the existing unwind_next_frame() which is
>   already not easy to read. Ideas are definitely welcome.

Ah, now I see. So patch 2 seems to be leftover(?). Could you just send
how the result would look like?

I'd really like to have only one function, since some of the sanity
checks you added also make sense for what we already have - so code
would diverge from the beginning.
