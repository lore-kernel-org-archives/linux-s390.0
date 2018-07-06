Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com>
 <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
 <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
 <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com>
 <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <585b3646-5515-240a-db57-406d6c311a43@redhat.com>
Date: Fri, 6 Jul 2018 12:08:17 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/07/2018 11:45, Thomas Gleixner wrote:
>> One possibility is to introduce another layer of indirection: in
>> addition to the percpu pvclock data, add a percpu pointer to the pvclock
>> data and initialize it to point to a page-aligned variable in BSS.  CPU0
>> (used by vDSO) doesn't touch the pointer and keeps using the BSS
>> variable, APs instead redirect the pointer to the percpu data.
> Yeah, thought about that, but the extra indirection is ugly. Instead of
> using per cpu data, I just can allocate the memory _after_ the allocators
> are up and running and use a single page sized static __initdata for the
> early boot.

Either works for me.  Assembly-wise, the indirection should be more or
less the same as what we have now; even more efficient because it
accesses a percpu pointer instead of computing it based on
smp_processor_id().

Paolo
