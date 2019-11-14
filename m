Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfKNPPy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 10:15:54 -0500
Date: Thu, 14 Nov 2019 16:15:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 17/37] DOCUMENTATION: protvirt: Instruction emulation
Message-ID: <20191114161526.1100f4fe.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-18-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-18-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:39 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> As guest memory is inaccessible and information about the guest's
> state is very limited, new ways for instruction emulation have been
> introduced.
>=20
> With a bounce area for guest GRs and instruction data, guest state
> leaks can be limited by the Ultravisor. KVM now has to move
> instruction input and output through these areas.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  Documentation/virtual/kvm/s390-pv.txt | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/s390-pv.txt b/Documentation/virtua=
l/kvm/s390-pv.txt
> index e09f2dc5f164..cb08d78a7922 100644
> --- a/Documentation/virtual/kvm/s390-pv.txt
> +++ b/Documentation/virtual/kvm/s390-pv.txt
> @@ -48,3 +48,50 @@ interception codes have been introduced. One which tel=
ls us that CRs
>  have changed. And one for PSW bit 13 changes. The CRs and the PSW in
>  the state description only contain the mask bits and no further info
>  like the current instruction address.
> +
> +
> +Instruction emulation:
> +With the format 4 state description the SIE instruction already

s/description/description,/

> +interprets more instructions than it does with format 2. As it is not
> +able to interpret all instruction, the SIE and the UV safeguard KVM's

s/instruction/instructions/

> +emulation inputs and outputs.
> +
> +Guest GRs and most of the instruction data, like IO data structures

Hm, what 'IO data structures'?

> +are filtered. Instruction data is copied to and from the Secure
> +Instruction Data Area. Guest GRs are put into / retrieved from the
> +Interception-Data block.
> +
> +The Interception-Data block from the state description's offset 0x380
> +contains GRs 0 - 16. Only GR values needed to emulate an instruction
> +will be copied into this area.
> +
> +The Interception Parameters state description field still contains the
> +the bytes of the instruction text but with pre-set register
> +values. I.e. each instruction always uses the same instruction text,
> +to not leak guest instruction text.
> +
> +The Secure Instruction Data Area contains instruction storage
> +data. Data for diag 500 is exempt from that and has to be moved
> +through shared buffers to KVM.

I find this paragraph a bit confusing. What does that imply for diag
500 interception? Data is still present in gprs 1-4?

(Also, why only diag 500? Because it is the 'reserved for kvm' diagnose
call?)

> +
> +When SIE intercepts an instruction, it will only allow data and
> +program interrupts for this instruction to be moved to the guest via
> +the two data areas discussed before. Other data is ignored or results
> +in validity interceptions.
> +
> +
> +Instruction emulation interceptions:
> +There are two types of SIE secure instruction intercepts. The normal
> +and the notification type. Normal secure instruction intercepts will
> +make the guest pending for instruction completion of the intercepted
> +instruction type, i.e. on SIE entry it is attempted to complete
> +emulation of the instruction with the data provided by KVM. That might
> +be a program exception or instruction completion.
> +
> +The notification type intercepts inform KVM about guest environment
> +changes due to guest instruction interpretation. Such an interception

'interpretation by SIE' ?

> +is recognized for the store prefix instruction and provides the new
> +lowcore location for mapping change notification arming. Any KVM data
> +in the data areas is ignored, program exceptions are not injected and
> +execution continues on next SIE entry, as if no intercept had
> +happened.
