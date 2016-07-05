Return-Path: <kernellwp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 5 Jul 2016 17:57:56 +0800
Message-ID: <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Waiman Long <waiman.long@hpe.com>, will.deacon@arm.com, boqun.feng@gmail.com, Davidlohr Bueso <dave@stgolabs.net>, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Xinhui,
2016-06-28 22:43 GMT+08:00 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>:
> This is to fix some lock holder preemption issues. Some other locks
> implementation do a spin loop before acquiring the lock itself. Currently
> kernel has an interface of bool vcpu_is_preempted(int cpu). It take the cpu
> as parameter and return true if the cpu is preempted. Then kernel can break
> the spin loops upon on the retval of vcpu_is_preempted.
>
> As kernel has used this interface, So lets support it.
>
> Only pSeries need supoort it. And the fact is powerNV are built into same
> kernel image with pSeries. So we need return false if we are runnig as
> powerNV. The another fact is that lppaca->yiled_count keeps zero on
> powerNV. So we can just skip the machine type.

Lock holder vCPU preemption can be detected by hardware pSeries or
paravirt method?

Regards,
Wanpeng Li
