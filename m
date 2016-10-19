From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3] s390/spinlock: Provide vcpu_is_preempted
Date: Wed, 19 Oct 2016 10:50:18 +0200
Message-ID: <20161019085018.GE4077@osiris>
References: <20161019074448.GC4077@osiris>
	<1476866524-7724-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1476866524-7724-1-git-send-email-borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 19, 2016 at 10:42:04AM +0200, Christian Borntraeger wrote:
> this implements the s390 backend for commit
> "kernel/sched: introduce vcpu preempted check interface"
> by reworking the existing smp_vcpu_scheduled into
> arch_vcpu_is_preempted. We can then also get rid of the
> local cpu_is_preempted function by moving the
> CIF_ENABLED_WAIT test into arch_vcpu_is_preempted.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/spinlock.h |  8 ++++++++
>  arch/s390/kernel/smp.c           |  9 +++++++--
>  arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
>  3 files changed, 23 insertions(+), 19 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
