Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFKPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jul 2020 06:15:48 -0400
Date: Mon, 6 Jul 2020 12:15:34 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: bpf: bpf_probe_read helper restriction on s390x
Message-ID: <20200706101534.GA3401866@krava>
References: <OFDA9C9258.BBAFD274-ON0025859D.001E3F9D-C125859D.001E497A@notes.na.collabserv.com>
 <f95739ee-59a9-4dfc-8da0-dfef2c73bd6a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f95739ee-59a9-4dfc-8da0-dfef2c73bd6a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: agordeev@linux.ibm.com, ast@kernel.org, bas@baslab.org, bpf@vger.kernel.org, brendan.d.gregg@gmail.com, daniel@iogearbox.net, dxu@dxuuu.xyz, linux-s390@vger.kernel.org, mat@mmarchini.me, netdev@vger.kernel.org, yauheni.kaliuta@redhat.com, Sumanth.Korikkar@ibm.com

On Mon, Jul 06, 2020 at 08:33:15AM +0200, Sumanth Korikkar wrote:
> Hi Jiri,
>=20
> s390 has overlapping address space. As suggested by the commit,
> ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should not be enabled for s390
> kernel.
>=20
> This should be changed in bpftrace application.
>=20
> Even if we enable ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE, bpf_probe_read
> will only work in certain cases like kernel pointer deferences (kprobes).=
=EF=BF=BD
> User pointer deferences in uprobes/kprobes/etc will fail or have some
> invalid data
>=20
> I am looking forward to this fix:
> https://github.com/iovisor/bpftrace/pull/1141 OR probe split in bpftrace.

did not see this, will review ;-) thanks a lot!

jirka

>=20
> (Resending as some cc from my email client failed.)
>=20
> Thank you
>=20
> Best Regards
> Sumanth Korikkar
> > Jiri Olsa <jolsa@redhat.com> wrote on 07/05/2020 09:42:25 PM:
> >=20
> > > Subject: [EXTERNAL] bpf: bpf_probe_read helper restriction on s390x
> > >
> > > hi,
> > > with following commit:
> > > =EF=BF=BD 0ebeea8ca8a4 bpf: Restrict bpf_probe_read{, str}() only to =
archs
> > > where they work
> > >
> > > the bpf_probe_read BPF helper is restricted on architectures that
> > > have 'non overlapping address space' and select following config:
> > >
> > > =EF=BF=BD =EF=BF=BDselect ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> > >
> > > there's also nice explanation in this commit's changelog:
> > > =EF=BF=BD 6ae08ae3dea2 bpf: Add probe_read_{user, kernel} and probe_r=
ead_
> > > {user, kernel}_str helpers
> > >
> > >
> > > We have a problem with bpftrace not working properly on s390x because
> > > bpf_probe_read is no longer available, and bpftrace does not use
> > > bpf_probe_read_(user/kernel) variants yet.
> > >
> > > My question is if s390x is 'arch with overlapping address space' and =
we
> > > could fix this by adding ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE for
> > s390x
> > > or we need to fix bpftrace to detect this, which we probably need to =
do
> > > in any case ;-)
> > >
> > > thanks,
> > > jirka
> > >
> >=20
> --=20
> Sumanth Korikkar
>=20
