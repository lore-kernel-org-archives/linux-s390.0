Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36781 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgB0LHS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Feb 2020 06:07:18 -0500
Date: Thu, 27 Feb 2020 16:37:13 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH 00/18] genirq: Remove setup_irq()
Message-ID: <20200227110713.GA5708@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <87y2somido.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2somido.fsf@nanos.tec.linutronix.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>

Hi Thomas,

On Thu, Feb 27, 2020 at 11:31:15AM +0100, Thomas Gleixner wrote:

> Vs. merging this series, I suggest the following approach:
> 
>    - Resubmit the individual changes as single patches or small series
>      to the relevant maintainers and subsystem mailing lists. They have
>      no dependency on a core change and can be applied where they belong
>      to.
> 
>    - After 5.6-rc6, verify which parts have made their way into
>      linux-next and resubmit the ignored ones as a series to me along
>      with the removal of the core parts.
> 
> That way we can avoid conflicting changes between subsystems and the tip
> irq/core branch as much as possible.

Okay, i will do accordingly.

[ your mail crossed my v3 (only one patch) posting ]

Regards
afzal
