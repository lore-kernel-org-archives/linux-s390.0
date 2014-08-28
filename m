From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Thu, 28 Aug 2014 11:51:58 -0700
Message-ID: <CALCETrWtZ8ZRDvcg8cCxS53zmUPZCpqKFuAEdurSXdR2yXsJSQ@mail.gmail.com>
References: <cover.1409176034.git.luto@amacapital.net>
	<53FEDDF5.3030903@de.ibm.com>
	<CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
	<53FF751D.2040006@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FF751D.2040006@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 28, 2014 at 11:29 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 28/08/14 20:06, Andy Lutomirski wrote:
> [...]
>>> block seems to work, with net a simple ping works, iperf causes this:
>>
>> I neither see the bug, nor can I reproduce it on x86_64 on KVM.  I
>> doubt that dma vs. non-dma is relevant.  I tried -net user a -net tap
>> with iperf running in both directions.  I also tried switching
>> virtio_pci into non-DMA-API mode.  No errors.
>>
>> Is there any chance that you could instrument that BUG_ON to print n,
>> i, in_sgs, out_sgs, total_sg, total_in, and total_out?  I assume this
>> is some oddity with patch 1, but I'm mystified.
>
> Yes, its triggered by patch 1.

I must be doing something wrong, since virtio_net isn't sending me
through that code path at all.  This may be related to ethtool
refusing to enable scatter-gather on my NIC.  This happens on
vhost-net and QEMU's implementation.  Grr.

Can you change the code to something like:

        if (i != total_sg) {
                printk(KERN_ERR "i=%d total_sg=%u total_out=%u total_in=%u out_\
sgs=%u in_sgs=%u\n",
                       i, total_sg, total_out, total_in, out_sgs, in_sgs);
        }
        BUG_ON(i != total_sg);

and try to capture another oops?

Sorry to ask for debugging help for something that's explicitly
designed not to affect your arch :-/

--Andy
