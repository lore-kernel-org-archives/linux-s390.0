Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfFKKhu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 06:37:50 -0400
Date: Tue, 11 Jun 2019 12:37:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 0/8] s390: virtio: support protected virtualization
Message-ID: <20190611123740.3d46f31b.cohuck@redhat.com>
In-Reply-To: <20190606115127.55519-1-pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Thu,  6 Jun 2019 13:51:19 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> * Documentation is still very sketchy. I'm committed to improving this,
>   but I'm currently hampered by some dependencies currently.  

Have the "dependencies" been resolved in the meantime? It probably
would be a good idea to include some documentation for what needs to be
dma and what doesn't somewhere in the kernel documentation (IIRC we
have a s390 drivers 'book' partially generated from kerneldoc; there's
some general document about the cio interfaces as well, but I'm not
sure how up-to-date that is.)

I think the code in here looks sane from my point of view (except for
the one easy-to-fix issue I found); I would be fine with the virtio-ccw
patches making it into the kernel via the s390 tree (and not via the
virtio tree).
