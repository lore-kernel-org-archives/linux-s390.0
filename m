Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9DC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 02:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE6E6136F
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 02:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJSCJG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 22:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhJSCJG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 22:09:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FF661360;
        Tue, 19 Oct 2021 02:06:53 +0000 (UTC)
Date:   Mon, 18 Oct 2021 22:06:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <20211018220652.014c12a0@gandalf.local.home>
In-Reply-To: <YWadVEtwt8+mWsWo@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
        <20211012094852.7f6a59b8@gandalf.local.home>
        <YWWithSCGThguq7s@osiris>
        <YWXANRbkPIE3HtOE@krava>
        <YWXTCm2S8WFIZKbh@osiris>
        <YWadVEtwt8+mWsWo@osiris>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 13 Oct 2021 10:48:20 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Tue, Oct 12, 2021 at 08:25:14PM +0200, Heiko Carstens wrote:
> > On Tue, Oct 12, 2021 at 07:04:53PM +0200, Jiri Olsa wrote:  
> > > > > See here:
> > > > > 
> > > > >   https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/  
> > > > 
> > > > I applied Jiri's patch set and the newly added selftest passes.  
> > > 
> > > nice, could I have your Tested-by? ;-)  
> > 
> > Well, now I added also the missing pieces to ftrace-direct-multi
> > sample module and when loading that and looking into
> > /sys/kernel/debug/tracing/trace it looks like "my_direct_func" gets
> > some random junk as parameter and nothing that could count as "ip".
> > 
> > Will look into that, probably tomorrow.  
> 
> Ok, if I load the correct module, it even works. I had a bug in the
> first version, fixed it, but still loaded the broken module to test
> my changes. Clever me ;)
> 
> So it all works for me.

BTW, in case you need my ack:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

for the series.

-- Steve
