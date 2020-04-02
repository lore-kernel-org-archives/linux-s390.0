Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail26.static.mailgun.info ([104.130.122.26]:42917 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388942AbgDBPDf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 11:03:35 -0400
Reply-To: <bcain@codeaurora.org>
From: "Brian Cain" <bcain@codeaurora.org>
References: <20200321174303.GA7930@afzalpc> <cover.1585320721.git.afzal.mohd.ma@gmail.com> <059b01d604ab$637355b0$2a5a0110$@codeaurora.org> <20200328073253.GA5250@afzalpc>
In-Reply-To: <20200328073253.GA5250@afzalpc>
Subject: RE: [PATCH 0/6] Kill setup_irq()
Date: Thu, 2 Apr 2020 10:03:28 -0500
Message-ID: <0fc601d608ff$df0ea550$9d2beff0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: 'afzal mohammed' <afzal.mohd.ma@gmail.com>
Cc: 'Thomas Gleixner' <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of afzal mohammed
...
> On Fri, Mar 27, 2020 at 09:48:38PM -0500, Brian Cain wrote:
> 
> > > Note 2: hexagon final image creation fails even w/o my patch
> 
> > 	What's the nature of the failure in "Note 2"?
> 
> drivers/base/firmware_loader/main.o: In function `fw_is_builtin_firmware':
> /devel/src/kernel6/drivers/base/firmware_loader/main.c:132:(.text+0xc8):
> relocation truncated to fit: R_HEX_16_X against symbol
`__start_builtin_fw'
> defined in .modinfo section in .tmp_vmlinux1
> Makefile:1077: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1

Thanks for reporting it -- I will make a patch to fix it.

-Brian
