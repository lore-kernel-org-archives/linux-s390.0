From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
Date: Thu, 2 Mar 2017 15:05:50 +0000
Message-ID: <20170302150550.GC12157@e104818-lin.cambridge.arm.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.ne>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> Now that all call sites, completely decouple cacheflush.h and
> set_memory.h
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
