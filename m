From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 1/2] KVM: static inline empty kvm_arch functions
Date: Mon, 1 Sep 2014 11:21:49 +0200
Message-ID: <20140901092149.GD19836@cbox>
References: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
 <1409231583-7048-2-git-send-email-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409231583-7048-2-git-send-email-rkrcmar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 28, 2014 at 03:13:02PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
> Using static inline is going to save few bytes and cycles.
> For example on powerpc, the difference is 700 B after stripping.
> (5 kB before)
>=20
> This patch also deals with two overlooked empty functions:
> kvm_arch_flush_shadow was not removed from arch/mips/kvm/mips.c
>   2df72e9bc KVM: split kvm_arch_flush_shadow
> and kvm_arch_sched_in never made it into arch/ia64/kvm/kvm-ia64.c.
>   e790d9ef6 KVM: add kvm_arch_sched_in
>=20
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>

=46or the arm/arm64 part:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
