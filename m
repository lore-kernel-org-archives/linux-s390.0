From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/spinlock: Provide vcpu_is_preempted
Date: Wed, 19 Oct 2016 09:44:48 +0200
Message-ID: <20161019074448.GC4077@osiris>
References: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
	<1475164265-246160-2-git-send-email-borntraeger@de.ibm.com>
	<190cd825-ca7c-d160-a0ac-4e0d27ac4a93@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <190cd825-ca7c-d160-a0ac-4e0d27ac4a93@de.ibm.com>
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

On Wed, Oct 19, 2016 at 08:56:36AM +0200, Christian Borntraeger wrote:
> On 09/29/2016 05:51 PM, Christian Borntraeger wrote:
> > this implements the s390 backend for commit
> > "kernel/sched: introduce vcpu preempted check interface"
> > by reworking the existing smp_vcpu_scheduled into
> > arch_vcpu_is_preempted. We can then also get rid of the
> > local cpu_is_preempted function by moving the
> > CIF_ENABLED_WAIT test into arch_vcpu_is_preempted.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> 
> Martin, Peter,
> 
> I think we could go with the patch as is. In other words not providing
> arch_vcpu_is_preempted for !CONFIG_SMP.
> 
> This will result in compile errors if code does spinning or yielding for
> non-SMP kernels - which does not make sense to me, so this might actually
> be a nice indicator.
> If you prefer the !CONFIG_SMP implementation let me know and I will respin.

...but I do prefer an implementation for !CONFIG_SMP. I'm tired of fixing
silly compile errors that only happen on s390.
