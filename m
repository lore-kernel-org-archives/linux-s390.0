From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 02 Sep 2014 08:16:54 +1000
Message-ID: <1409609814.30640.11.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409593066.git.luto@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2014-09-01 at 10:39 -0700, Andy Lutomirski wrote:
> Changes from v1:
>  - Using the DMA API is optional now.  It would be nice to improve the
>    DMA API to the point that it could be used unconditionally, but s390
>    proves that we're not there yet.
>  - Includes patch 4, which fixes DMA debugging warnings from virtio_net.

I'm not sure if you saw my reply on the other thread but I have a few
comments based on the above "it would be nice if ..."

So here we have both a yes and a no :-)

It would be nice to avoid those if () games all over and indeed just
use the DMA API, *however* we most certainly don't want to actually
create IOMMU mappings for the KVM virio case. This would be a massive
loss in performances on several platforms and generally doesn't make
much sense.

However, we can still use the API without that on any architecture
where the dma mapping API ends up calling the generic dma_map_ops,
it becomes just a matter of virtio setting up some special "nop" ops
when needed.

The difficulty here resides in the fact that we have never completely
made the dma_map_ops generic. The ops themselves are defined generically
as are the dma_map_* interfaces based on them, but the location of the
ops pointer is still more/less arch specific and some architectures
still chose not to use that indirection at all I believe.

Cheers,
Ben.
