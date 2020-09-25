Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 25 Sep 2020 16:23:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: let import_iovec deal with compat_iovecs as well v4
Message-ID: <20200925152345.GX3421308@ZenIV.linux.org.uk>
References: <20200925045146.1283714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925045146.1283714-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 25, 2020 at 06:51:37AM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> this series changes import_iovec to transparently deal with compat iovec
> structures, and then cleanups up a lot of code dupliation.

OK, I can live with that.  Applied, let's see if it passes smoke tests
into -next it goes.
