From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 1/1] s390/spinlock: Provide vcpu_is_preempted
Date: Fri, 30 Sep 2016 13:52:44 +0800
Message-ID: <20160930055236.GB22004@tardis.cn.ibm.com>
References: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
	<1475164265-246160-2-git-send-email-borntraeger@de.ibm.com>
	<b2ace794-c1cc-11be-f9f5-d6429e192825@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3093541685354505050=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b2ace794-c1cc-11be-f9f5-d6429e192825@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>


--===============3093541685354505050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2016 at 12:49:52PM +0800, Pan Xinhui wrote:
>=20
>=20
> =E5=9C=A8 2016/9/29 23:51, Christian Borntraeger =E5=86=99=E9=81=93:
> > this implements the s390 backend for commit
> > "kernel/sched: introduce vcpu preempted check interface"
> > by reworking the existing smp_vcpu_scheduled into
> > arch_vcpu_is_preempted. We can then also get rid of the
> > local cpu_is_preempted function by moving the
> > CIF_ENABLED_WAIT test into arch_vcpu_is_preempted.
> >=20
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
>=20
> hi, Christian
> 	thanks for your patch!
>=20
> >  arch/s390/include/asm/spinlock.h |  3 +++
> >  arch/s390/kernel/smp.c           |  9 +++++++--
> >  arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
> >  3 files changed, 18 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/s=
pinlock.h
> > index 63ebf37..e16e02f 100644
> > --- a/arch/s390/include/asm/spinlock.h
> > +++ b/arch/s390/include/asm/spinlock.h
> > @@ -21,6 +21,9 @@ _raw_compare_and_swap(unsigned int *lock, unsigned in=
t old, unsigned int new)
> >  	return __sync_bool_compare_and_swap(lock, old, new);
> >  }
> >=20
> > +bool arch_vcpu_is_preempted(int cpu);
> > +#define vcpu_is_preempted arch_vcpu_is_preempted
> > +
> >  /*
> >   * Simple spin lock operations.  There are two variants, one clears IR=
Q's
> >   * on the local processor, one does not.
> > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> > index 7b89a75..4aadd16 100644
> > --- a/arch/s390/kernel/smp.c
> > +++ b/arch/s390/kernel/smp.c
> > @@ -376,10 +376,15 @@ int smp_find_processor_id(u16 address)
> >  	return -1;
> >  }
> >=20
> > -int smp_vcpu_scheduled(int cpu)
> root@ltcalpine2-lp13:~/linux# git grep -wn smp_vcpu_scheduled arch/s390/
> arch/s390/include/asm/smp.h:34:extern int smp_vcpu_scheduled(int cpu);
> arch/s390/include/asm/smp.h:56:static inline int smp_vcpu_scheduled(int c=
pu) { return 1; }
> arch/s390/kernel/smp.c:371:int smp_vcpu_scheduled(int cpu)
> arch/s390/lib/spinlock.c:44:    if (smp_vcpu_scheduled(cpu))
>=20
> > +bool arch_vcpu_is_preempted(int cpu)
> >  {
> > -	return pcpu_running(pcpu_devices + cpu);
> > +	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
> > +		return false;
> > +	if (pcpu_running(pcpu_devices + cpu))
> > +		return false;
> I saw smp_vcpu_scheduled() returns true always on !SMP system.
>=20
> maybe we can do somegthing silimar. like below
>=20
> #ifndef CONFIG_SMP
> static inline bool arch_vcpu_is_preempted(int cpu) { return !test_cpu_fla=
g_of(CIF_ENABLED_WAIT, cpu); }
> #else
> ...
>=20
> but I can't help thinking that if this is a!SMP system, maybe we could on=
ly
> #ifndef CONFIG_SMP
> static inline bool arch_vcpu_is_preempted(int cpu) { return false; }
> #else

Why do we need a vcpu_is_preempted() implementation for UP? Where will
you use it?

Regards,
Boqun

> ...
>=20
>=20
> thanks
> xinhui
>=20
> > +	return true;
> >  }
> > +EXPORT_SYMBOL(arch_vcpu_is_preempted);
> >=20
> >  void smp_yield_cpu(int cpu)
> >  {
> > diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> > index e5f50a7..e48a48e 100644
> > --- a/arch/s390/lib/spinlock.c
> > +++ b/arch/s390/lib/spinlock.c
> > @@ -37,15 +37,6 @@ static inline void _raw_compare_and_delay(unsigned i=
nt *lock, unsigned int old)
> >  	asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
> >  }
> >=20
> > -static inline int cpu_is_preempted(int cpu)
> > -{
> > -	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
> > -		return 0;
> > -	if (smp_vcpu_scheduled(cpu))
> > -		return 0;
> > -	return 1;
> > -}
> > -
> >  void arch_spin_lock_wait(arch_spinlock_t *lp)
> >  {
> >  	unsigned int cpu =3D SPINLOCK_LOCKVAL;
> > @@ -62,7 +53,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
> >  			continue;
> >  		}
> >  		/* First iteration: check if the lock owner is running. */
> > -		if (first_diag && cpu_is_preempted(~owner)) {
> > +		if (first_diag && arch_vcpu_is_preempted(~owner)) {
> >  			smp_yield_cpu(~owner);
> >  			first_diag =3D 0;
> >  			continue;
> > @@ -81,7 +72,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
> >  		 * yield the CPU unconditionally. For LPAR rely on the
> >  		 * sense running status.
> >  		 */
> > -		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
> > +		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
> >  			smp_yield_cpu(~owner);
> >  			first_diag =3D 0;
> >  		}
> > @@ -108,7 +99,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, =
unsigned long flags)
> >  			continue;
> >  		}
> >  		/* Check if the lock owner is running. */
> > -		if (first_diag && cpu_is_preempted(~owner)) {
> > +		if (first_diag && arch_vcpu_is_preempted(~owner)) {
> >  			smp_yield_cpu(~owner);
> >  			first_diag =3D 0;
> >  			continue;
> > @@ -127,7 +118,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp,=
 unsigned long flags)
> >  		 * yield the CPU unconditionally. For LPAR rely on the
> >  		 * sense running status.
> >  		 */
> > -		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
> > +		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
> >  			smp_yield_cpu(~owner);
> >  			first_diag =3D 0;
> >  		}
> > @@ -165,7 +156,7 @@ void _raw_read_lock_wait(arch_rwlock_t *rw)
> >  	owner =3D 0;
> >  	while (1) {
> >  		if (count-- <=3D 0) {
> > -			if (owner && cpu_is_preempted(~owner))
> > +			if (owner && arch_vcpu_is_preempted(~owner))
> >  				smp_yield_cpu(~owner);
> >  			count =3D spin_retry;
> >  		}
> > @@ -211,7 +202,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw, unsign=
ed int prev)
> >  	owner =3D 0;
> >  	while (1) {
> >  		if (count-- <=3D 0) {
> > -			if (owner && cpu_is_preempted(~owner))
> > +			if (owner && arch_vcpu_is_preempted(~owner))
> >  				smp_yield_cpu(~owner);
> >  			count =3D spin_retry;
> >  		}
> > @@ -241,7 +232,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw)
> >  	owner =3D 0;
> >  	while (1) {
> >  		if (count-- <=3D 0) {
> > -			if (owner && cpu_is_preempted(~owner))
> > +			if (owner && arch_vcpu_is_preempted(~owner))
> >  				smp_yield_cpu(~owner);
> >  			count =3D spin_retry;
> >  		}
> > @@ -285,7 +276,7 @@ void arch_lock_relax(unsigned int cpu)
> >  {
> >  	if (!cpu)
> >  		return;
> > -	if (MACHINE_IS_LPAR && !cpu_is_preempted(~cpu))
> > +	if (MACHINE_IS_LPAR && !arch_vcpu_is_preempted(~cpu))
> >  		return;
> >  	smp_yield_cpu(~cpu);
> >  }
> >=20
>=20

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX7f2pAAoJEEl56MO1B/q4SAYIAKDn78gdtlZJ7tjMjuu/hXSR
kgVpphv7Kxz8PSEzG1j3oVebCpFF2LiqxhcTDA2P+7pXgR3OdAlAsmtCJ76y/epa
nhRQaZZPByg3GO8ftt0EM2Q/kiMyGEI9JsT3dKMVfHbg2qxR9qiBW7QnNYbQihXq
uZryO0jcHYY1zu7vISxbJrdJGHEOBGFlJR+70MwsX3QUzdrNK6XtkOpMOkfjAcaJ
fljAH9GUyTpU01IILRiOX4cVn2PelhU84fDEu4hawly1U52b7/RSySpySTaKF5KC
vDxEGe+aeCj4XS/Cz3fOFLoKrcVGknLxU73CH2vcPMHQS0ygN65Ke712nwi7N8g=
=j4Ci
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

--===============3093541685354505050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3093541685354505050==--
