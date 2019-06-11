Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44851 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFKKoH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Jun 2019 06:44:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so13839507qtk.11
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 03:44:06 -0700 (PDT)
Date: Tue, 11 Jun 2019 06:44:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/8] s390: virtio: support protected virtualization
Message-ID: <20190611064354-mutt-send-email-mst@kernel.org>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
 <20190611123740.3d46f31b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611123740.3d46f31b.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Tue, Jun 11, 2019 at 12:37:40PM +0200, Cornelia Huck wrote:
> On Thu,  6 Jun 2019 13:51:19 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > * Documentation is still very sketchy. I'm committed to improving this,
> >   but I'm currently hampered by some dependencies currently.  
> 
> Have the "dependencies" been resolved in the meantime? It probably
> would be a good idea to include some documentation for what needs to be
> dma and what doesn't somewhere in the kernel documentation (IIRC we
> have a s390 drivers 'book' partially generated from kerneldoc; there's
> some general document about the cio interfaces as well, but I'm not
> sure how up-to-date that is.)
> 
> I think the code in here looks sane from my point of view (except for
> the one easy-to-fix issue I found); I would be fine with the virtio-ccw
> patches making it into the kernel via the s390 tree (and not via the
> virtio tree).

Yes, me too.
