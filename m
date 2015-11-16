From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: 4.4-rc1 errors on bridge/macvtap interfaces (maybe commit
 0bc05d58 switchdev: allow caller to exp...).
Date: Mon, 16 Nov 2015 14:25:14 +0100
Message-ID: <20151116132514.GB2217@nanopsycho.orion>
References: <5649D370.1040403@de.ibm.com>
 <20151116131955.GB24489@unicorn.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151116131955.GB24489@unicorn.suse.cz>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, "ms >> Michael S. Tsirkin" <mst@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Mon, Nov 16, 2015 at 02:19:55PM CET, mkubecek@suse.cz wrote:
>On Mon, Nov 16, 2015 at 02:00:32PM +0100, Christian Borntraeger wrote:
>>=20
>> on 4.4-rc1 running on an s390x box (so qeth OSA network cards as rea=
l NICs) I get errors like:
>>=20
>> [   10.940523] Ebtables v2.0 registered
>> [   11.685609] bridge: automatic filtering via arp/ip/ip6tables has =
been deprecated. Update your scripts to load br_netfilter if you need t=
his.
>> [   11.686252] virbr0-nic: set_features() failed (-1); wanted 0x0000=
0080000048c1, left 0x00000080001b48c9
>> [   11.794553] virbr0: error setting offload STP state on port 1(vir=
br0-nic)
>> [   11.794556] virbr0-nic: failed to set HW ageing time
>> [   11.794558] virbr0: error setting offload STP state on port 1(vir=
br0-nic)
>> [   11.794644] virbr0-nic: set_features() failed (-1); wanted 0x0000=
0080000048c1, left 0x00000080001b48c9
>> [   11.794675] device virbr0-nic entered promiscuous mode
>> [   11.794706] virbr0: set_features() failed (-1); wanted 0x00000080=
1fdb78c9, left 0x000000801fff78e9
>> [   11.962901] ip_tables: (C) 2000-2006 Netfilter Core Team
>> [   12.025317] nf_conntrack version 0.5.0 (65536 buckets, 262144 max=
)
>> [   12.086880] virbr0: set_features() failed (-1); wanted 0x00000080=
1fdb78c9, left 0x000000801fff78e9
>> [   12.086924] virbr0: error setting offload STP state on port 1(vir=
br0-nic)
>> [   12.086926] virbr0-nic: failed to set HW ageing time
>> [   12.086927] virbr0: error setting offload STP state on port 1(vir=
br0-nic)
>> [   12.086928] virbr0: port 1(virbr0-nic) entered listening state
>> [   12.086934] virbr0: port 1(virbr0-nic) entered listening state
>> [   12.087023] virbr0: set_features() failed (-1); wanted 0x00000080=
1fdb78c9, left 0x000000801fff78e9
>> [   12.087057] virbr0-nic: set_features() failed (-1); wanted 0x0000=
0080000048c1, left 0x00000080001b48c9
>> [   12.087088] virbr0: set_features() failed (-1); wanted 0x00000080=
1fdb78c9, left 0x000000801fff78e9
>> [   12.087122] virbr0-nic: set_features() failed (-1); wanted 0x0000=
0080000048c1, left 0x00000080001b48c9
>> [   12.087153] virbr0: set_features() failed (-1); wanted 0x00000080=
1fdb78c9, left 0x000000801fff78e9
>> [   12.102634] virbr0: error setting offload STP state on port 1(vir=
br0-nic)
>> [   12.102637] virbr0: port 1(virbr0-nic) entered disabled state
>>=20
>...
>>=20
>> [  260.414547] macvtap0: set_features() failed (-1); wanted 0x000000=
04001f5209, left 0x00000004001f5a09
>> [  260.414555] macvtap0: set_features() failed (-1); wanted 0x000000=
04001f5209, left 0x00000004001f5a09
>> [  260.541477] macvtap0: set_features() failed (-1); wanted 0x000000=
04001f5209, left 0x00000004001f5a09
>> [  260.541532] macvtap0: set_features() failed (-1); wanted 0x000000=
04001f5209, left 0x00000004001f5a09
>> [  260.541603] macvtap0: set_features() failed (-1); wanted 0x000000=
04001f5209, left 0x00000004001f5a09
>> [  260.984503] device enccw0.0.f500 entered promiscuous mode
>>=20
>> Does somebody have an idea?
>
>Looks like the issue addressed by
>
>  http://patchwork.ozlabs.org/patch/544307/

second issues (stp state) is fixed by:
http://patchwork.ozlabs.org/patch/544246/


>
>Michal Kube=C4=8Dek
>
>--
>To unsubscribe from this list: send the line "unsubscribe netdev" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
