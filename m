From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next] Latest next does not boot on s390x
Date: Fri, 24 Sep 2010 12:44:10 +0200
Message-ID: <20100924104410.GB2230@osiris.boeblingen.de.ibm.com>
References: <4C9B5AAB.6020000@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C9B5AAB.6020000@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>, David Howells <dhowells@redhat.com>
Cc: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 23, 2010 at 07:18:27PM +0530, Sachin Sant wrote:
> I cannot boot recent linux-next builds on a s390x box.
> 
> I first ran into this problem with Sept 17th linux-next build(2.6.36-rc4_next_20100917)
> 
> The following messages are displayed on the console :
> 
> 03: Please choose (default will boot in 20 seconds):
> 03: Booting default (autotest)...
> 03: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 0010DB3E
> 
> Any idea what could be the problem or how can i debug this issue ?

Caused by "Fix IRQ flag handling naming". It changed a define to a function
which takes an unsigned long. That adds an implicit cast of the ssm_mask from
int to unsigned long and changes bit positions.
In consequence we fail to enable the virtual addressing mode and hence the
kernel crashes at first access to an address that is only available in
virtual addressing mode.
The patch below fixes it.

David, could you please merge it into your "Fix IRQ flag handling naming"
patch? Thanks!

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index d3a24e4..bb40933 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -91,7 +91,6 @@ static unsigned long setup_zero_pages(void)
  */
 void __init paging_init(void)
 {
-	static const int ssm_mask = 0x04000000L;
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 	unsigned long pgd_type;
 
@@ -113,7 +112,7 @@ void __init paging_init(void)
 	__ctl_load(S390_lowcore.kernel_asce, 1, 1);
 	__ctl_load(S390_lowcore.kernel_asce, 7, 7);
 	__ctl_load(S390_lowcore.kernel_asce, 13, 13);
-	arch_local_irq_restore(ssm_mask);
+	arch_local_irq_restore(4UL << (BITS_PER_LONG - 8));
 
 	atomic_set(&init_mm.context.attach_count, 1);
 
