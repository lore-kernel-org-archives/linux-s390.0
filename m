Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/cpum_sf: Remove superfluous SMP function call
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris> <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris> <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de> <5703A836.7030708@linutronix.de>
 <20160405121155.GF6890@osiris>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <5703AD4B.30903@linutronix.de>
Date: Tue, 5 Apr 2016 14:19:23 +0200
MIME-Version: 1.0
In-Reply-To: <20160405121155.GF6890@osiris>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: rcochran@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On 04/05/2016 02:11 PM, Heiko Carstens wrote:
> I think there is more broken: if I willingly let __cpu_disable() fail and
> try to offline e.g. cpu 2 for the second time chcpu will never return.
> Plus the console contains several "NOHZ: local_softirq_pending 01"
> messages.

…
> 
> All of this works without problems on vanilla 4.5 kernel.
> 
> I think you can reproduce this on any architecture :)

oh yes.

Sebastian
