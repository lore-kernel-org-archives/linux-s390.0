Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46438 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJ3M2f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Oct 2019 08:28:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id e66so2418812qkf.13
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 05:28:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Date: Wed, 30 Oct 2019 08:28:31 -0400
Message-Id: <1DA7B9E0-4BE2-4A9C-9B33-20EEFE3B5069@lca.pw>
References: <20191030102800.GX4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191030102800.GX4097@hirez.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com, linux-pci@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org



> On Oct 30, 2019, at 6:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> It only makes 'wild' guesses when the BIOS is shit and it complains
> about that.
>=20
> Or do you like you BIOS broken?

Agree. It is the garbage in and garbage out. No need to complicate the exist=
ing code further.=
