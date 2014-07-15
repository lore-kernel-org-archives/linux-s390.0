Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Jul 2014 16:27:31 -0700 (PDT)
Message-Id: <20140715.162731.976775911116907392.davem@davemloft.net>
Subject: Re: [PATCH 00/16] net: remove unnecessary break after goto/return
From: David Miller <davem@davemloft.net>
In-Reply-To: <1405355467-7350-1-git-send-email-fabf@skynet.be>
References: <1405355467-7350-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, joe@perches.com, v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-s390@vger.kernel.org, linux-wireless@vger.kernel.org, linux-nfc@ml01.01.org, linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>

From: Fabian Frederick <fabf@skynet.be>
Date: Mon, 14 Jul 2014 18:30:50 +0200

> Small patchset addressing break redundancy on net branch
> (suggested by Joe Perches).

Series applied, thanks Fabian.
