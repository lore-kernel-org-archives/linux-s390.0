From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RESEND PATCH v3 09/11] powerpc/mm/radix: mark
 __radix__flush_tlb_range_psize() as __always_inline
Date: Fri, 3 May 2019 22:40:50 +0900
Message-ID: <CAK7LNAQfHSchx26_q3kBvxybkQLqbUj6d=ay8QaSuVPx-B62Uw@mail.gmail.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-10-yamada.masahiro@socionext.com>
 <40b48947-b80e-7971-376d-52b594e26d17@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <40b48947-b80e-7971-376d-52b594e26d17@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christophe,


On Tue, Apr 30, 2019 at 12:36 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 23/04/2019 =C3=A0 05:49, Masahiro Yamada a =C3=A9crit :
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
>
> How did you identify the functions requiring __always_inline as this one
> ? Just by 'test and see if it fails',

Yes.

Based on my local build tests + 0day bot reports +
Arnd's randconfig + your reports.



> or did you have some script or so ?
>
> Here the problem is that one of the parameters of the function are used
> as "immediate" constraint for the inline assembly, therefore requiring
> the function to always be inline.
>
> I guess this should be explained in the commit log and I'm wondering how
> you ensure that you did identify all functions like this.


I think it is difficult to check all function call graphs, but
I just roughly checked though the "i" constraints,
and at least the following should be fixed.

This series has been a while in linux-next already,
so I want to let it go in
and I want to send the following fix-ups to each arch later
since they are currently not real problems.




diff --git a/arch/mips/include/asm/ginvt.h b/arch/mips/include/asm/ginvt.h
index 49c6dbe..6eb7c2b 100644
--- a/arch/mips/include/asm/ginvt.h
+++ b/arch/mips/include/asm/ginvt.h
@@ -19,7 +19,7 @@ _ASM_MACRO_1R1I(ginvt, rs, type,
 # define _ASM_SET_GINV
 #endif

-static inline void ginvt(unsigned long addr, enum ginvt_type type)
+static __always_inline void ginvt(unsigned long addr, enum ginvt_type type=
)
 {
  asm volatile(
  ".set push\n"
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native=
_64.c
index aaa28fd..bc2c35c 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -60,9 +60,11 @@ static inline void tlbiel_hash_set_isa206(unsigned
int set, unsigned int is)
  * tlbiel instruction for hash, set invalidation
  * i.e., r=3D1 and is=3D01 or is=3D10 or is=3D11
  */
-static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int i=
s,
- unsigned int pid,
- unsigned int ric, unsigned int prs)
+static __always_inline void tlbiel_hash_set_isa300(unsigned int set,
+    unsigned int is,
+    unsigned int pid,
+    unsigned int ric,
+    unsigned int prs)
 {
  unsigned long rb;
  unsigned long rs;
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 14ff414..c84d1a4 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -29,9 +29,11 @@
  * tlbiel instruction for radix, set invalidation
  * i.e., r=3D1 and is=3D01 or is=3D10 or is=3D11
  */
-static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int =
is,
- unsigned int pid,
- unsigned int ric, unsigned int prs)
+static __always_inline void tlbiel_radix_set_isa300(unsigned int set,
+     unsigned int is,
+     unsigned int pid,
+     unsigned int ric,
+     unsigned int prs)
 {
  unsigned long rb;
  unsigned long rs;
@@ -120,8 +122,8 @@ static __always_inline void __tlbie_pid(unsigned
long pid, unsigned long ric)
  trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }

-static inline void __tlbiel_lpid(unsigned long lpid, int set,
- unsigned long ric)
+static __always_inline void __tlbiel_lpid(unsigned long lpid, int set,
+   unsigned long ric)
 {
  unsigned long rb,rs,prs,r;

@@ -150,8 +152,8 @@ static __always_inline void __tlbie_lpid(unsigned
long lpid, unsigned long ric)
  trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
 }

-static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
- unsigned long ric)
+static __always_inline void __tlbiel_lpid_guest(unsigned long lpid, int se=
t,
+ unsigned long ric)
 {
  unsigned long rb,rs,prs,r;

@@ -167,8 +169,8 @@ static inline void __tlbiel_lpid_guest(unsigned
long lpid, int set,
 }


-static inline void __tlbiel_va(unsigned long va, unsigned long pid,
-        unsigned long ap, unsigned long ric)
+static __always_inline void __tlbiel_va(unsigned long va, unsigned long pi=
d,
+ unsigned long ap, unsigned long ric)
 {
  unsigned long rb,rs,prs,r;

@@ -183,8 +185,8 @@ static inline void __tlbiel_va(unsigned long va,
unsigned long pid,
  trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }

-static inline void __tlbie_va(unsigned long va, unsigned long pid,
-       unsigned long ap, unsigned long ric)
+static __always_inline void __tlbie_va(unsigned long va, unsigned long pid=
,
+        unsigned long ap, unsigned long ric)
 {
  unsigned long rb,rs,prs,r;

@@ -199,8 +201,9 @@ static inline void __tlbie_va(unsigned long va,
unsigned long pid,
  trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }

-static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
-       unsigned long ap, unsigned long ric)
+static __always_inline void __tlbie_lpid_va(unsigned long va,
+     unsigned long lpid,
+     unsigned long ap, unsigned long ric)
 {
  unsigned long rb,rs,prs,r;

diff --git a/arch/s390/include/asm/atomic_ops.h
b/arch/s390/include/asm/atomic_ops.h
index d3f0952..b5d86e9 100644
--- a/arch/s390/include/asm/atomic_ops.h
+++ b/arch/s390/include/asm/atomic_ops.h
@@ -41,7 +41,7 @@ __ATOMIC_OPS(__atomic64_xor, long, "laxg")
 #undef __ATOMIC_OP

 #define __ATOMIC_CONST_OP(op_name, op_type, op_string, op_barrier) \
-static inline void op_name(op_type val, op_type *ptr) \
+static __always_inline void op_name(op_type val, op_type *ptr) \
 { \
  asm volatile( \
  op_string " %[ptr],%[val]\n" \
diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 2769675..4ded4cc 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -163,7 +163,8 @@ typedef struct { unsigned char bytes[16]; } cpacf_mask_=
t;
  *
  * Returns 1 if @func is available for @opcode, 0 otherwise
  */
-static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+static __always_inline void __cpacf_query(unsigned int opcode,
+   cpacf_mask_t *mask)
 {
  register unsigned long r0 asm("0") =3D 0; /* query function */
  register unsigned long r1 asm("1") =3D (unsigned long) mask;
diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.=
h
index ae3e3221..3ac02f7 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -220,7 +220,7 @@ enum stcctm_ctr_set {
  MT_DIAG =3D 5,
  MT_DIAG_CLEARING =3D 9, /* clears loss-of-MT-ctr-data alert */
 };
-static inline int stcctm(enum stcctm_ctr_set set, u64 range, u64 *dest)
+static __always_inline int stcctm(enum stcctm_ctr_set set, u64 range,
u64 *dest)
 {
  int cc;

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtabl=
e.h
index 9f0195d..d4c56f4 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -996,9 +996,9 @@ static inline pte_t pte_mkhuge(pte_t pte)
 #define IPTE_NODAT 0x400
 #define IPTE_GUEST_ASCE 0x800

-static inline void __ptep_ipte(unsigned long address, pte_t *ptep,
-        unsigned long opt, unsigned long asce,
-        int local)
+static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep=
,
+ unsigned long opt, unsigned long asce,
+ int local)
 {
  unsigned long pto =3D (unsigned long) ptep;

@@ -1019,8 +1019,8 @@ static inline void __ptep_ipte(unsigned long
address, pte_t *ptep,
  : [r1] "a" (pto), [m4] "i" (local) : "memory");
 }

-static inline void __ptep_ipte_range(unsigned long address, int nr,
-      pte_t *ptep, int local)
+static __always_inline void __ptep_ipte_range(unsigned long address, int n=
r,
+       pte_t *ptep, int local)
 {
  unsigned long pto =3D (unsigned long) ptep;

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8d6d75d..e98c4a0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -327,7 +327,7 @@ static inline int plo_test_bit(unsigned char nr)
  return cc =3D=3D 0;
 }

-static inline void __insn32_query(unsigned int opcode, u8 query[32])
+static __always_inline void __insn32_query(unsigned int opcode, u8 query[3=
2])
 {
  register unsigned long r0 asm("0") =3D 0; /* query function */
  register unsigned long r1 asm("1") =3D (unsigned long) query;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 3a36b07..8e96a94 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -66,7 +66,7 @@ static inline int clp_get_ilp(unsigned long *ilp)
 /*
  * Call Logical Processor with c=3D0, the give constant lps and an lpcb re=
quest.
  */
-static inline int clp_req(void *data, unsigned int lps)
+static __always_inline int clp_req(void *data, unsigned int lps)
 {
  struct { u8 _[CLP_BLK_SIZE]; } *req =3D data;
  u64 ignored;











> Christophe
>
> >
> > If it is enabled for powerpc, the following error is reported:
> >
> > arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psiz=
e':
> > arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn'=
t match constraints [-Werror]
> >    asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> >    ^~~
> > arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm=
'
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v3: None
> > Changes in v2:
> >    - split into a separate patch
> >
> >   arch/powerpc/mm/tlb-radix.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index 6a23b9ebd2a1..a2b2848f0ae3 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
> >       tlb->need_flush_all =3D 0;
> >   }
> >
> > -static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm=
,
> > +static __always_inline void __radix__flush_tlb_range_psize(struct mm_s=
truct *mm,
> >                               unsigned long start, unsigned long end,
> >                               int psize, bool also_pwc)
> >   {
> >
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--
Best Regards
Masahiro Yamada
