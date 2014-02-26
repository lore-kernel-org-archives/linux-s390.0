From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/6] s390x: Add I/O adapter registration.
Date: Wed, 26 Feb 2014 09:37:05 +0100
Message-ID: <20140226093705.3d111f2f.cornelia.huck@de.ibm.com>
References: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
	<1393349120-18228-5-git-send-email-cornelia.huck@de.ibm.com>
	<530DA5D8.6040909@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <530DA5D8.6040909@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Feb 2014 09:29:12 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 25/02/14 18:25, Cornelia Huck wrote:
> 
> > +int kvm_s390_io_adapter_map(uint32_t id, uint64_t map_addr, bool do_map)
> > +{
> > +    struct kvm_s390_io_adapter_req req = {
> > +        .id = id,
> > +        .type = do_map ? KVM_S390_IO_ADAPTER_MAP : KVM_S390_IO_ADAPTER_UNMAP,
> > +        .addr = map_addr,
> > +    };
> > +    KVMS390FLICState *flic = s390_get_flic();
> > +    struct kvm_device_attr attr;
> 
> Can we use designated initializer for attr, e.g.
>     struct kvm_device_attr attr = {
>         .group = KVM_DEV_FLIC_ADAPTER_MODIFY,
>         .addr = (uint64_t)&req,
>     }
> 
> > +    int r;
> > +
> > +    if (!flic) {
> > +        return -ENOSYS;
> > +    }
> > +    if (!kvm_check_extension(kvm_state, KVM_CAP_IRQ_ROUTING)) {
> > +        return -ENOSYS;
> > +    }
> > +
> > +    attr.group = KVM_DEV_FLIC_ADAPTER_MODIFY;
> > +    attr.addr = (uint64_t)&req;
> 
> and not do it here. That will zero out the other fields of attr.
> 
> Same for the register code.
> 

Hm, yes, I missed that. I'll change it for the next version.
