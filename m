Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076CC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKSPp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiGKSPn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 14:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736772CCA0
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 11:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CBA614CF
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 18:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A22C341C8;
        Mon, 11 Jul 2022 18:15:40 +0000 (UTC)
Date:   Mon, 11 Jul 2022 14:15:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] trace-cmd: fix writing of uncompressed size
Message-ID: <20220711141539.59727f34@gandalf.local.home>
In-Reply-To: <20220711135146.35e163b0@gandalf.local.home>
References: <20220711094340.2829115-1-svens@linux.ibm.com>
        <20220711135146.35e163b0@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 11 Jul 2022 13:51:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Can you resend and Cc linux-trace-devel@vger.kernel.org so that it gets
> added to patchwork.

Actually, I'll just send it for you ;-)

-- Steve
