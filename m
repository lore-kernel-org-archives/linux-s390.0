From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 0/5] perf trace: Introduce arch-specific errno
 code/name mappings
Date: Thu, 25 Jan 2018 06:28:09 -0300
Message-ID: <20180125092809.GB23548@kernel.org>
References: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <23f01b64-0584-bbaf-2418-e34c229bcce0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <23f01b64-0584-bbaf-2418-e34c229bcce0@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Jan 25, 2018 at 01:30:13PM +0530, Ravi Bangoria escreveu:
> Hi Hendrik,
>=20
> On 01/19/2018 02:26 PM, Hendrik Brueckner wrote:
> > Introduce an interface to perf to resolve errno codes to their names.
> > This is used by perf trace to display the errno name, for example, ENOE=
NT,
> > for an system call.  The previous implementation used the errno_to_name=
()
> > function from the audit library.
> >
> > With this change, a table of errno codes and their names are created for
> > each architecture on which perf is supported (others can be easily added
> > if necessary).  The errno_to_name() function from the audit library is
> > replaced with an arch-specific one, arch_errno_to_name().
> >
> > The benefit is that perf trace does not longer have a direct dependency
> > for the audit library and the perf trace output can be displayed across
> > architectures.  For example, collect trace output on s390 and display it
> > on x86.
>=20
> I haven't tested this but are you sure that we can do cross-arch perf-tra=
ce
> after this patch set?

This patch is a step in that direction
=20
> Why I'm curious is because, we embed arch specific syscall table in the p=
erf
> binary at compile time:
>=20
> =A0=A0=A0 $ cat tools/perf/util/syscalltbl.c
>=20
> =A0=A0=A0 #if defined(__x86_64__)
> =A0=A0=A0 #include <asm/syscalls_64.c>
> =A0=A0=A0 const int syscalltbl_native_max_id =3D SYSCALLTBL_x86_64_MAX_ID;
> =A0=A0=A0 static const char **syscalltbl_native =3D syscalltbl_x86_64;
> =A0=A0=A0 #elif defined(__s390x__)
> =A0=A0=A0 #include <asm/syscalls_64.c>
> =A0=A0=A0 const int syscalltbl_native_max_id =3D SYSCALLTBL_S390_64_MAX_I=
D;
> =A0=A0=A0 static const char **syscalltbl_native =3D syscalltbl_s390_64;
> =A0=A0=A0 #endif
>=20
> If we don't have, let's say, s390 syscall table in perf compiled on x86 m=
achine,
> we won't be able to do perf-trace across architecture. Right ?

Right.
=20
> Please let me know if I'm missing anything.

You are not, we need to start testing running 'perf trace record' for
some workloads on a, say, PowerPC machine, run perf trace -i on that
file to do the beautification, copy this formatted output file + its
perf.data file, copy that to x86_64 or s/390 and try to get the same
output.

We will not, and the differences will tell us what to work on :-)

- Arnaldo
=20
> Thanks,
> Ravi
>=20
> P.S.: Seems I can remove libaudit dependency for syscalls on PowerPC as w=
ell.
> Will prepare patches for that very soon.

Great!
