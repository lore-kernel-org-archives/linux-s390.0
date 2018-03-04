Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <e417db45-d400-3513-3897-7aefa9889711@gmx.de>
Date: Sun, 4 Mar 2018 21:45:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <deller@gmx.de>
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
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com, catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org, rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 16.01.2018 03:18, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

For parisc:

Acked-by: Helge Deller <deller@gmx.de> # parisc
