Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 5 Dec 2018 13:56:07 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC 0/7] mm: PG_reserved cleanups and documentation
Message-ID: <20181205125607.GM1286@dhcp22.suse.cz>
References: <20181205122851.5891-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205122851.5891-1-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bhupesh Sharma <bhsharma@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, linux-riscv@lists.infradead.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Tobias Klauser <tklauser@distanz.ch>, Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, linux-m68k@lists.linux-m68k.org, Dave Kleikamp <dave.kleikamp@oracle.com>, linux-mediatek@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, James Morse <james.morse@arm.com>, Souptick Joarder <jrdr.linux@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Wed 05-12-18 13:28:44, David Hildenbrand wrote:
[...]
> Most notably, for device memory we can hopefully soon stop setting
> it PG_reserved

I am busy as hell so I am not likely to look at specific patche this
week. But could you be more specific why we need to get rid of other
PG_reserved users before we can do so for device memory?

I am all for removing relicts because they just confuse people but I
fail to see any relation here.

-- 
Michal Hocko
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
