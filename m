Return-Path: <SRS0=e7nO=SU=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 18 Apr 2019 10:02:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Fix potential spectre warnings
Message-ID: <20190418100202.5e3505ed.cohuck@redhat.com>
In-Reply-To: <20190417005414.47801-1-farman@linux.ibm.com>
References: <20190417005414.47801-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Apr 2019 02:54:14 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Fix some warnings from smatch:
> 
> arch/s390/kvm/interrupt.c:2310 get_io_adapter() warn: potential spectre issue 'kvm->arch.adapters' [r] (local cap)
> arch/s390/kvm/interrupt.c:2341 register_io_adapter() warn: potential spectre issue 'dev->kvm->arch.adapters' [w]
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> A recent patch from Paolo [1] acted as a reminder (thanks, Christian!)
> that I had one for the s390 KVM code after some code reviews [2].
> Let's clean that up.
> 
> [1] https://patchwork.kernel.org/patch/10895463/
> [2] https://patchwork.kernel.org/patch/10788565/#22484223
> ---
>  arch/s390/kvm/interrupt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
