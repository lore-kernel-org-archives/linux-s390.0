From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: Oops in Unix sockets code
Date: Thu, 19 Nov 2009 16:46:26 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911191631210.5225@localhost.localdomain>
References: <20091119132028.GA22427@tuxmaker.boeblingen.de.ibm.com> <200911191440.18949.borntraeger@de.ibm.com> <4B05542D.7060401@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4B05542D.7060401@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Blaschka <frank.blaschka@de.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On Thu, 19 Nov 2009, Eric Dumazet wrote:
...
> 2.6.31 has a known bug
> 
> 2.6.31.4 should correct it
> 
> commit 657453424a3c382035983f9a47306fafea730f6d
> Author: Eric Dumazet <eric.dumazet@gmail.com>
> Date:   Thu Sep 24 10:49:24 2009 +0000

indeed, problem didn't show up with d99927f applied. thanks for
pointing that out.

sebastian
