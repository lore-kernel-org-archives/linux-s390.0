From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Fri, 19 Jan 2018 01:54:51 +0000
Subject: Re: [strace PATCH 01/12] Add compat support for s390x
Message-Id: <20180119015451.GA7430@altlinux.org>
In-Reply-To: <20180118061635.GA28715@asgard.redhat.com>
References: <20180118061635.GA28715@asgard.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Q68bSM7Ycu6FN28Q"
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:16:35AM +0100, Eugene Syromyatnikov wrote:
> By very popular demand.
>=20
> While we are here, let's refactor the condition for old_mmap_pgoff into
> an arch-specific one, as it is used more than in one place.
>=20
> * NEWS: Mention this.
> * configure.ac (case "$host_cpu" in) <s390x>: Set arch_m32 to s390, set
> cc_flags_m32 to -m31.
> (st_MPERS([m32])): Add s390x.
> * defs.h [S390X]: Define NEED_UID16_PARSERS.
> * linux/s390/arch_sigreturn.c [!S390_FRAME_PTR] (S390_FRAME_PTR): New
> macro, define to s390_frame_ptr.
> [!SIGNAL_FRAMESIZE] (SIGNAL_FRAMESIZE): New macro, define to
> __SIGNAL_FRAMESIZE.
> [!PTR_TYPE] (PTR_TYPE): New macro, define to unsigned long.
> (arch_sigreturn): Use S390_FRAME_PTR, SIGNAL_FRAMESIZE, and PTR_TYPE
> instead of s390_frame_ptr, __SIGNAL_FRAMESIZE, and pointer-sized type,
> respectively.
> * linux/s390/get_error.c [!ARCH_REGSET] (ARCH_REGSET): New macro, define
> * to s390_regset.
> (get_error): Use it instead of s390_regset.
> * linux/s390/get_scno.c (arch_get_scno): Likewise.
> * linux/s390/get_syscall_args.c (get_syscall_args): Likewise.
> * linux/s390/set_error.c (arch_set_error, arch_set_success): Likewise.
> * linux/s390/set_scno.c (arch_set_scno): Likewise.
> * linux/s390x/arch_regs.c (psw_compat_t, s390_compat_regs,
> s390x_regs_union, s390_frame_ptr, s390x_frame_ptr, s390x_io): New
> variable.
> (s390_regset, s390x_regset, ARCH_REGS_FOR_GETREGSET,
> ARCH_IOVEC_FOR_GETREGSET, ARCH_PC_REG, ARCH_PERSONALITY_0_IOV_SIZE,
> ARCH_PERSONALITY_1_IOV_SIZE): New macro.
> * linux/s390x/arch_regs.h (s390_frame_ptr, s390x_frame_ptr): New
> external definitions.
> * linux/s390x/arch_rt_sigframe.c: Behave based on tcp->currpers.
> * linux/s390x/arch_sigreturn.c: Likewise.
> * linux/s390x/get_error.c: Likewise.
> * linux/s390x/get_scno.c: Likewise.
> * linux/s390x/get_syscall_args.c: Likewise.
> * linux/s390x/set_error.c: Likewise.
> * linux/s390x/set_scno.c: Likewise.
> * linux/s390x/errnoent1.h: New file.
> * linux/s390x/ioctls_arch1.h: Likewise.
> * linux/s390x/ioctls_inc1.h: Likewise.
> * linux/s390x/signalent1.h: Likewise.
> * linux/s390x/syscallent1.h: Likewise.

These new files had to be added to Makefile.am as well.

> * supported_personalities.h [S390X]: Define SUPPORTED_PERSONALITIES to
> 2.
> * tests/strace-V.test: Add s390 to the list of architectures that have
> m32 personality.
> * linux/s390/arch_defs.h (HAVE_ARCH_OLD_MMAP_PGOFF): New definition.
> * linux/s390x/arch_defs.h: Likewise.
> * mem.c: Replace #ifdef S390 with #ifdef HAVE_ARCH_OLD_MMAP_PGOFF.
> * pathtrace.c: Likewise.

Looks good, passes tests.  Applied, thanks.


--=20
ldv

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaYU/rAAoJEAVFT+BVnCUIyV8QAJHhZrNG0pLYk6NK1vChbqkr
lojhboyFBy6wuFWIa/CsOEJketUhpM3RREEksO6Fs7BjdLN3e1opvMg00db3NEsw
J0p0f9QYNBTM9o1w1jYbwnIl+f0Gh0Ujviln6pXFuL58DOoa2YuGwXIkNGXJJYu7
YTt4F4ugav7KbTX44UZw6Z51K4awwVe+2QdA+rCFBR8tjx/L8zYtJWMuFCjg59YT
f6L3T/sWhla9b9tFTlPAJ+btgYTr7ugwuxVeMtP2xJHw3K3cSAsYbE6beiUSDU4E
gI8VWXRSL8mQwlRRUGk6zjbIRrxbxQY5ZEmKOJozFN62G2qH/HGl7A670TGmnq1r
MMk2EmcUtC9BO53QIBJfWIPy+ZeyJKCLnN6oLNq7Q1sGkhMdGam0vYJ0HgmF31H9
NelKNukLiJ9tceysuTblUHFOl8tCu7BYn6i2okTcEODe1mkLL+BEVZpx6JRd+6wZ
agZeRr9EC5Qxcktwh8f/8n4/PtvPwMKCP9Zt0/ztPkEj5srNX4SfxRB2w3sG4BP+
A5mSPhnsS1/JembdggO4r1dlZVWlFDQ28k8geMI4RF2MMsO1Ik530wp4rbzlO1BL
R69oRXl4R5FVOghahZtK2vI7nm0G4lFeSnxp8zj8IU6DURroNkk8sFa0pLSh+6QK
KW8mDYQ1zrb4T/yaprY9
=cvBz
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
