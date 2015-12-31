From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 24/32] sparc: define __smp_xxx
Date: Thu, 31 Dec 2015 14:44:03 -0500 (EST)
Message-ID: <20151231.144403.84288151398339321.davem@davemloft.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-25-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451572003-2440-25-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: mst@redhat.com
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, x86@kernel.org, xen-devel@lists.xenproject.org, mingo@elte.hu, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, stefano.stabellini@eu.citrix.com, andreyknvl@google.com, adi-buildroot-devel@lists.sourceforge.net, tglx@linutronix.de, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:08:53 +0200

> This defines __smp_xxx barriers for sparc,
> for use by virtualization.
> 
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
