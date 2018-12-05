Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/7] mm: PG_reserved cleanups and documentation
Date: Wed,  5 Dec 2018 13:28:44 +0100
Message-Id: <20181205122851.5891-1-david@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: linux-mm@kvack.org
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bhupesh Sharma <bhsharma@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, Paul Mackerras <paulus@samba.org>, linux-riscv@lists.infradead.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Tobias Klauser <tklauser@distanz.ch>, Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, linux-m68k@lists.linux-m68k.org, Dave Kleikamp <dave.kleikamp@oracle.com>, linux-mediatek@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, James Morse <james.morse@arm.com>, Souptick Joarder <jrdr.linux@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

I was recently going over all users of PG_reserved. Short story: it is
difficult and sometimes not really clear if setting/checking for
PG_reserved is only a relict from the past. Easy to break things.

I had way more cleanups in this series inititally,
but some architectures take PG_reserved as a way to apply a different
caching strategy (for MMIO pages). So I decided to only include the most
obvious changes (that are less likely to break something).

So let's see if the documentation update for PG_reserved I crafted
actually covers most cases or if there is plenty more.

Most notably, for device memory we can hopefully soon stop setting
it PG_reserved

I only briefly tested this on s390x.

David Hildenbrand (7):
  agp: efficeon: no need to set PG_reserved on GATT tables
  s390/vdso: don't clear PG_reserved
  powerpc/vdso: don't clear PG_reserved
  riscv/vdso: don't clear PG_reserved
  m68k/mm: use __ClearPageReserved()
  arm64: kexec: no need to ClearPageReserved()
  mm: better document PG_reserved

 arch/arm64/kernel/machine_kexec.c |  1 -
 arch/m68k/mm/memory.c             |  2 +-
 arch/powerpc/kernel/vdso.c        |  2 --
 arch/riscv/kernel/vdso.c          |  1 -
 arch/s390/kernel/vdso.c           |  2 --
 drivers/char/agp/efficeon-agp.c   |  2 --
 include/linux/page-flags.h        | 18 ++++++++++++++++--
 7 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
