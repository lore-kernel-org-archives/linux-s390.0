Return-Path: <linux-kernel-owner+w=401wt.eu-S1423460AbXDZAdl@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Date: Thu, 26 Apr 2007 02:32:06 +0200
References: <20070423141123.GA21174@skybase> <20070425143011.57247c1d.akpm@linux-foundation.org> <20070425172447.1576c399.akpm@linux-foundation.org>
In-Reply-To: <20070425172447.1576c399.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200704260232.06909.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thursday 26 April 2007, Andrew Morton wrote:
> It would be neat if someone could create and maintain a new
> scripts/spot-common-mistakes. =A0Feed it a unified diff and it would comp=
lain
> about newly-added code (and only newly-added code) which has busted
> whitespace, adds new semaphores, adds new kernel_thread calls, etc, etc.

http://patchstylecheck.googlecode.com/svn/trunk/patchstylecheckemail.pl
Might serve as a starting point for this. It doesn't have any semantic
checks right now, but I guess they can be added.

	Arnd <><
