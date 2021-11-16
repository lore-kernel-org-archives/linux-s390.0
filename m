Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A3C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 22:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE358613AC
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 22:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhKPWra (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Nov 2021 17:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhKPWra (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Nov 2021 17:47:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9535761BBD;
        Tue, 16 Nov 2021 22:44:32 +0000 (UTC)
Date:   Tue, 16 Nov 2021 17:44:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] ftrace/samples: add s390 support for ftrace direct
 multi sample
Message-ID: <20211116174430.159c89c7@gandalf.local.home>
In-Reply-To: <20211115195614.3173346-3-hca@linux.ibm.com>
References: <20211115195614.3173346-1-hca@linux.ibm.com>
        <20211115195614.3173346-3-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 15 Nov 2021 20:56:14 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

I know this is for your tree, but you really should never have an empty
change log. I could think of many things to say here.

The only acceptable empty change log IMHO is spelling fixes.

-- Steve

> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>
