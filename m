From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: 4.4-rc1 errors on bridge/macvtap interfaces (maybe commit 0bc05d58
 switchdev: allow caller to exp...).
Date: Mon, 16 Nov 2015 14:00:32 +0100
Message-ID: <5649D370.1040403@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Jiri Pirko <jiri@mellanox.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, "ms >> Michael S. Tsirkin" <mst@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Jiri,

on 4.4-rc1 running on an s390x box (so qeth OSA network cards as real NICs) I get errors like:

[   10.940523] Ebtables v2.0 registered
[   11.685609] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[   11.686252] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
[   11.794553] virbr0: error setting offload STP state on port 1(virbr0-nic)
[   11.794556] virbr0-nic: failed to set HW ageing time
[   11.794558] virbr0: error setting offload STP state on port 1(virbr0-nic)
[   11.794644] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
[   11.794675] device virbr0-nic entered promiscuous mode
[   11.794706] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
[   11.962901] ip_tables: (C) 2000-2006 Netfilter Core Team
[   12.025317] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   12.086880] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
[   12.086924] virbr0: error setting offload STP state on port 1(virbr0-nic)
[   12.086926] virbr0-nic: failed to set HW ageing time
[   12.086927] virbr0: error setting offload STP state on port 1(virbr0-nic)
[   12.086928] virbr0: port 1(virbr0-nic) entered listening state
[   12.086934] virbr0: port 1(virbr0-nic) entered listening state
[   12.087023] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
[   12.087057] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
[   12.087088] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
[   12.087122] virbr0-nic: set_features() failed (-1); wanted 0x00000080000048c1, left 0x00000080001b48c9
[   12.087153] virbr0: set_features() failed (-1); wanted 0x000000801fdb78c9, left 0x000000801fff78e9
[   12.102634] virbr0: error setting offload STP state on port 1(virbr0-nic)
[   12.102637] virbr0: port 1(virbr0-nic) entered disabled state



bisecting _one_ of the problem (the error message change, but I said "bad" whenever there was at least
one error) points to 

commit 0bc05d585d381c30de3fdf955730df31593d2101
Author:     Jiri Pirko <jiri@mellanox.com>
AuthorDate: Wed Oct 14 19:40:50 2015 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Thu Oct 15 06:09:48 2015 -0700

    switchdev: allow caller to explicitly request attr_set as deferred


Macvtap has a similar issue on 4.4-rc1:

[  260.414547] macvtap0: set_features() failed (-1); wanted 0x00000004001f5209, left 0x00000004001f5a09
[  260.414555] macvtap0: set_features() failed (-1); wanted 0x00000004001f5209, left 0x00000004001f5a09
[  260.541477] macvtap0: set_features() failed (-1); wanted 0x00000004001f5209, left 0x00000004001f5a09
[  260.541532] macvtap0: set_features() failed (-1); wanted 0x00000004001f5209, left 0x00000004001f5a09
[  260.541603] macvtap0: set_features() failed (-1); wanted 0x00000004001f5209, left 0x00000004001f5a09
[  260.984503] device enccw0.0.f500 entered promiscuous mode


Does somebody have an idea?

Christian
