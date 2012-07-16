Date: Mon, 16 Jul 2012 03:29:01 -0700 (PDT)
Message-Id: <20120716.032901.1657058688119342783.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] etherdevice: Rename random_ether_addr to
 eth_random_addr
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120716101437.GC22638@arwen.pp.htv.fi>
References: <1341968967.13724.23.camel@joe2Laptop>
        <cover.1342157022.git.joe@perches.com>
        <20120716101437.GC22638@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: balbi@ti.com
Cc: joe@perches.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org, wimax@linuxwimax.org, linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com, linux-s390@vger.kernel.org, johannes@sipsolutions.net, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, e1000-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

From: Felipe Balbi <balbi@ti.com>
Date: Mon, 16 Jul 2012 13:14:38 +0300

> if you're really renaming the function, then this patch alone will break
> all of the below users. That should all be a single patch, I'm afraid.

It would help if you actually read his patches before saying what they
might or might not do.

He provides a macro in the first patch that provides the old name,
and this will get removed at the end.
