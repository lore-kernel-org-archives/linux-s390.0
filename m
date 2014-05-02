From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH/RFC 00/11] perf/s390/kvm: trace events, perf kvm stat
Date: Fri, 02 May 2014 12:14:19 -0600
Message-ID: <5363E07B.7040805@gmail.com>
References: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com> <20140502091638.GA6327@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140502091638.GA6327@krava.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 5/2/14, 3:16 AM, Jiri Olsa wrote:
> On Fri, Apr 25, 2014 at 11:12:22AM +0200, Christian Borntraeger wrote:
>> The goal of this series is to
>> - enable perf kvm stat on s390
>> - get rid of a perf warning "insn_to_mnemonic not found" when it tries to
>>    decode s390 perf trace events
>
> perf tools changes look good to me
>
>>
>> Review feedback is welcome.
>
> CC-ing David Ahern
>
I don't have the original emails, but looking at
https://lkml.org/lkml/2014/4/25/331


[PATCH 01/11] s390: add sie exit reasons tables
[PATCH 02/11] KVM: s390: Use trace tables from sie.h
[PATCH 03/11] KVM: s390: decoder of SIE intercepted instructions
[PATCH 04/11] KVM: s390: Use intercept_insn decoder in trace event
- not perf related


[PATCH 05/11] perf kvm: Intoduce HAVE_KVM_STAT_SUPPORT flag
[PATCH 06/11] perf kvm: simplify of exit reasons tables definitions
[PATCH 07/11] perf kvm: Refactoring of cpu_isa_config()
[PATCH 10/11] perf: allow to use cpuinfo on s390
Reviewed-by: David Ahern <dsahern@gmail.com>


[PATCH 09/11] perf kvm: use defines of kvm events
- KVM team should ack kvm.h change
- perf side looks fine to me

[PATCH 11/11] perf kvm: add stat support on s390
- like to see the arch bits moved to arch/x86 and arch/s390 rather than 
adding #ifdefs
- disabling ioport and mmio options is ok, but if you are going to 
compile it out update the documentation accordingly.

David
