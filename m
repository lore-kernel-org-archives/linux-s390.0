From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 00/11] perf/s390/kvm: trace events, perf kvm stat
Date: Mon, 05 May 2014 12:36:23 +0200
Message-ID: <536769A7.4050000@de.ibm.com>
References: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com> <20140502091638.GA6327@krava.redhat.com> <5363E07B.7040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5363E07B.7040805@gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/05/14 20:14, David Ahern wrote:
> On 5/2/14, 3:16 AM, Jiri Olsa wrote:
[...]
>> CC-ing David Ahern
>>
> I don't have the original emails, but looking at
> https://lkml.org/lkml/2014/4/25/331
> 
> 
> [PATCH 01/11] s390: add sie exit reasons tables
> [PATCH 02/11] KVM: s390: Use trace tables from sie.h
> [PATCH 03/11] KVM: s390: decoder of SIE intercepted instructions
> [PATCH 04/11] KVM: s390: Use intercept_insn decoder in trace event
> - not perf related
> 
> 
> [PATCH 05/11] perf kvm: Intoduce HAVE_KVM_STAT_SUPPORT flag
> [PATCH 06/11] perf kvm: simplify of exit reasons tables definitions
> [PATCH 07/11] perf kvm: Refactoring of cpu_isa_config()
> [PATCH 10/11] perf: allow to use cpuinfo on s390
> Reviewed-by: David Ahern <dsahern@gmail.com>
> 
> 
> [PATCH 09/11] perf kvm: use defines of kvm events
> - KVM team should ack kvm.h change

Paolo,
any chance to ack these changes?


> - perf side looks fine to me
> 
> [PATCH 11/11] perf kvm: add stat support on s390
> - like to see the arch bits moved to arch/x86 and arch/s390 rather than adding #ifdefs
> - disabling ioport and mmio options is ok, but if you are going to compile it out update the documentation accordingly.
> 
> David
> 

Thanks.

Question is now how to proceed:

Patch 1-4 are s390/kvm specific. I am s390/kvm maintainer, so I can hereby Ack them.
Patch 5-10 are perf specific
Patch 11 is s390/kvm/perf specific and needs both patch series as a base.

I see several variants for the next submission:

a: all patches via Paolos KVM tree
b: all patches via perf tree  (e.g. via Jiri)
c: via both trees. (e.g. I prepare a git branch based on 3.15-rc1 so that during next merge window the common history should make most things work out fine)
d: patch 1-4 via KVM, patch 5-10 via perf, patch 11 after both trees are merged into Linus

Christian
