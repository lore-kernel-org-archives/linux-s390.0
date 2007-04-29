From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] [AF_IUCV/IUCV]: smp_call_function deadlock
Date: Sat, 28 Apr 2007 23:04:47 -0700 (PDT)
Message-ID: <20070428.230447.122616979.davem@davemloft.net>
References: <20070419091145.GC14586@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070419091145.GC14586@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: fpavlic@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Pavlic <fpavlic@de.ibm.com>
Date: Thu, 19 Apr 2007 11:11:45 +0200

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> From: Ursula Braun <braunu@de.ibm.com>
> 
> Calling smp_call_function can lead to a deadlock if it is called
> from tasklet context. 
> Fixing this deadlock requires to move the smp_call_function from the
> tasklet context to a work queue. To do that queue the path pending
> interrupts to a separate list and move the path cleanup out of
> iucv_path_sever to iucv_path_connect and iucv_path_pending.
> This creates a new requirement for iucv_path_connect: it may not be
> called from tasklet context anymore. 
> Also fixed compile problem for CONFIG_HOTPLUG_CPU=n and
> another one when walking the cpu_online mask. When doing this, 
> we must disable cpu hotplug.
> 
> Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Applied, except I had to kick out the HOTPLUT_CPU ifdef removal
since that was already done by f8a6d97043f9adc25889876b681998b77f543bfa

Thanks.
