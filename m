Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:54409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfGSKSI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 06:18:08 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
In-Reply-To: <20190716130631.tohj4ub54md25dys@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io> <20190714192205.27190-2-christian@brauner.io> <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com> <20190716130631.tohj4ub54md25dys@brauner.io>
Date: Fri, 19 Jul 2019 20:18:02 +1000
Message-ID: <874l3i8h0l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Christian Brauner <christian@brauner.io> writes:
> On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
>> I think Vasily already has a clone3 patch for s390x with 435. 
>
> A quick follow-up on this. Helge and Michael have asked whether there
> are any tests for clone3. Yes, there will be and I try to have them
> ready by the end of the this or next week for review. In the meantime I
> hope the following minimalistic test program that just verifies very
> very basic functionality (It's not pretty.) will help you test:

Hi Christian,

Thanks for the test.

This actually oopses on powerpc, it hits the BUG_ON in CHECK_FULL_REGS
in process.c around line 1633:

	} else {
		/* user thread */
		struct pt_regs *regs = current_pt_regs();
		CHECK_FULL_REGS(regs);
		*childregs = *regs;
		if (usp)


So I'll have to dig into how we fix that before we wire up clone3.

Turns out testing is good! :)

cheers
