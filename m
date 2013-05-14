Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCHv2 net 1/2] sfc: Delete EFX_PAGE_IP_ALIGN, equivalent to NET_IP_ALIGN
Date: Tue, 14 May 2013 09:32:18 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7235@saturn3.aculab.com>
In-Reply-To: <1368482311.3305.48.camel@bwh-desktop.uk.solarflarecom.com>
References: <1368482311.3305.48.camel@bwh-desktop.uk.solarflarecom.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ben Hutchings <bhutchings@solarflare.com>, David Miller <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-net-drivers@solarflare.com, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, netdev <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> The two architectures that define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> (powerpc and x86) now both define NET_IP_ALIGN as 0, so there is no
> need for this optimisation any more.

Hmmm.... even on x86 there will be a measurable cost
in misaligned accesses - at least for some workloads.

If the DMA is able to write to a mis-aligned buffer and
still perform aligned burst transfers mid-frame then
4n+2 aligning the rx buffer should be a win even on x86.

Note to hardware engineers: add an option to write two
bytes of junk before the rx data :-)

	David

���{.n�+�������+%�����ݶ��w��{.n�+����{��G�����{ay�ʇڙ�,j��f���h��������z_�(�階�ݢj"���m������G������?����&���~��iO��z��v�^�m����������?�I�
