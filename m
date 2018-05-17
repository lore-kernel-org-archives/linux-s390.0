Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Thu, 17 May 2018 17:16:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v17 0/9] Address error and recovery for AER and DPC
Message-ID: <20180517221639.GE19955@bhelgaas-glaptop.roam.corp.google.com>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sam.bobroff@au1.ibm.com>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

[+cc Russell, Sam, Bryant, linuxppc-dev, Sebastian, linux-s390]

Sorry, I should have pulled in these new CC's earlier because ppc and
s390 both have PCI error handling similar to what Oza is changing
here.

The basic issue is that the new PCIe DPC (Downstream Port Containment,
see PCIe r4.0, sec 6.2.10) feature doesn't fit very well in the
framework of the pci_error_handlers callbacks.

When DPC is enabled, a Downstream Port (either a Root Port or a Switch
Downstream Port) that receives an ERR_FATAL message automatically
disables its Link.  IIUC, this is also intended for use in hot-unplug
scenarios.

When the DPC hardware takes the Link down, it resets all the
downstream devices, and there's not much point in calling the
pci_error_handlers callbacks because the devices are unreachable.
Even after the Link comes back up, we can't be certain the same device
is there because of the hotplug possibility.

The software side of DPC recovery basically consists of detaching the
drivers of the downstream devices (calling their .remove() methods),
bringing the link back up, re-enumerating the downstream devices, and
re-attaching the drivers (calling their .probe() methods).

The existing AER code also responds to ERR_FATAL messages, but it does
call the pci_error_handlers callbacks and also resets the link.

This is a bit of a mess because things look a lot different to the
driver depending on whether the platform supports AER or DPC.

Since we can't change the way DPC works, the idea of this series is
basically to make AER handle ERR_FATAL more like DPC does, i.e., by
resetting the link, detaching, and re-attaching the drivers.

This series is currently on my pci/aer branch
(https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/aer)
and is headed for v4.18 unless somebody raises major objections.

On Thu, May 17, 2018 at 03:43:02AM -0400, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> The goal of the patch-set is:
> DPC should handle the error handling and recovery similar to AER, because 
> finally both are attempting recovery in some or the other way,
> and for that error handling and recovery framework has to be loosely
> coupled.
> 
> It achieves uniformity and transparency to the error handling agents such
> as AER, DPC, with respect to recovery and error handling.
> 
> So, this patch-set tries to unify lot of things between error agents and
> make them behave in a well defined way. (be it error (FATAL, NON_FATAL)
> handling or recovery).
> 
> The FATAL error handling is handled with remove/reset_link/re-enumerate
> sequence while the NON_FATAL follows the default path.
> Documentation/PCI/pci-error-recovery.txt talks more on that.

I applied this series with a trivial change to remove an unused variable to
pci/aer for v4.18, thanks!

> Changes since v16:
>     Bjorn's comments addressed
>     > remove call pci_walk_bus(dev->subordinate, report_resume, &result_data)
>     > pci_cleanup_aer_uncorrect_error_status(dev); happens only if service is AER
>     > aer_error_resume does not handle ERR_FATAL clearing anymore
> Changes since v15:
>     Bjorn's comments addressed
>     > minor comments fixed
>     > made FATAL sequence aligned to existing one, as far as clearing status are concerned.
>     > pcie_do_fatal_recovery and pcie_do_nonfatal_recovery functions made to modularize
>     > pcie_do_fatal_recovery now takes service as an argument
> Changes since v14:
>     Bjorn's comments addressed
>     > simplified the patch set, and moved AER_FATAL handling in the beginning.
>     > rebase the code to 4.17-rc1.
> Changes since v13:
>     Bjorn's comments addressed
>     > handke FATAL errors with remove devices followed by re-enumeration.
>     > changes in AER and DPC along with required Documentation.
> Changes since v12:
>     Bjorn's and Keith's Comments addressed.
>     > Made DPC and AER error handling identical <aligned err.c>
>     > hanldled cases for hotplug enabled system differently.
> Changes since v11:
>     Bjorn's comments addressed.
>     > rename pcie-err.c to err.c
>     > removed EXPORT_SYMBOL
>     > made generic find_serivce function in port driver.
>     > removed mutex patch as no need to have mutex in pcie_do_recovery
>     > brough in DPC_FATAL in aer.h
>     > so now all the error codes (AER and DPC) are unified in aer.h
> Changes since v10:
>     Christoph Hellwig's, David Laight's and Randy Dunlap's
>     comments addressed.
>         > renamed pci_do_recovery to pcie_do_recovery
>         > removed inner braces in conditional statements.
>         > restrctured the code in pci_wait_for_link
>         > EXPORT_SYMBOL_GPL
> Changes since v9:
>     Sinan's comments addressed.
>         > bool active = true; unnecessary variable removed.
> Changes since v8:
>     Fixed Kbuild errors.
> Changes since v7:
>     Rebased the code on pci master
>         > https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci
> Changes since v6:
>     Sinan's and Stefan's comments implemented.
>         > reordered patch 6 and 7
>         > cleaned up
> Changes since v5:
>     Sinan's and Keith's comments incorporated.
>         > made separate patch for mutex
>         > unified error repotting codes into driver/pci/pci.h
>         > got rid of wait link active/inactive and
>           made generic function in driver/pci/pci.c
> Changes since v4:
>     Bjorn's comments incorporated.
>         > Renamed only do_recovery.
>         > moved the things more locally to drivers/pci/pci.h
> Changes since v3:
>     Bjorn's comments incorporated.
>         > Made separate patch renaming generic pci_err.c
>         > Introduce pci_err.h to contain all the error types and recovery
>         > removed all the dependencies on pci.h
> Changes since v2:
>     Based on feedback from Keith:
>     "
>     When DPC is triggered due to receipt of an uncorrectable error Message,
>     the Requester ID from the Message is recorded in the DPC Error
>     Source ID register and that Message is discarded and not forwarded Upstream.
>     "
>     Removed the patch where AER checks if DPC service is active
> Changes since v1:
>     Kbuild errors fixed:
>         > pci_find_dpc_dev made static
>         > ras_event.h updated
>         > pci_find_aer_service call with CONFIG check
>         > pci_find_dpc_service call with CONFIG check
> 
> Oza Pawandeep (9):
>   PCI: Unify wait for link active into generic PCI
>   pci-error-recovery: Add AER_FATAL handling
>   PCI/AER: Handle ERRR_FATAL with removal and re-enumeration of devices
>   PCI/AER: Rename error recovery to generic PCI naming
>   PCI/AER: Factor out error reporting from AER
>   PCI/PORTDRV: Implement generic find service
>   PCI/PORTDRV: Implement generic find device
>   PCI/DPC: Unify and plumb error handling into DPC
>   PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC
> 
>  Documentation/PCI/pci-error-recovery.txt |  35 ++-
>  drivers/pci/hotplug/pciehp_hpc.c         |  20 +-
>  drivers/pci/pci.c                        |  29 +++
>  drivers/pci/pci.h                        |   4 +
>  drivers/pci/pcie/Makefile                |   2 +-
>  drivers/pci/pcie/aer/aerdrv.c            |   2 +
>  drivers/pci/pcie/aer/aerdrv.h            |  30 ---
>  drivers/pci/pcie/aer/aerdrv_core.c       | 317 +-------------------------
>  drivers/pci/pcie/dpc.c                   |  58 +++--
>  drivers/pci/pcie/err.c                   | 374 +++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h               |   4 +
>  drivers/pci/pcie/portdrv_core.c          |  67 ++++++
>  include/linux/aer.h                      |   1 +
>  include/uapi/linux/pci_regs.h            |   1 +
>  14 files changed, 540 insertions(+), 404 deletions(-)
>  create mode 100644 drivers/pci/pcie/err.c
> 
> -- 
> 2.7.4
> 
