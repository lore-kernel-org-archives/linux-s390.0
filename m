From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] vfio: ccw: validate the count field of a ccw before
 pinning
Date: Mon, 16 Oct 2017 11:14:20 +0200
Message-ID: <20171016111420.4a8ca1af.cohuck@redhat.com>
References: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
        <20171011023822.42948-3-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011023822.42948-3-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Oct 2017 04:38:22 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> If the count field of a ccw is zero, there is no need to
> try to pin page(s) for it. Let's check the count value
> before starting pinning operations.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

This sounds reasonable, and I could not spot anything in the
architecture that speaks against simply setting the IDA flag. Hopefully
there's nothing buried out of sight :)
