From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 2/2] KVM: remove garbage arg to *hardware_{en,dis}able
Date: Mon, 1 Sep 2014 11:23:30 +0200
Message-ID: <20140901092330.GE19836@cbox>
References: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
 <1409231583-7048-3-git-send-email-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409231583-7048-3-git-send-email-rkrcmar@redhat.com>
Sender: kvm-ppc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 28, 2014 at 03:13:03PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
> In the beggining was on_each_cpu(), which required an unused argument=
 to
> kvm_arch_ops.hardware_{en,dis}able, but this was soon forgotten.
>=20
> Remove unnecessary arguments that stem from this.
>=20
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>

=46or the arm/arm64 part:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
