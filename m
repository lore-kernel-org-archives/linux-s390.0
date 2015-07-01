From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/1] KVM: s390: virtio-ccw: Fix config space values
Date: Wed, 1 Jul 2015 16:05:27 +0200
Message-ID: <5593F3A7.3070100@redhat.com>
References: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
 <20150701154427-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150701154427-mutt-send-email-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Eric Farman <farman@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/07/2015 15:45, Michael S. Tsirkin wrote:
> > Paolo,
> > 
> > here is fix targetted for kvm/master (4.2) that fixes an issue with
> > virtio config space on s390. It mostly manifests in vhost-scsi
> > not working properly on s390. The problem itself might affect other
> > things as well so cc stable/target 4.2.
> > 
> > @Michael FYI, sending this via Paolo as most virtio-ccw kernel
> > things went this way.
>
> OK but virtio patches should be Cc'd to the virtualization mailing
> list. So I think we need a separate MAINTAINERS entry for
> s390/virtio.

See my other email---I think no special case is necessary.

Paolo
