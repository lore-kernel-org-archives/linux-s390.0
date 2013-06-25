Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <51C8F861.9010101@asianux.com>
Date: Tue, 25 Jun 2013 09:54:41 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [Suggestion] arch: s390: mm: the warnings with allmodconfig and "EXTRA_CFLAGS=-W"
References: <51C8F685.6000209@asianux.com>
In-Reply-To: <51C8F685.6000209@asianux.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20130625015441.yimPsU9P_MbLl68LALkInHU6BHTrHMbIdSo3M3RUxiM@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

Hello Maintainers:

When allmodconfig for " IBM zSeries model z800 and z900"

It will report the related warnings ("EXTRA_CFLAGS=3D-W"):
  mm/slub.c:1875:1: warning: =91deactivate_slab=92 uses dynamic stack alloc=
ation [enabled by default]
  mm/slub.c:1941:1: warning: =91unfreeze_partials.isra.32=92 uses dynamic s=
tack allocation [enabled by default]
  mm/slub.c:2575:1: warning: =91__slab_free=92 uses dynamic stack allocatio=
n [enabled by default]
  mm/slub.c:1582:1: warning: =91get_partial_node.isra.34=92 uses dynamic st=
ack allocation [enabled by default]
  mm/slub.c:2311:1: warning: =91__slab_alloc.constprop.42=92 uses dynamic s=
tack allocation [enabled by default]

Is it OK ?


Thanks.
--
Chen Gang

Asianux Corporation=20
