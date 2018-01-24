From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: add proper locking for CMMA migration
 bitmap
Date: Wed, 24 Jan 2018 15:21:44 +0100
Message-ID: <20180124152144.4ba21dca.cohuck@redhat.com>
References: <20180124124100.15690-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124124100.15690-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Jan 2018 13:41:00 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Some parts of the cmma migration bitmap is already protected
> with the kvm->lock (e.g. the migration start). On the other
> hand the read of the cmma bits is not protected against a
> concurrent free, neither is the emulation of the ESSA instruction.
> Let's extend the locking to all related ioctls by using
> the slots lock and wait for the freeing until all unlocked
> users have finished (those hold kvm->srcu for read).
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: stable@vger.kernel.org # 4.13+
> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
> v1->v2: fix comments in kvm_s390_vm_[start|stop]_migration
>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
