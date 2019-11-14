Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfKNNKB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 08:10:01 -0500
Date: Thu, 14 Nov 2019 14:09:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 11/37] DOCUMENTATION: protvirt: Interrupt injection
Message-ID: <20191114140946.7bca2350.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-12-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-12-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:33 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Interrupt injection has changed a lot for protected guests, as KVM
> can't access the cpus' lowcores. New fields in the state description,
> like the interrupt injection control, and masked values safeguard the
> guest from KVM.
>=20
> Let's add some documentation to the interrupt injection basics for
> protected guests.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  Documentation/virtual/kvm/s390-pv.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtua=
l/kvm/s390-pv.txt
> index 86ed95f36759..e09f2dc5f164 100644
> --- a/Documentation/virtual/kvm/s390-pv.txt
> +++ b/Documentation/virtual/kvm/s390-pv.txt
> @@ -21,3 +21,30 @@ normally needed to be able to run a VM, some changes h=
ave been made in
>  SIE behavior and fields have different meaning for a PVM. SIE exits
>  are minimized as much as possible to improve speed and reduce exposed
>  guest state.
> +
> +
> +Interrupt injection:
> +
> +Interrupt injection is safeguarded by the Ultravisor and, as KVM lost
> +access to the VCPUs' lowcores, is handled via the format 4 state
> +description.
> +
> +Machine check, external, IO and restart interruptions each can be
> +injected on SIE entry via a bit in the interrupt injection control
> +field (offset 0x54). If the guest cpu is not enabled for the interrupt
> +at the time of injection, a validity interception is recognized. The
> +interrupt's data is transported via parts of the interception data
> +block.

"Data associated with the interrupt needs to be placed into the
respective fields in the interception data block to be injected into
the guest."

?

> +
> +Program and Service Call exceptions have another layer of
> +safeguarding, they are only injectable, when instructions have
> +intercepted into KVM and such an exception can be an emulation result.

I find this sentence hard to parse... not sure if I understand it
correctly.

"They can only be injected if the exception can be encountered during
emulation of instructions that had been intercepted into KVM."

?

> +
> +
> +Mask notification interceptions:
> +As a replacement for the lctl(g) and lpsw(e) interception, two new
> +interception codes have been introduced. One which tells us that CRs
> +0, 6 or 14 have been changed and therefore interrupt masking might
> +have changed. And one for PSW bit 13 changes. The CRs and the PSW in

Might be helpful to mention that this bit covers machine checks, which
do not get a separate bit in the control block :)

> +the state description only contain the mask bits and no further info
> +like the current instruction address.

"The CRs and the PSW in the state description only contain the bits
referring to interrupt masking; other fields like e.g. the current
instruction address are zero."

?
