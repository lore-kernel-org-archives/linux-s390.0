From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] small optimizations for exitless interrupts
Date: Wed, 14 Feb 2018 09:38:06 +0100
Message-ID: <ff83e158-5f93-37d8-3548-59b7abe5bcef@de.ibm.com>
References: <20180213122858.74748-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180213122858.74748-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

queued both patches for Master (4.16)

On 02/13/2018 01:28 PM, Christian Borntraeger wrote:
> Some small optimizations for the exitless interrupts
> 
> Christian Borntraeger (2):
>   KVM: s390: optimize wakeup for exitless interrupts
>   KVM: s390: do not set intervention requests for GISA interrupts
> 
>  arch/s390/kvm/interrupt.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
