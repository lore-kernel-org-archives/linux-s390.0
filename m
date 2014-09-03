From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 3 Sep 2014 19:39:24 +0300
Message-ID: <20140903163924.GA2587@redhat.com>
References: <CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<1409695810.30640.57.camel@pasglop>
	<CALCETrXA0Po5mhLWDn41_sT+zBwbo7Rzm5Nqxdmao-MbtfKvmQ@mail.gmail.com>
	<1409700010.30640.67.camel@pasglop>
	<CALCETrWTwoBLj6onvNWOrwvY_n3-rWx0KifR0xP7091Vd-xHbg@mail.gmail.com>
	<1409703942.30640.71.camel@pasglop> <5406C77B.1000809@redhat.com>
	<1409731536.30640.95.camel@pasglop> <54070555.70608@redhat.com>
	<CALCETrUW_T-KcpDXP+JYLW8sZ_dp3DiXAjEf_gF9iCHOsEsRxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUW_T-KcpDXP+JYLW8sZ_dp3DiXAjEf_gF9iCHOsEsRxQ@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@au1.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 03, 2014 at 08:07:15AM -0700, Andy Lutomirski wrote:
> On Sep 3, 2014 5:11 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:
> >
> > Il 03/09/2014 10:05, Benjamin Herrenschmidt ha scritto:
> > > On Wed, 2014-09-03 at 09:47 +0200, Paolo Bonzini wrote:
> > >>
> > >> IOMMU support for x86 is going to go in this week.
> > >
> > > But won't that break virtio on x86 ? Or will virtio continue bypassing
> > > it ? IE, the guest side virtio doesn't expect an IOMMU and doesn't call
> > > the dma mappings ops.
> > >
> > >> However, it is and likely will remain niche enough that I don't really
> > >> care about performance loss from IOMMU support.  If you enable it, you
> > >> want it.
> > >>
> > >> So from the QEMU point of view we can simply add the direct-ram-access
> > >> property, and have the pseries machine turn it on by default (while
> > >> other machines can leave it off by default---they have no IOMMU and
> > >> thus no performance cost).
> > >
> > > Well, it's only for virtio and should be on by default on x86 as well if
> > > an iommu is installed no ?
> >
> > Yes, only for virtio---but for x86 I think it should be off by default,
> > even if that means virtio+IOMMU requires a new kernel.
> 
> Just to clarify: is "it" the direct-ram-access property?  If so, I
> think I might agree.
> 
> Alternatively, could QEMU easily teach the IOMMU code to generate the
> ACPI tables such that virtio-pci devices aren't advertised as living
> behind the IOMMU?  This would work both with and without my patches.

How exactly does this look in ACPI?

> On the other hand, maybe this gets complicated when hotplug is
> involved.
> 
> --Andy
> 
> >
> > Paolo
