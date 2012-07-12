From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 0/2] kvm: Improving directed yield in PLE handler
Date: Thu, 12 Jul 2012 16:08:21 +0530
Message-ID: <87bojl463m.fsf@abhimanyu.in.ibm.com>
References: <20120709062012.24030.37154.sendpatchset@codeblue> <4FFA8E5E.3070108@de.ibm.com> <4FFD422B.9060008@redhat.com> <4FFD52CD.7040403@de.ibm.com> <4FFD5DA3.3010001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD5DA3.3010001@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Jul 2012 14:04:03 +0300, Avi Kivity <avi@redhat.com> wrote:
> 
> > So this would probably improve guests that uses cpu_relax, for example
> > stop_machine_run. I have no measurements, though.
> 
> smp_call_function() too (though that can be converted to directed yield
> too).  It seems worthwhile.
> 
With 

https://lkml.org/lkml/2012/6/26/266 in tip:x86/mm

which now uses smp_call_function_many in native_flush_tlb_others. It
will help that too.

Nikunj
