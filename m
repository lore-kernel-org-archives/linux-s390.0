From: Eric Paris <eparis@redhat.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Date: Wed, 18 Nov 2009 12:24:43 -0500
Message-ID: <1258565083.6446.61.camel@dhcp231-106.rdu.redhat.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
	 <4B0291BB.3090005@in.ibm.com>
	 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
	 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
	 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
	 <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
	 <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-11-18 at 08:04 +0100, Heiko Carstens wrote:


> long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>                        u64 mask,
>      	 	       int fd, const char  __user *pathname);

I'm willing to go with this interface if that works the best for most
arches.  I'll queue it up for -next tomorrow.

-Eric
