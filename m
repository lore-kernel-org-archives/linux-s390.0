From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/5] s390x/virtio-ccw: Wire up irq routing and irqfds.
Date: Tue, 18 Mar 2014 17:13:04 +0100
Message-ID: <53287090.10105@redhat.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com> <1395079921-29325-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079921-29325-6-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 17/03/2014 19:12, Cornelia Huck ha scritto:
>      if (!qemu_opt_get_bool(qemu_get_machine_opts(), "kernel_irqchip", true) ||
> -        !kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> +        (!kvm_check_extension(s, KVM_CAP_IRQCHIP) &&
> +         kvm_enable_cap_vm(s, KVM_CAP_S390_IRQCHIP))) {

Please add a "< 0" here for clarity.

Paolo
