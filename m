From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] Improved yield performance
Date: Wed, 26 Feb 2014 16:16:00 +0100
Message-ID: <530E0530.3060809@redhat.com>
References: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 26/02/2014 16:14, Christian Borntraeger ha scritto:
> Paolo,
>
> here is the reworked yield heuristics series against kvm/queue with
> your suggested changes.
>
> Attached is a minimized testcase that reproduces the performance
> win  (runtime 0:50 instead of 1:00). The constants and the setup
> seem a bit artificial but these seem to reproduce the problem on my
> test system: as soon as there is contention from other guests the
> patch improves the runtime of belows testcase. The original test
> had 8 competing guests with 4 cpus, I simplified that a bit to have
> one big guest as cpu stealer.
>
>                            host 20 cpus
> GUEST1 (20vCPUS)			GUEST2(40vCPUS)
> runs the test				all 40 CPUs cpu bound
>
>
> The testcase stresses the IPC system call, since that creates a lot
> of diag44 exits on s390 if contended.
>
> Some other spinlock tests like fio on guest tmpfs seem to be unaffected.
>
> Please consider for kvm/queue. If you have some performance tests
> a regression run on x86 is welcome.

Yes, will apply as soon as kvm/queue moves to kvm/next (1 hour or so).

Paolo
