From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 0/5] s390/bpf: recache skb->data/hlen for
 skb_vlan_push/pop
Date: Wed, 29 Jul 2015 15:00:14 -0700 (PDT)
Message-ID: <20150729.150014.82183966921783124.davem@davemloft.net>
References: <1438197318-16903-1-git-send-email-holzheu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1438197318-16903-1-git-send-email-holzheu@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: holzheu@linux.vnet.ibm.com
Cc: ast@plumgrid.com, schwidefsky@de.ibm.com, daniel@iogearbox.net, joe@perches.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 29 Jul 2015 21:15:13 +0200

> Here the s390 backend for Alexei's patch 4e10df9a60d9 ("bpf: introduce
> bpf_skb_vlan_push/pop() helpers") plus two bugfixes and two minor
> improvements.
> 
> The first patch "s390/bpf: clear correct BPF accumulator register" will
> also go upstream via Martin's "fixes" branch.
> 
> * v2: Integrated suggestions from Joe Perches

Series applied, thanks.
