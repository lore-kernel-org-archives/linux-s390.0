From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 17:11:45 +0200
Message-ID: <54072FB1.1090205@redhat.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@au1.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 03/09/2014 17:07, Andy Lutomirski ha scritto:
>> > Yes, only for virtio---but for x86 I think it should be off by default,
>> > even if that means virtio+IOMMU requires a new kernel.
> Just to clarify: is "it" the direct-ram-access property?  If so, I
> think I might agree.

Yes.

> Alternatively, could QEMU easily teach the IOMMU code to generate the
> ACPI tables such that virtio-pci devices aren't advertised as living
> behind the IOMMU?  This would work both with and without my patches.
> On the other hand, maybe this gets complicated when hotplug is
> involved.

That could be possible.  For hot-plug, you can simply forbid hotplugging
with direct-ram-access=on.  If you want hotplug, then we should add the
direct-ram-access property to PCI bridges too (with the same limitation
on hotplug).  All devices under such a bridge would be outside the
IOMMU, including virtio devices with direct-ram-access=off.

Paolo
