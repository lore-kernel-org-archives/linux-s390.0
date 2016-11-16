From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] sched: provide common cpu_relax_yield definition
Date: Wed, 16 Nov 2016 13:34:22 +0100
Message-ID: <c41d574c-c89e-e518-91bb-3acd701e5023@redhat.com>
References: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Noam Camus <noamc@ezchip.com>, Nicholas Piggin <npiggin@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 16.11.2016 um 13:23 schrieb Christian Borntraeger:
> No need to duplicate the same define everywhere. Since
> the only user is stop-machine and the only provider is
> s390, we can use a default implementation of cpu_relax_yield
> in sched.h.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Looks good to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

David
