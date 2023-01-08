Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1BC53210
	for <linux-s390@archiver.kernel.org>; Sun,  8 Jan 2023 09:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAHJVS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 8 Jan 2023 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHJVR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Jan 2023 04:21:17 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1619EFD08;
        Sun,  8 Jan 2023 01:21:14 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3089KmKu017835;
        Sun, 8 Jan 2023 10:20:48 +0100
Date:   Sun, 8 Jan 2023 10:20:48 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/5] add s390 support to nolibc and rcutorture
Message-ID: <20230108092048.GA17754@1wt.eu>
References: <20230103071957.222360-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103071957.222360-1-svens@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Sven,

On Tue, Jan 03, 2023 at 08:19:52AM +0100, Sven Schnelle wrote:
> Hi,
> 
> these patches add support for the s390 architecture both to nolibc
> and rcutorture. Note that this only adds support for the 64 bit
> version, no support for 31 bit (compat) is added. For nolibc it
> includes one bugfix to make the fd_set datatype match the kernel
> type.

Perfect, looks clean and works out of the box now. I've queued the
fd_set one for fixes and will submit the rest to Paul for his dev
branch. Thank you!

Willy
