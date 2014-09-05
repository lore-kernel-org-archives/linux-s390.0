From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Fri, 05 Sep 2014 15:16:27 +1000
Message-ID: <1409894187.4246.115.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au>
	<CALCETrWMc6TQy02kLXLcLwMJbPkpY4yv7U-As6jv0Frx34nuww@mail.gmail.com>
	<87lhpykdbu.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lhpykdbu.fsf@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2014-09-05 at 12:01 +0930, Rusty Russell wrote:
> If the answers are both "yes", then x86 is going to be able to use
> virtio+IOMMU, so PPC looks like the odd one out. 

Well, yes and no ... ppc will be able to do that too, it's just
pointless and will suck performances.

Additionally, it will be incompatible with existing guests since
today, the guest assumes physical (doesn't use the dma mapping
routines), so even if x86 grows the ability to have virtio behind an
iommu in qemu, that will break existing guests.

>  Otherwise it looks
> like we're really going to want to stick with the "ignore IOMMU" rule
> until (handwave future), and we make an exception for Xen.

Either that or we have a capability that can be negociated.

There are other reasons for wanting to allow the use of the DMA ops,
such as people using virtio as a transport between two physically
connected machines (such as a CPU running a PCIe endpoint to a CPU
running a PCIe host, or two hosts connected to a non-transparent switch,
essentially using PCIe as a fast network fabric).

Cheers,
Ben.
