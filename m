From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/1] vfio-ccw: one bugfix for 4.12
Date: Wed, 26 Jul 2017 10:36:30 +0200
Message-ID: <20170726103630.377b3c6e@gondolin>
References: <20170724164701.26715-1-cohuck@redhat.com>
        <20170726082853.240ad7e2@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170726082853.240ad7e2@mschwideX1>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Jul 2017 08:28:53 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 24 Jul 2017 18:47:00 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > The following changes since commit 97ca7bfc19605bc08e9183441b8b8545e84032d6:
> > 
> >   s390/mm: set change and reference bit on lazy key enablement (2017-07-13 11:28:29 +0200)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20170724
> > 
> > for you to fetch changes up to c389377c01bf2d6e2a178e86aef8535931bfbd75:
> > 
> >   vfio: ccw: fix bad ptr math for TIC cda translation (2017-07-24 09:54:37 +0200)
> > 
> > ----------------------------------------------------------------
> > A bugfix in the ccw translation code.
> > 
> > ----------------------------------------------------------------  
> 
> Applied to s390/linux:features. Thanks.
> 

Thanks. Would you consider to push this out as a bugfix if you have
anything else queued up as well?
