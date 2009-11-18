Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 18 Nov 2009 15:49:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [-next Nov 17] s390 build
	break(arch/s390/kernel/compat_wrapper.S)
Message-ID: <20091118144936.GB17146@linux-mips.org>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au> <4B0291BB.3090005@in.ibm.com> <20091117125201.GB5124@osiris.boeblingen.de.ibm.com> <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com> <20091117135525.GF5124@osiris.boeblingen.de.ibm.com> <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com> <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20091118144936.j0CjEFKx6PdiJoPJjTx6Q3hnZebLK1peKGxrXjVYDFw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Eric Paris <eparis@redhat.com>, Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-mips@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 18, 2009 at 08:04:18AM +0100, Heiko Carstens wrote:

> Please note that other architectures (I think at least arm and powerpc) put
> 64 bit values into even/odd register pairs and add padding if the first free
> available register is an odd one. So any of the following interfaces should
> work for all architectures:
> 
> long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>      	 	       int fd, const char  __user *pathname,
>                        u32 mask_high, u32 mask_low);
> 
> long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>                        u64 mask,
>      	 	       int fd, const char  __user *pathname);
> 
> long sys_fanotify_mark(u64 mask,
>      		       int fanotify_fd, unsigned int flags,
>      	 	       int fd, const char  __user *pathname);

Correct - but the splitting is unnecessary pain for some platforms like
64-bit userland on 64-bit MIPS where the 64-bit argument would be passed
in a single register so I have preference for the 2nd or 3rd suggestion.

The 1st prototype has the advantage of avoiding the need for a compat
wrapper which otherwise would look like:

long compat_sys_fanotify_mark(int fanotify_fd, unsigned int flags,
                       u32 a2, u32 a3,
     	 	       int fd, const char  __user *pathname);
{
	/* assuming 2nd suggested prototype from above */
	return sys_fanotify_mark(fd, flags,
				 merge64(a2, a3),
				 fd, pathname);
}

I'd prefer to see the compat code carrying the burden.

  Ralf
