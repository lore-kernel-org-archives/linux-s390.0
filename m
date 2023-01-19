Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC95C004D4
	for <linux-s390@archiver.kernel.org>; Thu, 19 Jan 2023 14:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjASOE6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjASOE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Jan 2023 09:04:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B926B0;
        Thu, 19 Jan 2023 06:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7766BCE22B1;
        Thu, 19 Jan 2023 14:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A4EC433D2;
        Thu, 19 Jan 2023 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674137091;
        bh=gnM0aF25mfMtoSW5Jtq0KcQ6CpBJFX2/gUgnyKab6aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+WBUwyUX9r9ew85BwDT6f4mopSskOyprmZFXKFKVpw5cAfwk76ywX0DiuYfKsMR7
         WlZn2EYIBOc4VZoqcBUvvqwLFUxxmZmTx8B5dnKMbp/2GLatFipzDLr3OFqCeBpr48
         SjecCr/l3f3dCOiEhylhdNTVTFv8TKYAX/Je/Ho4=
Date:   Thu, 19 Jan 2023 15:04:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix out-of-bounds access when specifying invalid
 console
Message-ID: <Y8lOAVTBlay2QrYC@kroah.com>
References: <20221209112737.3222509-1-svens@linux.ibm.com>
 <yt9dh6x6n4tq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dh6x6n4tq.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jan 04, 2023 at 08:20:49AM +0100, Sven Schnelle wrote:
> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Hi,
> >
> > these two patches fix a crash in the tty driver when a user specifies an
> > invalid console like 'console=tty3000'. The first patch adds a check to
> > tty_driver_lookup_tty(), the second one prevents that such a console gets
> > registered in the vt driver.
> >
> > Changes in v2:
> > - trim commit message in first patch
> > - add second patch as suggested by Jiri Slaby
> >
> > Sven Schnelle (2):
> >   tty: fix out-of-bounds access in tty_driver_lookup_tty()
> >   tty/vt: prevent registration of console with invalid number
> >
> >  drivers/tty/tty_io.c | 8 +++++---
> >  drivers/tty/vt/vt.c  | 6 ++++++
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> Gentle ping... I couldn't find that this was applied anywhere?

Sorry, still digging out of a lot of patches...
