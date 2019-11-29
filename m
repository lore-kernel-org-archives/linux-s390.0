Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfK2SQr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 13:16:47 -0500
Date: Fri, 29 Nov 2019 19:16:45 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 1/2] s390/unwind: add stack pointer alignment sanity
 checks
In-Reply-To: <patch-1.thread-a0061f.git-617139935cc4.your-ad-here.call-01575012971-ext-9115@work.hours>
Message-ID: <alpine.LSU.2.21.1911291533310.23789@pobox.suse.cz>
References: <20191106095601.29986-5-mbenes@suse.cz> <cover.thread-a0061f.your-ad-here.call-01575012971-ext-9115@work.hours> <patch-1.thread-a0061f.git-617139935cc4.your-ad-here.call-01575012971-ext-9115@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Fri, 29 Nov 2019, Vasily Gorbik wrote:

> From: Miroslav Benes <mbenes@suse.cz>
> 
> ABI requires SP to be aligned 8 bytes, report unwinding error otherwise.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Signed-off-by: Miroslav Benes <mbenes@suse.cz>

M
