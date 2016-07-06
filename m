Return-Path: <jgross@suse.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <577CB786.8000902@suse.com>
 <20160706081920.GG30921@twins.programming.kicks-ass.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <577CC3A1.3070002@suse.com>
Date: Wed, 6 Jul 2016 10:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <20160706081920.GG30921@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com, dave@stgolabs.net, schwidefsky@de.ibm.com, pbonzini@redhat.com, xen-devel-request@lists.xenproject.org
List-ID: <linux-s390.vger.kernel.org>

On 06/07/16 10:19, Peter Zijlstra wrote:
> On Wed, Jul 06, 2016 at 09:47:18AM +0200, Juergen Gross wrote:
>> On 06/07/16 08:52, Peter Zijlstra wrote:
> 
>>> Paolo, could you help out with an (x86) KVM interface for this?
>>
>> Xen support of this interface should be rather easy. Could you please
>> Cc: xen-devel-request@lists.xenproject.org in the next version?
> 
> So meta question; aren't all you virt people looking at the regular
> virtualization list? Or should we really dig out all the various
> hypervisor lists and Cc them?

Hmm, good question. Up to now I didn't look at the virtualization list,
just changed that. :-)

Can't speak for the other virt people.


Juergen
