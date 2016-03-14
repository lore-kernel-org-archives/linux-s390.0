Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 16:47:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/2] s390: Hotplug notifier transitions
Message-ID: <20160314154742.GB5346@osiris>
References: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 11, 2016 at 11:52:36AM +0100, Anna-Maria Gleixner wrote:
> The following patches fix missing error handling of hotplug notifier
> transitions.
> 
> Thanks,
> Anna-Maria
> 
> ---
>  perf_cpum_cf.c |    1 +
>  perf_cpum_sf.c |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
