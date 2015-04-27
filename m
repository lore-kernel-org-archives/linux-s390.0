From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 15/17] target-s390x: Extend arch specific
 QMP command query-cpu-definitions
Date: Mon, 27 Apr 2015 10:11:29 +0200
Message-ID: <553DEF31.5070803@de.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com> <1428933396-37887-16-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-16-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 13.04.2015 um 15:56 schrieb Michael Mueller:
> This patch implements the QMP command 'query-cpu-definitions' in the S390
> context. The command returns a list of cpu definitions in the current host
> context. A runnable and migratable cpu model has the related attributes
> set to true. The order attribute is used to bring the listed cpu definitions
> in a release order.

Can you add some explanation why we need the fallback code (e.g. something
along the line, when querying no KVM guest is available and to query the
capabilities we have to open a dummy VM bla bla)

[...]
> -static int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
> +static int get_machine_props_fallback(S390MachineProps *prop)
> +{
> +    struct kvm_device_attr dev_attr;
> +    int rc, kvmfd = -1, vmfd = -1;
> +
> +    rc  = qemu_open("/dev/kvm", O_RDWR);
> +    if (rc < 0) {
> +        goto out_err;
> +    }
> +    kvmfd = rc;
> +
> +    rc = ioctl(kvmfd, KVM_CREATE_VM, 0);
> +    if (rc < 0) {
> +        goto out_err;
> +    }
> +    vmfd = rc;
> +
> +    rc = ioctl(vmfd, KVM_CHECK_EXTENSION, KVM_CAP_VM_ATTRIBUTES);
> +    if (rc < 0) {
> +        rc = -ENOSYS;
> +        goto out_err;
> +    }
> +
> +    dev_attr.group = KVM_S390_VM_CPU_MODEL;
> +    dev_attr.attr = KVM_S390_VM_CPU_MACHINE;
> +    rc = ioctl(vmfd, KVM_HAS_DEVICE_ATTR, &dev_attr);
> +    if (rc < 0) {
> +        rc = -EFAULT;
> +        goto out_err;
> +    }
> +
> +    dev_attr.addr = (uint64_t) prop;
> +    rc = ioctl(vmfd, KVM_GET_DEVICE_ATTR, &dev_attr);
> +
> +out_err:
> +    if (vmfd >= 0) {
> +        close(vmfd);
> +    }
> +    if (kvmfd >= 0) {
> +        close(kvmfd);
> +    }
> +
> +    return rc;
> +}
> +
> +int kvm_s390_get_machine_props(KVMState *s, S390MachineProps *prop)
>  {
>      int rc = -EFAULT;
> 
>      if (s) {
>          rc = cpu_model_get(s, KVM_S390_VM_CPU_MACHINE, (uint64_t) prop);
> +    } else {
> +        rc = get_machine_props_fallback(prop);
>      }
>      trace_kvm_get_machine_props(rc, prop->cpuid, prop->ibc);
> 
