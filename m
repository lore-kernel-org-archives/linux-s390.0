Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB29C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AF8611AE
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhKESmG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhKESmD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 5 Nov 2021 14:42:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30554611AE;
        Fri,  5 Nov 2021 18:39:23 +0000 (UTC)
Date:   Fri, 5 Nov 2021 14:39:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] s390 patches for the 5.16 merge window
Message-ID: <20211105143921.06050d1c@gandalf.local.home>
In-Reply-To: <your-ad-here.call-01636137270-ext-1192@work.hours>
References: <your-ad-here.call-01636137270-ext-1192@work.hours>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 5 Nov 2021 19:34:30 +0100
Vasily Gorbik <gor@linux.ibm.com> wrote:

> +++ b/samples/Makefile
> @@ -21,6 +21,7 @@ subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
>  obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
>  obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
> +obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace/
>  obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
>  subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
>  obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
> diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
> index ab1d1c05c288..e8a3f8520a44 100644
> --- a/samples/ftrace/Makefile
> +++ b/samples/ftrace/Makefile
> @@ -3,7 +3,7 @@
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
>  obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
> -obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-multi.o
> +obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
>  
>  CFLAGS_sample-trace-array.o := -I$(src)
>  obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
> --

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
