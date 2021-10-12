Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E5C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2DB61074
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 15:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhJLPgQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhJLPgI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 11:36:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B5F60EBB;
        Tue, 12 Oct 2021 15:34:05 +0000 (UTC)
Date:   Tue, 12 Oct 2021 11:34:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <20211012113404.29ac7c9c@gandalf.local.home>
In-Reply-To: <YWWithSCGThguq7s@osiris>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
        <20211012094852.7f6a59b8@gandalf.local.home>
        <YWWithSCGThguq7s@osiris>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 12 Oct 2021 16:59:02 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> One thing to note: Jiri adds a new a sample module, which obviously
> will not compile for s390. Not sure if the config mechanism I propose
> with this patch set is the best way to address this - it would then
> require to add a config option for each new sample module.

Is that really an issue?

We could just group them, as long as they have the same prefix.

HAVE_SAMPLE_FTRACE_DIRECT
HAVE_SAMPLE_FTRACE_MULTI_DIRECT

??

-- Steve
