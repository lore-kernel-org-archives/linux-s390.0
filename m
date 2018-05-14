Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 May 2018 16:41:17 -0400 (EDT)
Message-Id: <20180514.164117.792209096555574754.davem@davemloft.net>
Subject: Re: [PATCH] net/smc: check for missing nlattrs in SMC_PNETID
 messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514000130.13780-1-ebiggers3@gmail.com>
References: <001a113f9bb83e4d560568457853@google.com>
        <20180514000130.13780-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ebiggers3@gmail.com
Cc: ubraun@linux.ibm.com, tmricht@linux.vnet.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, ebiggers@google.com
List-ID: <linux-s390.vger.kernel.org>

From: Eric Biggers <ebiggers3@gmail.com>
Date: Sun, 13 May 2018 17:01:30 -0700

> From: Eric Biggers <ebiggers@google.com>
> 
> It's possible to crash the kernel in several different ways by sending
> messages to the SMC_PNETID generic netlink family that are missing the
> expected attributes:
> 
> - Missing SMC_PNETID_NAME => null pointer dereference when comparing
>   names.
> - Missing SMC_PNETID_ETHNAME => null pointer dereference accessing
>   smc_pnetentry::ndev.
> - Missing SMC_PNETID_IBNAME => null pointer dereference accessing
>   smc_pnetentry::smcibdev.
> - Missing SMC_PNETID_IBPORT => out of bounds array access to
>   smc_ib_device::pattr[-1].
> 
> Fix it by validating that all expected attributes are present and that
> SMC_PNETID_IBPORT is nonzero.
> 
> Reported-by: syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com
> Fixes: 6812baabf24d ("smc: establish pnet table management")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied and queued up for -stable, thanks.
