Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52131C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 14 Nov 2022 09:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiKNJST (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiKNJSR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Nov 2022 04:18:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5B1DDDC
        for <linux-s390@vger.kernel.org>; Mon, 14 Nov 2022 01:18:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668417492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+VxRIxfB6hlYwFIqHI7yAuHOJEZicLTE0JKAZwLc7w=;
        b=2AnzchggBXrmq/2mCMPhLcDMs6W5tK4SB3E58TO5H873cyPEktF1R099BMQSzvnntxCiMg
        0YEsPKGRN1WIETzPsm43J8Jbnoliv/PM6Mm4YWqih5YyttN6S/lHW9Kv58Bwm3hCa0xqA7
        ULLwc4hXhuDLeY32hDgno+ldrlE5EY7vRWR8CRpKawTNyr8AUeiuNcqXUIpkZopa6+HZHz
        aYioN7Nb6RhakmcBXIXT9GnC9OHIW4r7jlc3YkohU/+qMG2VsVQcVNFsiO76KkugKb0L71
        zLtEx9wBkNRLAJy7rZxih6Ukh00cC7AmjIUJSt9nTmltFdgEe5gdvzySusytOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668417492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+VxRIxfB6hlYwFIqHI7yAuHOJEZicLTE0JKAZwLc7w=;
        b=GVns1NPRC4wRYC+m3gPbAbTawYJimaU1HnmMV8zZMA1aj/uyEA+js1Twa03MhFMLohwuxs
        sgQfYy337emHF7AA==
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: Use irq_data_get_msi_desc()
In-Reply-To: <b7ec3c33bb8e356fe29f3433002cb31f8013be74.camel@linux.ibm.com>
References: <8735aoui07.ffs@tglx>
 <b7ec3c33bb8e356fe29f3433002cb31f8013be74.camel@linux.ibm.com>
Date:   Mon, 14 Nov 2022 10:18:11 +0100
Message-ID: <87mt8tsxm4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 14 2022 at 09:55, Niklas Schnelle wrote:
> On Sat, 2022-11-12 at 19:47 +0100, Thomas Gleixner wrote:
> That said it must be noted that this function is only called when using
> directed PCI IRQs which is a hardware feature that has not made it to
> any released hardware. Nevertheless no point int doing things more
> complicated than necessary even for that case.
>
> If there are no objections I'll apply this to our internal tree and it
> will then go upstream via the s390 tree.

Sure. It has no dependencies. I just stumbled over it when doing a tree
wide inspection of (PCI)MSI code.

Thanks,

        tglx
