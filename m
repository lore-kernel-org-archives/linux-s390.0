Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jul 2011 08:06:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] [S390] irq: fix show_interrupts() vs cpu hotplug
Message-ID: <20110727060605.GB2561@osiris.boeblingen.de.ibm.com>
References: <20110726163424.GC2576@osiris.boeblingen.de.ibm.com>
 <1311742583-18633-1-git-send-email-yong.zhang0@gmail.com>
 <1311742583-18633-2-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311742583-18633-2-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 27, 2011 at 12:56:23PM +0800, Yong Zhang wrote:
> The current usage of get_online_cpus()/put_online_cpus()
> in show_interrupts() is not correct since show_interrupts()
> will be called nr_irqs times, during that period, cpu hotplug
> could also happen.
> Since have moved the protection to upper(patch#1), the pair of
> get_online_cpus()/put_online_cpus() could be removed here.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
