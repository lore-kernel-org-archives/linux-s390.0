From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/17] target-s390x: Add KVM VM
 attribute interface for S390 CPU models
Date: Mon, 27 Apr 2015 11:43:53 +0200
Message-ID: <20150427114353.0386c3eb@bee>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1428933396-37887-12-git-send-email-mimu@linux.vnet.ibm.com>
	<553DF033.1060405@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553DF033.1060405@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 Apr 2015 10:15:47 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 13.04.2015 um 15:56 schrieb Michael Mueller:
> [...]
> > +static int cpu_model_get(KVMState *s, uint64_t attr, uint64_t addr)
> > +{
> > +    int rc = -ENOSYS;
> > +    struct kvm_device_attr dev_attr = {
> > +        .group = KVM_S390_VM_CPU_MODEL,
> > +        .attr = attr,
> > +        .addr = addr,
> 
> Would it make sense to do the cast here....

cpu_model_get/set() is used to handle both attributes,
KVM_S390_VM_CPU_MACHINE and KVM_S390_VM_CPU_PROCESSOR.
Both require a different type in the signature, (S390ProcessorProps*)
and (S390MachineProps*). Adding both as parameters seems to be odd
and would require additionally logic in the function.
Thus I think doing the cast outside is just the right thing to do.

Michael

> > +    };
> > +
> > +    if (kvm_vm_check_attr(s, dev_attr.group, dev_attr.attr)) {
> > +        rc = kvm_vm_ioctl(s, KVM_GET_DEVICE_ATTR, &dev_attr);
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static int cpu_model_set(KVMState *s, uint64_t attr, uint64_t addr)
> > +{
> > +    int rc = -ENOSYS;
> > +    struct kvm_device_attr dev_attr = {
> > +        .group = KVM_S390_VM_CPU_MODEL,
> > +        .attr = attr,
> > +        .addr = addr,
> 
> ...and here...
> 
> > +    };
> > +
> > +    if (kvm_vm_check_attr(s, dev_attr.group, dev_attr.attr)) {
> > +        rc = kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &dev_attr);
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
> > +{
> > +    int rc = -EFAULT;
> > +
> > +    if (s) {
> > +        rc = cpu_model_get(s, KVM_S390_VM_CPU_MACHINE, (uint64_t) prop);
> 
> and pass S390MachineProps as 3rd parameter?
> 
> 
> > +int kvm_s390_get_processor_props(S390ProcessorProps *prop)
> > +{
> > +    int rc;
> > +
> > +    rc = cpu_model_get(kvm_state, KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
> 
> dito
> > +    trace_kvm_get_processor_props(rc, prop->cpuid, prop->ibc);
> > +    return rc;
> > +}
> > +
> > +int kvm_s390_set_processor_props(S390ProcessorProps *prop)
> > +{
> > +    int rc;
> > +
> > +    rc = cpu_model_set(kvm_state, KVM_S390_VM_CPU_PROCESSOR, (uint64_t) prop);
> 
> dito
