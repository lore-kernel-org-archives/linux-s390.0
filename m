From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] KVM: minor cleanup and optimizations
Date: Tue, 02 Sep 2014 00:46:05 +0200
Message-ID: <5404F72D.8030402@suse.de>
References: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
Sender: kvm-ppc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>
List-ID: <linux-s390.vger.kernel.org>



On 28.08.14 15:13, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> The first patch answers a demand for inline arch functions.
> (There is a lot of constant functions that could be inlined as well.)
>=20
> Second patch digs a bit into the history of KVM and removes a useless
> argument that seemed suspicious when preparing the first patch.
>=20
>=20
> Radim Kr=C4=8Dm=C3=A1=C5=99 (2):
>   KVM: static inline empty kvm_arch functions
>   KVM: remove garbage arg to *hardware_{en,dis}able

Acked-by: Alexander Graf <agraf@suse.de>


Alex
