Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388711AbfKESET (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:04:19 -0500
Date: Tue, 5 Nov 2019 19:04:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 12/37] KVM: s390: protvirt: Handle SE notification
 interceptions
Message-ID: <20191105190407.68992d92.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-13-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-13-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:34 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Since KVM doesn't emulate any form of load control and load psw
> instructions anymore, we wouldn't get an interception if PSWs or CRs
> are changed in the guest. That means we can't inject IRQs right after
> the guest is enabled for them.
>=20
> The new interception codes solve that problem by being a notification
> for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
> well a the machine check mask bit in the PSW.
>=20
> No special handling is needed for these interception codes, the KVM
> pre-run code will consult all necessary CRs and PSW bits and inject
> IRQs the guest is enabled for.

Just to clarify: The hypervisor can still access the relevant bits for
pv guests, this is only about the notification, right?

>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 ++
>  arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
