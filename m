From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
Date: Mon, 25 Jan 2016 14:51:08 -0800 (PST)
Message-ID: <20160125.145108.1332641183366177944.davem@davemloft.net>
References: <cover.1453759363.git.luto@kernel.org>
	<cover.1453759363.git.luto@kernel.org>
	<e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: luto@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, cmetcalf@ezchip.com, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 14:24:16 -0800

> On sparc64 compat-enabled kernels, any task can make 32-bit and
> 64-bit syscalls.  is_compat_task returns true in 32-bit tasks, which
> does not necessarily imply that the current syscall is 32-bit.
> 
> Provide an in_compat_syscall implementation that checks whether the
> current syscall is compat.
> 
> As far as I know, sparc is the only architecture on which
> is_compat_task checks the compat status of the task and on which the
> compat status of a syscall can differ from the compat status of the
> task.  On x86, is_compat_task checks the syscall type, not the task
> type.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
