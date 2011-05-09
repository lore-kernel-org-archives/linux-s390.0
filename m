Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105081133.50824.sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
 <20110508092403.GB27807@n2100.arm.linux.org.uk> <201105081133.50824.sven@narfation.org>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Sun, 8 May 2011 22:38:43 -0400
Message-ID: <BANLkTim+z0mv7oXZHr0YnoxtfnoDZTEr9Q@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20110509023843.wfLIMeEkYcxtlo_moLpLhcU834QEHVApdLzcyQol9qg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 8, 2011 at 05:33, Sven Eckelmann wrote:
> Russell King - ARM Linux wrote:
> [...]
>> Do we need atomic_dec_not_zero() et.al. in every arch header - is there no
>> generic header which it could be added to?
>
> Mike Frysinger already tried to answer it in
> <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>:
>> that's what asm-generic is for.  if the arch isnt using it, it's
>> either because the arch needs to convert to it, or they're using SMP
>> and asm-generic doesnt yet support that for atomic.h.
>>
>> for example, the Blackfin port only needed updating for the SMP case.
>> in the non-SMP case, we're getting the def from asm-generic/atomic.h.
>
> Feel free to change that but I just followed the style used by all other
> macros and will not redesign the complete atomic*.h idea.

what you're doing is currently correct.  i think merging SMP support
into asm-generic for atomic* will take a bit of pondering first.
-mike
