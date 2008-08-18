Message-ID: <8bd0f97a0808181610x2e5efce0lb00ba5c0cf9e1e9a@mail.gmail.com>
Date: Mon, 18 Aug 2008 19:10:21 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] Remove duplicated unlikely() in IS_ERR()
In-Reply-To: <48A52D69.1040501@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48A52D69.1040501@miraclelinux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: Hirofumi Nakagawa <hnakagawa@miraclelinux.com>
Cc: yoshfuji@linux-ipv6.org, linux-s390@vger.kernel.org, christof.schmitt@de.ibm.com, linux-mtd@lists.infradead.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 3:16 AM, Hirofumi Nakagawa wrote:
> Some drivers have duplicated unlikely() macros.
> IS_ERR() already has unlikely() in itself.
> This patch cleans up such pointless codes although there is no real
> effect on the kernel's behaviour.

sounds like a good check to add to checkpatch.pl ...
-mike
