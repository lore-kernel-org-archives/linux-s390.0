From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Tue, 08 Jul 2014 14:01:30 +1000
Message-ID: <1404792090.26459.1.camel@concordia>
References: <cover.1402405331.git.agordeev@redhat.com>
	 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
	 <20140702202201.GA28852@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140702202201.GA28852@google.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-ide/>
List-Post: <mailto:linux-ide@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2014-07-02 at 14:22 -0600, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2014 at 03:10:30PM +0200, Alexander Gordeev wrote:
> > There are PCI devices that require a particular value written
> > to the Multiple Message Enable (MME) register while aligned on
> > power of 2 boundary value of actually used MSI vectors 'nvec'
> > is a lesser of that MME value:
> > 
> > 	roundup_pow_of_two(nvec) < 'Multiple Message Enable'
> > 
> > However the existing pci_enable_msi_block() interface is not
> > able to configure such devices, since the value written to the
> > MME register is calculated from the number of requested MSIs
> > 'nvec':
> > 
> > 	'Multiple Message Enable' = roundup_pow_of_two(nvec)
> 
> For MSI, software learns how many vectors a device requests by reading
> the Multiple Message Capable (MMC) field.  This field is encoded, so a
> device can only request 1, 2, 4, 8, etc., vectors.  It's impossible
> for a device to request 3 vectors; it would have to round up that up
> to a power of two and request 4 vectors.
> 
> Software writes similarly encoded values to MME to tell the device how
> many vectors have been allocated for its use.  For example, it's
> impossible to tell the device that it can use 3 vectors; the OS has to
> round that up and tell the device it can use 4 vectors.
> 
> So if I understand correctly, the point of this series is to take
> advantage of device-specific knowledge, e.g., the device requests 4
> vectors via MMC, but we "know" the device is only capable of using 3.
> Moreover, we tell the device via MME that 4 vectors are available, but
> we've only actually set up 3 of them.
> 
> This makes me uneasy because we're lying to the device, and the device
> is perfectly within spec to use all 4 of those vectors.  If anything
> changes the number of vectors the device uses (new device revision,
> firmware upgrade, etc.), this is liable to break.

It also adds more complexity into the already complex MSI API, across all
architectures, all so a single Intel chipset can save a couple of MSIs. That
seems like the wrong trade off to me.

cheers
