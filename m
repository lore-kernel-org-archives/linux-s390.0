Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 8 Aug 2018 14:47:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use
 KVM_REQ_VSIE_RESTART
Message-ID: <20180808144733.507ba955.cohuck@redhat.com>
In-Reply-To: <20180807125131.3606-3-david@redhat.com>
References: <20180807125131.3606-1-david@redhat.com>
        <20180807125131.3606-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  7 Aug 2018 14:51:31 +0200
David Hildenbrand <david@redhat.com> wrote:

> When we change the crycb (or execution controls), we also have to make sure
> that the vSIE shadow datastructures properly consider the changed
> values before rerunning the vSIE. We can achieve that by simply using a
> VCPU request now.

Is this actually a concrete problem right now, or does this only become
a real concern with vfio-ap?

> 
> This has to be a synchronous request (== handled before entering the
> (v)SIE again).
> 
> The request will make sure that the vSIE handler is left, and that the
> request will be processed (NOP), therefore forcing a reload of all
> vSIE data (including rebuilding the crycb) when re-entering the vSIE
> interception handler the next time.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
