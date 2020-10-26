Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <7c592b6b4cc3bc4e629e35445fa76cf07b5482a6.camel@perches.com>
Subject: Re: [PATCH 1/1] s390: correct __bootdata / __bootdata_preserved
 macros
From: Joe Perches <joe@perches.com>
Date: Mon, 26 Oct 2020 06:31:17 -0700
In-Reply-To: <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
         <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
         <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Michal Kubecek <mkubecek@suse.cz>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, 2020-10-26 at 13:49 +0100, Vasily Gorbik wrote:
> Currently s390 build is broken.
>=20
> =EF=BF=BD=EF=BF=BDSECTCMP .boot.data
> error: section .boot.data differs between vmlinux and arch/s390/boot/comp=
ressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
> =EF=BF=BD=EF=BF=BDSECTCMP .boot.preserved.data
> error: section .boot.preserved.data differs between vmlinux and arch/s390=
/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
> make[1]: *** [bzImage] Error 2
>=20
> Commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") converted all __section(foo) to __section("foo").
> This is wrong for __bootdata / __bootdata_preserved macros which want
> variable names to be a part of intermediate section names .boot.data.<var
> name> and .boot.preserved.data.<var name>. Those sections are later
> sorted by alignment + name and merged together into final .boot.data
> / .boot.preserved.data sections. Those sections must be identical in
> the decompressor and the decompressed kernel (that is checked during
> the build).
>=20
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) =
to __section("foo")")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Apologies and thank you.
I believed the robot had done these compilation tests.
