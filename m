Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Date: Wed, 04 May 2011 12:53:19 +0100
Message-ID: <20684.1304509999@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20110504115319.dwdT6vRj507zJ6D0eGLySfPx0WroTSYuRFYJpunQTXo@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Sven Eckelmann <sven@narfation.org> wrote:

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: David Howells <dhowells@redhat.com> [MN10300 and FRV]
