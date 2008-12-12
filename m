Return-Path: <linux-kernel-owner+w=401wt.eu-S1753576AbYLLTif@vger.kernel.org>
Date: Fri, 12 Dec 2008 11:07:30 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/4] s390: remove s390_root_dev_*()
Message-ID: <20081212190730.GB2950@kroah.com>
References: <1229012203.7968.79.camel@blaa> <1229012216-4211-1-git-send-email-markmc@redhat.com> <1229012216-4211-2-git-send-email-markmc@redhat.com> <1229012216-4211-3-git-send-email-markmc@redhat.com> <1229012216-4211-4-git-send-email-markmc@redhat.com> <20081211180025.045b9b4a@gondolin> <20081212102951.01446f22@gondolin> <1229074546.4041.8.camel@blaa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1229074546.4041.8.camel@blaa>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mark McLoughlin <markmc@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <aliguori@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 12, 2008 at 09:35:46AM +0000, Mark McLoughlin wrote:
> On Fri, 2008-12-12 at 10:29 +0100, Cornelia Huck wrote:
> > On Thu, 11 Dec 2008 18:00:25 +0100,
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > > On Thu, 11 Dec 2008 16:16:56 +0000,
> > > Mark McLoughlin <markmc@redhat.com> wrote:
> > > 
> > > > Replace s390_root_dev_register() with root_device_register() etc.
> > > 
> > > Nice, one more special case generalized :) I'll give it a run.
> > 
> > You missed one occurrence in iucv (see below);
> 
> Oops.
> 
> >  with that patch applied,
> > everything seems to work as expected, both for root devices created by
> > built-ins and by modules.
> 
> Thanks,
> Mark.
> 
> From: Mark McLoughlin <markmc@redhat.com>
> Subject: [PATCH] s390: remove s390_root_dev_*()
> 
> Replace s390_root_dev_register() with root_device_register() etc.

Can you resend this whole series, I see lots of replacements in this
thread and it would be good to know exactly what I should be
reviewing/applying.

thanks,

greg k-h
