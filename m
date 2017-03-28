From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 00/16] basic vfio-ccw infrastructure
Date: Tue, 28 Mar 2017 15:31:52 +0200
Message-ID: <20170328153152.16ddb794.cornelia.huck@de.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
        <20170328102016.4926f21d.cornelia.huck@de.ibm.com>
        <ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 28 Mar 2017 10:39:40 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/28/2017 10:20 AM, Cornelia Huck wrote:

> > Patch set looks good to me, and I think we should target it for the
> > next merge window (the interface looks fine, and we can iron out any
> > other things later.)
> > 
> > Question: Which tree should this go through? Vfio or kvm/s390?
> 
> Reading todays MAINTAINERS file this would go via Martins tree, after the last
> patch it will be separate. I can certainly carry that via the kvms390 tree,
> but Alex is certainly the final maintainer. 
> So what about having a new repository under 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/
> e.g. vfio.git that will then queue the patches for Alex to take?

Whatever we decide:

Patches with collected acks pushed out to

https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-v0
