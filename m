Date: Wed, 04 Oct 2017 17:41:11 -0700 (PDT)
Message-Id: <20171004.174111.1056977714603579000.davem@davemloft.net>
Subject: Re: [PATCH 05/13] timer: Remove init_timer_deferrable() in favor
 of timer_setup()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1507159627-127660-6-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
        <1507159627-127660-6-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: keescook@chromium.org
Cc: tglx@linutronix.de, benh@kernel.crashing.org, mpe@ellerman.id.au, sre@kernel.org, harish.patil@cavium.com, manish.chopra@cavium.com, kvalo@qca.qualcomm.com, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, cmetcalf@mellanox.com, geert@linux-m68k.org, gregkh@linuxfoundation.org, linux@roeck-us.net, heiko.carstens@de.ibm.com, jejb@linux.vnet.ibm.com, john.stultz@linaro.org, jwi@linux.vnet.ibm.com, jiangshanlai@gmail.com, len.brown@intel.com, mark.gross@intel.com, martin.petersen@oracle.com, schwidefsky@de.ibm.com, mdr@sgi.com, oleg@redhat.com, paulus@samba.org, pavel@ucw.cz, pmladek@suse.com, rjw@rjwysocki.net, ralf@linux-mips.org, stefanr@s5r6.in-berlin.de, sboyd@codeaurora.org, sudipm.mukherjee@gmail.com, tj@kernel.org, ubraun@linux.vnet.ibm.com, viresh.kumar@linaro.org, wim@iguana.be, linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>
Date: Wed,  4 Oct 2017 16:26:59 -0700

> This refactors the only users of init_timer_deferrable() to use
> the new timer_setup() and from_timer(). Removes definition of
> init_timer_deferrable().
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Harish Patil <harish.patil@cavium.com>
> Cc: Manish Chopra <manish.chopra@cavium.com>
> Cc: Kalle Valo <kvalo@qca.qualcomm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

For networking:

Acked-by: David S. Miller <davem@davemloft.net>
