Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] net: s390: qeth: use new api
 ethtool_{get|set}_link_ksettings
References: <1490534858-4049-1-git-send-email-tremyfr@gmail.com>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Mon, 27 Mar 2017 15:56:24 +0200
MIME-Version: 1.0
In-Reply-To: <1490534858-4049-1-git-send-email-tremyfr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <381d471f-e1e6-a189-d2ce-bf6db1d93614@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philippe Reynes <tremyfr@gmail.com>, ubraun@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03/26/2017 03:27 PM, Philippe Reynes wrote:
> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---

Hello Philippe,

thank you for the patch! Unfortunately I queued up pretty much the same
change to our internal repo just last week... should be going upstream with
our next patch series. Sorry for the duplicated effort.

Regards,
Julian
