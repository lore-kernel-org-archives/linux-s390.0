Date: Wed, 30 Apr 2014 23:19:03 +0200
From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140430211902.GA5550@dhcp-26-207.brq.redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
 <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
 <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
Return-Path: <agordeev@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 14, 2014 at 03:28:34PM +0200, Alexander Gordeev wrote:
> There are no users of pci_enable_msi_block() function have
> left. Obsolete it in favor of pci_enable_msi_range() and
> pci_enable_msi_exact() functions.

Hi Bjorn,

How about this one?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
