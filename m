Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41314 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNTVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 14:21:21 -0500
Date: Thu, 14 Nov 2019 11:21:18 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Message-ID: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
References: <1573751861-10303-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751861-10303-1-git-send-email-cai@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:17:41PM -0500, Qian Cai wrote:
> The commit f05499a06fb4 ("writeback: use ino_t for inodes in
> tracepoints") introduced a lot of GCC compilation warnings on s390,
> 
> In file included from ./include/trace/define_trace.h:102,
>                  from ./include/trace/events/writeback.h:904,
>                  from fs/fs-writeback.c:82:
> ./include/trace/events/writeback.h: In function
> 'trace_raw_output_writeback_page_template':
> ./include/trace/events/writeback.h:76:12: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 4 has type 'ino_t'
> {aka 'unsigned int'} [-Wformat=]
>   TP_printk("bdi %s: ino=%lu index=%lu",
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/trace/trace_events.h:360:22: note: in definition of macro
> 'DECLARE_EVENT_CLASS'
>   trace_seq_printf(s, print);     \
>                       ^~~~~
> ./include/trace/events/writeback.h:76:2: note: in expansion of macro
> 'TP_printk'
>   TP_printk("bdi %s: ino=%lu index=%lu",
>   ^~~~~~~~~
> 
> Fix them by adding necessary casts where ino_t could be either "unsigned
> int" or "unsigned long".
> 
> Fixes: f05499a06fb4 ("writeback: use ino_t for inodes in tracepoints")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
