Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA784C4743F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9212061107
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFGJdp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGJdo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:33:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F00C061766;
        Mon,  7 Jun 2021 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KVqRz6ZmzerLYd7xV5qg7kf3ByX/ndWAg7ZXAC9ih5Q=; b=v780oCvswkoS9OGCd22PSGPhGL
        I0Yo6knLveuryhDZD6s2ejz4tLzLgkyXD6cMQwUaL0C/egNWhkWE9GZYUOq/I4gqY3ywNo0JzhhWI
        STU0TkT7YitcJVxvjUpZnfBYUyZfGljAdW10UnqD75xCUeUkzXK8rvCEDPGFjkM1/FmhrdIH1JLRX
        2cKkZCjfSff6zje6eZxM/w6czj5WnKqWVWLLv/pi6lJoiH0lx0DZaUus3z1VyVwcpsl2ozaUeHsfa
        Ouc/kmJjrzyufbljXzBFMYURW5q3tMZW1Kd2eggrtM6pEGv33vf9TphBDXbRCCunceot5ysCr9gOF
        FRQ42zoA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqBan-00Fa8A-N1; Mon, 07 Jun 2021 09:30:50 +0000
Date:   Mon, 7 Jun 2021 10:30:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] kprobes: remove duplicated strong free_insn_page in
 x86 and s390
Message-ID: <YL3nRQnE3H7ogHKI@infradead.org>
References: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Please also mark free_insn_page static now.
