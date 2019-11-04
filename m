Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727861AbfKDOS2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:18:28 -0500
Date: Mon, 4 Nov 2019 15:18:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 01/37] DOCUMENTATION: protvirt: Protected virtual machine
 introduction
Message-ID: <20191104151815.6f11a274.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-2-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:23 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Introduction to Protected VMs.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  Documentation/virtual/kvm/s390-pv.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/virtual/kvm/s390-pv.txt
>=20
> diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtua=
l/kvm/s390-pv.txt
> new file mode 100644
> index 000000000000..86ed95f36759
> --- /dev/null
> +++ b/Documentation/virtual/kvm/s390-pv.txt

This should be under /virt/, I think. Also, maybe start out with RST
already for new files?

> @@ -0,0 +1,23 @@
> +Ultravisor and Protected VMs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Summary:
> +
> +Protected VMs (PVM) are KVM VMs, where KVM can't access the VM's state
> +like guest memory and guest registers anymore. Instead the PVMs are

s/Instead/Instead,/

> +mostly managed by a new entity called Ultravisor (UV), which provides
> +an API, so KVM and the PVM can request management actions.

Hm...

"The UV provides an API (both for guests and hypervisors), where PVMs
and KVM can request management actions." ?

> +
> +Each guest starts in the non-protected mode and then transitions into

"and then may make a request to transition into protected mode" ?

> +protected mode. On transition KVM registers the guest and its VCPUs
> +with the Ultravisor and prepares everything for running it.
> +
> +The Ultravisor will secure and decrypt the guest's boot memory
> +(i.e. kernel/initrd). It will safeguard state changes like VCPU
> +starts/stops and injected interrupts while the guest is running.
> +
> +As access to the guest's state, like the SIE state description is

"such as the SIE state description," ?

> +normally needed to be able to run a VM, some changes have been made in
> +SIE behavior and fields have different meaning for a PVM. SIE exits
> +are minimized as much as possible to improve speed and reduce exposed
> +guest state.
