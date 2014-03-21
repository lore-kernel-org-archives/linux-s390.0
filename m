From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: adapter interrupt sources
Date: Fri, 21 Mar 2014 11:07:13 +0100
Message-ID: <20140321110713.4b2b29e8.cornelia.huck@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
	<1395079899-29239-4-git-send-email-cornelia.huck@de.ibm.com>
	<532C05CB.5010604@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <532C05CB.5010604@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Mar 2014 10:26:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 17/03/14 19:11, Cornelia Huck wrote:
> > Add a new interface to register/deregister sources of adapter interrupts
> > identified by an unique id via the flic. Adapters may also be maskable
> > and carry a list of pinned pages.
> > 
> > These adapters will be used by irq routing later.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> [...]
> 
> > +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
> > +{
> > +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> > +	struct s390_map_info *map;
> > +	int ret;
> > +
> > +	if (!adapter || !addr)
> > +		return -EINVAL;
> > +
> > +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> > +	if (!map) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	INIT_LIST_HEAD(&map->list);
> > +	map->addr = addr;
> > +	ret = get_user_pages_fast(addr, 1, 1, &map->page);
> > +	if (ret < 0)
> > +		goto out;
> > +	BUG_ON(ret != 1);
> > +	down_write(&adapter->maps_lock);
> > +	list_add_tail(&map->list, &adapter->maps);
> > +	up_write(&adapter->maps_lock);
> > +	ret = 0;
> 
> Can you limit the amount of pinned pages to something sane, e.g. 1MB?
> As far as I can see, QEMU will fall back to non-irqfd if the mapping fails.

I'll introduce a counter for that.

> 
> Otherwise looks good.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
