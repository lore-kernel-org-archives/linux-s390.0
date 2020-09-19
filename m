Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgISXYU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 19 Sep 2020 19:24:20 -0400
Date: Sun, 20 Sep 2020 00:24:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200919232411.GK3421308@ZenIV.linux.org.uk>
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
 <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Sat, Sep 19, 2020 at 03:53:40PM -0700, Andy Lutomirski wrote:

> > It would not be a win - most of the syscalls don't give a damn
> > about 32bit vs. 64bit...
> 
> Any reasonable implementation would optimize it out for syscalls that don’t care.  Or it could be explicit:
> 
> DEFINE_MULTIARCH_SYSCALL(...)

1) what would that look like?
2) have you counted the syscalls that do and do not need that?
3) how many of those realistically *can* be unified with their
compat counterparts?  [hint: ioctl(2) cannot]
