From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Mon, 24 Oct 2016 10:47:47 +0200
Message-ID: <20161024084747.GE3102@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
	<1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
	<20161021120536.GC3142@twins.programming.kicks-ass.net>
	<20161022110636.410f20bd@roar.ozlabs.ibm.com>
	<251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, Noam Camus <noamc@ezchip.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 24, 2016 at 09:52:31AM +0200, Christian Borntraeger wrote:
> Peter, I will fixup the patch set (I forgot to remove the lowlatency
> in 2 places) and push it on my tree for linux-next. Lets see what happens.
> Would the tip tree be the right place if things work out ok?

I think so, you're touching a fair bit of kernel/locking/ and there's
bound to be some conflicts with work there. So carrying it in the
locking tree might be best.
