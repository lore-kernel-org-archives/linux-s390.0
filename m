Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42704 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgAPXoR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 18:44:17 -0500
MIME-Version: 1.0
References: <20200113105156.25945-1-geert@linux-m68k.org>
In-Reply-To: <20200113105156.25945-1-geert@linux-m68k.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 17 Jan 2020 00:44:03 +0100
Message-ID: <CAFLxGvxNUcKiaCxXy_oracH-3xg3MPETxkaDqgtkMkB1vp-02Q@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix ino_t format warnings in orphan_delete()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org

On Mon, Jan 13, 2020 at 11:52 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On alpha and s390x:
>
>     fs/ubifs/debug.h:158:11: warning: format =E2=80=98%lu=E2=80=99 expect=
s argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has =
type =E2=80=98ino_t {aka unsigned int}=E2=80=99 [-Wformat=3D]
>     ...
>     fs/ubifs/orphan.c:132:3: note: in expansion of macro =E2=80=98dbg_gen=
=E2=80=99
>        dbg_gen("deleted twice ino %lu", orph->inum);
>     ...
>     fs/ubifs/orphan.c:140:3: note: in expansion of macro =E2=80=98dbg_gen=
=E2=80=99
>        dbg_gen("delete later ino %lu", orph->inum);
>
> __kernel_ino_t is "unsigned long" on most architectures, but not on
> alpha and s390x, where it is "unsigned int".  Hence when printing an
> ino_t, it should always be cast to "unsigned long" first.
>
> Fix this by re-adding the recently removed casts.
>
> Fixes: 8009ce956c3d2802 ("ubifs: Don't leak orphans on memory during comm=
it")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  fs/ubifs/orphan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied! Thank you, Geert.

--=20
Thanks,
//richard
