Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH 0/7] Add definition for the number of standard PCI BARs
References: <20190811150802.2418-1-efremov@linux.com>
 <20190812090639.GX56241@e119886-lin.cambridge.arm.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <4a8e0b95-192b-335e-653a-5a973f18ba2e@linux.com>
Date: Tue, 13 Aug 2019 00:00:34 +0300
MIME-Version: 1.0
In-Reply-To: <20190812090639.GX56241@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On 12.08.2019 12:06, Andrew Murray wrote:
> 
> Hi Denis,

Hi!

> 
> You could also fix up a few cases where the number of BARs is hard coded in
> loops, e.g.
> 
> drivers/pci/controller/pci-hyperv.c - look for uses of probed_bar in loops
> drivers/pci/pci.c - pci_release_selected_regions and __pci_request_selected_regions
> drivers/pci/quirks.c - quirk_alder_ioapic
> 

Thanks for pointing me on that. I will take this into account in v2.

Denis
