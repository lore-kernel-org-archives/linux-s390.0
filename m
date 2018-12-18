From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next] strace tests fail because of "y2038: socket: Add
 compat_sys_recvmmsg_time64"
Date: Tue, 18 Dec 2018 08:56:53 +0100
Message-ID: <20181218075653.GB3590@osiris>
References: <20181217130646.GB3560@osiris>
 <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
 <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 17, 2018 at 11:05:06PM +0100, Arnd Bergmann wrote:
> On Mon, Dec 17, 2018 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Dec 17, 2018 at 2:06 PM Heiko Carstens
> > <heiko.carstens@de.ibm.com> wrote:
> > >
> > > Hi Arnd,
> > >
> > > in linux-next as of today 16 strace self tests fail on s390. I could
> > > bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").
> > >
> > > The following tests fail:
> >
> > Hi Heiko,
> >
> > Thanks for the report and sorry I broke things. I'll have a closer look
> > tomorrow if I don't find it right away. I suppose the regression was in
> > native system calls, not the compat syscalls with 31-bit user space,
> > right?

Yes, I was talking about 64 bit native system calls.

> I found a bug in my patch by inspection. Can you try if the patch
> below makes it all work (apologies for the garbled whitespace),
> I'm considering a rewrite of that function now (to split it into two
> again), but want to make sure there isn't another problem in my
> original patch.

With your patch below applied, the tests pass again.

Thanks!

> ----
> diff --git a/net/socket.c b/net/socket.c
> index 3bb2ee083f97..7f9f225d0b6c 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2486,12 +2486,12 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>          return -EFAULT;
> 
>      if (!timeout && !timeout32)
> -        do_recvmmsg(fd, mmsg, vlen, flags, NULL);
> +        return do_recvmmsg(fd, mmsg, vlen, flags, NULL);
> 
>      datagrams = do_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);
> 
> -    if (!datagrams)
> -        return 0;
> +    if (datagrams <= 0)
> +        return datagrams;
> 
>      if (timeout && put_timespec64(&timeout_sys, timeout))
>          datagrams = -EFAULT;
> 
