Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:49141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 15:53:09 -0400
MIME-Version: 1.0
References: <20200923060547.16903-1-hch@lst.de> <20200923060547.16903-6-hch@lst.de>
 <20200923142549.GK3421308@ZenIV.linux.org.uk> <20200923143251.GA14062@lst.de>
 <20200923145901.GN3421308@ZenIV.linux.org.uk> <20200923163831.GO3421308@ZenIV.linux.org.uk>
 <CAK8P3a3nkLUOkR+jwz2_2LcYTUTqdVf8JOtZqKWbtEDotNhFZA@mail.gmail.com> <20200923194755.GR3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200923194755.GR3421308@ZenIV.linux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Sep 2020 21:52:47 +0200
Message-ID: <CAK8P3a1VPh0ufiUMbcRuj9wrpqojzQ_8mO68Vjc8yzLGxVNkpw@mail.gmail.com>
Subject: Re: [PATCH 5/9] fs: remove various compat readv/writev helpers
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Wed, Sep 23, 2020 at 9:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> FWIW, after playing with that for a while...  Do we really want the
> compat_sys_...() declarations to live in linux/compat.h?  Most of
> the users of that file don't want those; why not move them to
> linux/syscalls.h?

Sure, let's do that. The trend overall is to integrate the compat stuff
more closely into where the native implementation lives, so this
would just follow that trend.

I think with Christoph's latest patches, about half of them are
going away as well.

> Reason: there's a lot more users of linux/compat.h than those of
> linux/syscalls.h - it's pulled by everything in the networking stack,
> for starters...

Right, the network headers pull in almost everything else through
multiple indirect inclusions, anything we can do to reduce that
helps.

     Arnd
