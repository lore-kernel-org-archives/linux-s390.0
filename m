Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 May 2013 11:32:33 -0700 (PDT)
Message-Id: <20130514.113233.108654708844467379.davem@davemloft.net>
Subject: Re: [PATCHv2 net 1/2] sfc: Delete EFX_PAGE_IP_ALIGN, equivalent to
 NET_IP_ALIGN
From: David Miller <davem@davemloft.net>
In-Reply-To: <1368482311.3305.48.camel@bwh-desktop.uk.solarflarecom.com>
References: <1368482311.3305.48.camel@bwh-desktop.uk.solarflarecom.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: bhutchings@solarflare.com
Cc: heiko.carstens@de.ibm.com, geert@linux-m68k.org, linux-net-drivers@solarflare.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 13 May 2013 22:58:31 +0100

> The two architectures that define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> (powerpc and x86) now both define NET_IP_ALIGN as 0, so there is no
> need for this optimisation any more.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>

Applied.
