Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49514 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729992AbgBYQXJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 11:23:09 -0500
Date: Tue, 25 Feb 2020 17:22:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 33/36] DOCUMENTATION: Protected virtual machine
 introduction and IPL
Message-ID: <20200225172255.6ec8e7ac.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-34-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-34-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:41:04 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Add documentation about protected KVM guests and description of changes
> that are necessary to move a KVM VM into Protected Virtualization mode.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: fixing and conversion to rst]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/index.rst        |   2 +
>  Documentation/virt/kvm/s390-pv-boot.rst |  83 +++++++++++++++++
>  Documentation/virt/kvm/s390-pv.rst      | 116 ++++++++++++++++++++++++
>  MAINTAINERS                             |   1 +
>  4 files changed, 202 insertions(+)
>  create mode 100644 Documentation/virt/kvm/s390-pv-boot.rst
>  create mode 100644 Documentation/virt/kvm/s390-pv.rst
> 
(...)
> diff --git a/Documentation/virt/kvm/s390-pv-boot.rst b/Documentation/virt/kvm/s390-pv-boot.rst
> new file mode 100644
> index 000000000000..b762df206ab7
> --- /dev/null
> +++ b/Documentation/virt/kvm/s390-pv-boot.rst
> @@ -0,0 +1,83 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +s390 (IBM Z) Boot/IPL of Protected VMs
> +======================================
> +
> +Summary
> +-------
> +The memory of Protected Virtual Machines (PVMs) is not accessible to
> +I/O or the hypervisor. In those cases where the hypervisor needs to
> +access the memory of a PVM, that memory must be made accessible.
> +Memory made accessible to the hypervisor will be encrypted. See
> +:doc:`s390-pv` for details."
> +
> +On IPL (boot) a small plaintext bootloader is started, which provides
> +information about the encrypted components and necessary metadata to
> +KVM to decrypt the protected virtual machine.
> +
> +Based on this data, KVM will make the protected virtual machine known
> +to the Ultravisor(UV) and instruct it to secure the memory of the PVM,

s/Ultravisor(UV)/Ultravisor (UV)/

> +decrypt the components and verify the data and address list hashes, to
> +ensure integrity. Afterwards KVM can run the PVM via the SIE
> +instruction which the UV will intercept and execute on KVM's behalf.
(...)
> +Subcodes 4 and 7, which specify operations that do not clear the guest
> +memory, will result in specification exceptions. This is because the
> +UV will clear all memory when a secure VM is removed, and therefore
> +non-clearing IPL subcodes are not allowed."

stray '"'

(...)
> diff --git a/Documentation/virt/kvm/s390-pv.rst b/Documentation/virt/kvm/s390-pv.rst
> new file mode 100644
> index 000000000000..27fe03eaeaad
> --- /dev/null
> +++ b/Documentation/virt/kvm/s390-pv.rst
> @@ -0,0 +1,116 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +s390 (IBM Z) Ultravisor and Protected VMs
> +=========================================
> +
> +Summary
> +-------
> +Protected virtual machines (PVM) are KVM VMs that do not allow KVM to
> +access VM state like guest memory or guest registers. Instead, the
> +PVMs are mostly managed by a new entity called Ultravisor (UV). The UV
> +provides an API that can be used by PVMs and KVM to request management
> +actions.
> +
> +Each guest starts in the non-protected mode and then may make a

s/in the/in/

> +request to transition into protected mode. On transition, KVM
> +registers the guest and its VCPUs with the Ultravisor and prepares
> +everything for running it.
(...)
> +
> +Mask notification interceptions
> +-------------------------------
> +In order to be notified when a PVM enables a certain class of
> +interrupt, KVM cannot intercept lctl(g) and lpsw(e) anymore. As a

"KVM cannot intercept (...) in order to notified..." might read a bit
better.

> +replacement, two new interception codes have been introduced: One
> +indicating that the contents of CRs 0, 6, or 14 have been changed,
> +indicating different interruption subclasses; and one indicating that
> +PSW bit 13 has been changed, indicating that a machine check
> +intervention was requested and those are now enabled.
> +
> +Instruction emulation
> +---------------------
> +With the format 4 state description for PVMs, the SIE instruction already
> +interprets more instructions than it does with format 2. It is not able
> +to interpret every instruction, but needs to hand some tasks to KVM;
> +therefore, the SIE and the ultravisor safeguard emulation inputs and outputs.
> +
> +The control structures associated with SIE provide the Secure
> +Instruction Data Area (SIDA), the Interception Parameters (IP) and the
> +Secure Interception General Register Save Area.  Guest GRs and most of
> +the instruction data, such as I/O data structures, are filtered.
> +Instruction data is copied to and from the Secure Instruction Data
> +Area (SIDA) when needed.  Guest GRs are put into / retrieved from the

I think you can use 'SIDA' directly the second time.

> +Secure Interception General Register Save Area.

(...)

Otherwise,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
