Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <20110801201644.GG3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	 <20110727125807.529303146@linux.vnet.ibm.com>
	 <20110801201644.GG3805@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 11:51:04 +0200
Message-ID: <1312278664.4881.35.camel@br98xy6r>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek,

On Mon, 2011-08-01 at 16:16 -0400, Vivek Goyal wrote:
> On Wed, Jul 27, 2011 at 02:55:05PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
> > the kdump kexec case. Therefore this patch introduces a new macro
> > KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
> > KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
> > KEXEC_CRASH_CONTROL_MEMORY_LIMIT.
> 
> Hi Michael,
> 
> Curious that why limit is different for kexec and kdump cases on s390
> only.

The standard kexec relocate_kernel code calls a machine instruction that
must run below 2 GiB. For kdump we currently do not use the control page
at all because no segments have to be moved in that case. Perhaps I am
still missing something here?

Michael
