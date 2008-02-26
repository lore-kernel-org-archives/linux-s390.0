From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 26 Feb 2008 09:20:12 +0000
Subject: Re: BUG: soft lockup detected on CPU#0! Process swapper
Message-Id: <20080226092012.GB7114@osiris.boeblingen.de.ibm.com>
In-Reply-To: <200802260854.53213.borntraeger@de.ibm.com>
References: <200802260854.53213.borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 25, 2008 at 03:52:32PM -0600, John Gnew wrote:
> I copied this message from the dmesg listing. From time to time I have seen 
> this BUG for swapper, events and kjournald. Now that I have some time, I 
> thought I would attempt to see if there is a fix available or try to get 
> some information that I can use to debug this.
>
> Questions?
> How do I determine is a fix has already addressed this issue.
> If no fix is available, how do I get additional data and submit this as a 
> bug?
>
> John
>
> -------------------------------------------------
>
> The kernel is at 2.6.16.27
>
> BUG: soft lockup detected on CPU#0!
> CPU:    0    Not tainted
> Process swapper (pid: 0, task: 004f6400, ksp: 00551e80)
> [...]

This is not a bug as explained by others already. The patch below went into
2.6.19 to address the issue of false positives.

Adrian, would you please consider the patch below for your 2.6.16 stable
series? Patch is for 2.6.16.60. Upstream commit id in Linus' tree is
dea20a3fbdd08e5ae2a0b33d2577c794a3764a11 . Thanks!

Subject: [PATCH] Disable DETECT_SOFTLOCKUP for s390
    
From: Heiko Carstens <heiko.carstens@de.ibm.com>

We got several false bug reports because of enabled
CONFIG_DETECT_SOFTLOCKUP.  Disable soft lockup detection on s390, since it
doesn't work on a virtualized architecture.
    
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16.60/lib/Kconfig.debug
===================================================================
--- linux-2.6.16.60.orig/lib/Kconfig.debug
+++ linux-2.6.16.60/lib/Kconfig.debug
@@ -48,7 +48,7 @@ config LOG_BUF_SHIFT
 
 config DETECT_SOFTLOCKUP
 	bool "Detect Soft Lockups"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !S390
 	default y
 	help
 	  Say Y here to enable the kernel to detect "soft lockups",
