Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E225543;
	Wed, 20 Dec 2023 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZpiAPDG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b79d1ebd6so1964906a91.1;
        Wed, 20 Dec 2023 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077128; x=1703681928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8+xBOCKo9/coO5rJSjQQ+60/0EmuEgDI94F7Fa9SaE=;
        b=RZpiAPDGzckCr3UHS3L+W2qdTARID6cuDciIwyHPQBpfbpnJ1su1hqMJJMcUabv9Ul
         vnfcdS6y7FW7N12ZXIiaqnopS/9wTE5koE0v8XHweGUDicC2edigxqzzypV9OxMYpauv
         cRDAgXwP3skPDAaJ8g6bhgUC4sTlUPQBAoK+NFhO53iwVTZApAOB/RuKfuf++IL2oOE3
         KQBatKhYnLtJ2WnUce1TTzuusrz5hvLkhblIaqf5fO/mjNSIujfzrKqtN49ofZoRODfM
         TbLzbXWU0bdT9v7r4KyOtLdfmC62ZT6ZpAWjyin9j/DrkZDwfr/UChM5kKGFyAwRHmbe
         rxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077128; x=1703681928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8+xBOCKo9/coO5rJSjQQ+60/0EmuEgDI94F7Fa9SaE=;
        b=jgVh1jgWkfM3XzgDrS6zUAhcTLRVEoBnz/dlO9zR5ve8/FuhmyjgW6oWURs8pHjAQZ
         PKC7Q04L5BqCtNx03qkFp7f8NWA6BUtX0yz+ZG7kBEZW6lVrFbo+OaXh9ggByuvl/6n1
         i3tfTBRkw8V55vfhsJgqyhrwTWE3P5aiZDv5+U0OEQoo8L+iOqwPFW2EZPWQSx4KMh/h
         FT5zvArIEpl11PpHris2oZ4k4aFTFm5KqKAIAh8H5o28YlZ8mjALQRwgP1OOyC8tknX5
         Nj7/J/kf0OKBnnehqXFa8AR5UX9yMnAeySb3qpMIA9zLD0xbGqgJDFN5cABuVaGBvzIy
         hpXg==
X-Gm-Message-State: AOJu0YwE+HrBd04/Pk7UpC/Ss/OniuEJd7BeQvvcmeBFnjr6jGxjXuSI
	H1geUMxxsED4fiGl3KRpeF67Zh2B1Bsi+UXVj+XBSQ54G0oCvw==
X-Google-Smtp-Source: AGHT+IGh8bxmaD9blVAqiToJmhtI5AMJt74jSAWiC5mC8pKr6BtWzEdk0UwIA+Y96k5lPcWQIdXO2sE0LcAp7jo0Ro4=
X-Received: by 2002:a17:90a:d901:b0:28b:a507:b31e with SMTP id
 c1-20020a17090ad90100b0028ba507b31emr2154917pjv.70.1703077127728; Wed, 20 Dec
 2023 04:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com> <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com> <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
 <20231030123558.10816-A-hca@linux.ibm.com> <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
 <20231109144834.11754-B-hca@linux.ibm.com>
In-Reply-To: <20231109144834.11754-B-hca@linux.ibm.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 20 Dec 2023 13:58:36 +0100
Message-ID: <CAO8sHcnqPojEJ7YVPzRWow5D9ELWpCaHG7kPeNoZzJb0QOOYXg@mail.gmail.com>
Subject: Re: s390x stack unwinding with perf?
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Neal Gompa <ngompa@fedoraproject.org>, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andreas Krebbel <krebbel@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Davide Cavalca <dcavalca@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> FWIW, this is now upstream and will land in 6.7, together with a similar
> patch which adds user stacktrace support:

> 504b73d00a55 ("s390/perf: implement perf_callchain_user()")
> aa44433ac4ee ("s390: add USER_STACKTRACE support")

> Please let us know if there are any problems.

I've been trying out the new userspace stacktrace support on Fedora
Rawhide but I'm having some problems getting it to work. I rebuilt
systemd and all of its dependencies (specifically, glibc) with
-mbackchain using copr
(https://copr.fedorainfracloud.org/coprs/daandemeyer/fno-omit-frame-pointer=
/builds/),
built a Fedora Rawhide image with the rebuilt packages and perf using
mkosi, started an s390x virtual machine and ran "perf record -g
journalctl --verify" followed by "perf report -g 'graph,0.5,caller'".
On x86, this gives me a sensible perf report. On s390x, it seems a lot
of information is still missing.

uname -r: 6.7.0-0.rc6.48.fc40.s390x
cat /usr/lib/modules/6.7.0-0.rc6.48.fc40.s390x/config | grep STACK:
"""
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
CONFIG_HAVE_ARCH_STACKLEAK=3Dy
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy
CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
CONFIG_VMAP_STACK=3Dy
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=3Dy
CONFIG_BLK_MQ_STACKING=3Dy
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
CONFIG_NET_EMATCH_STACK=3D32
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=3Dy
CONFIG_ARCH_STACKWALK=3Dy
CONFIG_STACKDEPOT=3Dy
# CONFIG_STACKTRACE_BUILD_ID is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=3Dy
CONFIG_STACKTRACE=3Dy
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_STACK_TRACER=3Dy
CONFIG_STACKINIT_KUNIT_TEST=3Dm
"""

To reproduce (from a s390x host system):

- git clone https://www.github.com/systemd/mkosi
- cd mkosi
- tee copr.repo <<EOF
[copr:copr.fedorainfracloud.org:daandemeyer:fno-omit-frame-pointer]
name=3DCopr repo for fno-omit-frame-pointer owned by daandemeyer
baseurl=3Dhttps://download.copr.fedorainfracloud.org/results/daandemeyer/fn=
o-omit-frame-pointer/fedora-$releasever-$basearch/
type=3Drpm-md
skip_if_unavailable=3DTrue
gpgcheck=3D1
gpgkey=3Dhttps://download.copr.fedorainfracloud.org/results/daandemeyer/fno=
-omit-frame-pointer/pubkey.gpg
repo_gpgcheck=3D0
enabled=3D1
enabled_metadata=3D1
priority=3D1
EOF
- tee mkosi.local.conf <<EOF
[Distribution]
Distribution=3Dfedora
Release=3Drawhide
Repositories=3Dfedora-debuginfo
PackageManagerTrees=3Dcopr.repo:/etc/yum.repos.d/copr.repo

[Content]
Packages=3D
        systemd-debuginfo
        systemd-debugsource

[Host]
ToolsTree=3Ddefault
Incremental=3Dyes
EOF
- bin/mkosi -f qemu"
# You'll end up in a virtual machine running Fedora Rawhide with a
6.7-rc kernel and glibc + systemd built with -mbackchain
- perf record -g journalctl --verify
- perf report -g 'graph,0.5,caller'
# The output will not make a lot of sense whereas it does on x86


On Thu, 9 Nov 2023 at 15:48, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Mon, Oct 30, 2023 at 09:19:02AM -0400, Neal Gompa wrote:
> > On Mon, Oct 30, 2023 at 9:02=E2=80=AFAM Heiko Carstens <hca@linux.ibm.c=
om> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 11:22:42AM -0400, Neal Gompa wrote:
> > > > On Fri, Oct 27, 2023 at 6:10=E2=80=AFAM Heiko Carstens <hca@linux.i=
bm.com> wrote:
> > > > >
> > > > > On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> > > > > >
> > > > > > If the kernel gets support for s390x user space unwinding using=
 the backchain,
> > > > > > we'll propose to enable -mbackchain in the default compilation =
flags for Fedora
> > > > > > so that s390x on Fedora will have the same profiling experience=
 as x86-64, arm64
> > > > > > and ppc64. For now we'll keep the status quo since compiling wi=
th the backchain
> > > > > > doesn't provide any benefit until the kernel unwinder can unwin=
d user
> > > > > > space stacks
> > > > > > using it.
> > > > > >
> > > > > > Thanks for clarifying the current state of user space stack unw=
inding on s390x!
> > > > >
> > > > > We will implement the missing pieces and let you know when things=
 are
> > > > > supposed to work.
> > > >
> > > > Do you think we could have an initial patch set for implementing th=
e
> > > > missing pieces in time for the Linux 6.8 merge window? Then we can
> > > > look at enabling this for s390x as a Fedora Linux 40 Change.
> > >
> > > This will be very likely the case. Actually the plan is to go with th=
e
> > > patch below. I gave it some testing with Fedora 38 and replaced (only=
)
> > > glibc with a variant that was compiled with -mbackchain.
> ...
> > This patch LGTM. I'd love to see it land in Linux 6.7!
> >
> > Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>
>
> FWIW, this is now upstream and will land in 6.7, together with a similar
> patch which adds user stacktrace support:
>
> 504b73d00a55 ("s390/perf: implement perf_callchain_user()")
> aa44433ac4ee ("s390: add USER_STACKTRACE support")
>
> Please let us know if there are any problems.
