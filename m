Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 12 Aug 2019 22:11:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] Add definition for the number of standard PCI BARs
In-Reply-To: <20190812200134.GB11785@google.com>
Message-ID: <alpine.DEB.2.21.1908122210300.7324@nanos.tec.linutronix.de>
References: <20190811150802.2418-1-efremov@linux.com> <20190812200134.GB11785@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Denis Efremov <efremov@linux.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Bjorn Helgaas wrote:

> On Sun, Aug 11, 2019 at 06:07:55PM +0300, Denis Efremov wrote:
> > Code that iterates over all standard PCI BARs typically uses
> > PCI_STD_RESOURCE_END, but this is error-prone because it requires
> > "i <= PCI_STD_RESOURCE_END" rather than something like
> > "i < PCI_STD_NUM_BARS". We could add such a definition and use it the same
> > way PCI_SRIOV_NUM_BARS is used. There is already the definition
> > PCI_BAR_COUNT for s390 only. Thus, this patchset introduces it globally.
> > 
> > The patch is splitted into 7 parts for different drivers/subsystems for
> > easy readability.
> 
> This looks good.  I can take all these together, since they all depend
> on the first patch.  I have a few comments on the individual patches.
> 
> > Denis Efremov (7):
> >   PCI: Add define for the number of standard PCI BARs
> >   s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
> >   x86/PCI: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END

Fine with me for the x86 part. That's your turf anyway :)

Thanks,

	tglx
