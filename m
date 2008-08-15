Subject: Re: [PATCH] Remove duplicated unlikely() in IS_ERR()
From: Artem Bityutskiy <dedekind@infradead.org>
In-Reply-To: <48A52D69.1040501@miraclelinux.com>
References: <48A52D69.1040501@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 15 Aug 2008 15:16:07 +0300
Message-Id: <1218802567.3095.1.camel@sauron>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: dedekind@infradead.org
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: Hirofumi Nakagawa <hnakagawa@miraclelinux.com>
Cc: yoshfuji@linux-ipv6.org, christof.schmitt@de.ibm.com, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi

On Fri, 2008-08-15 at 16:16 +0900, Hirofumi Nakagawa wrote:
> Hi
> Some drivers have duplicated unlikely() macros.
> IS_ERR() already has unlikely() in itself.
> This patch cleans up such pointless codes although there is no real
> effect on the kernel's behaviour.

please, send an UBIFS-only patch and I'll put it to ubifs-2.6.git,
thanks.

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)
