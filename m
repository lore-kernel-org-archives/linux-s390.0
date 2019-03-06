Return-Path: <SRS0=hX7x=RJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 06 Mar 2019 11:04:36 -0800 (PST)
Message-Id: <20190306.110436.1714716608828903522.davem@davemloft.net>
Subject: Re: [PATCH v5 2/4] sparc: Advertise gigantic page support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190306190005.7036-3-alex@ghiti.fr>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-3-alex@ghiti.fr>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: alex@ghiti.fr
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org, benh@kernel.crashing.org, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, mike.kravetz@oracle.com
List-ID: <linux-s390.vger.kernel.org>

From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed,  6 Mar 2019 14:00:03 -0500

> sparc actually supports gigantic pages and selecting
> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
> gigantic pages at runtime.
> 
> sparc allows configuration such as huge pages of 16GB,
> pages of 8KB and MAX_ORDER = 13 (default):
> HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Much better.

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
