Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWO7M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 10:59:12 -0400
Date: Wed, 23 Sep 2020 15:59:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 5/9] fs: remove various compat readv/writev helpers
Message-ID: <20200923145901.GN3421308@ZenIV.linux.org.uk>
References: <20200923060547.16903-1-hch@lst.de>
 <20200923060547.16903-6-hch@lst.de>
 <20200923142549.GK3421308@ZenIV.linux.org.uk>
 <20200923143251.GA14062@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923143251.GA14062@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Wed, Sep 23, 2020 at 04:32:51PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 23, 2020 at 03:25:49PM +0100, Al Viro wrote:
> > On Wed, Sep 23, 2020 at 08:05:43AM +0200, Christoph Hellwig wrote:
> > >  COMPAT_SYSCALL_DEFINE3(readv, compat_ulong_t, fd,
> > > -		const struct compat_iovec __user *,vec,
> > > +		const struct iovec __user *, vec,
> > 
> > Um...  Will it even compile?
> > 
> > >  #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
> > >  COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
> > > -		const struct compat_iovec __user *,vec,
> > > +		const struct iovec __user *, vec,
> > 
> > Ditto.  Look into include/linux/compat.h and you'll see
> > 
> > asmlinkage long compat_sys_preadv64(unsigned long fd,
> >                 const struct compat_iovec __user *vec,
> >                 unsigned long vlen, loff_t pos);
> > 
> > How does that manage to avoid the compiler screaming bloody
> > murder?
> 
> That's a very good question.  But it does not just compile but actually
> works.  Probably because all the syscall wrappers mean that we don't
> actually generate the normal names.  I just tried this:
> 
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -468,7 +468,7 @@ asmlinkage long sys_lseek(unsigned int fd, off_t offset,
>  asmlinkage long sys_read(unsigned int fd, char __user *buf, size_t count);
>  asmlinkage long sys_write(unsigned int fd, const char __user *buf,
>                             size_t count);
> -asmlinkage long sys_readv(unsigned long fd,
> +asmlinkage long sys_readv(void *fd,
> 
> for fun, and the compiler doesn't care either..

Try to build it for sparc or ppc...
