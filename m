Return-Path: <linux-kernel-owner+w=401wt.eu-S1763421AbXJRJo0@vger.kernel.org>
Message-ID: <47172AD5.2030009@trash.net>
Date: Thu, 18 Oct 2007 11:43:49 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: s390x: getting ipv6 bugs on mainline since 2.6.23-git3
References: <20071018093556.GT21136@shadowen.org>
In-Reply-To: <20071018093556.GT21136@shadowen.org>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Andy Whitcroft wrote:
> Seems we are getting some kind of bug out of our s390x partition (lnxabat=
1)
> when booting latest mainline releases, specifically since 2.6.23-git3.
>=20
> Kernel BUG at 0000000000000002 =DDverbose debug info unavailable?
> illegal operation: 0001 =DD#1?
> Modules linked in: dm_mod sit tunnel4 ipv6 qeth ccwgroup qdio dasd_fba_mo=
d dasd_
> eckd_mod dasd_mod
> CPU:    0    Not tainted
> Process ip (pid: 2614, task: 000000003f42f680, ksp: 000000003cf2feb8)
> Krnl PSW : 0704200180000000 0000000000000002 (0x2)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:2 PM:0 EA:3
> Krnl GPRS: 0000000000000000 0000000000000000 000000003e6d5d00 000000003e0=
1f000
>            00000000000086dd 000000003cdac144 0000000000000000 00000000000=
00010
>            000000003e01f000 000000003d97e3c0 0000000100eaaa00 000000003cd=
ac100
>            000000003e6d5d00 00000001018fb1d0 0000000000286da8 000000003cf=
2f5e8
> Krnl Code:>0000000000000002: 0000               unknown
>            0000000000000004: 0000               unknown
>            0000000000000006: 0000               unknown
>            0000000000000008: 0000               unknown
>            000000000000000a: 0000               unknown
>            000000000000000c: 0000               unknown
>            000000000000000e: 0000               unknown
>            0000000000000010: 0000               unknown
> Call Trace:
> (=DD<0000000000286d60>? neigh_connected_output+0x68/0xfc)


Which network driver are you using? Please post the output of
"ip link list <dev>".
