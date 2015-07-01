From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] KVM: s390: virtio-ccw: Fix config space values
Date: Wed, 1 Jul 2015 15:45:57 +0200
Message-ID: <20150701154427-mutt-send-email-mst@redhat.com>
References: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Eric Farman <farman@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 29, 2015 at 04:44:00PM +0200, Christian Borntraeger wrote:
> Paolo,
> 
> here is fix targetted for kvm/master (4.2) that fixes an issue with
> virtio config space on s390. It mostly manifests in vhost-scsi
> not working properly on s390. The problem itself might affect other
> things as well so cc stable/target 4.2.
> 
> @Michael FYI, sending this via Paolo as most virtio-ccw kernel
> things went this way.

OK but virtio patches should be Cc'd to the virtualization mailing
list. So I think we need a separate MAINTAINERS entry for
s390/virtio.

> Cornelia Huck (1):
>   KVM: s390: virtio-ccw: don't overwrite config space values
> 
>  drivers/s390/kvm/virtio_ccw.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> -- 
> 2.3.0
