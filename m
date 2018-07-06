Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com>
 <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
 <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com>
Date: Fri, 6 Jul 2018 11:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/07/2018 11:24, Thomas Gleixner wrote:
>> The reason for this is to avoid wasting a lot of BSS memory when KVM is
>> not in use.  Thomas is going to send his take on this!
> Got it working with per cpu variables, but there is a different subtle
> issue with that.
> 
> The pvclock data is mapped into the VDSO as well, i.e. as a full page.
> 
> Right now with the linear array, which is forced to be page sized at least
> this only maps pvclock data or zeroed data (after the last CPU) into the
> VDSO.
> 
> With PER CPU variables this would map arbitraty other per cpu data which
> happens to be in the same page into the VDSO. Not really what we want.
> 
> That means to utilize PER CPU data this requires to allocate page sized
> pvclock data space for each CPU to prevent leaking arbitrary stuff.
> 
> As this data is allocated on demand, i.e. only if kvmclock is used, this
> might be tolerable, but I'm not so sure.

One possibility is to introduce another layer of indirection: in
addition to the percpu pvclock data, add a percpu pointer to the pvclock
data and initialize it to point to a page-aligned variable in BSS.  CPU0
(used by vDSO) doesn't touch the pointer and keeps using the BSS
variable, APs instead redirect the pointer to the percpu data.

Paolo
