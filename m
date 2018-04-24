From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/5] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Tue, 24 Apr 2018 11:31:47 +0200
Message-ID: <20180424113147.139e2e0b.cohuck@redhat.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
        <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 Apr 2018 13:01:09 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> If the translation of a channel program fails, we may end up attempting
> to clean up (free, unpin) stuff that never got translated (and allocated,
> pinned) in the first place.
> 
> By adjusting the lengths of the chains accordingly (so the element that
> failed, and all subsequent elements are excluded) cleanup activities
> based on false assumptions can be avoided.
> 
> Let's make sure cp_free works properly after cp_prefetch returns with an
> error by setting ch_len of a ccw chain to the number of the translated
> CCWs on that chain.
> 
> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Thanks, applied. I'll probably send a pull req after lunch.

[Some procedural notes: I've created a new vfio-ccw-fixes branch based
on the s390 fixes branch for easier handling. Things targeted for the
next release will go on the vfio-ccw branch on top of the s390 features
branch, as before. Does that work for everybody? (And I am the only
vfio-ccw maintainer with a kernel.org account, right?)]
