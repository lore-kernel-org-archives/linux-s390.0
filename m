Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502940AbgDPIvD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 04:51:03 -0400
Date: Thu, 16 Apr 2020 10:50:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: Optimize kvm_arch_vcpu_ioctl_run function
Message-ID: <20200416105019.51191d79.cohuck@redhat.com>
In-Reply-To: <8b92fb5b-5138-0695-fb90-6c36b8dfad00@linux.alibaba.com>
References: <20200416051057.26526-1-tianjia.zhang@linux.alibaba.com>
        <878sivx67g.fsf@vitty.brq.redhat.com>
        <1000159f971a6fa3b5bd9e5871ce4d82@kernel.org>
        <8b92fb5b-5138-0695-fb90-6c36b8dfad00@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Marc Zyngier <maz@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com

On Thu, 16 Apr 2020 16:45:33 +0800
Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:

> On 2020/4/16 16:28, Marc Zyngier wrote:
> > On 2020-04-16 08:03, Vitaly Kuznetsov wrote: =20
> >> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:
> >> =20
> >>> In earlier versions of kvm, 'kvm_run' is an independent structure
> >>> and is not included in the vcpu structure. At present, 'kvm_run'
> >>> is already included in the vcpu structure, so the parameter
> >>> 'kvm_run' is redundant.
> >>>
> >>> This patch simplify the function definition, removes the extra
> >>> 'kvm_run' parameter, and extract it from the 'kvm_vcpu' structure
> >>> if necessary.
> >>>
> >>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >>> ---
> >>>
> >>> v2 change:
> >>> =C2=A0 remove 'kvm_run' parameter and extract it from 'kvm_vcpu'
> >>>
> >>> =C2=A0arch/mips/kvm/mips.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
> >>> =C2=A0arch/powerpc/kvm/powerpc.c |=C2=A0 3 ++-
> >>> =C2=A0arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0 |=C2=A0 3 ++-
> >>> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 ++++++-----
> >>> =C2=A0include/linux/kvm_host.h=C2=A0=C2=A0 |=C2=A0 2 +-
> >>> =C2=A0virt/kvm/arm/arm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++---
> >>> =C2=A0virt/kvm/kvm_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> >>> =C2=A07 files changed, 17 insertions(+), 13 deletions(-)

> > Overall, there is a large set of cleanups to be done when both the vcpu=
=20
> > and the run
> > structures are passed as parameters at the same time. Just grepping the=
=20
> > tree for
> > kvm_run is pretty instructive.
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M. =20
>=20
> Sorry, it's my mistake, I only compiled the x86 platform, I will submit=20
> patch again.

I think it's completely fine (and even preferable) to do cleanups like
that on top.

[FWIW, I compiled s390 here.]
