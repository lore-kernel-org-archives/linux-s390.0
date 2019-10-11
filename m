Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.136]:40955 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfJKBj3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 21:39:29 -0400
Date: Thu, 10 Oct 2019 18:38:03 -0700
In-Reply-To: <201910101657.234CB71E53@keescook>
References: <20190926175602.33098-1-keescook@chromium.org> <20191010180331.GI7658@zn.tnic> <201910101657.234CB71E53@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
From: hpa@zytor.com
Message-ID: <A020A6D1-C7DB-480B-826E-AE18308CD3E5@zytor.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org

On October 10, 2019 4:57:36 PM PDT, Kees Cook <keescook@chromium=2Eorg> wro=
te:
>On Thu, Oct 10, 2019 at 08:03:31PM +0200, Borislav Petkov wrote:
>> On Thu, Sep 26, 2019 at 10:55:33AM -0700, Kees Cook wrote:
>> > This series works to move the linker sections for NOTES and
>> > EXCEPTION_TABLE into the RO_DATA area, where they belong on most
>> > (all?) architectures=2E The problem being addressed was the discovery
>> > by Rick Edgecombe that the exception table was accidentally marked
>> > executable while he was developing his execute-only-memory series=2E
>When
>> > permissions were flipped from readable-and-executable to
>only-executable,
>> > the exception table became unreadable, causing things to explode
>rather
>> > badly=2E :)
>> >=20
>> > Roughly speaking, the steps are:
>> >=20
>> > - regularize the linker names for PT_NOTE and PT_LOAD program
>headers
>> >   (to "note" and "text" respectively)
>> > - regularize restoration of linker section to program header
>assignment
>> >   (when PT_NOTE exists)
>> > - move NOTES into RO_DATA
>> > - finish macro naming conversions for RO_DATA and RW_DATA
>> > - move EXCEPTION_TABLE into RO_DATA on architectures where this is
>clear
>> > - clean up some x86-specific reporting of kernel memory resources
>> > - switch x86 linker fill byte from x90 (NOP) to 0xcc (INT3), just
>because
>> >   I finally realized what that trailing ": 0x9090" meant -- and we
>should
>> >   trap, not slide, if execution lands in section padding
>>=20
>> Yap, nice patchset overall=2E
>
>Thanks!
>
>> > Since these changes are treewide, I'd love to get
>architecture-maintainer
>> > Acks and either have this live in x86 -tip or in my own tree,
>however
>> > people think it should go=2E
>>=20
>> Sure, I don't mind taking v2 through tip once I get ACKs from the
>> respective arch maintainers=2E
>
>Okay, excellent=2E I've only had acks from arm64, but I'll call it out
>again in v2=2E Thanks for the review!

I would like to once again advocate for the generalized link table mechani=
sm=2E It is nuts that each individual table should need vmlinux=2Elds hacki=
ng across architectures=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
