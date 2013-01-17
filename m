From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 04/12] Update linux headers.
Date: Thu, 17 Jan 2013 15:05:46 +0000
Message-ID: <CAFEAcA8iZwQTLCf6EC3oud7HMFORS2WmL1amk10MCXmMD+2VGA@mail.gmail.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com> <1358432637-42512-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 17 January 2013 14:23, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> Base is kvm-next as of 2013/01/16.

> --- a/linux-headers/asm-powerpc/kvm_para.h
> +++ b/linux-headers/asm-powerpc/kvm_para.h
> @@ -78,7 +78,7 @@ struct kvm_vcpu_arch_shared {
>
>  #define KVM_HCALL_TOKEN(num)     _EV_HCALL_TOKEN(EV_KVM_VENDOR_ID, num)
>
> -#include <asm/epapr_hcalls.h>
> +#include <uapi/asm/epapr_hcalls.h>

This is reintroducing a bug, isn't it? cf
http://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02807.html

(maybe this just means the sync needs to be against some
different set of kernel headers?)

-- PMM
