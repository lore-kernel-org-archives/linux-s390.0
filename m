Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PREEMPT-RT] [PATCH] s390/cpum_sf: Remove superfluous SMP
 function call
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris> <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris> <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Message-ID: <5703A836.7030708@linutronix.de>
Date: Tue, 5 Apr 2016 13:57:42 +0200
MIME-Version: 1.0
In-Reply-To: <20160405115129.GE30124@linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: rcochran@linutronix.de, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On 04/05/2016 01:51 PM, rcochran@linutronix.de wrote:
> On Tue, Apr 05, 2016 at 01:36:38PM +0200, Heiko Carstens wrote:
>> On Tue, Apr 05, 2016 at 01:23:36PM +0200, Heiko Carstens wrote:
>>> Subsequently, in this case, the setup_pmc_cpu() call will be executed on
>>> the wrong cpu.
>>
>> .. or to illustrate this behaviour: the following patch (white space
>> damaged due to copy-paste) results in the following:
>=20
> I guess you are missing the following commit?
=85
>     cpu/hotplug: Move online calls to hotplugged cpu

No, Heiko is right here. If one of the "CPU_DOWN_PREPARE" fails then
the following CPU_DOWN_FAILED will be invoked on the correct CPU.

However if we are further down the road and the final ARCH specific
"die" failed (just before CPU_DYING) are invoked then we get this done
on the wrong CPU.

> Thanks,
> Richard

Sebastian
