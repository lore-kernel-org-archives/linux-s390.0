From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/4] virtio: Clean up scatterlists and
	use the DMA API
Date: Thu, 28 Aug 2014 12:03:19 -0700
Message-ID: <CALCETrUb__cfwx1N-ZrrYJz0ffvD8jgRPwXOY3_oSb-8MCb3-Q@mail.gmail.com>
References: <cover.1409176034.git.luto@amacapital.net>
	<53FEDDF5.3030903@de.ibm.com>
	<CALCETrXxFJQsZyLmbrjYyXK6LKmRuBK=KMas2Db8vCVaBwe9yQ@mail.gmail.com>
	<53FF751D.2040006@de.ibm.com> <53FF7B1A.2050307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FF7B1A.2050307@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

[removed virtio-dev -- I'm sick of bounces]

On Thu, Aug 28, 2014 at 11:55 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 28/08/2014 20:29, Christian Borntraeger ha scritto:
>>>> >> block seems to work, with net a simple ping works, iperf causes this:
>>> >
>>> > I neither see the bug, nor can I reproduce it on x86_64 on KVM.  I
>>> > doubt that dma vs. non-dma is relevant.  I tried -net user a -net tap
>>> > with iperf running in both directions.  I also tried switching
>>> > virtio_pci into non-DMA-API mode.  No errors.
>>> >
>>> > Is there any chance that you could instrument that BUG_ON to print n,
>>> > i, in_sgs, out_sgs, total_sg, total_in, and total_out?  I assume this
>>> > is some oddity with patch 1, but I'm mystified.
>> Yes, its triggered by patch 1.
>
> What version of QEMU?  Can you two cat the "features" file in the
> virtio-net device's sysfs directory?

With vhost=on:

# cat /sys/class/net/eth0/device/features
0000011000000001111101010001110000000000000000000000000000000000

Without vhost=on:

# cat /sys/class/net/eth0/device/features
0000011000000001111101010001110000000000000000000000000000000000

Instrumenting the code says that indirect=1.

--Andy
