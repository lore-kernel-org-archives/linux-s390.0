Return-Path: <linux-kernel-owner+w=401wt.eu-S1753821AbXJXLtj@vger.kernel.org>
Message-ID: <471F2499.7030309@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2007 16:25:21 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [BUG] 2.6.23-git19 - S390x: Kernel panic while bringing up the
 network interface
References: <471EBC02.5000907@linux.vnet.ibm.com> <20071024050633.GA12335@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20071024050633.GA12335@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:
> On Wed, Oct 24, 2007 at 08:59:06AM +0530, Kamalesh Babulal wrote:
>> Hi,
>>
>> Kernel panic's while bringing up the network interface with the 2.6.23-g=
it19
>>
>> Setting network parameters:  =DD  OK  =A8
>> Bringing up loopback interface:  =DD  OK  =A8
>> Bringing up interface eth0:
>>  =DD<00000000002e2f72>=A8 inet_ioctl+0xd6/0x110
>>  =DD<000000000027cae2>=A8 sock_ioctl+0x26e/0x2a0
>>  =DD<00000000000b4c52>=A8 do_ioctl+0x4a/0xac
>>  =DD<00000000000b5076>=A8 vfs_ioctl+0x3c2/0x3d8
>>  =DD<00000000000b50ec>=A8 sys_ioctl+0x60/0x88
>>  =DD<0000000000021b7e>=A8 sysc_noemu+0x10/0x16
>>  =DD<00000200001201ca>=A8 0x200001201ca
>>
>>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>> 00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP s=
top from
>>  CPU 01.
>> 02: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP s=
top from
>>  CPU 01.
>> 03: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP s=
top from
>>  CPU 01.
>> 01: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 =
000164DE
>=20
> That should be fixed with this one:
>=20
> commit f1ecfd5d3b69d98b814435758c485e6fd0e112de
> Author: Ursula Braun <braunu@de.ibm.com>
> Date:   Mon Oct 22 16:16:14 2007 +0200
>=20
>     remove header_ops bug in qeth driver
>    =20
>     Remove qeth bug caused by commit:
>     [NET]: Move hardware header operations out of netdevice.
>    =20
>     This is the second part of the qeth header_ops patch, since
>     first patch sent 10/19 has been insufficient.
>     Nevertheless first patch is still valid and should be kept.
>    =20
>     Signed-off-by: Ursula Braun <braunu@de.ibm.com>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
>=20
> Patch is in -rc1. Could you please pull and try again? Thanks.

Hi,

The kernel panic is not seen in the 2.6.24-rc1 kernel.

--=20
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
