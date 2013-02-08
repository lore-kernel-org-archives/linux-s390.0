From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] kvm-s390: Bugfix for handling of iscs.
Date: Fri, 08 Feb 2013 15:20:53 +0100
Message-ID: <511509C5.6070707@de.ibm.com>
References: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 07/02/13 13:20, Cornelia Huck wrote:
> Hi,
> 
> here's another kvm-s390 bugfix for kvm-next, this time fixing a
> thinko in the I/O interrupt injection.
> 
> Please apply.
> 
> Cornelia Huck (1):
>   KVM: s390: Fix handling of iscs.
> 
>  arch/s390/kvm/interrupt.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Would be good if this could be queued for 3.9 together with the
other virtio-ccw patches to ensure that the first version of 
virtio-ccw in Linus tree works as expected.

Thanks

Christian
