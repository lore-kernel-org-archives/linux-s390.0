Return-Path: <linux-kernel-owner+w=401wt.eu-S1030787AbXD1Ezr@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17970.53875.506097.699517@cargo.ozlabs.ibm.com>
Date: Sat, 28 Apr 2007 14:49:55 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 20/38] Minor fault path optimization.
In-Reply-To: <20070427140516.523272684@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
	<20070427140516.523272684@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky writes:

> The minor fault path has grown a lot in terms of cycles. In particular
> the kprobes hook is very costly. Optimize the path to save a couple of
> cycles. If kprobes is enabled more than 300 cycles can be avoided if 
> kprobes_running() is false.

There's no good reason to use a notifier for page faults, since
there's only one external piece of code that wants to know about
them...

Regards,
Paul.
