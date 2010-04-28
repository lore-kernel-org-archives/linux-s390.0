From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: linux-next: Apr 27 - S390 boot failure.
Date: Wed, 28 Apr 2010 17:18:38 +0200
Message-ID: <20100428151838.GA2772@osiris.boeblingen.de.ibm.com>
References: <4BD7D399.2090601@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BD7D399.2090601@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 28, 2010 at 11:50:09AM +0530, Sachin Sant wrote:
> Yesterday's -next (20100427) fails to boot on a s390.
> Here is the boot log.
> [...]
> 01: HCPGSP2627I The virtual machine is placed in CP mode due to a SIGP initial C
> PU reset from CPU 00.
> 02: HCPGSP2627I The virtual machine is placed in CP mode due to a SIGP initial C
> PU reset from CPU 00.
> 03: HCPGSP2627I The virtual machine is placed in CP mode due to a SIGP initial C
> PU reset from CPU 00.
> 
> At this point the boot process just hangs. Previous -next build
> (20100415) worked fine.
> Have attached the .config

Yes, I got several reports about this. The patch "improve irq tracing code
in entry[64].S" was broken for !CONFIG_PREEMPT. I fixed it and pushed out
a new version.
Should be fixed with tomorrow's linux-next.

Thanks for reporting!
