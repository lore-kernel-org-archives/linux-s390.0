Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:60774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgKSJh1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 04:37:27 -0500
Date: Thu, 19 Nov 2020 10:37:23 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
Message-ID: <20201119093723.xbwq2o3k2k7kc2z3@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
 <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
 <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
 <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 2020-11-19 10:16:28 [+0200], Julian Wiedmann wrote:
> I am not worried about performance at all. Yet readability matters.

As you wish. Let me respin it then.

Sebastian
