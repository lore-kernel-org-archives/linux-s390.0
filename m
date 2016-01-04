Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1451945497.4334.107.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
From: Joe Perches <joe@perches.com>
Date: Mon, 04 Jan 2016 14:11:37 -0800
In-Reply-To: <20160104230528-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	 <1451907395-15978-4-git-send-email-mst@redhat.com>
	 <1451926073.4334.90.camel@perches.com>
	 <20160104230528-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104221137.eGCDeP82Dd8_UKO_i_kdjyOeLYtJCQgOy6DgcO35eNc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> >=20
> > Are these virt_ barriers used anywhere?
> >=20
> > I see some virtio_ barrier like uses.
>=20
> They will be :) They are added and used by patchset
> 	=A0=A0=A0=A0=A0=A0=A0=A0arch: barrier cleanup + barriers for virt
>=20
> See
> http://article.gmane.org/gmane.linux.kernel.virtualization/26555

Ah, OK, thanks.

Are the virtio_ barriers going away?
If not, maybe those should be added too.
