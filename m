Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jul 2011 08:05:45 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] proc/insterrupts: make it cpu hotplug safe
Message-ID: <20110727060545.GA2561@osiris.boeblingen.de.ibm.com>
References: <20110726163424.GC2576@osiris.boeblingen.de.ibm.com>
 <1311742583-18633-1-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311742583-18633-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Keika Kobayashi <kobayashi.kk@ncos.nec.co.jp>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 27, 2011 at 12:56:22PM +0800, Yong Zhang wrote:
> KOSAKI Motonhiro noticed that the reader of /proc/interrupts
> could be preempted by cpu hotplug, thus the reader can get
> broken result due to show_interrupts() iterate every online
> cpu without any protection.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Keika Kobayashi <kobayashi.kk@ncos.nec.co.jp>
> Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
