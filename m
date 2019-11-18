Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbfKRMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 07:15:23 -0500
Received: by mail-wm1-f69.google.com with SMTP id z3so11251936wmk.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 04:15:17 -0800 (PST)
Subject: Re: [GIT PULL 0/5] KVM: s390: fixes and enhancements for 5.5
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47e79931-f6e0-ad92-e705-0d6c07cdf515@redhat.com>
Date: Mon, 18 Nov 2019 13:15:20 +0100
MIME-Version: 1.0
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

On 18/11/19 09:35, Christian Borntraeger wrote:
> Paolo, Radim,
>=20
> everybody is busy on the ultravisor related things, so only a small
> number of changes for s390 for 5.5.
>=20
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c=
5c:
>=20
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-5.5-1
>=20
> for you to fetch changes up to c7b7de63124645089ccf9900b9e5ea08059ccae0:
>=20
>   KVM: s390: Do not yield when target is already running (2019-10-10 13:1=
8:40 +0200)
>=20

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: small fixes and enhancements
>=20
> - selftest improvements
> - yield improvements
> - cleanups
>=20
> ----------------------------------------------------------------
> Christian Borntraeger (3):
>       selftests: kvm: make syncregs more reliable on s390
>       KVM: s390: count invalid yields
>       KVM: s390: Do not yield when target is already running
>=20
> Janosch Frank (1):
>       KVM: s390: Cleanup kvm_arch_init error path
>=20
> Thomas Huth (1):
>       KVM: s390: Remove unused parameter from __inject_sigp_restart()
>=20
>  arch/s390/include/asm/kvm_host.h                   |  1 +
>  arch/s390/kvm/diag.c                               | 22 ++++++++++++++++=
++----
>  arch/s390/kvm/interrupt.c                          |  5 ++---
>  arch/s390/kvm/kvm-s390.c                           | 19 ++++++++--------=
---
>  tools/testing/selftests/kvm/s390x/sync_regs_test.c | 15 +++++++++------
>  5 files changed, 38 insertions(+), 24 deletions(-)
>=20
