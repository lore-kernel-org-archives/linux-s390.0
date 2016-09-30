From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/spinlock: Provide vcpu_is_preempted
Date: Fri, 30 Sep 2016 12:29:50 +0200
Message-ID: <d4beac12-5be3-32ed-28d5-82fc2f79143b@de.ibm.com>
References: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
	<1475164265-246160-2-git-send-email-borntraeger@de.ibm.com>
	<b2ace794-c1cc-11be-f9f5-d6429e192825@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b2ace794-c1cc-11be-f9f5-d6429e192825@linux.vnet.ibm.com>
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
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/30/2016 06:49 AM, Pan Xinhui wrote:

> 
> but I can't help thinking that if this is a!SMP system, maybe we could only
> #ifndef CONFIG_SMP
> static inline bool arch_vcpu_is_preempted(int cpu) { return false; }
> #else

Yes, I will add that to v3. Thanks for spotting.
