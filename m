Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfIBNvr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Sep 2019 09:51:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id 30so3169224wrk.11
        for <linux-s390@vger.kernel.org>; Mon, 02 Sep 2019 06:51:44 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2
 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz> <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz> <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz> <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz> <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz> <20190731171510.GB24998@rapoport-lnx>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <f57f15b5-dee7-c2be-5a34-192a9ecf0763@monstr.eu>
Date: Mon, 2 Sep 2019 15:51:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190731171510.GB24998@rapoport-lnx>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D19tTfHRF2QuIUUzbbAPQ12tjJW2Zl1nR"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Will Deacon <will@kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "willy@infradead.org" <willy@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Hoan Tran OS <hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>, Randy Dunlap <rdunlap@infradead.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D19tTfHRF2QuIUUzbbAPQ12tjJW2Zl1nR
Content-Type: multipart/mixed; boundary="qZIZzQB7m0rVymNdwsbZ2zyiI1LguDOGl";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Will Deacon <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Hoan Tran OS <hoan@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Open Source Submission <patches@amperecomputing.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>,
 Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f57f15b5-dee7-c2be-5a34-192a9ecf0763@monstr.eu>
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2
 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz> <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz> <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz> <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz> <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz> <20190731171510.GB24998@rapoport-lnx>
In-Reply-To: <20190731171510.GB24998@rapoport-lnx>

--qZIZzQB7m0rVymNdwsbZ2zyiI1LguDOGl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31. 07. 19 19:15, Mike Rapoport wrote:
> On Wed, Jul 31, 2019 at 04:41:14PM +0200, Michal Hocko wrote:
>> On Wed 31-07-19 17:21:29, Mike Rapoport wrote:
>>> On Wed, Jul 31, 2019 at 03:00:37PM +0200, Michal Hocko wrote:
>>>>
>>>> I am sorry, but I still do not follow. Who is consuming that node id=

>>>> information when NUMA=3Dn. In other words why cannot we simply do
>>> =20
>>> We can, I think nobody cared to change it.
>>
>> It would be great if somebody with the actual HW could try it out.
>> I can throw a patch but I do not even have a cross compiler in my
>> toolbox.
>=20
> Well, it compiles :)
> =20
>>>> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
>>>> index a015a951c8b7..3a47e8db8d1c 100644
>>>> --- a/arch/microblaze/mm/init.c
>>>> +++ b/arch/microblaze/mm/init.c
>>>> @@ -175,14 +175,9 @@ void __init setup_memory(void)
>>>> =20
>>>>  		start_pfn =3D memblock_region_memory_base_pfn(reg);
>>>>  		end_pfn =3D memblock_region_memory_end_pfn(reg);
>>>> -		memblock_set_node(start_pfn << PAGE_SHIFT,
>>>> -				  (end_pfn - start_pfn) << PAGE_SHIFT,
>>>> -				  &memblock.memory, 0);
>>>> +		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT)=
;
>>>
>>> memory_present() expects pfns, the shift is not needed.
>>
>> Right.

Sorry for slow response on this. In general regarding this topic.
Microblaze is soft core CPU (now there are hardcore versions too but not
running Linux). I believe there could be Numa system with
microblaze/microblazes (SMP is not supported in mainline).

This code was added in 2011 which is pretty hard to remember why it was
done in this way.

It compiles but not working on HW. Please take a look at log below.

Thanks,
Michal


[    0.000000] Linux version 5.3.0-rc6-00007-g54b01939182f-dirty
(monstr@monstr-desktop3) (gcc version 8.2.0 (crosstool-NG 1.20.0)) #101
Mon Sep 2 15:44:05 CEST 2019
[    0.000000] setup_memory: max_mapnr: 0x40000
[    0.000000] setup_memory: min_low_pfn: 0x80000
[    0.000000] setup_memory: max_low_pfn: 0xb0000
[    0.000000] setup_memory: max_pfn: 0xc0000
[    0.000000] start pfn 0x80000
[    0.000000] end pfn 0xc0000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x00000000b0000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   1: [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] Could not find start_pfn for node 0
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x0000000000000000]
[    0.000000] earlycon: ns16550a0 at MMIO 0x44a01000 (options '115200n8'=
)
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] setup_cpuinfo: initialising
[    0.000000] setup_cpuinfo: Using full CPU PVR support
[    0.000000] wt_msr_noirq
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 0
[    0.000000] Kernel command line: earlycon
[    0.000000] Dentry cache hash table entries: -2147483648 (order: -13,
0 bytes, linear)
[    0.000000] Inode-cache hash table entries: -2147483648 (order: -13,
0 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Oops: kernel access of bad area, sig: 11
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
5.3.0-rc6-00007-g54b01939182f-dirty #101
[    0.000000]  Registers dump: mode=3D805B9EA8
[    0.000000]  r1=3D000065A0, r2=3DC05B7AE6, r3=3D00000000, r4=3D0000000=
0
[    0.000000]  r5=3D00080000, r6=3D00080B50, r7=3D00000000, r8=3D0000000=
4
[    0.000000]  r9=3D00000000, r10=3D0000001F, r11=3D00000000, r12=3D0000=
6666
[    0.000000]  r13=3D4119DCC0, r14=3D00000000, r15=3DC05EFF8C, r16=3D000=
00000
[    0.000000]  r17=3DC0604408, r18=3DFFFC0000, r19=3DC05B9F6C, r20=3DBFF=
EC168
[    0.000000]  r21=3DBFFEC168, r22=3DEFFF9AC0, r23=3D00000001, r24=3DC06=
06874
[    0.000000]  r25=3DBFE6B74C, r26=3D80000000, r27=3D00000000, r28=3D900=
00040
[    0.000000]  r29=3D01000000, r30=3D00000380, r31=3DC05C02F0, rPC=3DC06=
04408
[    0.000000]  msr=3D000046A0, ear=3D00000004, esr=3D00000D12, fsr=3DFFF=
FFFFF
[    0.000000] Oops: kernel access of bad area, sig: 11


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--qZIZzQB7m0rVymNdwsbZ2zyiI1LguDOGl--

--D19tTfHRF2QuIUUzbbAPQ12tjJW2Zl1nR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXW0eXQAKCRDKSWXLKUoM
IQSRAJ95LhdDRja4rjrT7nFf2urcLyUsawCgh/Ho29ldM07jS/qDcder85B3TdA=
=d2ww
-----END PGP SIGNATURE-----

--D19tTfHRF2QuIUUzbbAPQ12tjJW2Zl1nR--
