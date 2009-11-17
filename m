From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next PATCH] Add param ops struct for hvc_iucv driver.
Date: Tue, 17 Nov 2009 14:24:48 +0100
Message-ID: <20091117132448.GC5124@osiris.boeblingen.de.ibm.com>
References: <20091117132103.18413.53658.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091117132103.18413.53658.sendpatchset@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, rusty@rustcorp.com.au, linux-next@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 17, 2009 at 06:51:03PM +0530, Sachin Sant wrote:
> Today's next 20091117 build failed on s390 with
> 
> drivers/char/hvc_iucv.c:1331: error: 'param_ops_vmidfilter' undeclared here (not in a function)
> make[2]: *** [drivers/char/hvc_iucv.o] Error 1
> 
> Most probably caused by commit 684a6d340b8a5767db4670031b0f39455346018a
> (param:param_ops) which introduced a param_ops structure.
> 
> The following compile tested patch adds a param_ops structure for hvc_iucv.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---

Yep, thanks. I just did the same.

Rusty, could you pick this one up?

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
