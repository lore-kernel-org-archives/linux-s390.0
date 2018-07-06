Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com>
 <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
 <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
 <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com>
 <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de>
 <585b3646-5515-240a-db57-406d6c311a43@redhat.com>
 <alpine.DEB.2.21.1807061243400.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
 <CAGM2reZ1fkvzECyy4Eo+O9ZE-ddJvE3hFtPGUAv=QJ9Cv_hJvw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9529e874-6fd3-81d8-0a50-bf2efea6c113@redhat.com>
Date: Fri, 6 Jul 2018 17:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAGM2reZ1fkvzECyy4Eo+O9ZE-ddJvE3hFtPGUAv=QJ9Cv_hJvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, tglx@linutronix.de
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/07/2018 17:03, Pavel Tatashin wrote:
> I think using __initdata during init_hypervisor_platform()  +
> allocating during x86_init.hyper.guest_late_init() is a good approach.
> My only concern, it would mean we need to init/uinit/init clock for
> boot cpu. Does it mean the clock continuity is preserved during the
> transition? I believe so, but needs to be verified.

Yes, it's the same as any other pvclock update.

Paolo
