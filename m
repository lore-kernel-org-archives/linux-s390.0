Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch v2 02/10] kdump: Make kimage_load_crash_segment() weak
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <20110801203143.GH3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	 <20110727125807.695225427@linux.vnet.ibm.com>
	 <20110801203143.GH3805@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 11:30:03 +0200
Message-ID: <1312277403.4881.26.camel@br98xy6r>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek,

On Mon, 2011-08-01 at 16:31 -0400, Vivek Goyal wrote:
> On Wed, Jul 27, 2011 at 02:55:06PM +0200, Michael Holzheu wrote:

[snip]

> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -842,8 +842,8 @@ out:
> >  	return result;
> >  }
> >  
> > -static int kimage_load_crash_segment(struct kimage *image,
> > -					struct kexec_segment *segment)
> > +int __weak kimage_load_crash_segment(struct kimage *image,
> > +				     struct kexec_segment *segment)
> 
> A comment here why we are making it weak should help in increasing
> the code readability.

What about the following:

/*
 * Load crash segment into memory. Architecture code can override this
 * function. E.g. this is necessary for architectures that do not
 * create page tables for crashkernel memory.
 */
int __weak kimage_load_crash_segment(struct kimage *image,

Michael
