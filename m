Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <20200623131418.31473-6-tianjia.zhang@linux.alibaba.com> <e447bb5c-8b83-dfb1-a293-f2e9e586c2ec@flygoat.com>
In-Reply-To: <e447bb5c-8b83-dfb1-a293-f2e9e586c2ec@flygoat.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 16 Jul 2020 10:19:56 +0800
Message-ID: <CAAhV-H53JLTtyi=3vvSw3xxR12YiJq-5SKRXZzVcFLt=r2iXgQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] KVM: MIPS: clean up redundant kvm_run parameters
 in assembly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, all,

On Thu, Jul 16, 2020 at 10:10 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/6/23 21:14, Tianjia Zhang =E5=86=99=E9=81=93:
> > In the current kvm version, 'kvm_run' has been included in the 'kvm_vcp=
u'
> > structure. For historical reasons, many kvm-related function parameters
> > retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> > patch does a unified cleanup of these remaining redundant parameters.
> >
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Reviewed-by: Huacai Chen <chenhc@lemote.com>
>
> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Can confirm it works on Loongson-3A4000.
I'm sorry for the late response, and thank Jiaxun for his tests.

Huacai
>
> Thanks!
>
> > ---
>
> --
> - Jiaxun
