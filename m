From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH net-next v2 0/5] s390/bpf: recache skb->data/hlen for skb_vlan_push/pop
Date: Wed, 29 Jul 2015 21:15:13 +0200
Message-ID: <1438197318-16903-1-git-send-email-holzheu@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@plumgrid.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Daniel Borkmann <daniel@iogearbox.net>, Joe Perches <joe@perches.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Here the s390 backend for Alexei's patch 4e10df9a60d9 ("bpf: introduce
bpf_skb_vlan_push/pop() helpers") plus two bugfixes and two minor
improvements.

The first patch "s390/bpf: clear correct BPF accumulator register" will
also go upstream via Martin's "fixes" branch.

* v2: Integrated suggestions from Joe Perches

Michael Holzheu (5):
  s390/bpf: clear correct BPF accumulator register
  s390/bpf: Fix multiple macro expansions
  s390/bpf: increase BPF_SIZE_MAX
  s390/bpf: Only clear A and X for converted BPF programs
  s390/bpf: recache skb->data/hlen for skb_vlan_push/pop

 arch/s390/net/bpf_jit.h      |  5 ++-
 arch/s390/net/bpf_jit_comp.c | 93 +++++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.3.8
