From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/17] target-s390x: Add KVM VM
 attribute interface for S390 CPU models
Date: Mon, 27 Apr 2015 15:01:30 +0200
Message-ID: <20150427150130.134689ab@bee>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1428933396-37887-12-git-send-email-mimu@linux.vnet.ibm.com>
	<553DF033.1060405@de.ibm.com>
	<20150427114353.0386c3eb@bee>
	<553E1506.5080206@de.ibm.com>
	<20150427130758.5be04a87@bee>
	<20150427141913.7014b017.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150427141913.7014b017.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 Apr 2015 14:19:13 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> > > >> Would it make sense to do the cast here....  
> > > > 
> > > > cpu_model_get/set() is used to handle both attributes,
> > > > KVM_S390_VM_CPU_MACHINE and KVM_S390_VM_CPU_PROCESSOR.
> > > > Both require a different type in the signature, (S390ProcessorProps*)
> > > > and (S390MachineProps*). Adding both as parameters seems to be odd
> > > > and would require additionally logic in the function.
> > > > Thus I think doing the cast outside is just the right thing to do.  
> > > 
> > > So what about a void pointer then as parameter?
> > > I prefer a pointer for qemu process memory over uint64_t as part of the 
> > > function interface. This makes it somewhat clearer that this is an
> > > address within QEMU. Both ways will certainly work, though.  
> > 
> > The interface calls are:
> > 
> > int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
> > int kvm_s390_get_processor_props(S390ProcessorProps *prop)
> > 
> > cpu_model_get/set() are just static helpers.  
> 
> So this makes them internal calls...
> 
> >   
> > > 
> > > Conny, I guess you will pick up the patches. Any preference?  
> 
> ...and I'd prefer using a void pointer for them.

Ok, I will make void pointers then to emphasize their address characteristics.

Michael
