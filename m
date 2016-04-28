From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 28 Apr 2016 22:43:59 +0200
Message-ID: <2760348.qmm1L3yQch@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
 <20160428191914.GA28527@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160428191914.GA28527@yury-N73SV>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, Catalin Marinas <catalin.marinas@arm.com>, joseph@codesourcery.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwab@suse.de, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thursday 28 April 2016 22:19:14 Yury Norov wrote:
> 
> Yes, we need. Otherwise we have circular dependency like this:
> arch/arm64/kernel/sys_ilp32.c:60:0: warning: "__SC_WRAP" redefined
>  #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
>   ^
>   In file included from include/asm-generic/unistd.h:1:0,
>                    from ./arch/arm64/include/uapi/asm/unistd.h:16,
>                    from ./arch/arm64/include/asm/unistd.h:62,
>                    from ./include/uapi/linux/unistd.h:7,
>                    from include/linux/syscalls.h:23,
>                    from arch/arm64/kernel/sys_ilp32.c:30:
> include/uapi/asm-generic/unistd.h:33:0: note: this is the location of the previous definition
>  #define __SC_WRAP __SYSCALL
> 
> Defining __SYSCALL_COMPAT at the top of the file does not help much.

Hmm, this sounds like something that we should fix in the asm-generic/unistd.h
file. Is it just for __SC_WRAP, or also the other macros?

	Arnd
