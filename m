Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CFC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 15 Jun 2022 06:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbiFOG5d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiFOG5b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jun 2022 02:57:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2077B21B;
        Tue, 14 Jun 2022 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qNXVqmxSpUOvgxRgQ5LFOcNQ8o56Uupm2hxFNDJ6o4A=; b=SUzqfrnDPOqROLEVY4dilVwjsT
        s9dP7gDfSz1s87ZFKwdNfBnEewrk82sE2kWW7HUPeBdmZD7XbyasqPcpEYzajrJBLt68yaVxCDfBu
        UNem7+Sxy8d99R6ehfS/E6jHiusjLHaURpRKNfXf5kIA//DAh+Gto+PBjdDVl6ji8fn/89/M5NgWl
        3X0Sy1Tj0NYy26foekGpjmpddeZF7GqsS+PMyZW8F1rJbbyhlfI9GfqsfcJaIewJe+VYjImM2MIor
        ytGxwg4TKaKAj9wJIEfIf1F0+q3bG6igtjekGb7zpOkUNgpd53WvF/HcJXKP3H8rfkrCXq8YzeYkW
        T67SvWwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Mxx-00CxiS-1O; Wed, 15 Jun 2022 06:57:25 +0000
Date:   Tue, 14 Jun 2022 23:57:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] arch/*: Disable softirq stacks on PREEMPT_RT.
Message-ID: <YqmC1aAm+O7RD2IH@infradead.org>
References: <YqjQ5kso7czrmYPW@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqjQ5kso7czrmYPW@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 14, 2022 at 08:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and

s/safe/save/
