Return-Path: <linux-kselftest-owner@vger.kernel.org>
Date: Tue, 22 Sep 2020 16:50:30 -0700 (PDT)
Message-Id: <20200922.165030.2291105439162323404.davem@davemloft.net>
Subject: Re: [PATCH] kbuild: explicitly specify the build id style
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200922232140.1994390-1-morbo@google.com>
References: <20200922232140.1994390-1-morbo@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: morbo@google.com
Cc: linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com, luto@kernel.org, michal.lkml@markovi.net, catalin.marinas@arm.com, will@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, natechancellor@gmail.com

From: Bill Wendling <morbo@google.com>
Date: Tue, 22 Sep 2020 16:21:40 -0700

> ld's --build-id defaults to "sha1" style, while lld defaults to "fast".
> The build IDs are very different between the two, which may confuse
> programs that reference them.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
