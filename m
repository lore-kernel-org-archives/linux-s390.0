Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728540AbgBKMXw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 07:23:52 -0500
Subject: Re: [PATCH 35/35] DOCUMENTATION: Protected virtual machine
 introduction and IPL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-36-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5d8050a6-c730-4325-2d46-2b5c9cdc8408@redhat.com>
Date: Tue, 11 Feb 2020 13:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-36-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> Add documentation about protected KVM guests and description of changes
> that are necessary to move a KVM VM into Protected Virtualization mode.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: fixing and conversion to rst]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
[...]
> diff --git a/Documentation/virt/kvm/s390-pv-boot.rst b/Documentation/vi=
rt/kvm/s390-pv-boot.rst
> new file mode 100644
> index 000000000000..47814e53369a
> --- /dev/null
> +++ b/Documentation/virt/kvm/s390-pv-boot.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +s390 (IBM Z) Boot/IPL of Protected VMs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Summary
> +-------
> +Protected Virtual Machines (PVM) are not accessible by I/O or the
> +hypervisor.  When the hypervisor wants to access the memory of PVMs
> +the memory needs to be made accessible. When doing so, the memory will
> +be encrypted.  See :doc:`s390-pv` for details.
> +
> +On IPL a small plaintext bootloader is started which provides
> +information about the encrypted components and necessary metadata to
> +KVM to decrypt the protected virtual machine.
> +
> +Based on this data, KVM will make the protected virtual machine known
> +to the Ultravisor(UV) and instruct it to secure the memory of the PVM,
> +decrypt the components and verify the data and address list hashes, to
> +ensure integrity. Afterwards KVM can run the PVM via the SIE
> +instruction which the UV will intercept and execute on KVM's behalf.
> +
> +The switch into PV mode lets us load encrypted guest executables and

Maybe rather: "After the switch into PV mode, the guest can load ..." ?

> +data via every available method (network, dasd, scsi, direct kernel,
> +...) without the need to change the boot process.
> +
> +
> +Diag308
> +-------
> +This diagnose instruction is the basis for VM IPL. The VM can set and
> +retrieve IPL information blocks, that specify the IPL method/devices
> +and request VM memory and subsystem resets, as well as IPLs.
> +
> +For PVs this concept has been extended with new subcodes:
> +
> +Subcode 8: Set an IPL Information Block of type 5 (information block
> +for PVMs)
> +Subcode 9: Store the saved block in guest memory
> +Subcode 10: Move into Protected Virtualization mode
> +
> +The new PV load-device-specific-parameters field specifies all data,

remove the comma?

> +that is necessary to move into PV mode.
> +
> +* PV Header origin
> +* PV Header length
> +* List of Components composed of
> +   * AES-XTS Tweak prefix
> +   * Origin
> +   * Size
> +
> +The PV header contains the keys and hashes, which the UV will use to
> +decrypt and verify the PV, as well as control flags and a start PSW.
> +
> +The components are for instance an encrypted kernel, kernel cmd and

s/kernel cmd/kernel parameters/ ?

> +initrd. The components are decrypted by the UV.
> +
> +All non-decrypted data of the guest before it switches to protected
> +virtualization mode are zero on first access of the PV.

Before it switches to protected virtualization mode, all non-decrypted
data of the guest are ... ?

> +
> +When running in protected mode some subcodes will result in exceptions
> +or return error codes.
> +
> +Subcodes 4 and 7 will result in specification exceptions as they would
> +not clear out the guest memory.
> +When removing a secure VM, the UV will clear all memory, so we can't
> +have non-clearing IPL subcodes.
> +
> +Subcodes 8, 9, 10 will result in specification exceptions.
> +Re-IPL into a protected mode is only possible via a detour into non
> +protected mode.
> +
> +Keys
> +----
> +Every CEC will have a unique public key to enable tooling to build
> +encrypted images.
> +See  `s390-tools <https://github.com/ibm-s390-tools/s390-tools/>`_
> +for the tooling.
> diff --git a/Documentation/virt/kvm/s390-pv.rst b/Documentation/virt/kv=
m/s390-pv.rst
> new file mode 100644
> index 000000000000..dbe9110dfd1e
> --- /dev/null
> +++ b/Documentation/virt/kvm/s390-pv.rst
> @@ -0,0 +1,116 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +s390 (IBM Z) Ultravisor and Protected VMs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Summary
> +-------
> +Protected virtual machines (PVM) are KVM VMs, where KVM can't access
> +the VM's state like guest memory and guest registers anymore. Instead,
> +the PVMs are mostly managed by a new entity called Ultravisor
> +(UV). The UV provides an API that can be used by PVMs and KVM to
> +request management actions.
> +
> +Each guest starts in the non-protected mode and then may make a
> +request to transition into protected mode. On transition, KVM
> +registers the guest and its VCPUs with the Ultravisor and prepares
> +everything for running it.
> +
> +The Ultravisor will secure and decrypt the guest's boot memory
> +(i.e. kernel/initrd). It will safeguard state changes like VCPU
> +starts/stops and injected interrupts while the guest is running.
> +
> +As access to the guest's state, such as the SIE state description, is
> +normally needed to be able to run a VM, some changes have been made in
> +SIE behavior. A new format 4 state description has been introduced,

s/in SIE behavior/in the behavior of the SIE instruction/ ?

> +where some fields have different meanings for a PVM. SIE exits are
> +minimized as much as possible to improve speed and reduce exposed
> +guest state.
[...]

 Thomas
