From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/5] s390x/mm: cleanup gmap_pte_op_walk()
Date: Wed, 20 Dec 2017 17:33:00 +0100
Message-ID: <20171220173300.6f308f2f.cohuck@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
        <20171220155300.102321-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 16:52:56 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: David Hildenbrand <david@redhat.com>
> 
> gmap_mprotect_notify() refuses shadow gmaps. Turns out that
> a) gmap_protect_range()
> b) gmap_read_table()
> c) gmap_pte_op_walk()
> 
> Are never called for gmap shadows. And never should be. This dates back
> to gmap shadow prototypes where we allowed to call mprotect_notify() on
> the gmap shadow (to get notified about the prefix pages getting removed).
> This is avoided by always getting notified about any change on the gmap
> shadow.
> 
> The only real function for walking page tables on shadow gmaps is
> gmap_table_walk().
> 
> So, essentially, these functions should never get called and
> gmap_pte_op_walk() can be cleaned up. Add some checks to callers of
> gmap_pte_op_walk().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20171110151805.7541-1-david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
