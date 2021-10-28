Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E3C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D70E6103B
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1Rkz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ1Rkz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Oct 2021 13:40:55 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Oct 2021 10:38:27 PDT
Received: from helium.openadk.org (helium.openadk.org [IPv6:2a00:1828:2000:679::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC3C061570
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 10:38:27 -0700 (PDT)
Received: by helium.openadk.org (Postfix, from userid 1000)
        id CF56E31E0851; Thu, 28 Oct 2021 19:28:36 +0200 (CEST)
Date:   Thu, 28 Oct 2021 19:28:36 +0200
From:   Waldemar Brodkorb <mail@waldemar-brodkorb.de>
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>
Subject: REGRESSION: relocating a Debian/bullseye guest is losing network
 connection
Message-ID: <YXrdxGTkjLhj/2KA@waldemar-brodkorb.de>
Reply-To: Waldemar Brodkorb <mail@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 5.10.0-9-amd64 x86_64
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

we use z/VM's Live Guest Relocation for our Debian/GNU Linux
servers. Since following commit this is broken:

d4560150cb47daba50b0d080550ca4bbe80cf3c3 is the first bad commit
commit d4560150cb47daba50b0d080550ca4bbe80cf3c3
Author: Julian Wiedmann <jwi@linux.ibm.com>
Date:   Thu Feb 28 18:59:39 2019 +0100

     s390/qeth: call dev_close() during recovery


With Debian/buster and Linux 4.18.x this works fine.
With Debian/bullseye and Linux 5.10.x this does not work anymore.
The reason for that is that all configured routes are lost after
relocating the guest.
This looks to me like a major regression.

The network is configured via /etc/network/interfaces and executing
systemctl restart networking fixes the issue. This can be done via a 
udev rule, but this looks like a rather incomplete workaround to us.

All manually added routing information will be lost anyway.

And I might not imagine what happens to any firewall connection
tables or ipvs connection tracking information in case of a Live
Guest Relocation.

So is there any kernel level solution for this you can think of?

Thanks for any advice and comments,

best regards
 Waldemar
