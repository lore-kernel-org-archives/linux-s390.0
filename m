From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: shrink halt polling even more for invalid
 wakeups
Date: Tue, 17 May 2016 19:00:51 +0200
Message-ID: <20160517190051.5f58e57d.cornelia.huck@de.ibm.com>
References: <1463474962-5941-1-git-send-email-borntraeger@de.ibm.com>
	<1463474962-5941-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1463474962-5941-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Matlack <dmatlack@google.com>, Wanpeng Li <kernellwp@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 17 May 2016 10:49:22 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> commit 3491caf2755e ("KVM: halt_polling: provide a way to qualify
>  wakeups during poll") added more aggressive shrinking of the
> polling interval if the wakeup did not match some criteria. This
> still allows to keep polling enabled if the polling time was
> smaller that the current max poll time (block_ns <=3D vcpu->halt_poll=
_ns).
> Performance measurement shows that even more aggressive shrinking
> (shrink polling on any invalid wakeup) reduces absolute and relative
> (to the workload) CPU usage even further.
>=20
> Cc: David Matlack <dmatlack@google.com>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  virt/kvm/kvm_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
