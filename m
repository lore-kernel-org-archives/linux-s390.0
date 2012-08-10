From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/4] s390/kvm: Handle hosts not supporting s390-virtio.
Date: Fri, 10 Aug 2012 10:42:48 +0200
Message-ID: <20120810084248.GA3283@osiris.de.ibm.com>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
 <1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
 <50238B0D.2060604@redhat.com>
 <20120809124157.582fd609@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120809124157.582fd609@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 09, 2012 at 12:41:57PM +0200, Cornelia Huck wrote:
> On Thu, 09 Aug 2012 13:03:57 +0300
> Avi Kivity <avi@redhat.com> wrote:
> 
> > On 08/07/2012 05:52 PM, Cornelia Huck wrote:
> > > Running under a kvm host does not necessarily imply the presence of
> > > a page mapped above the main memory with the virtio information;
> > > however, the code includes a hard coded access to that page.
> > > 
> > > Instead, check for the presence of the page and exit gracefully
> > > before we hit an addressing exception if it does not exist.
> > > 
> > >  /*
> > >   * Init function for virtio
> > >   * devices are in a single page above top of "normal" mem
> > > @@ -443,6 +458,12 @@ static int __init kvm_devices_init(void)
> > >  	}
> > >  
> > >  	kvm_devices = (void *) real_memory_size;
> > > +	if (test_devices_support() < 0) {
> > > +		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
> > > +		root_device_unregister(kvm_root);
> > > +		/* No error. */
> > > +		return 0;
> > > +	}
> > >  
> > 
> > Cleaner to defer root_device_register() until after the mapping has been
> > verified.
> 
> OK, will reorder.

Please use the "lura" instruction to figure out if the guest real page
even exists _before_ creating the mapping.
That way you don't need all the code afterwards.
